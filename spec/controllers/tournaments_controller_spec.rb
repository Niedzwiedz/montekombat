require "rails_helper"

RSpec.describe TournamentsController do
  describe "GET #index" do
    let(:tournament) { create(:tournament) }
    before { get :index }
    it "populates an array of tournaments" do
      expect(assigns(:tournaments)).to eq [tournament]
    end
    it "renders the :index view" do
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    let(:tournament) { create(:tournament) }
    before { get :show, params: { id: tournament.id } }
    it "assigns the requested tournament to @tournament" do
      expect(assigns(:tournament)).to eq tournament
    end
    it "renders the :show view" do
      expect(response).to render_template("show")
    end
  end

  describe "GET #new" do
    context "As logged in user" do
      before do
        session[:user_id] = create(:user).id
        get :new
      end
      it "assigns the new tournament to @tournament" do
        expect(assigns(:tournament)).to be_present
      end
      it "renders the :show view" do
        expect(response).to render_template("new")
      end
    end

    context "As guest" do
      before { get :new }
      it "redirects the login view" do
        expect(response).to redirect_to login_path
      end
    end
  end
  describe "POST #create" do
    subject { post :create, params: { tournament: tournament.attributes }}
    context "As logged in user" do
      before do
        session[:user_id] = create(:user).id
      end
      context "with valid attributes" do
        let(:tournament) { build(:tournament) }
        it { expect { subject }.to change { Tournament.count }.by(1) }
        it { subject; expect(response).to redirect_to Tournament.last }
      end
      context "with invalid attribures" do
        let(:tournament) { build(:tournament, :without_title) }
        it { expect { subject }.not_to change { Tournament.count } }
        it { subject; expect(response).to render_template :new }
      end
    end
    context "As not logged in user" do
      let(:tournament) { build(:tournament) }
      it { expect { subject }.not_to change { Tournament.count } }
      it "redirects to root path" do
        subject
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "POST #update" do
    let(:tournament) { create(:tournament, number_of_teams: 666)}
    context "As a creator" do
      before do
        session[:user_id] = tournament.creator.id
      end
      context "with valid attributes" do
        before do
          @tournament = build(:tournament, number_of_teams: 66)
          put :update, params: { id: tournament.id, tournament: @tournament.attributes }
        end
        it { expect(assigns(:tournament)).to eq(tournament) }
        it "" do
          tournament.reload
          expect(tournament.number_of_teams).to eq(66)
        end
      end

      context "with invalid attributes" do
        before do
          @tournament = build(:tournament, :without_title)
          put :update, params: { id: tournament.id, tournament: @tournament.attributes }
        end
        subject { assigns(:tournament) }
        it { is_expected.to eq(tournament) }
        it "does not change tournament" do
          tournament.reload
          expect(tournament.number_of_teams).not_to eq(66)
        end
      end
    end

    context "As logged in user" do
      before do
        session[:user_id] = create(:user).id
      end
      context "with valid attributes" do
        before do
          @tournament = build(:tournament, number_of_teams: 66)
          put :update, params: { id: tournament.id, tournament: @tournament.attributes }
        end
        it { expect(assigns(:tournament)).to eq(tournament) }
        it "" do
          tournament.reload
          expect(tournament.number_of_teams).not_to eq(66)
        end
      end
    end
  end

  describe "DELETE #destroy" do
    subject { delete :destroy, params: { id: tournament.id } }
    let!(:tournament) { create(:tournament) }
    context "As creator" do
      before do
        session[:user_id] = tournament.creator.id
      end
      it { expect { subject }.to change { Tournament.count } }
      it "redirects to tournament" do
        subject
        expect(response).to redirect_to tournaments_path
      end
    end
    context "As logged in user" do
      before do
        session[:user_id] = create(:user)
      end
      it { expect { subject }.not_to change { Tournament.count } }
      it "redirects to tournament" do
        subject
        expect(response).to redirect_to tournaments_path
      end

    end
  end
end

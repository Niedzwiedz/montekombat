require "rails_helper"

RSpec.describe TournamentsController do
  subject(:log_in_user) { session[:user_id] = create(:user).id }
  subject(:log_in_admin) { session[:user_id] = create(:user, :admin).id }
  subject(:log_in_creator) { session[:user_id] = tournament.creator.id }

  describe "GET #index" do
    let(:tournament) { create(:tournament) }
    before { get :index }
    it { expect(assigns(:tournaments)).to eq [tournament] }
    it { expect(response).to render_template("index") }
  end

  describe "GET #show" do
    let(:tournament) { create(:tournament) }
    before { get :show, params: { id: tournament.id } }
    it { expect(assigns(:tournament)).to eq tournament }
    it { expect(response).to render_template("show") }
  end

  describe "GET #new" do
    context "As logged in user" do
      before do
        log_in_user
        get :new
      end
      it { expect(assigns(:tournament)).to be_present }
      it { expect(response).to render_template("new") }
    end

    context "As guest" do
      before { get :new }
      it { expect(response).to redirect_to login_path }
    end
  end
  describe "POST #create" do
    subject(:post_create) { post :create, params: { tournament: tournament.attributes } }
    context "As logged in user" do
      before { log_in_user }

      context "with valid attributes" do
        let(:tournament) { build(:tournament) }
        it { expect { post_create }.to change { Tournament.count }.by(1) }
        it do
          post_create
          expect(response).to redirect_to Tournament.last
        end
      end

      context "with invalid attribures" do
        let(:tournament) { build(:tournament, :without_title) }
        it { expect { post_create }.not_to change { Tournament.count } }
        it "renders new template" do
          post_create
          expect(response).to render_template :new
        end
      end
    end
    context "As not logged in user" do
      let(:tournament) { build(:tournament) }
      it { expect { post_create }.not_to change { Tournament.count } }
      it "redirects to root path" do
        post_create
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "POST #update" do
    subject(:post_update) do
      put :update, params: { id: tournament.id, tournament: @tournament.attributes }
    end
    context "As a creator" do
      before { log_in_creator }

      context "with valid attributes and open status" do
        let(:tournament) { create(:tournament, number_of_teams: 666) }
        before do
          @tournament = build(:tournament, number_of_teams: 66)
          post_update
        end
        it { expect(assigns(:tournament)).to eq(tournament) }
        it "changes permited param" do
          tournament.reload
          expect(tournament.number_of_teams).to eq(66)
        end
      end

      context "with teams present" do
        subject(:change_team_number) do
          @tournament = build(:tournament, :with_5_teams, number_of_teams: 4)
          post_update
        end
        subject(:change_players_number) do
          @tournament = build(:tournament, :with_5_teams, number_of_players_in_team: 2)
          post_update
        end
        let(:tournament) { create(:tournament, :with_5_teams) }

        it "cannot change number of teams to be lower" do
          change_team_number
          tournament.reload
          expect(tournament.number_of_teams).to eq(5)
        end

        it "cannot change number of players" do
          change_players_number
          tournament.reload
          expect(tournament.number_of_players_in_team).to eq(3)
        end
      end

      context "when tournament status is started" do
        let(:tournament) { create(:tournament, :started, number_of_teams: 666) }
        before do
          @tournament = build(:tournament, :started, number_of_teams: 66)
          post_update
        end
        it { expect(assigns(:tournament)).to eq(tournament) }
        it "can't change param that is not permited" do
          tournament.reload
          expect(tournament.number_of_teams).not_to eq(66)
        end
      end

      context "with invalid attributes" do
        let(:tournament) { create(:tournament, number_of_teams: 666) }
        before do
          @tournament = build(:tournament, :without_title)
          post_update
        end
        subject { assigns(:tournament) }
        it { is_expected.to eq(tournament) }
        it "does not change tournament" do
          tournament.reload
          expect(tournament.number_of_teams).not_to eq(66)
        end
      end

      context "As logged in user" do
        let(:tournament) { create(:tournament, number_of_teams: 666) }
        before { log_in_user }
        context "with valid attributes" do
          before do
            @tournament = build(:tournament, number_of_teams: 66)
            post_update
          end
          it { expect(assigns(:tournament)).to eq(tournament) }
          it "does not change tournament" do
            tournament.reload
            expect(tournament.number_of_teams).not_to eq(66)
          end
        end
      end
    end

    describe "DELETE #destroy" do
      subject(:destroy) { delete :destroy, params: { id: tournament.id } }
      let!(:tournament) { create(:tournament) }

      context "As admin" do
        before { log_in_admin }
        it { expect { destroy }.to change { Tournament.count } }
        it "redirects to tournament" do
          destroy
          expect(response).to redirect_to tournaments_path
        end
      end

      context "As creator" do
        before { log_in_creator }
        it { expect { destroy }.to change { Tournament.count } }
        it "redirects to tournament" do
          destroy
          expect(response).to redirect_to tournaments_path
        end
      end
      context "As logged in user" do
        before { log_in_user }
        it { expect { destroy }.not_to change { Tournament.count } }
        it "redirects to tournament" do
          destroy
          expect(response).to redirect_to root_path
        end
      end
    end
  end
end

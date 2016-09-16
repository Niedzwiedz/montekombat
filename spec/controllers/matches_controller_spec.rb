require "rails_helper"

RSpec.describe MatchesController do
  describe "GET #index" do
    let(:match) { create(:match) }
    before { get :index }
    it "populates an array of matches" do
      expect(assigns(:matches)).to eq [match]
    end
    it "renders the :index view" do
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    let(:match) { create(:match) }
    before { get :show, params: { id: match.id } }
    it "assigns the requested match to @match" do
      expect(assigns(:match)).to eq match
    end
    it "renders the :show view" do
      expect(response).to render_template("show")
    end
  end

  describe "GET #new" do
    before { get :new }
    it "assigns the new match to @match" do
      expect(assigns(:match)).to be_present
    end
    it "renders the :show view" do
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    subject { post :create, params: { match: match.attributes } }
    context "with valid attributes" do
      let(:match) { build(:match) }
      it { expect { subject }.to change { Match.count }.by(1) }
      it { subject; expect(response).to redirect_to Match.last }
    end
    context "with invalid attributes" do
      let(:match) { build(:invalid_match) }
      it { expect { subject }.not_to change { Match.count } }
      it "renders :new template" do
        subject
        expect(response).to render_template :new
      end
    end
  end

  describe "POST #update" do
    let(:match) { create(:match, points_for_team1: 666) }
    context "with valid attributes" do
      before do
        @match_in = build(:match, points_for_team1: 10)
        put :update, params: { id: match.id, match: @match_in.attributes }
      end
      it "locates requested match" do
        expect(assigns(:match)).to eq(match)
      end
      it "changes match" do
        match.reload
        expect(match.points_for_team1).to eq(10)
      end
      it "redirects to uploaded match" do
        expect(response).to redirect_to @match
      end
    end
    context "with invalid attributes" do
      before do
        @match_in = build(:match, points_for_team1: nil)
        put :update, params: { id: match.id, match: @match_in.attributes }
      end
      subject { assigns(:match) }
      it { is_expected.to eq(match) }
      it "does not change match" do
        match.reload
        expect(match.points_for_team1).not_to eq(10)
      end
      it { expect(response).to render_template :edit }
    end
  end

  describe "DELETE #destroy" do
    before { @match = create(:match) }
    subject { delete :destroy, params: { id: @match.id } }
    it { expect { subject }.to change(Match, :count) }
    it "redirects to match" do
      subject
      expect(response).to redirect_to matches_url
    end
  end
end

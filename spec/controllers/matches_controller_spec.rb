require "rails_helper"

RSpec.describe MatchesController do
  describe "GET #index" do
    let(:match) { create(:match) }
    it "populates an array of matches" do
      get :index
      expect(assigns(:matches)).to eq [match]
    end
    it "renders the :index view" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    let(:match) { create(:match) }
    it "assigns the requested match to @match" do
      get :show, params: { id: match.id }
      expect(assigns(:match)).to eq match
    end
    it "renders the :show view" do
      get :show, params: { id: match.id }
      expect(response).to render_template("show")
    end
  end

  describe "GET #new" do
    it "assigns the new match to @match" do
      get :new
      expect(assigns(:match)).to be_present
    end
    it "renders the :show view" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      let(:match) { build(:match) }
      it "saves the match in the database" do
        expect{
          post :create, params: { match: match.attributes }
        }.to change(Match, :count).by(1)
      end
      it "redirects to match :show view" do
        post :create, params: { match: match.attributes }
        expect(response).to redirect_to Match.last
      end
    end
    context "with invalid attributes" do
      let(:invalid_match) { build(:invalid_match) }
      it "does not save match to database" do
        expect{
          post :create, params: { match: invalid_match.attributes }
        }.not_to change(Match, :count)
      end
      it "renders :new template" do
        post :create, params: { match: invalid_match.attributes }
        expect(response).to render_template :new
      end
    end
  end

  describe "POST #update" do
    let(:match) { create(:match, points_for_team1: 666) }
    context "with valid attributes" do
      it "locates requested match" do
        match_in = build(:match)
        put :update, params: { id: match.id, match: match_in.attributes }
        expect(assigns(:match)).to eq(match)
      end
      it "changes match" do
        match_in = build(:match, points_for_team1: 10)
        put :update, params: { id: match.id, match: match_in.attributes }
        match.reload
        expect(match.points_for_team1).to eq(10)
      end
      it "redirects to uploaded match" do
        match_in = build(:match)
        put :update, params: { id: match.id, match: match_in.attributes }
        expect(response).to redirect_to match
      end
    end
    context "with invalid attributes" do
      it "locates requested match" do
        match_in = build(:invalid_match)
        put :update, params: { id: match.id, match: match_in.attributes }
        expect(assigns(:match)).to eq(match)
      end
      it "does not change match" do
        match_in = build(:match, points_for_team1: nil)
        put :update, params: { id: match.id, match: match_in.attributes }
        match.reload
        expect(match.points_for_team1).not_to eq(10)
      end
      it "rerenders the edit" do
        match_in = build(:invalid_match)
        put :update, params: { id: match.id, match: match_in.attributes }
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @match = create(:match)
    end
    it "deletes match" do
      expect {
        delete :destroy, params: { id: @match.id }
      }.to change(Match, :count)
    end
    it "redirects to match" do
      delete :destroy, params: { id: @match.id }
      expect(response).to redirect_to matches_url
    end
  end
end

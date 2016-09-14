require "rails_helper"

RSpec.describe MatchesController do
  describe "GET #index" do
    it "populates an array of matches"
    it "renders the :index view" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    it "assigns the requested match to @match"
    it "renders the :show view" do
      get :show, id: Factory(:match_controller)
      expect(response).to render_template("show")
    end
  end

  describe "GET #new" do
    it "assigns the new match to @match"
    it "renders the :show view"
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the match in the database"
      it "redirects to match :show view"
    end
    context "with invalid attributes" do
      it "does not save match to database"
      it "renders :new template"
    end
  end
end

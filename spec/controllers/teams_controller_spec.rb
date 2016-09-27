require "rails_helper"

RSpec.describe TeamsController do
  describe "GET #new" do
    before { get :new }
    it "assigns the new team to @team" do
      expect(assigns(:team)).to be_present
    end
    it "renders the :show view" do
      expect(response).to render_template("new")
    end
  end

  # ------------------------------------------------------------------
  # create and edit needs users in params
  # ------------------------------------------------------------------
  describe "POST #create" do
    let(:team) { build(:team) }
    subject(:post_create) { post :create, params: { team: team.attributes, users: team.users_ids } }
    context "with valid attributes" do
      it { expect { post_create }.to change { Team.count }.by(1) }
      it do
        post_create
        expect(response).to redirect_to Team.last
      end
    end
    context "with invalid attributes" do
      let(:team) { build(:team, :without_name) }
      it { expect { post_create }.not_to change { Team.count } }
      it "renders :new template" do
        post_create
        expect(response).to render_template :new
      end
    end
  end
end

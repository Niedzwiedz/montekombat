require "rails_helper"

RSpec.describe UsersController do
  let(:valid_user) { create(:user) }
  let(:admin_user) { create(:user, :admin) }

  let(:not_valid_user) { create(:user, :without_email) }

  describe "GET #show" do
    before { get :show, params: { id: valid_user.id } }
    it "assigns the requested user to @user" do
      expect(assigns(:user)).to eq valid_user
    end
    it "renders the :show view" do
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    before { get :new }
    it "assigns the new user to @user" do
      expect(assigns(:user)).to be_present
    end
    it "renders the :new view" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      subject { post :create, params: { user: attributes_for(:user) } }
      it { expect { subject }.to change { User.count }.by(1) }
      it { subject; expect(response).to redirect_to User.last }
    end
    context "with invalid attributes" do
      subject { post :create, params: { user: attributes_for(:user, :without_email) } }

      it { expect { subject }.not_to change { User.count } }
      it "renders :new template" do
        subject
        expect(response).to render_template :new
      end
    end
  end
end

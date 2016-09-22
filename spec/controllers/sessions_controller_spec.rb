require "rails_helper"

RSpec.describe SessionsController do

  describe "GET #new" do
    before { get :new }
    it{ expect(response).to have_http_status(:success) }
  end

  let(:user) { create(:user) }
  let(:login) { { session: { username: user.username, password: user.password }} }
  let(:invalid_login_param) { { session: { username: nil, password: user.password }} }

  describe "POST #create" do
    context "with valid attributes" do
      subject { post :create, params: login }
      it { expect { subject }.to change { session[:user_id] }.to eq(user.id) }
    end
    context "with invalid attributes" do
      subject { post :create, params: invalid_login_param }
      it { expect { subject }.not_to change { session[:user_id] } }
    end
  end

  describe "DELETE #destroy" do
    before { post :create, params: login }
    subject { post :destroy }
    it { expect{ subject }.to change { session[:user_id] } }
  end
end

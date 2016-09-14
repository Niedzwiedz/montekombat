require "rails_helper"

RSpec.describe User do
  let(:user) { create(:user) }

  context "with valid attributes" do
    context "can be member of multiple teams" do
      before do
        user.teams << create_list(:team, 2)
      end
      it { expect(user).to be_valid }
    end
    it "user has normal account" do
      expect(user.normal?).to eq(true)
    end
    context "has admin account" do
      before do
        user.admin!
      end
      it { expect(user.admin?).to eq(true) }
    end
  end

  context "with invalid attributes" do
    let(:user) { build(:user, username: "TheHops") }
    context "username doesn't exist" do
      before do
        user.username = nil
      end
      it { expect(user).not_to be_valid }
    end

    context "username isn't unique" do
      before do
        create(:user, username: "TheHops")
      end
      it { expect(user).not_to be_valid }
    end

    context "email doesn't exist" do
      before do
        user.email = nil
      end
      it { expect(user).not_to be_valid }
    end

    context "email doesn't have @" do
      before do
        user.email = "some-mail-without-at"
      end
      it { expect(user).not_to be_valid }
    end

    context "doesn't have firstname" do
      before do
        user.firstname = nil
      end
      it { expect(user).not_to be_valid }
    end

    context "doesn't have lastname" do
      before do
        user.lastname = nil
      end
      it { expect(user).not_to be_valid }
    end
  end
end

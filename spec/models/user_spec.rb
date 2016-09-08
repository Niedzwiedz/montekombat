require "rails_helper"

RSpec.describe User do
  let(:user) { build(:user) }

  context "When it's valid" do
    it "has email" do
      expect(user.email).to be_present
    end
    it "has username" do
      expect(user.username).to be_present
    end
    it "has firstname" do
      expect(user.firstname).to be_present
    end
    it "has lastname" do
      expect(user.lastname).to be_present
    end
    it "can be member of multiple teams" do
      user.teams << create(:team)
      user.teams << create(:team)
      expect(user).to be_valid
    end
    context "can have different account types" do
      it "is normal user" do
        expect(user.normal?).to eq(true)
      end
      it "is administrator" do
        user.admin!
        expect(user.admin?).to eq(true)
      end
    end
  end

  context "When it's invalid" do
    let(:user) { build(:user, username: "TheHops") }
    context "the username" do
      it "doesn't exist" do
        user.username = nil
        expect(user).not_to be_valid
      end

      it "isn't unique" do
        create(:user, username: "TheHops")
        expect(user).not_to be_valid
      end
    end

    context "the email" do
      it "doesn't exist" do
        user.email = nil
        expect(user).not_to be_valid
      end

      it "doesn't have @" do
        user.email = "some-mail-without-at"
        expect(user).not_to be_valid
      end
    end

    it "doesn't have firstname" do
      user.firstname = nil
      expect(user).not_to be_valid
    end

    it "doesn't have lastname" do
      user.lastname = nil
      expect(user).not_to be_valid
    end

    it "doesn't have account type" do
      user.account_type = nil
      expect(user).not_to be_valid
    end
  end
end

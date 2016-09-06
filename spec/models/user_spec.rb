require 'rails_helper'

RSpec.describe User do
  let(:user) { build(:user) }

  context "When it's valid" do
    it "should have email" do
      expect(user.email).to be_present
    end
    it "should have username" do
      expect(user.username).to be_present
    end
    it "should have firstname" do
      expect(user.firstname).to be_present
    end
    it "should have lastname" do
      expect(user.lastname).to be_present
    end
  end

  context "When it's invalid" do
    let(:user) { build(:user, username: 'TheHops')}
    context "the username" do
      it "doesn't exist" do
        user.username = nil
        expect(user).to_not be_valid
      end

      it "is too short" do
        user.username = "**"
        expect(user).to_not be_valid
      end

      it "is too long" do
        user.username = "more-than-15-signs"
        expect(user).to_not be_valid
      end

      it "isn't unique" do
        create(:user, username: 'TheHops')
        expect(user).to_not be_valid
      end

    end

    context "the email" do
      it "doesn't exist" do
        user.email = nil
        expect(user).to_not be_valid
      end

      it "doesn't have @" do
        user.email = 'some-mail-without-at'
        expect(user).to_not be_valid
      end
    end

    it "doesn't have firstname" do
      user.firstname = nil
      expect(user).to_not be_valid
    end

    it "doesn't have lastname" do
      user.lastname = nil
      expect(user).to_not be_valid
    end

  end
end

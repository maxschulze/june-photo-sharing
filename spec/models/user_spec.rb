require 'spec_helper'

describe User do
  describe "Factory" do
    it { build(:user).should be_valid }
  end

  describe "Associations" do
    # it { should have_and_belong_to_many(:stores) }
  end

  describe "Validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end
end

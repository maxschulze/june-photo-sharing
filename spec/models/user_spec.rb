require 'spec_helper'

describe User do
  describe "Factory" do
    it { build(:user).should be_valid }
  end

  describe "Associations" do
    it { should have_many(:photos) }
  end

  describe "Validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end
end

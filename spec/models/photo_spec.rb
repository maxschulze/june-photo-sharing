require 'spec_helper'

describe Photo do
  describe "Factory" do
    it { build(:photo).should be_valid }
  end

  describe "Associations" do
    it { should belong_to(:user) }
  end

  describe "Validations" do
    # it { should validate_presence_of(:attribute) }
  end
end

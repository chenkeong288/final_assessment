require 'rails_helper'

RSpec.describe User, type: :model do 
  let(:email) {"bruce@gmail.com"}
  let(:password) {"123"}
  let(:first_name) {"Bruce"}
  let(:last_name) {"Lee"}
  
  let(:user) { User.create(email: email, password: password, first_name: first_name, last_name: last_name) }

  context "association" do
    it { expect(user).to have_many(:listings) }
    it { expect(user).to have_many(:bookings) }
  end

  context "validation" do
    it { is_expected.to have_secure_password}
    it { is_expected.to validate_uniqueness_of(:email)}
  end

end
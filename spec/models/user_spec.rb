require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_one(:library) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end

  describe 'callbacks' do
    context 'after_create' do
      subject { User.new(email: 'user@email.com') }

      it 'creates library when creates a user' do
        expect {
          subject.save
        }.to change(Library, :count).by(1)
      end
    end
  end
end

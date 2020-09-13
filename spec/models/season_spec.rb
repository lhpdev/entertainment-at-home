require 'rails_helper'

RSpec.describe Season, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:episodes) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:plot) }
  end
end

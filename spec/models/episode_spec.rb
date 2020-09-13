require 'rails_helper'

RSpec.describe Episode, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:season) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:plot) }
    it { is_expected.to validate_presence_of(:episode_number) }
  end
end

require 'rails_helper'

RSpec.describe Library, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:purchase_options) }
  end
end

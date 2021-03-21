require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Valid User attributes' do
    let(:user) { build_stubbed :user, :valid }

    it 'is valid' do
      expect(user).to be_valid
    end

    it 'with unique email' do
      other_user = build(:user, email: 'valid_user@email.com')
      expect(other_user).to_not be_valid
    end
  end

  context 'Invalid User attributes' do
    let(:invalid_user) { build_stubbed :user, :invalid }

    it 'is not valid without password' do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid without email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid with password bellow 6 characters' do
      expect(invalid_user).not_to be_valid
    end
  end

  context 'associations' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
  end
end

require 'rails_helper'

RSpec.describe Season, type: :model do
  describe 'commit' do
    context 'when create' do
      let(:season) { build(:season, hits: 2, at_bats: 3) }

      it 'calculates batting average' do
        season.save

        expect(season.batting_avg).to eq(0.667)
      end
    end

    context 'when update' do
      let(:season) { create(:season) }
      it 'calculates batting average' do
        season.update!(hits: 3, at_bats: 5)

        expect(season.batting_avg).to eq(0.6)
      end
    end
  end
end

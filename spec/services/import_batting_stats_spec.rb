require 'rails_helper'

RSpec.describe ImportBattingStats do
  describe ".call" do
    subject(:call) { described_class.new(file).call }

    let(:file) { fixture_file_upload("batting_test.csv", "text/csv") }

    before do
      create(:team, year: 1871, public_id: 'TRO', name: 'TRO Baseball')
      create(:team, year: 1872, public_id: 'TRO', name: 'TRO Baseball 1872')
    end

    it 'creates expected records based on csv data' do
      expect { call }
        .to change { Player.count }.by(2)
        .and change { Season.count }.by(3)
        .and change { SeasonSegment.count }.by(4)
    end

    it "populates records with expected data from csv" do
      call

      player_1, player_2 = Player.all

      expect(player_1.public_id).to eq('abercda01')
      expect(player_2.public_id).to eq('allisar01')
      expect(player_1.seasons).to match_array([
        have_attributes(
          year: 1871,
          hits: 0,
          at_bats: 4,
          batting_avg: 0
        ),
        have_attributes(
          year: 1872,
          hits: 40, # 20(stint 1) + 20(stint 2)
          at_bats: 300, # 200(stint 1) + 100(stint 2)
          batting_avg: 0.133
        )
      ])
      expect(player_2.seasons).to match_array([
        have_attributes(
          year: 1872,
          hits: 40,
          at_bats: 80,
          batting_avg: 0.5
        )
      ])
    end
  end
end

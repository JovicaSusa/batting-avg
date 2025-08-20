FactoryBot.define do
  factory :season do
    player

    year { 1888 }
    hits { 1 }
    at_bats { 1 }
  end
end

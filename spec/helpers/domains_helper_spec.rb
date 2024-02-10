# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the DomainsHelper. For example:
#
# describe DomainsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe DomainsHelper do
  describe 'Format date' do
    it 'with the long format' do
      date = Time.zone.parse('2024-02-10 15:30:45')

      expect(helper.format_date(date)).to eq('February 10, 2024 15:30')
    end
  end
end

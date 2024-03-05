# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the JobsHelper. For example:
#
# describe JobsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe FeedbacksHelper do
  describe 'source_ip_list' do
    it 'return the first ip when there is only one' do
      record = double
      allow(record).to receive(:source_ip).and_return('240.0.0.1')

      records = [record]
      feedback = double
      allow(feedback).to receive(:records).and_return(records)

      expect(helper.source_ip_list(feedback)).to eq('240.0.0.1')
    end

    it 'return the first ip and the total count when there is more than one' do
      record = double
      allow(record).to receive(:source_ip).and_return('240.0.0.1')

      records = [record, record, record]
      feedback = double
      allow(feedback).to receive(:records).and_return(records)

      expect(helper.source_ip_list(feedback)).to eq('240.0.0.1 + 2 others IP')
    end
  end
end

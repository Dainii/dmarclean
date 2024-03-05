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
RSpec.describe JobsHelper do
  describe 'job_status' do
    it 'return the status when it exists' do
      status = double
      allow(status).to receive(:status).and_return(:success)

      expect(helper.job_status(status)).to eq('success')
    end

    it 'return Unknown when it does not exists' do
      status = double
      allow(status).to receive(:status).and_return(nil)

      expect(helper.job_status(status)).to eq('Unknown')
    end
  end
end

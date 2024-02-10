# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Feedback do
  subject(:feedback) { described_class.new }

  describe 'associations' do
    it { is_expected.to belong_to(:domain).optional(true) }
    it { is_expected.to belong_to(:organization).optional(true) }
  end
end

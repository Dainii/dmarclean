# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Domain do
  subject(:domain) { described_class.new }

  describe 'associations' do
    it { is_expected.to have_many(:feedbacks).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Organization do
  subject(:organization) { described_class.new }

  describe 'associations' do
    it { is_expected.to have_many(:feedbacks).dependent(:nullify) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end

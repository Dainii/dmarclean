# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ptr do
  describe 'return the associated PTR record' do
    it { expect(described_class.resolve('9.9.9.9')).to eq('dns9.quad9.net') }
  end
end

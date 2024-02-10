# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/domains').to route_to('domains#index')
    end

    it 'routes to #show' do
      expect(get: '/domains/1').to route_to('domains#show', id: '1')
    end
  end
end

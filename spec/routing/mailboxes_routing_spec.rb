# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MailboxesController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/mailboxes').to route_to('mailboxes#index')
    end

    it 'routes to #new' do
      expect(get: '/mailboxes/new').to route_to('mailboxes#new')
    end

    it 'routes to #show' do
      expect(get: '/mailboxes/1').to route_to('mailboxes#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/mailboxes/1/edit').to route_to('mailboxes#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/mailboxes').to route_to('mailboxes#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/mailboxes/1').to route_to('mailboxes#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/mailboxes/1').to route_to('mailboxes#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/mailboxes/1').to route_to('mailboxes#destroy', id: '1')
    end
  end
end

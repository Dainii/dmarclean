# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FeedbackUploadsController do
  describe 'routing' do
    it 'routes to #new' do
      expect(get: '/feedback_uploads/new').to route_to('feedback_uploads#new')
    end

    it 'routes to #create' do
      expect(post: '/feedback_uploads').to route_to('feedback_uploads#create')
    end
  end
end

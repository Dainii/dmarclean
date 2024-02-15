# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController do
  describe 'GET /' do
    context 'with an unauthenticated user' do
      before do
        get :index
      end

      it { is_expected.to respond_with(200) }
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'feedback_uploads/new' do
  before do
    assign(:feedback_upload, FeedbackUpload.new)
  end

  it 'renders new feedback_upload form' do
    render

    assert_select 'form[action=?][method=?]', feedback_uploads_path, 'post' do
      assert_select 'input[name=?]', 'feedback_upload[archives][]'
    end
  end
end

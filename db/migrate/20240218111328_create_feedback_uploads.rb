class CreateFeedbackUploads < ActiveRecord::Migration[7.1]
  def change
    create_table :feedback_uploads do |t|

      t.timestamps
    end
  end
end

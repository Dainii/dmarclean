class AddUniqueConstraintToFeedbackReportId < ActiveRecord::Migration[7.1]
  def change
    add_index :feedbacks, :report_id
    add_index :feedbacks, [:domain_id, :report_id], unique: true
  end
end

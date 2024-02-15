class ChangeFeedbackReportIDtoString < ActiveRecord::Migration[7.1]
  def change
    change_column :feedbacks, :report_id, :string
  end
end

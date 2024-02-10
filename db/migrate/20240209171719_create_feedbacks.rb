class CreateFeedbacks < ActiveRecord::Migration[7.1]
  def change
    create_table :feedbacks do |t|
      t.belongs_to :domain, null: true, foreign_key: true
      t.belongs_to :organization, null: true, foreign_key: true
      t.json :raw_content
      t.datetime :begin_date
      t.datetime :end_date
      t.float :report_id
      t.boolean :processed, default: false

      t.timestamps
    end
  end
end

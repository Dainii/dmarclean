class AddRelationJobSolidQueueJob < ActiveRecord::Migration[7.1]
  def change
    change_table :jobs do |t|
      t.belongs_to :solid_queue_job, foreign_key: true
    end
  end
end

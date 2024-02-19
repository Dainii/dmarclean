class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.string :job_id
      t.index :job_id, unique: true

      t.timestamps
    end
  end
end

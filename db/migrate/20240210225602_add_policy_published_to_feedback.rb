class AddPolicyPublishedToFeedback < ActiveRecord::Migration[7.1]
  def change
    add_column :feedbacks, :policy_published, :json
  end
end

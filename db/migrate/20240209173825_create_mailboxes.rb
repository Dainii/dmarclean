class CreateMailboxes < ActiveRecord::Migration[7.1]
  def change
    create_table :mailboxes do |t|
      t.string :mail_address
      t.string :password
      t.string :server
      t.integer :port
      t.boolean :verify_ssl, default: true
      t.boolean :disable_ssl_tls, default: false

      t.timestamps
    end
  end
end

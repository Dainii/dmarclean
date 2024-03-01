class CreateRodauthOtpSmsCodesRecoveryCodesWebauthn < ActiveRecord::Migration[7.1]
  def change
    # Used by the otp feature
    create_table :account_otp_keys, id: false do |t|
      t.bigint :id, primary_key: true
      t.foreign_key :accounts, column: :id
      t.string :key, null: false
      t.integer :num_failures, null: false, default: 0
      t.datetime :last_use, null: false, default: -> { "CURRENT_TIMESTAMP" }
    end

    # Used by the sms codes feature
    create_table :account_sms_codes, id: false do |t|
      t.bigint :id, primary_key: true
      t.foreign_key :accounts, column: :id
      t.string :phone_number, null: false
      t.integer :num_failures
      t.string :code
      t.datetime :code_issued_at, null: false, default: -> { "CURRENT_TIMESTAMP" }
    end

    # Used by the recovery codes feature
    create_table :account_recovery_codes, primary_key: [:id, :code] do |t|
      t.bigint :id
      t.foreign_key :accounts, column: :id
      t.string :code
    end

    # Used by the webauthn feature
    create_table :account_webauthn_user_ids, id: false do |t|
      t.bigint :id, primary_key: true
      t.foreign_key :accounts, column: :id
      t.string :webauthn_id, null: false
    end
    create_table :account_webauthn_keys, primary_key: [:account_id, :webauthn_id] do |t|
      t.references :account, foreign_key: true
      t.string :webauthn_id
      t.string :public_key, null: false
      t.integer :sign_count, null: false
      t.datetime :last_use, null: false, default: -> { "CURRENT_TIMESTAMP" }
    end
  end
end

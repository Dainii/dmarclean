# frozen_string_literal: true

if config.dsn = ENV.fetch('SENTRY_DSN', nil)
  Sentry.init do |config|
    config.dsn = ENV.fetch('SENTRY_DSN', nil)
    config.breadcrumbs_logger = %i[active_support_logger http_logger]

    config.traces_sampler = lambda do |sampling_context|
      # transaction_context is the transaction object in hash form
      # keep in mind that sampling happens right after the transaction is initialized
      # for example, at the beginning of the request
      transaction_context = sampling_context[:transaction_context]

      # transaction_context helps you sample transactions with more sophistication
      # for example, you can provide different sample rates based on the operation or name
      op = transaction_context[:op]
      transaction_name = transaction_context[:name]

      case op
      when /request/
        case transaction_name
        when /check/
          0.0 # ignore health_check requests
        else
          1.0
        end
      else
        0.0 # ignore all other transactions
      end
    end
  end
end

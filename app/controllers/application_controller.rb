# frozen_string_literal: true

class ApplicationController < ActionController::Base
  around_action :switch_locale

  def switch_locale(&)
    locale = extract_locale
    I18n.with_locale(locale, &)
  end

  def extract_locale
    if request.env['HTTP_ACCEPT_LANGUAGE']
      logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"

      locale = extract_locale_from_accept_language_header
      logger.debug "* Extracted locale: #{locale}"

      I18n.locale_available?(locale) ? locale : I18n.default_locale
    else
      I18n.default_locale
    end
  end

  private

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  def current_account
    rodauth.rails_account
  end
  helper_method :current_account
end

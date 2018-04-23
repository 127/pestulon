class ApplicationController < ActionController::Base
  before_action :set_locale
  protect_from_forgery with: :exception

  def set_locale
    #  params[:locale] ||
    I18n.locale = params[:locale] || I18n.default_locale  || extract_locale_from_accept_language_header #|| I18n.default_locale
  end

  def default_url_options(options={})
    { :locale => I18n.locale }
  end
  
  private

    def extract_locale_from_accept_language_header
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end
end

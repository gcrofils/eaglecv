# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.


class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user, :current_user_session
  #before_filter :set_locale
  before_filter :load_locales
  before_filter :set_locale_from_url
  before_filter :set_preferred_language
  
  I18n.record_missing_keys = true
  
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
   filter_parameter_logging :password, :password_confirmation
  
  private
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to account_url
      return false
    end
  end
  
  def store_location
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  def load_locales
    @loaded_locales ||= Locale.find(:all)
  end
  
  # Verifies if the specified locale is among loaded.
  # locale_str: string with 2-letter language code like "de", "nl"
  def valid_locale?(locale_str)
    @loaded_locales.any? { |loc| loc.short == locale_str }
  end

  # Makes sure that up-to-date translations for the fallback and current locales are
  # available to the application. Sets the active locale.
  def set_locale_with_fallback(locale)
    # Loading the default (fallback) locale
    set_locale Locale.find_main_cached.short.to_sym

    # Loading the current locale
    current_locale = @loaded_locales.detect { |loc| loc.short.to_sym == locale }
    if current_locale && current_locale != Locale.find_main_cached
      set_locale current_locale.short.to_sym
      @current_locale = current_locale
    else
      @current_locale = Locale.find_main_cached
    end
  end
  
  def set_preferred_language
    set_locale_with_fallback I18n.locale.to_sym
  end
  
  #def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
    #I18n.locale = params[:locale]
  #end
  
  #def default_url_options(options={})
   # logger.debug "default_url_options is passed options: #{options.inspect}\n"
  #  { :locale => I18n.locale }
  #end
end

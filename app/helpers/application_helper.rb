# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def translate(key, options = {})
    options[:raise] = false
    I18n.translate(scope_key_by_partial(key), options)
  rescue I18n::MissingTranslationData => e
    keys = I18n.send(:normalize_translation_keys, e.locale, e.key, e.options[:scope])
    content_tag('span', keys.join(', '), :class => 'translation_missing')
  end
  alias :t :translate
  
  
end

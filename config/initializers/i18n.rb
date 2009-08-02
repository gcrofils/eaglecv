#Dir.glob(Rails.root.join('vendor', 'plugins', 'i18n', 'lib', '**', '*.rb')).each{|f| require f}
#Dir.glob(Rails.root.join('vendor', 'plugins', 'i18n', 'lib', '**', 'chain.rb')).each{|f| require f}
require "i18n/backend/fallbacks"
#I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
#I18n.fallbacks[:fr]

# preserves an existing Simple backend set to I18n.backend
#I18n.backend = I18n::Backend::Chain.new(I18nDb::DbLoader.new, I18n.backend)
require 'spree_core'
require 'spree_comments_hooks'

module SpreeComments
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
      Ability.register_ability(CommentsAbility)
    end

    config.to_prepare &method(:activate).to_proc
  end
end
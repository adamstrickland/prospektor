module ActionView
  module Helpers
    module AssetTagHelper
      def stylesheet_link_tag_with_system(*sources)
        stylesheet_link_tag_without_system(sources.map{|s| "system/#{s}"})
      end
      def thirdparty_stylesheet_link_tag(*sources)
        stylesheet_link_tag_without_system(sources.map{|s| "thirdparty/#{s}"})
      end
      alias_method_chain :stylesheet_link_tag, :system
      alias_method :system_stylesheet_link_tag, :stylesheet_link_tag_with_system
    end
  end
end
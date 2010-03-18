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

module ActionMailer
  class Base
    def perform_delivery_smtp(mail)
      destinations = mail.destinations
      mail.ready_to_send
      sender = (mail['return-path'] && mail['return-path'].spec) || Array(mail.from).first
 
      smtp = Net::SMTP.new(smtp_settings[:address], smtp_settings[:port])
      smtp.enable_starttls_auto if smtp_settings[:enable_starttls_auto] && smtp.respond_to?(:enable_starttls_auto)
      smtp.start(smtp_settings[:domain], smtp_settings[:user_name], smtp_settings[:password], smtp_settings[:authentication]) do |smtp|
        smtp.sendmail(mail.encoded, sender, destinations)
      end
    end
  end
end
require_dependency 'issue'

# Patches Redmine's Issues dynamically.
module IssuePatch
  def self.included(base) # :nodoc:
    base.extend(ClassMethods)

    base.send(:include, InstanceMethods)

    # Same as typing in the class
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
    end
  end

  # Class Methods
  module ClassMethods
    def zendesk_settings
      Setting.plugin_redmine_zendesk_issue_bridge || {}
    end
  end

  # Instance Methods
  module InstanceMethods
    def related_zendesk_tickets
      tickets = []
      retrieved = zendesk_client.search query: "fieldvalue:#{id}"
      retrieved.each do |ticket|
        tickets << ticket if matches_on_custom_field?(ticket[:fields])
      end
      tickets
    rescue
      []
    end

    def zendesk_subdomain
      Issue.zendesk_settings[:zendesk_subdomain]
    end

    private

    ##
    # Match on Custom Field
    def matches_on_custom_field?(custom_fields = [])
      custom_fields.each do |f|
        next if f.id != Issue.zendesk_settings[:zendesk_custom_field_id].to_i
        next if f.value.nil?
        tickets = f.value.split(/,\s?/).map(&:strip)
        return true if tickets.include?(id.to_s)
      end
      false
    end

    ##
    # Zendesk Client
    def zendesk_client
      require 'zendesk_api'
      ZendeskAPI::Client.new do |config|
        subdomain = Issue.zendesk_settings[:zendesk_subdomain]
        config.url = "https://#{subdomain}.zendesk.com/api/v2" # e.g. https://mydesk.zendesk.com/api/v2
        config.username = Issue.zendesk_settings[:zendesk_username]
        config.password = Issue.zendesk_settings[:zendesk_password]
        config.retry = true
      end
    end
  end
end

# Add module to Issue
Issue.send(:include, IssuePatch)

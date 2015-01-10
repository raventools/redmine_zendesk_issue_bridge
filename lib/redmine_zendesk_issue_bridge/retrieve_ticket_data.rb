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
      retrieved = retrieve_from_api
      retrieved.each do |ticket|
        tickets << ticket if matches_on_custom_field?(ticket[:fields])
      end
      tickets
    end

    def zendesk_subdomain
      Issue.zendesk_settings[:zendesk_subdomain]
    end

    private

    # Match on Custom Field
    def matches_on_custom_field?(custom_fields = [])
      custom_fields.each do |field|
        return true if field.id == Issue.zendesk_settings[:zendesk_custom_field_id].to_i && field.value.include?(id.to_s)
      end
      false
    end

    # Retrieve related tickets from API
    def retrieve_from_api
      zendesk_client.search(
        query: "fieldvalue:#{id}"
      )
    end

    ##
    # Zendesk Client
    def zendesk_client
      require 'zendesk_api'
      ZendeskAPI::Client.new do |config|
        config.url = "https://#{Issue.zendesk_settings[:zendesk_subdomain]}.zendesk.com/api/v2" # e.g. https://mydesk.zendesk.com/api/v2
        config.username = Issue.zendesk_settings[:zendesk_username]
        config.password = Issue.zendesk_settings[:zendesk_password]
        config.retry = true
        # Logger prints to STDERR by default, to e.g. print to stdout:
        require 'logger'
        config.logger = Logger.new(STDOUT)
      end
    end
  end
end

# Add module to Issue
Issue.send(:include, IssuePatch)

module RedmineZendeskIssueBridge
  module RetrieveTicketData
    def self.included(base) # :nodoc:
      base.extend(ClassMethods)

      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development
      end
    end
  end

  # Class Methods
  module ClassMethods
    def zendesk_settings
      Setting.plugin_redmine_zendesk_issue_bridge || {}
    end
  end
end

Issue.send(:include, RedmineZendeskIssueBridge::RetrieveTicketData)
#

# require_dependency 'issue'
#
# # Patches Redmine's Issues dynamically.
# module IssuePatch
#   def self.included(base) # :nodoc:
#     base.extend(ClassMethods)
#
#     # Same as typing in the class
#     base.class_eval do
#       unloadable # Send unloadable so it will not be unloaded in development
#     end
#   end
#
#   # Class Methods
#   module ClassMethods
#     def zendesk_settings
#       Setting.plugin_redmine_zendesk_issue_bridge || {}
#     end
#   end
# end
#
# # Add module to Issue
# Issue.send(:include, IssuePatch)

Redmine::Plugin.register :redmine_zendesk_issue_bridge do
  name 'Redmine Zendesk Issue Bridge'
  author 'Raven Tools'
  description 'Shows related Zendesk tickets in Redmine issues.'
  version '1.0.0'
  url 'https://github.com/raventools/redmine_zendesk_issue_bridge'
  author_url 'http://raventools.com/'

  settings :default => {'empty' => true}, :partial => 'settings/zendesk_settings'
end

require_dependency 'redmine_zendesk_issue_bridge/retrieve_ticket_data'
require_dependency 'redmine_zendesk_issue_bridge/hooks'

require_dependency 'redmine_zendesk_issue_bridge/hooks'

Redmine::Plugin.register :redmine_zendesk_issue_bridge do
  name 'Redmine Zendesk Issue Bridge'
  author 'Raven Tools'
  description 'Shows related ZenDesk tickets in Redmine issues.'
  version '0.0.1'
  url 'https://github.com/raventools/redmine_zendesk_issue_bridge'
  author_url 'http://raventools.com/'
end

# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
match 'issues/:id/redmine_zendesk_issue_bridge', :to => 'redmine_zendesk_issue_bridge#index', :via => 'get'
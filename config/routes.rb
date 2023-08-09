# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
match 'issues/:id/redmine_zendesk_issue_bridge', :to => 'redmine_zendesk_issue_bridge#index', :via => 'get'
put '/update_ticket_status/:ticket_id', to: 'redmine_zendesk_issue_bridge#update_ticket_status', as: 'update_ticket_status'
put '/update_ticket_field_value/:ticket_id', to: 'redmine_zendesk_issue_bridge#update_ticket_field_value', as: 'update_ticket_field_value'

module RedmineZendeskIssueBridge
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_issues_show_details_bottom, :partial => 'issues/related_zendesk_tickets'
  end
end
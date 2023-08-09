module RedmineZendeskIssueBridge
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_issues_show_description_bottom, :partial => 'issues/redmine_zendesk_issue_bridge_container'
  end
end

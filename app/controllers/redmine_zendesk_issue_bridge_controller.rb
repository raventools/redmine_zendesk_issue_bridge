# Redmine Zendesk Issue Bridge Controller
class RedmineZendeskIssueBridgeController < ApplicationController
  unloadable

  layout false
  before_action :require_login

  def index
    @zendesk_subdomain = Issue.zendesk_settings[:zendesk_subdomain]
    @related_zendesk_tickets = related_zendesk_tickets()
  end

private
	def related_zendesk_tickets
		tickets = []
		retrieved = zendesk_client.search query: "fieldvalue:#{params[:id]}"
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

	##
	# Match on Custom Field
	def matches_on_custom_field?(custom_fields = [])
		custom_fields.each do |f|
			next if f.id != Issue.zendesk_settings[:zendesk_custom_field_id].to_i
			next if f.value.nil?
			tickets = f.value.split(/,\s?/).map(&:strip)
			return true if tickets.include?(params[:id].to_s)
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

#       If the retrieved value you received is [], please try querying with the token. When retrieving the token, make sure to append "/token" to the username.
# 			config.token = "user_zendesk_token"
# 			config.username = "username/token"
			config.retry = true
		end
	end

end

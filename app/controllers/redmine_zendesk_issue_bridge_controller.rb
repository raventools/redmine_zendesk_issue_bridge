# Redmine Zendesk Issue Bridge Controller
class RedmineZendeskIssueBridgeController < ApplicationController
  unloadable

  layout false
  before_action :require_login

  def index
    @zendesk_subdomain = Issue.zendesk_settings[:zendesk_subdomain]
    @related_zendesk_tickets = related_zendesk_tickets()
  end

  def update_ticket_status
    ticket_id = params[:ticket_id]
    ticket = zendesk_client.tickets.find(id: ticket_id)
    if ticket
      status = params[:status]

      if status == 'hold'
        ticket.status = 'hold'
      elsif status == 'open'
        ticket.status = 'open'
      else
        render json: { success: false, message: 'Invalid status value.'}
        return
      end
      ticket.save
      render json: { success: true, message: 'Ticket status updated successfully.' }
    else
      Rails.logger.info("Ticket status: fail")
      render json: { success: false, message: 'Ticket not found.' }
    end
  end

  def update_ticket_field_value
      ticket_id = params[:ticket_id]
      ticket = zendesk_client.tickets.find(id: ticket_id)
      Rails.logger.info("Ticket found: #{ticket.inspect}")
      if ticket
        issueNumber = params[:issueNumber]
        ticket.custom_fields = [
          { id: 'custom_ticket_number', value: issueNumber }
        ]
        ticket.save
      end
  end

private
	def related_zendesk_tickets
		tickets = []
		retrieved = zendesk_client.search query: "fieldvalue:#{params[:id]}"
                if retrieved.empty?
                else
                  retrieved.each do |ticket|
                    next if tickets.any? { |t| t[:id] == ticket[:id] }
                    Rails.logger.info("Adding Ticket ID: #{ticket[:id]}")
                    tickets << ticket if matches_on_custom_field?(ticket[:fields])
                  end
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
			config.url = "https://elandsystems.zendesk.com/api/v2" # e.g. https://mydesk.zendesk.com/api/v2
                        config.username = "your zendesk username/token"
                        config.token = "your zendesk token"
                        config.retry = true
		end
	end

end

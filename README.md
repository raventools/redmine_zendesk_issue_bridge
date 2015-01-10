# Redmine to Zendesk Issue Bridge

This is a Redmine plugin that uses the Zendesk API to query a set custom field (e.g. Redmine Issue ID) to pull in a list of associated tickets to the issue view.

## Use case

- You use Zendesk to manage your customer support requests
- You use Redmine to manage your development team's bug fixes
- When you create a Redmine issue to address a customer ticket, you cross-reference it in the Zendesk ticket via a custom field
- You need to see a list of related tickets when viewing a Redmine issue

## Configuration

![](http://cl.ly/image/03082F0v260S/1-settings.png)

Provide:

- Custom field ID (from Zendesk)
- Subdomain for Zendesk install (e.g. `example` for `example.zendesk.com`)
- A username to retrieve ticket detais
- A password to retrieve ticket details

## In Action

![](http://cl.ly/image/3k3F363B3H39/2-related-tickets.png)
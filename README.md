# Redmine to Zendesk Issue Bridge

This is a Redmine plugin that uses the Zendesk API to query a set custom field (e.g. Redmine Issue ID) to pull in a list of associated tickets to the issue view. Additionaly, it will cache a count of issues in a custom field to allow for sorting and filtering.

## TODO

### Setup

- [x] Use a plugin template to get started with integration
- [x] Load the [Zendesk gem](https://github.com/zendesk/zendesk_api_client_rb) for this plugin
- [x] Store the relevant credentials and custom field ID as configuration values

### Issue View

- [x] Add text block to issue detail
- [x] Use API to query list of matching issues on configured custom field
- [x] Display list with links (and relevant meta data, e.g. ticket status)

### Table View

- [ ] Add column to issue table (custom field?)
- [ ] Update custom field value with count of related Zendesk tickets (per view? cron task?) 

# Redmine to Zendesk Issue Bridge

This is a Redmine plugin that uses the Zendesk API to query a particular custom field (e.g. Redmine Issue ID) to pull in a list of associated tickets to the issue view. It has been tested with Redmine 2.6.x.

## Use Case

- You use Zendesk to manage your customer support requests
- You use Redmine to manage your development team's bug fixes
- When you create a Redmine issue to address a customer ticket, you cross-reference it in the Zendesk ticket via a custom field
- You need to see a list of related tickets when viewing a Redmine issue

## Installation

Installs the same as any Redmine 2.x plugin. Please [read this guide](http://www.redmine.org/projects/redmine/wiki/Plugins#Installing-a-plugin) for basic tips.

1. Unzip or clone into to your `./plugins` folder (e.g. `/path/to/redmine/plugins/redmine_zendesk_issue_bridge`)
2. Run `bundle exec rake redmine:plugins:migrate RAILS_ENV=production` from your Redmine root directory to pick up the necessary Gems
3. Restart your Redmine instance
4. Go to `Administration` > `Plugins` to verify that the plugin is shown
5. Click `Configure`

## Configuration

![](http://cl.ly/image/03082F0v260S/1-settings.png)

- [Custom field ID](https://github.com/raventools/redmine_zendesk_issue_bridge/wiki/How-to-find-the-Custom-Field-ID) (from Zendesk)
- Subdomain for Zendesk install (e.g. `example` for `example.zendesk.com`)
- A username to retrieve ticket detais
- A password to retrieve ticket details

## In Action

![](http://cl.ly/image/3k3F363B3H39/2-related-tickets.png)

## Contributing

1. Fork it ( https://github.com/raventools/redmine_zendesk_issue_bridge/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

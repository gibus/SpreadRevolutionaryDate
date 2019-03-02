# SpreadRevolutionaryDate

Spread date and time from Revolutionary (Republican) Calendar on Twitter, Mastodon and Freenode.

## Dependencies

* `Perl`
* `DateTime::Calendar::FrenchRevolutionary`
* `Net::Twitter::Lite::WithAPIv1_1`
* `Mastodon::Client`
* `Bot::BasicBot`

## Beta release disclaimer

Obviously, version 0.01 should be considered as beta release. It lacks documentation, comments, tests, configuration management, command line options parsing, helper functions to record the application in spread targets (Mastodon, Twitter, Freenode), and lots of polishing. But it is published as is to comply the Free Software philosophy "Release early, release often" (and to please some friends who asked for it).

Nevertheless it works! And it is used every day in a cron task to spread revolutionary date at #ACAB time on Twitter, Mastodon and some Freenode channels.

## Installation and configuration

You have to edit the `bin/spread_revolutionary_date` script and replace configuration options in the beginning of the code when you see `<replace by actual value>` with your own values.

### Twitter

Spreading to Twitter requires you to register this application on [https://apps.twitter.com/](https://apps.twitter.com/) and replace values for `access_token_secret`, `consumer_secret`, `access_token`, and `consumer_key`.

### Mastodon

Spreading to Mastodon requires you to register this application on [https://<your mastodon instance>/settings/applications](https://mstdn.fr/settings/applications) and replace values for `instance`, `client_id`, `client_secret` and `access_token`.

### Freenode

Spreading to Freenode channels requires you to register a nickname, as specified on [https://freenode.net/kb/answer/registration](https://freenode.net/kb/answer/registration), replace values for `nickname`, `password`, `test_channels` and `channels`.

# NAME

spread-revolutionary-date - Spread date and time from Revolutionary (Republican) Calendar

# VERSION

version 0.08

# DESCRIPTION

`spread-revolutionary-date` is a [Free Software](https://www.gnu.org/philosophy/free-sw.html) that spreads the current date, expressed in [French Revolutionary calendar](https://en.wikipedia.org/wiki/French_Republican_calendar), to various social networks: [Twitter](https://twitter.com/), [Mastodon](https://mastodon.social/), and the [Freenode](https://freenode.net/) Internet Relay Chat network. And you can easily extend these defaults targets with any desired one, see ["EXTENDING TO NEW TARGETS"](#extending-to-new-targets).

The French Revolutionary calendar, also called Republican calendar, was introduced during the [French Revolution](https://en.wikipedia.org/wiki/French_Revolution), and used from late 1793 to 1805, and also during the [Paris Commune](https://en.wikipedia.org/wiki/Paris_Commune) in 1871. This was an attempt to get rid of religious and royalist references found in Gregorian calendar when naming measures of Time. Months were given new names based on nature, each day of the year, instead of being named after an associated saint, had a unique name associated with the rural economy: agricultural tools, common animals, grains, pastures, trees, roots, flowers, fruits, plants, and minerals. But this was also an attempt to give more rational in measuring Time, basing measures on decimal system. Instead of weeks, each month was divided into exactly 3 _décades_, that is ten days; days were divided into ten hours; hours into 100 minutes; and minutes into 100 seconds.

You **must** have a registering account on each of the targets you want to spread the revolutionary date. And you must get credentials for `spread-revolutionary-date` to post on Twitter and Mastodon. Finally, you have to configure `spread-revolutionary-date` to use these credentials, see ["CONFIGURATION"](#configuration) and ["COMMAND LINE PARAMETERS"](#command-line-parameters) below.

The revolutionary date and time is computed thanks to the [DateTime::Calendar::FrenchRevolutionary](https://metacpan.org/pod/DateTime::Calendar::FrenchRevolutionary) Perl module, by Jean Forget.

# USAGE

    # Just execute the script in your shell
    # to spread current date to configured accounts on Twitter, Mastodon and Freenode:
    $ spread-revolutionary-date

    # Or, since this script do nothing but calling the L<App::SpreadRevolutionaryDate> Perl module,
    # use this one-liner:
    $ perl -MApp::SpreadRevolutionaryDate -e 'App::SpreadRevolutionaryDate->new->spread;'

    # Test spreading to Mastodon only:
    $ spread-revolutionary-date --targets=mastodon --test

    # Test spreading to Twitter only in English:
    $ spread-revolutionary-date --targets=twitter --test --locale=en

    # Spread to Twitter and Freenode explicit channels
    $ spread-revolutionary-date --targets=twitter \
        --targets=freenode \
        --freenode-channels='#revolution' \
        --freenode-channels='#acab'

# CONFIGURATION

Once again: you **have to** configure `spread-revolutionary-date` with credentials for registered account on each of the desired targets, so it can spread the revolutionary date on behalf of these accounts.

Configuration options may also be specified as command line parameters, see ["COMMAND LINE PARAMETERS"](#command-line-parameters) below, which take precedence on options of the configuration file.

The configuration file should lie on `~/.config/spread-revolutionary-date/spread-revolutionary-date.conf` or `~/.spread-revolutionary-date.conf`. In case a file is found on both paths, the second one is ignored. The configuration file should use the popular [INI file format](https://en.wikipedia.org/wiki/INI_file). A sample configuration file can be found in this distribution at `etc/sample-spread-revolutionary-date.conf`.

## General options

These options should appear outside of any section of the configuration file.

### targets

This option can be specified multiple time. It explicitly defines targets where the revolutionary date should be spread to. Any value set for this option should be a valid target: any of the three default targets (`twitter`, `mastodon`, or `freenode`) or some new target if you have extended this application (see ["EXTENDING TO NEW TARGETS"](#extending-to-new-targets)). If this option is not defined, the revolutionary date is spread on all of three default targets: `twitter`, `mastodon`, and `freenode`.

### locale

Spread with chosen language. As of [DateTime::Calendar::FrenchRevolutionary](https://metacpan.org/pod/DateTime::Calendar::FrenchRevolutionary) 0.14, locale is limited to 'en' or 'fr', defaults to 'fr'.

### test

Do no not actually spread the revolutionary date, just print it on standard output for Twitter and Mastodon, and send it on configured test channels for Freenode (see ["test\_channels"](#test_channels) below).

### acab

Instead of spreading the current date and time, pretend that decimal time is 1:31:20 (which corresponds to 03:08:56 UTC, 04:08:56 Paris winter time, or 05:08:56 Paris summer time, in sexagesimal scale used by common Anglo-Babylonian Time).

### twitter _DEPRECATED_

This option is _deprecated_ since version 0.07 of this distribution and may be removed in future release. Please use ["targets"](#targets) option below. Spread on Twitter explicitly. If none of the `twitter`, `mastodon`, `freenode` option is set, the revolutionary date is spread on all of these three targets.

### mastodon _DEPRECATED_

This option is _deprecated_ since version 0.07 of this distribution and may be removed in future release. Please use ["targets"](#targets) option below. Spread on Mastodon explicitly. If none of the `twitter`, `mastodon`, `freenode` option is set, the revolutionary date is spread on all of these three targets.

### freenode _DEPRECATED_

This option is _deprecated_ since version 0.07 of this distribution and may be removed in future release. Please use ["targets"](#targets) option below. Spread on Freenode explicitly. If none of the `twitter`, `mastodon`, `freenode` option is set, the revolutionary date is spread on all of these three targets.

## Twitter options

These options are credentials for `spread-revolutionary-date` to spread on a Twitter account. You have to get them from your [Twitter API account](https://apps.twitter.com/) with `write` access level.

### consumer\_key

Your Twitter Consumer API key for this application.

### consumer\_secret

Your Twitter Consumer API secret key for this application.

### access\_token

Your Twitter Access token for this application.

### access\_token\_secret

Your Twitter Access token secret for this application.

## Mastodon options

These options are credentials for `spread-revolutionary-date` to spread on a Mastodon account. You have to get them from your [Mastodon instance API account](https://mstdn.fr/settings/applications) with `write` scope. Note that Mastodon is a decentralized network with multiple instances, the previous link is for [mstdn.fr](https://mstdn.fr) instance, please replace url with your preferred instance.

### instance

The domain name of your instance, eg: `mastodon.social`, `mstdn.fr`, etc.

### client\_id

Your Mastodon Client key for this application.

### client\_secret

Your Mastodon Client secret for this application.

### access\_token

Your Mastodon Access token for this application.

## Freenode options

The first two options are credentials for `spread-revolutionary-date` to spread on a Freenode account. See [https://freenode.net/kb/answer/registration](https://freenode.net/kb/answer/registration) to find out how to register an account on Freenode.

### nickname

Your Freenode nickname.

### password

Your Freenode password.

### channels

This option can be specified multiple time. `spread-revolutionary-date` will spread on every channel specified with this option. This option should be specified at least one time if ["test"](#test) option is not set. It is ignored if ["test"](#test) option is set.

### test\_channels

This option can be specified multiple time. `spread-revolutionary-date` will spread on every channel specified with this option. This option should be specified at least one time if ["test"](#test) option is set. It is ignored if ["test"](#test) option is not set.

# COMMAND LINE PARAMETERS

Any command line parameter takes precedence on the corresponding option specified on the confiuration file, see [""CONFIGURATION"](#configuration) below.

## General parameters

### --targets | -tg

Same as ["targets"](#targets) configuration option below.

### --locale | -l

Same as ["locale"](#locale) configuration option below.

### --test | --no | -n

Same as ["test"](#test) configuration option below.

### --acab | -a

Same as ["acab"](#acab) configuration option below.

### --twitter | -t _DEPRECATED_

Same as ["twitter"](#twitter) configuration option below.

### --mastodon | -m _DEPRECATED_

Same as ["mastodon"](#mastodon) configuration option below.

### --freenode | -f _DEPRECATED_

Same as ["freenode"](#freenode) configuration option below.

## Twitter parameters

These parameters specify credentials for `spread-revolutionary-date` to spread on a Twitter account. You have to get them from your [Twitter API account](https://apps.twitter.com/) with `write` access level.

### --twitter-consumer\_key | -tck

Same as ["consumer\_key"](#consumer_key) configuration option below.

### --twitter-consumer\_secret | -tcs

Same as ["consumer\_secret"](#consumer_secret) configuration option below.

### --twitter-access\_token | -tat

Same as ["access\_token"](#access_token) configuration option below.

### --twitter-access\_token\_secret | -tats

Same as ["access\_token\_secret"](#access_token_secret) configuration option below.

## Mastodon parameters

These parameters specify credentials for `spread-revolutionary-date` to spread on a Mastodon account. You have to get them from your [Mastodon instance API account](https://mstdn.fr/settings/applications) with `write` scope. Note that Mastodon is a decentralized network with multiple instances, the previous link is for [mstdn.fr](https://mstdn.fr) instance, please replace url with your preferred instance.

### --mastodon-instance | -mi

Same as ["instance"](#instance) configuration option below.

### --mastodon-client\_id | -mci

Same as ["client\_id"](#client_id) configuration option below.

### --mastodon-client\_secret | -mcs

Same as ["client\_secret"](#client_secret) configuration option below.

### --mastodon-access\_token | -mat

Same as ["access\_token"](#access_token) configuration option below.

## Freenode parameters

The first two parameters are credentials for `spread-revolutionary-date` to spread on a Freenode account. See [https://freenode.net/kb/answer/registration](https://freenode.net/kb/answer/registration) to find out how to register an account on Freenode.

### --freenode-nickname | -fn

Same as ["nickname"](#nickname) configuration option below.

### --freenode-password | -fp

Same as ["password"](#password) configuration option below.

### --freenode-channels | -fc

Same as ["channels"](#channels) configuration option below.

### --freenode-test\_channels | -tc

Same as ["test\_channels"](#test_channels) configuration option below.

# EXTENDING TO NEW TARGETS

Version 0.07 of this distribution is a complete redesign of the API, taking advantage of [Moose](https://metacpan.org/pod/Moose), the postmodern object system for Perl 5, allowing to easily extend `spread-revolutionary-date` to other targets than the default ones (`Twitter`, `Mastondon` and `Freenode`.

To add a new target, you should write a new class in the `App::SpreadRevolutionaryDate::Target::` namespace (that is: the class should be `App::SpreadRevolutionaryDate::Target::Mytarget` for a new `Mytarget` target), that consumes the [App::SpreadRevolutionaryDate::Target](https://metacpan.org/pod/App::SpreadRevolutionaryDate::Target) role. See ["DESCRIPTION" in App::SpreadRevolutionaryDate::Target](https://metacpan.org/pod/App::SpreadRevolutionaryDate::Target#DESCRIPTION) for a comprehensive description of this role.

Such a target class is actually just a wrapper. Usually a target has to use an existing specific module (which can be a `Moose` class or not) to perform the actual work of posting a message according the specific target protocol, after having complied with any potential required authentication. Such authentication and posting should be carried on by the constructor or the required `spread` method of the target class.

To perform authentication and to post a message, there is a strong likelihood that the new target requires specific parameters (for eg. tokens, keys, account name, password, channels, etc.). These parameters should be defined as required attributes of the target class. Values for such attributes should be set in the [configuration file](#configuration), inside a section named after the target (`[mytarget]`), or as [command line parameters](#command-line-parameters) prefixed with the name of the target followed by a dash (`--mytarget-myparam`).

Should you extend `spread-revolutionary-date` to a new target, we advise you to have a look on how default targets are implemented: [App::SpreadRevolutionaryDate::Target::Twitter](https://metacpan.org/pod/App::SpreadRevolutionaryDate::Target::Twitter) with [Net::Twitter::Lite::WithAPIv1\_1](https://metacpan.org/pod/Net::Twitter::Lite::WithAPIv1_1) `worker`, [App::SpreadRevolutionaryDate::Target::Mastodon](https://metacpan.org/pod/App::SpreadRevolutionaryDate::Target::Mastodon) with [Mastodon::Client](https://metacpan.org/pod/Mastodon::Client) `worker`. Both are using [OAuth2 protocol](https://oauth.net/2/) to perform authentication. The third default target, `App::SpreadRevolutionaryDate::Target::Freenode`, uses a [chatbot](https://en.wikipedia.org/wiki/Chatbot): [App::SpreadRevolutionaryDate::Target::Freenode::Bot](https://metacpan.org/pod/App::SpreadRevolutionaryDate::Target::Freenode::Bot) subclassing [Bot::BasicBot](https://metacpan.org/pod/Bot::BasicBot). You can also see a very simple example with a test file provided in this distribution at `t/new_target.t`, which just prints out the revolutionary date on the standard input using core module [IO::Handle](https://metacpan.org/pod/IO::Handle).

# SEE ALSO

- [App::SpreadRevolutionaryDate](https://metacpan.org/pod/App::SpreadRevolutionaryDate)
- [DateTime::Calendar::FrenchRevolutionary](https://metacpan.org/pod/DateTime::Calendar::FrenchRevolutionary)
- [AppConfig](https://metacpan.org/pod/AppConfig)
- [Net::Twitter::Lite::WithAPIv1\_1](https://metacpan.org/pod/Net::Twitter::Lite::WithAPIv1_1)
- [Mastodon::Client](https://metacpan.org/pod/Mastodon::Client)
- [Bot::BasicBot](https://metacpan.org/pod/Bot::BasicBot)

# AUTHOR

Gérald Sédrati-Dinet <gibus@cpan.org>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2019 by Gérald Sédrati-Dinet.

This is free software, licensed under:

    The GNU General Public License, Version 3, June 2007

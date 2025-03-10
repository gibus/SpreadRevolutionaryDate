# NAME

spread-revolutionary-date - Spread date and time from Revolutionary (Republican) Calendar

# VERSION

version 0.44

# DESCRIPTION

`spread-revolutionary-date` is a [Free Software](https://www.gnu.org/philosophy/free-sw.html) that spreads the current date, expressed in the [French Revolutionary calendar](https://en.wikipedia.org/wiki/French_Republican_calendar), to various social networks: [Bluesky](https://bsky.app/), [Twitter](https://twitter.com/), [Mastodon](https://mastodon.social/), the [Freenode](https://freenode.net/) and [Liberachat](https://libera.chat/) Internet Relay Chat networks.

Moreover, you can easily extend these defaults targets with any desired one, see ["EXTENDING TO NEW TARGETS"](#extending-to-new-targets), and even spread something else than the revolutionary date, see ["msgmaker"](#msgmaker) option and ["EXTENDING TO NEW MESSAGE MAKERS"](#extending-to-new-message-makers).

The French Revolutionary calendar, also called Republican calendar, was introduced during the [French Revolution](https://en.wikipedia.org/wiki/French_Revolution), and used from late 1793 to 1805, and also during the [Paris Commune](https://en.wikipedia.org/wiki/Paris_Commune) in 1871. This was an attempt to get rid of religious and royalist references found in Gregorian calendar when naming measures of Time. Months were given new names based on nature, each day of the year, instead of being named after an associated saint, had a unique name associated with the rural economy: agricultural tools, common animals, grains, pastures, trees, roots, flowers, fruits, plants, and minerals. But this was also an attempt to give more rational in measuring Time, basing measures on decimal system. Instead of weeks, each month was divided into exactly 3 _décades_, that is ten days; days were divided into ten hours; hours into 100 minutes; and minutes into 100 seconds.

You **must** have a registered account on each of the targets you want to spread the revolutionary date. And you must get credentials for `spread-revolutionary-date` to post on Bluesky, Twitter and Mastodon. Finally, you have to configure `spread-revolutionary-date` to use these credentials, see ["CONFIGURATION"](#configuration) and ["COMMAND LINE PARAMETERS"](#command-line-parameters) below.

The revolutionary date and time is computed thanks to the [DateTime::Calendar::FrenchRevolutionary](https://metacpan.org/pod/DateTime::Calendar::FrenchRevolutionary) Perl module, by Jean Forget.

# USAGE

    # Just execute the script in your shell
    # to spread current date to configured accounts
    # to Bluesky, Twitter, Mastodon, Freenode and Liberachat:
    $ spread-revolutionary-date

    # Or, since this script does nothing but calling
    # the L<App::SpreadRevolutionaryDate> Perl module,
    # use this one-liner:
    $ perl -MApp::SpreadRevolutionaryDate \
        -e 'App::SpreadRevolutionaryDate->new->spread;'

    # Test spreading to Mastodon only:
    $ spread-revolutionary-date \
        --targets=mastodon --test

    # Test spreading to Twitter only in English:
    $ spread-revolutionary-date \
        --targets=twitter \
        --test \
        --locale en

    # Spread acab time to Twitter and Liberachat
    # explicit channels
    $ spread-revolutionary-date \
        --targets=twitter \
        --targets=liberachat \
        --liberachat_channels='#revolution' \
        --liberachat_channels='#acab' \
        --revolutionarydate_acab

    # Prompt user for a message to spread to mastodon
    $ spread-revolutionary-date \
        --targets=mastodon \
        --msgmaker=UserPrompt

    # Spread message as command line parameter to
    # Bluesky, Twitter, Mastodon, Freenode and Liberachat
    $ spread-revolutionary-date \
        --msgmaker=UserPrompt \
        --promptuser_default \

    # Spread message and image as command line parameter to
    # Mastodon and Bluesky
    $ spread-revolutionary-date \
        --msgmaker=UserPrompt \
        --targets=mastodon \
        --targets=bluesky \
        --promptuser_default \
          'This is my message to the world'
        --promptuser_img_path= \
          /my/path/to/image.png
        --promptuser_img_alt= \
          'Alternative text for image'

    # Spread message and image form web as command line parameter to
    # Mastodon and Bluesky
    $ spread-revolutionary-date \
        --msgmaker=UserPrompt \
        --targets=mastodon \
        --targets=bluesky \
        --promptuser_default \
          'This is my message to the world'
        --promptuser_img_url= \
          'https://example.com/imgs/my_image.jgp'
        --promptuser_img_alt \

    # Spread Téléchat date of the day on Mastodon and BlueSky
    $ spread-revolutionary-date \
        --msgmaker=Telechat \
        --targets=mastodon \
        --targets=bluesky \

# CONFIGURATION

Once again: you **have to** configure `spread-revolutionary-date` with credentials for registered account on each of the desired targets, so it can spread the revolutionary date on behalf of these accounts.

Configuration options may also be specified as command line parameters, see ["COMMAND LINE PARAMETERS"](#command-line-parameters) below, which take precedence on options of the configuration file.

The configuration file should lie on `~/.config/spread-revolutionary-date/spread-revolutionary-date.conf` or `~/.spread-revolutionary-date.conf`. In case a file is found on both paths, the second one is ignored. The configuration file should use the popular [INI file format](https://en.wikipedia.org/wiki/INI_file). A sample configuration file can be found in this distribution at `etc/sample-spread-revolutionary-date.conf`.

## General options

These options should appear outside of any section of the configuration file.

### targets

This option can be specified multiple times, with values as strings. It explicitly defines targets where the revolutionary date should be spread to. Any value set for this option should be a valid target: any of the five default targets (`Bluesky`, `twitter`, `mastodon`, `freenode`, or `liberachat`) or some new target if you have extended this application (see ["EXTENDING TO NEW TARGETS"](#extending-to-new-targets)). If this option is not defined, the revolutionary date is spread on all five default targets: `Bluesky`, `twitter`, `mastodon`, `freenode` and `liberachat`.

### msgmaker

This option can only be specified once, with a value as string. Spreads a message computed by the class defined by the value of this option, defaults to `RevolutionaryDate`. The `Value` (case sensitive) of this option should correspond to an existing `App::SpreadRevolutionaryDate::MsgMaker::Value` class consuming [App::SpreadRevolutionaryDate::MsgMaker](https://metacpan.org/pod/App::SpreadRevolutionaryDate::MsgMaker) role. Message makers values pre-defined in this distribution are `RevolutionaryDate`, which spreads the revolutionary date, `PromptUser`, which prompts the user for the message to be spread (with confirmation), and `Telechat`, which spreads the date of the day similar to the Belgian-French TV show 'Téléchat" on the 1980's. See ["EXTENDING TO NEW MESSAGE MAKERS"](#extending-to-new-message-makers) for details on using a new value for this option.

### locale

This option can only be specified once, with a value as string. Spreads with chosen language. As of [App::SpreadRevolutionaryDate](https://metacpan.org/pod/App::SpreadRevolutionaryDate) 0.11 locale is limited to `'fr'`, `'en'`, `'it'` or `'es'` for `RevolutionaryDate` and `'fr'`, `'en'`, `'it'`, `'es'` or `'de'` otherwise. Defaults to `'fr'` for `RevolutionaryDate` and `'en'` otherwise. To add more languages see ["INTERNATIONALIZATION AND LOCALIZATION"](#internationalization-and-localization).

### test

This boolean option takes no value, either it is defined or not. If defined, do not actually spread the revolutionary date, just print it on standard output for Bluesky, Twitter and Mastodon, and send it on configured test channels for Freenode and Liberachat (see ["test\_channels"](#test_channels) below).

## Bluesky options

These options are credentials for `spread-revolutionary-date` to spread on a Bluesky account. You have to get them from your [Bluesky account](https://bsky.app/). They should be defined in the `[bluesky]` section of the configuration file.

### identifier

This option can only be specified once, with a value as string: your Bluesky identifier (ending with `.bsky.social` by default).

### password

This option can only be specified once, with a value as string: your Bluesky password. You can define a special password for this application, in order to not use your main Bluesky password in your [Bluesky account settings](https://bsky.app/settings/app-passwords).

## Twitter options

These options are credentials for `spread-revolutionary-date` to spread on a Twitter account. You have to get them from your [Twitter API account](https://apps.twitter.com/) with `write` access level. They should be defined in the `[twitter]` section of the configuration file.

### consumer\_key

This option can only be specified once, with a value as string: your Twitter Consumer API key for this application.

### consumer\_secret

This option can only be specified once, with a value as string: your Twitter Consumer API secret key for this application.

### access\_token

This option can only be specified once, with a value as string: your Twitter Access token for this application.

### access\_token\_secret

This option can only be specified once, with a value as string: your Twitter Access token secret for this application.

## Mastodon options

These options are credentials for `spread-revolutionary-date` to spread on a Mastodon account. You have to get them from your [Mastodon instance API account](https://mstdn.fr/settings/applications) with `write` scope. Note that Mastodon is a decentralized network with multiple instances, the previous link is for [mstdn.fr](https://mstdn.fr) instance, please replace url with your preferred instance. They should be defined in the `[mastodon]` section of the configuration file.

### instance

This option can only be specified once, with a value as string: the domain name of your instance, eg: `mastodon.social`, `mstdn.fr`, etc.

### client\_id

This option can only be specified once, with a value as string: your Mastodon Client key for this application.

### client\_secret

This option can only be specified once, with a value as string: your Mastodon Client secret for this application.

### access\_token

This option can only be specified once, with a value as string: your Mastodon Access token for this application.

## Freenode options

The first two options are credentials for `spread-revolutionary-date` to spread on a Freenode account. See [https://freenode.net/kb/answer/registration](https://freenode.net/kb/answer/registration) to find out how to register an account on Freenode. They should be defined in the `[freenode]` section of the configuration file.

### nickname

This option can only be specified once, with a value as string: your Freenode nickname.

### password

This option can only be specified once, with a value as string: your Freenode password.

### channels

This option can be specified multiple times, with values as strings. `spread-revolutionary-date` will spread on every channel specified with this option. This option should be specified at least one time if ["test"](#test) option is not set. It is ignored if ["test"](#test) option is set.

### test\_channels

This option can be specified multiple times, with values as strings. `spread-revolutionary-date` will spread on every channel specified with this option. This option should be specified at least one time if ["test"](#test) option is set. It is ignored if ["test"](#test) option is not set.

## Liberachat options

The first two options are credentials for `spread-revolutionary-date` to spread on a Liberachat account. See [https://libera.chat/guides/registration](https://libera.chat/guides/registration) to find out how to register an account on Liberachat. They should be defined in the `[liberachat]` section of the configuration file.

### nickname

This option can only be specified once, with a value as string: your Liberachat nickname.

### password

This option can only be specified once, with a value as string: your Liberachat password.

### channels

This option can be specified multiple times, with values as strings. `spread-revolutionary-date` will spread on every channel specified with this option. This option should be specified at least one time if ["test"](#test) option is not set. It is ignored if ["test"](#test) option is set.

### test\_channels

This option can be specified multiple times, with values as strings. `spread-revolutionary-date` will spread on every channel specified with this option. This option should be specified at least one time if ["test"](#test) option is set. It is ignored if ["test"](#test) option is not set.

## RevolutionaryDate options

These options change the way revolutionary date is computed when  ["msgmaker"](#msgmaker) option is `RevolutionaryDate`. They should be defined in the `[revolutionarydate]` section of the configuration file.

### acab

This boolean option takes no value, either it is defined or not, defaults to `false`. If defined, instead of spreading the current date and time, pretend that decimal time is 1:31:20 (which corresponds to 03:08:56 UTC, 04:08:56 Paris winter time, or 05:08:56 Paris summer time, in sexagesimal scale used by common Anglo-Babylonian Time).

### wikipedia\_link

This boolean option takes no value, either it is defined or not, defaults to `true`. If defined, a link to the wikipedia page, in language defined by the [locale](https://metacpan.org/pod/locale) option, corresponding to the feast of the day, is added to the date to be spread.

## PromptUser option

If ["msgmaker"](#msgmaker) option is `PromptUser`, instead of spreading the revolutionary date, prompts the user (with confirmation) for the message to be spread, with a default value (if user enters nothing when prompted).

### default

This option can only be specified once, with a value as string. If `default` option is set, the user is not prompted and this default message is spread. If `default` option is not defined, the default message is `'Goodbye old world, hello revolutionary worlds'` if the user enters nothing when prompted. The `default` option should be defined in the `[promptuser]` section of the configuration file. It is only used if ["msgmaker"](#msgmaker) option is `PromptUser`.

### img\_path

This option can only be specified once, with a value as string valued by a path to an image file on local disk. The `img_path` option should be defined in the `[promptuser]` section of the configuration file. It is only used if ["msgmaker"](#msgmaker) option is `PromptUser`.

### img\_alt

This option can only be specified once, with a value as string valued by an alternative text to an image file specified by `img_path` or `img_url` options. The `img_alt` option should be defined in the `[promptuser]` section of the configuration file. It is only used if ["msgmaker"](#msgmaker) option is `PromptUser`.

### img\_url

This option can only be specified once, with a value as string valued by an external url to an image specified. The `img_url` option should be defined in the `[promptuser]` section of the configuration file. It is only used if ["msgmaker"](#msgmaker) option is `PromptUser`.

# COMMAND LINE PARAMETERS

Any command line parameter, other than the first three ones below, takes precedence on the corresponding option specified on the confiuration file, see ["CONFIGURATION"](#configuration) above.

## Command line only parameters

### --conf=&lt;file> | -c &lt;file>

Use `<file>` path as configuration file, instead of the default ones, see ["CONFIGURATION"](#configuration) above.

### --version | -v

Prints out the version of `spread-revolutionary-date`.

### --help | -h | -?

Prints out help with command line parameters.

## General parameters

### --targets=&lt;target> | -tg &lt;target>

Same as ["targets"](#targets) configuration option above.

### --msgmaker=<MsgMakerClass> | -mm <MsgMakerClass>

Same as ["msgmaker"](#msgmaker) configuration option above.

### --locale=&lt;fr|en|it|es> | -l &lt;fr|en|it|es>

Same as ["locale"](#locale) configuration option above.

### --test | --no | -n

Same as ["test"](#test) configuration option above.

## Bluesky parameters

These parameters specify credentials for `spread-revolutionary-date` to spread on a Bluesky account. You have to get them from your [Bluesky account](https://bsky.app/).

### --bluesky\_identifier=&lt;identifier> | -bi &lt;identifier>

Same as ["identifier"](#identifier) configuration option above.

### --bluesky\_password=&lt;password> | -bp &lt;password>

Same as ["password"](#password) configuration option above.

## Twitter parameters

These parameters specify credentials for `spread-revolutionary-date` to spread on a Twitter account. You have to get them from your [Twitter API account](https://apps.twitter.com/) with `write` access level.

### --twitter\_consumer\_key=&lt;key> | -tck &lt;key>

Same as ["consumer\_key"](#consumer_key) configuration option above.

### --twitter\_consumer\_secret=&lt;secret> | -tcs &lt;secret>

Same as ["consumer\_secret"](#consumer_secret) configuration option above.

### --twitter\_access\_token=&lt;token> | -tat &lt;token>

Same as ["access\_token"](#access_token) configuration option above.

### --twitter\_access\_token\_secret=&lt;token secret> | -tats &lt;token secret>

Same as ["access\_token\_secret"](#access_token_secret) configuration option above.

## Mastodon parameters

These parameters specify credentials for `spread-revolutionary-date` to spread on a Mastodon account. You have to get them from your [Mastodon instance API account](https://mstdn.fr/settings/applications) with `write` scope. Note that Mastodon is a decentralized network with multiple instances, the previous link is for [mstdn.fr](https://mstdn.fr) instance, please replace url with your preferred instance.

### --mastodon\_instance=&lt;instance> | -mi &lt;instance>

Same as ["instance"](#instance) configuration option above.

### --mastodon\_client\_id=&lt;id> | -mci &lt;id>

Same as ["client\_id"](#client_id) configuration option above.

### --mastodon\_client\_secret)&lt;secret> | -mcs &lt;secret>

Same as ["client\_secret"](#client_secret) configuration option above.

### --mastodon\_access\_token=&lt;token> | -mat &lt;token>

Same as ["access\_token"](#access_token) configuration option above.

## Freenode parameters

The first two parameters are credentials for `spread-revolutionary-date` to spread on a Freenode account. See [https://freenode.net/kb/answer/registration](https://freenode.net/kb/answer/registration) to find out how to register an account on Freenode.

### --freenode\_nickname=&lt;nick> | -fn &lt;nick>

Same as ["nickname"](#nickname) configuration option above.

### --freenode\_password=&lt;passwd> | -fp &lt;passwd>

Same as ["password"](#password) configuration option above.

### --freenode\_channels=&lt;channel> | -fc &lt;channel>

Same as ["channels"](#channels) configuration option above.

### --freenode\_test\_channels=&lt;channel> | -ftc &lt;channel>

Same as ["test\_channels"](#test_channels) configuration option above.

## Liberachat parameters

The first two parameters are credentials for `spread-revolutionary-date` to spread on a Liberachat account. See [https://libera.chat/guides/registration](https://libera.chat/guides/registration) to find out how to register an account on Liberachat.

### --liberachat\_nickname=&lt;nick> | -ln &lt;nick>

Same as ["nickname"](#nickname) configuration option above.

### --liberachat\_password=&lt;passwd> | -lp &lt;passwd>

Same as ["password"](#password) configuration option above.

### --liberachat\_channels=&lt;channel> | -lc &lt;channel>

Same as ["channels"](#channels) configuration option above.

### --liberachat\_test\_channels=&lt;channel> | -ltc &lt;channel>

Same as ["test\_channels"](#test_channels) configuration option above.

## RevolutionaryDate parameters

### --revolutionarydate\_acab | -ra

Same as ["acab"](#acab) configuration option above.

### --revolutionarydate\_wikipedia\_link

Same as ["wikipedia\_link"](#wikipedia_link) configuration option above.

## PromptUser parameter

### --promptuser\_default &lt;msg> | -pud &lt;msg>

Same as ["default"](#default) configuration option above.

### --promptuser\_img\_path &lt;path/to/image/file> | -pui &lt;/path/to/image/file>

Same as ["img\_path"](#img_path) configuration option above.

### --promptuser\_img\_alt &lt;alternative text> | -pud &lt;alternative text>

Same as ["img\_alt"](#img_alt) configuration option above.

### --promptuser\_default &lt;img\_url> | -pud &lt;img\_url>

Same as ["img\_url"](#img_url) configuration option above.

# EXTENDING TO NEW TARGETS

Starting from version 0.07, this distribution takes advantage of [Moose](https://metacpan.org/pod/Moose), the postmodern object system for Perl 5, allowing to easily extend `spread-revolutionary-date` to other targets than the default ones (`Bluesky`, `Twitter`, `Mastondon`, `Freenode` and `Liberachat`.

To add a new target, you should write a new class in the `App::SpreadRevolutionaryDate::Target::` namespace (that is: the class should be `App::SpreadRevolutionaryDate::Target::Mytarget` for a new `Mytarget` target), that consumes the [App::SpreadRevolutionaryDate::Target](https://metacpan.org/pod/App::SpreadRevolutionaryDate::Target) role. See ["DESCRIPTION" in App::SpreadRevolutionaryDate::Target](https://metacpan.org/pod/App::SpreadRevolutionaryDate::Target#DESCRIPTION) for a comprehensive description of this role.

The name of the target should be added as a value of the ["targets"](#targets) option in lower case.

Such a target class is actually just a wrapper. Usually a target has to use an existing specific module (which can be a `Moose` class or not) to perform the actual work of posting a message according the specific target protocol, after having complied with any potential required authentication. Such authentication should be carried on by the constructor or, along with posting, by the required `spread` method of the target class.

To perform authentication and to post a message, there is a strong likelihood that the new target requires specific parameters (e.g.: tokens, keys, account name, password, channels, etc.). These parameters should be defined as required attributes of the target class. Values for such attributes should be set in the [configuration file](#configuration), inside a section named after the target in lower case (`[mytarget]`), or as [command line parameters](#command-line-parameters) prefixed with the name of the target in lower case, followed by an underscore (`--mytarget_myparam`).

Should you extend `spread-revolutionary-date` to a new target, we advise you to have a look on how default targets are implemented: [App::SpreadRevolutionaryDate::Target::Bluesky](https://metacpan.org/pod/App::SpreadRevolutionaryDate::Target::Bluesky) with [App::SpreadRevolutionaryDate::BlueskyLite](https://metacpan.org/pod/App::SpreadRevolutionaryDate::BlueskyLite) `worker`, [App::SpreadRevolutionaryDate::Target::Twitter](https://metacpan.org/pod/App::SpreadRevolutionaryDate::Target::Twitter) with [Twitter::API](https://metacpan.org/pod/Twitter::API) `worker`, [App::SpreadRevolutionaryDate::Target::Mastodon](https://metacpan.org/pod/App::SpreadRevolutionaryDate::Target::Mastodon) with [Mastodon::Client](https://metacpan.org/pod/Mastodon::Client) `worker`. The last two are using [OAuth2 protocol](https://oauth.net/2/) to perform authentication. The third and fourth default targets, `App::SpreadRevolutionaryDate::Target::Freenode` <App::SpreadRevolutionaryDate::Target::Liberachat>, uses a [chatbot](https://en.wikipedia.org/wiki/Chatbot): [App::SpreadRevolutionaryDate::Target::Freenode::Bot](https://metacpan.org/pod/App::SpreadRevolutionaryDate::Target::Freenode::Bot) [App::SpreadRevolutionaryDate::Target::Liberachat::Bot](https://metacpan.org/pod/App::SpreadRevolutionaryDate::Target::Liberachat::Bot) subclassing [Bot::BasicBot](https://metacpan.org/pod/Bot::BasicBot). You can also see a very simple example with a test file provided in this distribution at `t/new_target.t`, which just prints out the revolutionary date on the standard output using core module [IO::Handle](https://metacpan.org/pod/IO::Handle).

Starting from version 0.39, you may have noticed that `Mastodon` and `Bluesky` targets can no spread not only a text message, but also an image (with alternative text). This is used by `Telechat` message maker, to post an image of Groucha, the presenter of Téléchat, and by `PromptUser` to send either an image file on local disk or an external image on the web.

This feature is not available now for _IRC_ targets, `Liberachat` and `Freenode`, since theses targets are mostly for text messages.

Also, we do not plan to extend this feature to `Twitter` target, since we recommand to not use this social network for political reasons.

# EXTENDING TO NEW MESSAGE MAKERS

It is even easier to spread whatever you want instead of the revolutionary date. You should write a new class in the `App::SpreadRevolutionaryDate::MsgMaker::` namespace (that is: the class should be `App::SpreadRevolutionaryDate::MsgMaker::MyMsgMaker` for a new `MyMsgMaker` message maker), that consumes the [App::SpreadRevolutionaryDate::MsgMaker](https://metacpan.org/pod/App::SpreadRevolutionaryDate::MsgMaker) role. See ["DESCRIPTION" in App::SpreadRevolutionaryDate::MsgMaker](https://metacpan.org/pod/App::SpreadRevolutionaryDate::MsgMaker#DESCRIPTION) for a comprehensive description of this role.

The name of the message maker should be set as a value of the ["msgmaker"](#msgmaker) option in lower case.

Such a message maker class is actually just a wrapper. Usually a message maker has to use an existing specific module (which can be a `Moose` class or not) to craft the message. [App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate](https://metacpan.org/pod/App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate) uses [DateTime::Calendar::FrenchRevolutionary](https://metacpan.org/pod/DateTime::Calendar::FrenchRevolutionary), while [App::SpreadRevolutionaryDate::MsgMaker::PromptUser](https://metacpan.org/pod/App::SpreadRevolutionaryDate::MsgMaker::PromptUser) is based on [IO::Prompt::Hooked](https://metacpan.org/pod/IO::Prompt::Hooked). You may need for example [LWP](https://metacpan.org/pod/LWP) to extract the message from a fetched web page or service, or [XML::Feed](https://metacpan.org/pod/XML::Feed) to build it from a [RSS](https://en.wikipedia.org/wiki/RSS) feed, or [DBI](https://metacpan.org/pod/DBI) to retrieve it from a database, or nothing at all to spread a fixed message, etc.

If your new message maker class needs specific parameters (other than `locale`, which comes with  [App::SpreadRevolutionaryDate::MsgMaker](https://metacpan.org/pod/App::SpreadRevolutionaryDate::MsgMaker) role), they should be defined as attributes of this class. Values for such attributes should be set in the [configuration file](#configuration), inside a section named after the message maker in lower case (`[mymsgmaker]`), or as [command line parameters](#command-line-parameters) prefixed with the name of the message maker in lower case, followed by an underscore (`--mytarget_myparam`).

Have a look to [App::SpreadRevolutionaryDate::MsgMaker::PromptUser](https://metacpan.org/pod/App::SpreadRevolutionaryDate::MsgMaker::PromptUser) or [App::SpreadRevolutionaryDate::MsgMaker::Telechat](https://metacpan.org/pod/App::SpreadRevolutionaryDate::MsgMaker::Telechat) classes, it shows simple examples on how to extend `spread-revolutionary-date` to a new message maker.

# INTERNATIONALIZATION AND LOCALIZATION

Starting from version 0.11, this distribution uses the widespread internationalization and localization system [gettext](https://en.wikipedia.org/wiki/Gettext), commonly used for writing multilingual programs. See [GNU gettext documentation](https://www.gnu.org/software/gettext/gettext.html) for details. From the point of view of a translator, this is rather simple.

Translators can find a portable object template `po/App-SpreadRevolutionaryDate.pot` which includes all translatable strings used by `spread-revolutionary-date` (but not translations of days, months, feasts used in the French Revolutionary Calendar, see below). They can copy this template to a portable object file of their language and translate strings of this file. For example, a German translator would work on `po/de.po`. All strings to be translated are laid down in lines beginning with `msgid` keyword, and translations should go on the next line beginning with keyword `msgstr`. E.g.:

    msgid "Please, enter message to spread"

A German translator would have to replace the next line:

    msgstr ""

by:

    msgstr "Bitte geben Sie die Nachricht zu verbreiten ein"

When the string to be translated includes some words in curly braces, these words are actually named variables and should be left as is in the translation. E.g.:

    msgid "or {abort} to abort"
    msgstr "oder {abort}, um abzubrechen"

And that's it! As of version 0.11 of `spread-revolutionary-date`, there is only about a dozen of strings to translate, mainly for `PromptUser` message maker. But with the possibility to extend to other message makers, you may need more and more strings to be translated.

Translating days, months and feasts used in the `RevolutionaryDate` message maker do not use the `gettext` system. Mainly because it uses [DateTime::Calendar::FrenchRevolutionary](https://metacpan.org/pod/DateTime::Calendar::FrenchRevolutionary) which proposes French and English translations in dedicated Perl modules. `spread-revolutionary-date` keeps the same way for translating expressions used in the French revolutionary calendar, but, thanks to [Moose::Role](https://metacpan.org/pod/Moose::Role) [App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale](https://metacpan.org/pod/App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale), translatable nominal groups have been isolated from other Perl code. Their translations lie in a consuming class in the `App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::` namespace for each translated language. These classes are named after the two-letter ([ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1)) or three-letter ([ISO 639-2](https://en.wikipedia.org/wiki/ISO_639-2) and [ISO 639-3](https://en.wikipedia.org/wiki/ISO_639-3)) lowercase abbreviation of the corresponding language. For example, a German translator would work on `App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::de` class.

Just copy the French class (from `lib/App/SpreadRevolutionaryDate/MsgMaker/RevolutionaryDate/Locale/fr.pm` file) into the desired language, change the name of the class and replace every French string. E.g.: the names of the months should be replace in:

    has '+months' => (
      default => sub {[
        'Vendémiaire', 'Brumaire',  'Frimaire',
        'Nivôse',      'Pluviôse',  'Ventôse',
        'Germinal',    'Floréal',   'Prairial',
        'Messidor',    'Thermidor', 'Fructidor',
        'jour complémentaire',
      ]},
    );

by names in German:

    has '+months' => (
      default => sub {[
        'Herbstmonat',    'Nebelmonat',  'Reifmonat',
        'Schneemonat',    'Regenmonat',  'Windmonat',
        'Keimmonat',      'Blütenmonat', 'Wiesenmonat',
        'Erntemonat',     'Hitzemonat',  'Fruchtmonat',
        'Ergänzungstage',
      ]},
    );

Feasts include a special trick, because they can be used in sentences like _this is `feast name` day_ or _c'est le jour de la `feast name`_. Depending on the language, it could then be prefixed or suffixed: in English it is suffixed by ` day`, whereas in French it is prefixed by `jour de la `. Prefixes are translated as an array of strings, while the suffix is translated in a single string. The reason is that in languages where the feast of the day is prefixed, the prefix often depends on the gender or the number of the noun used for the feast, or whereas this noun starts by a vowel, and other factors depending on the language. Therefore, each translation of the feast of each day should starts with a digit specifying the index (starting from 0) in the translated array of prefixes to use for this word. E.g.: with prefixes translated by `['jour du ', 'jour de la ', "jour de l'", 'jour des ']`, some feast can be translated by `'1carotte', '2amaranthe', '0panais'` (because you say: _jour de la carotte_, with prefix number `1`, _jour de l'amaranthe_, with prefix number `2`, and _jour du panais_, with prefix number `0`). If the language does not use any prefix before the feast of the day, each translation for the feast of the day should start with `0`, and the array of prefixes should include an empty string as its single element. If the language does not use a suffix after the feast of the day, the translation of the sufix should be an empty string.

Note also that any space in the name of the feast of the day should be replaced by an underscore (`_`).

Finally, these translation classes include a mapping between the feast of the day and the wikipedia entry for this word. This is useful when the feast of the day corresponds to an ambiguous entry, or a different word, in wikipedia. If the wikipedia entry is the same as the feast of the day, you can omit it. If the wikipedia entry is different from the feast of the day, you should add a line in the appropriate group of mappings for the considered month (groups of mappings are numbered from 1 to 13). In the left part of this new mapping you should use the feast of the day as you have translated it, but without the number indicating the prefix and with spaces, not underscores. And in the right part of this new mapping, you should use the wikipedia entry, i.e. the end of the wikipedia url. E.g.:

    has '+wikipedia_entries' => (
      default => sub {{
        2 => {
          'water chestnut' => 'Water_caltrop',
        },
        8 => {
          'hoe'            => 'Hoe_(tool)',
        },
      }},
    );

Because of the trick on prefix and suffix for feasts and the needed mapping for wikipedia entries, using the `gettext` system would be quite difficult. It wouldn't be an issue for translating names of months or days. But for consistency reasons, I'd rather group all these translations used in the French Revolutionary Calendar in the same translation class. Nevertheless, I'm open to find solutions if you think it would be easier to translate everything with the `gettext` system.

# SEE ALSO

- [App::SpreadRevolutionaryDate](https://metacpan.org/pod/App::SpreadRevolutionaryDate)
- [DateTime::Calendar::FrenchRevolutionary](https://metacpan.org/pod/DateTime::Calendar::FrenchRevolutionary)
- [AppConfig](https://metacpan.org/pod/AppConfig)
- [App::SpreadRevolutionaryDate::BlueskyLite](https://metacpan.org/pod/App::SpreadRevolutionaryDate::BlueskyLite)
- [Twitter::API](https://metacpan.org/pod/Twitter::API)
- [Mastodon::Client](https://metacpan.org/pod/Mastodon::Client)
- [Bot::BasicBot](https://metacpan.org/pod/Bot::BasicBot)

# AUTHOR

Gérald Sédrati <gibus@cpan.org>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2019-2025 by Gérald Sédrati.

This is free software, licensed under:

    The GNU General Public License, Version 3, June 2007

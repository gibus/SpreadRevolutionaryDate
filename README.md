# NAME

spread-revolutionary-date - Spread date and time from Revolutionary (Republican) Calendar

# VERSION

version 0.54

# DESCRIPTION

`spread-revolutionary-date` is a [Free Software](https://www.gnu.org/philosophy/free-sw.html) that spreads the current date, expressed in the [French Revolutionary calendar](https://en.wikipedia.org/wiki/French_Republican_calendar), to various social networks: [Mastodon](https://mastodon.social/), [Bluesky](https://bsky.app/), [Twitter](https://twitter.com/), the [Liberachat](https://libera.chat/) and [Freenode](https://freenode.net/) Internet Relay Chat networks.

Moreover, you can easily extend these defaults targets with any desired one, see ["EXTENDING TO NEW TARGETS"](#extending-to-new-targets), and even spread something else than the revolutionary date, see ["msgmaker"](#msgmaker) option and ["EXTENDING TO NEW MESSAGE MAKERS"](#extending-to-new-message-makers).

The French Revolutionary calendar, also called Republican calendar, was introduced during the [French Revolution](https://en.wikipedia.org/wiki/French_Revolution), and used from late 1793 to 1805, and also during the [Paris Commune](https://en.wikipedia.org/wiki/Paris_Commune) in 1871. This was an attempt to get rid of religious and royalist references found in Gregorian calendar when naming measures of Time. Months were given new names based on nature, each day of the year, instead of being named after an associated saint, had a unique name associated with the rural economy: agricultural tools, common animals, grains, pastures, trees, roots, flowers, fruits, plants, and minerals. But this was also an attempt to give more rational in measuring Time, basing measures on decimal system. Instead of weeks, each month was divided into exactly 3 _décades_, that is ten days; days were divided into ten hours; hours into 100 minutes; and minutes into 100 seconds.

You **must** have a registered account on each of the targets you want to spread the revolutionary date. And you must get credentials for `spread-revolutionary-date` to post on `Mastodon`, `Bluesky` and `Twitter`, and also for IA generated messages with _Gemini_ message maker. Finally, you have to configure `spread-revolutionary-date` to use these credentials, see ["CONFIGURATION"](#configuration) and ["COMMAND LINE PARAMETERS"](#command-line-parameters) below.

The revolutionary date and time is computed thanks to the [DateTime::Calendar::FrenchRevolutionary](https://metacpan.org/pod/DateTime%3A%3ACalendar%3A%3AFrenchRevolutionary) Perl module, by Jean Forget.

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
        --targets=Mastodon --test

    # Test spreading to Twitter only in English:
    $ spread-revolutionary-date \
        --targets=Twitter \
        --test \
        --locale en

    # Spread acab time to Twitter and Liberachat
    # explicit channels
    $ spread-revolutionary-date \
        --targets=Twitter \
        --targets=Liberachat \
        --liberachat_channels='#revolution' \
        --liberachat_channels='#acab' \
        --revolutionarydate_acab

    # Prompt user for a message to spread to Mastodon
    $ spread-revolutionary-date \
        --targets=Mastodon \
        --msgmaker=UserPrompt

    # Spread message as command line parameter to
    # Mastodon, Bluesky, Twitter, Liberachat and Freenode
    $ spread-revolutionary-date \
        --msgmaker=UserPrompt \
        --promptuser_default

    # Spread message and image as command line parameter to
    # Mastodon and Bluesky
    $ spread-revolutionary-date \
        --msgmaker=UserPrompt \
        --targets=Mastodon \
        --targets=Bluesky \
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
        --targets=Mastodon \
        --targets=Bluesky \
        --promptuser_default \
          'This is my message to the world'
        --promptuser_img_url= \
          'https://example.com/imgs/my_image.jgp'
        --promptuser_img_alt

    # Spread Téléchat date of the day on Mastodon and BlueSky
    $ spread-revolutionary-date \
        --msgmaker=Telechat \
        --targets=Mastodon \
        --targets=Bluesky

    # Spread Gemini generating an illustrated joke on Mastodon
    # NB: usually prompts are defined in configuration file along
    # with api_key, while --gemini-process is passed on command line
    # to choose which prompt to process
    $ spread-revolutionary-date \
        --targets=Mastodon \
        --msgmaker=Gemini \
        --gemini_api_key=ApiKey \
        --gemini_process=MacronJokeColuche \
        --gemini_prompt 'MacronJokeColuche=Invente-moi une blague \
          dans le style de Coluche sur Emmanuel Macron. Pas besoin \
          de dire "D\'accord, voici une blague" ou "Bien sûr, \
          voici une blague dans le style de Coluche sur Emmanuel \
          Macron" avant la blague.' \
        --gemini_img_path "MacronJokeColuche='/my/path/to/image.png'" \
        --gemini_img_alt "MacronJokeColuche='Caricature de Coluche \
          disant : « C’est l’histoire d’un mec… » avec une caricature \
          de macron'" \

    # Spread Gemini searching for real time weather on Mastodon
    # NB: usually prompts are defined in configuration file along
    # with api_key, while --gemini-process is passed on command line
    # to choose which prompt to process
    $ spread-revolutionary-date \
        --targets=Mastodon \
        --msgmaker=Gemini \
        --gemini_api_key=ApiKey \
        --gemini_process=MeteoParis \
        --gemini_prompt 'MeteoParis=Quelle est la météo aujourd\'hui \
          à Paris, avec la température, selon meteo-paris.com, ne devine \
          pas, va chercher l\'information.' \
        --gemini_search "MeteoParis=1"

    # Spread Gemini generating a list of celebrities with an url
    # prepended by an introdution on Mastodon
    # NB: usually prompts are defined in configuration file along
    # with api_key, while --gemini-process is passed on command line
    # to choose which prompt to process
    $ spread-revolutionary-date \
        --targets=Mastodon \
        --msgmaker=Gemini \
        --gemini_api_key=ApiKey \
        --gemini_process=FamousBirthday \
        --gemini_prompt 'FamousBirthday=Which famous people \
          have their birthday on $month_name $day? Give a list of up \
          to 6 people, then after the list give the unformatted URL of \
          the Wikipedia page of only one of them, no comments and no need \
          for an introduction like "Here are some famous people".' \
        --gemini_intro 'FamousBirthday=Famous people born on $month_name \
          $day for better or for worse:'

# CONFIGURATION

Once again: you **have to** configure `spread-revolutionary-date` with credentials for registered account on each of the desired targets and also for _Gemini_ message maker, so it can spread the revolutionary date or an IA generated message on behalf of these accounts.

Configuration options may also be specified as command line parameters, see ["COMMAND LINE PARAMETERS"](#command-line-parameters) below, which take precedence on options of the configuration file.

The configuration file should lie on `~/.config/spread-revolutionary-date/spread-revolutionary-date.conf` or `~/.spread-revolutionary-date.conf`. In case a file is found on both paths, the second one is ignored. The configuration file should use the popular [INI file format](https://en.wikipedia.org/wiki/INI_file). A sample configuration file can be found in this distribution at `etc/sample-spread-revolutionary-date.conf`.

## General options

These options should appear outside of any section of the configuration file.

### targets

This option can be specified multiple times, with values as strings. It explicitly defines targets where the revolutionary date should be spread to. Any value set for this option should be a valid target: any of the five default targets (`Mastodon`, `Bluesky`, `Twitter`, `Liberachat`, or `Freenode`) or some new target if you have extended this application (see ["EXTENDING TO NEW TARGETS"](#extending-to-new-targets)). If this option is not defined, the revolutionary date is spread on all five default targets: `Mastodon`, `Bluesky`, `Twitter`, `Liberachat`, or `Freenode`.

### msgmaker

This option can only be specified once, with a value as string. Spreads a message computed by the class defined by the value of this option, defaults to `RevolutionaryDate`. The `Value` (case sensitive) of this option should correspond to an existing `App::SpreadRevolutionaryDate::MsgMaker::Value` class consuming [App::SpreadRevolutionaryDate::MsgMaker](https://metacpan.org/pod/App%3A%3ASpreadRevolutionaryDate%3A%3AMsgMaker) role. Message makers values pre-defined in this distribution are `RevolutionaryDate`, which spreads the revolutionary date; `PromptUser`, which prompts the user for the message to be spread (with confirmation); `Telechat`, which spreads the date of the day similar to the Belgian-French TV show 'Téléchat" on the 1980's; and `Gemini` which prompts _Gemini_ AI to generate a message. See ["EXTENDING TO NEW MESSAGE MAKERS"](#extending-to-new-message-makers) for details on using a new value for this option.

### locale

This option can only be specified once, with a value as string. Spreads with chosen language. As of [App::SpreadRevolutionaryDate](https://metacpan.org/pod/App%3A%3ASpreadRevolutionaryDate) 0.11 locale is limited to `'fr'`, `'en'`, `'it'` or `'es'` for `RevolutionaryDate` and `'fr'`, `'en'`, `'it'`, `'es'` or `'de'` otherwise. Defaults to `'fr'` for `RevolutionaryDate` and `Gemini`, and to `'en'` for <PromptUser>. Locale is forced to 'fr' for `Telechat` since only french-spokers can understand the TV show. To add more languages see ["INTERNATIONALIZATION AND LOCALIZATION"](#internationalization-and-localization).

### test

This boolean option takes no value, either it is defined or not. If defined, do not actually spread the revolutionary date, just print it on standard output for `Mastodon`, `Bluesky` and `Twitter`, and send it on configured test channels for `Liberachat` and `Freenode` (see ["test\_channels"](#test_channels) below).

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

## RevolutionaryDate options

These options change the way revolutionary date is computed when  ["msgmaker"](#msgmaker) option is `RevolutionaryDate`. They should be defined in the `[revolutionarydate]` section of the configuration file.

### acab

This boolean option takes no value, either it is defined or not, defaults to `false`. If defined, instead of spreading the current date and time, pretend that decimal time is 1:31:20 (which corresponds to 03:08:56 UTC, 04:08:56 Paris winter time, or 05:08:56 Paris summer time, in sexagesimal scale used by common Anglo-Babylonian Time).

### wikipedia\_link

This boolean option takes no value, either it is defined or not, defaults to `true`. If defined, a link to the wikipedia page, in language defined by the [locale](https://metacpan.org/pod/locale) option, corresponding to the feast of the day, is added to the date to be spread.

## PromptUser options

If ["msgmaker"](#msgmaker) option is `PromptUser`, instead of spreading the revolutionary date, prompts the user (with confirmation) for the message to be spread, with a default value (if user enters nothing when prompted).

### default

This option can only be specified once, with a value as string. If `default` option is set, the user is not prompted and this default message is spread. If `default` option is not defined, the default message is `'Goodbye old world, hello revolutionary worlds'` if the user enters nothing when prompted. The `default` option should be defined in the `[PromptUser]` section of the configuration file. It is only used if ["msgmaker"](#msgmaker) option is `PromptUser`.

### img\_path (for PromptUser)

This option can only be specified once, with a value as string valued by a path to an image file on local disk. The `img_path` option should be defined in the `[PromptUser]` section of the configuration file. It is only used if ["msgmaker"](#msgmaker) option is `PromptUser`.

### img\_alt (for PromptUser)

This option can only be specified once, with a value as string valued by an alternative text to an image file specified by `img_path` or `img_url` options. The `img_alt` option should be defined in the `[PromptUser]` section of the configuration file. It is only used if ["msgmaker"](#msgmaker) option is `PromptUser`.

### img\_url (for PromptUser)

This option can only be specified once, with a value as string valued by an external url to a remote image. The `img_url` option should be defined in the `[PromptUser]` section of the configuration file. It is only used if ["msgmaker"](#msgmaker) option is `PromptUser`.

## Gemini options

If ["msgmaker"](#msgmaker) option is `Gemini`, instead of spreading the revolutionary date, requests _Gemini_ AI to generate a text from a prompt.

### api\_key

This option can only be specified once, with a value as string: your _Gemini_ API key. You have to get it following instructions on [https://ai.google.dev/gemini-api/docs/api-key](https://ai.google.dev/gemini-api/docs/api-key). The `api_key` option should be defined in the `[Gemini]` section of the configuration file. It is only used if ["msgmaker"](#msgmaker) option is `Gemini`.

### process

This option can only be specified once, with a value as string, telling which ["prompt"](#prompt) and other options below should be send to _Gemini_ AI. The `process` option should be defined in the `[Gemini]` section of the configuration file. It is only used if ["msgmaker"](#msgmaker) option is `Gemini`.

### prompt

This option can be specified for several prompts, each one with a key as a string, valued by the string configured for ["process"](#process) options above, and a value as string valued by the prompt to send to _Gemini_ AI. The `prompt` option should be defined in the `[Gemini]` section of the configuration file. It is only used if ["msgmaker"](#msgmaker) option is `Gemini`.

### intro

This option can be specified for several prompts, each one with a key as a string, valued by the string configured for ["process"](#process) options above, and a value as string to prepend to _Gemini_ answer. The `intro` option should be defined in the `[Gemini]` section of the configuration file. It is only used if ["msgmaker"](#msgmaker) option is `Gemini`.

### search

This option can be specified for several prompts, each one with a key as a string, valued by the string configured for ["process"](#process) options above, and a true value, telling _Gemini_ AI to use grounded sources (inline supporting links) and _Google Search_ suggestions. The `search` option should be defined in the `[Gemini]` section of the configuration file. It is only used if ["msgmaker"](#msgmaker) option is `Gemini`.

### img\_path (for Gemini)

This option can be specified for several prompts, each one with a key as a string, valued by the string configured for ["process"](#process) options above, and a value as string valued by a path to an image file on local disk. The `img_path` option should be defined in the `[Gemini]` section of the configuration file. It is only used if ["msgmaker"](#msgmaker) option is `Gemini`.

### img\_alt (for Gemini)

This option can be specified for several prompts, each one with a key as a string, valued by the string configured for ["process"](#process) options above, and a value as string valued by an alternative text to an image file specified by `img_path` or `img_url` options. The `img_alt` option should be defined in the `[Gemini]` section of the configuration file. It is only used if ["msgmaker"](#msgmaker) option is `Gemini`.

### img\_url (for Gemini)

This option can be specified for several prompts, each one with a key as a string, valued by the string configured for ["process"](#process) options above, and a value as string valued by an external url to a remote image. The `img_url` option should be defined in the `[Gemini]` section of the configuration file. It is only used if ["msgmaker"](#msgmaker) option is `Gemini`.

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

## RevolutionaryDate parameters

### --revolutionarydate\_acab | -ra

Same as ["acab"](#acab) configuration option above.

### --revolutionarydate\_wikipedia\_link

Same as ["wikipedia\_link"](#wikipedia_link) configuration option above.

## PromptUser parameters

### --promptuser\_default &lt;msg> | -pud &lt;msg>

Same as ["default"](#default) configuration option above.

### --promptuser\_img\_path &lt;path/to/image/file> | -pui &lt;/path/to/image/file>

Same as ["img\_path (for PromptUser)"](#img_path-for-promptuser) configuration option above.

### --promptuser\_img\_alt &lt;alternative text> | -pua &lt;alternative text>

Same as ["img\_alt (for PromptUser)"](#img_alt-for-promptuser) configuration option above.

### --promptuser\_img\_url &lt;img\_url> | -puu &lt;img\_url>

Same as ["img\_url"](#img_url) (for PromptUser) configuration option above.

## Gemini parameters

### --gemini\_api\_key &lt;api key> | -ga &lt;api key>

Same as ["api\_key"](#api_key) configuration option above.

### --gemini\_process <SomePrompt> | -g <SomePrompt>

Same as ["process"](#process) configuration option above.

### --gemini\_prompt "<SomePrompt>=&lt;my prompt string>" | -gp "<SomePrompt>=&lt;my prompt string>"

Same as ["process"](#process) configuration option above.

### --gemini\_intro "<SomePrompt>=&lt;intro msg>" | -gi "<SomePrompt>=&lt;intro msg>"

Same as ["process"](#process) configuration option above.

### --gemini\_search "<SomePrompt>=1" | -gs "<SomePrompt>=1"

Same as ["process"](#process) configuration option above.

### --gemini\_img\_path "<SomePrompt>=&lt;path/to/image/file>" | -gip "<SomePrompt>=&lt;/path/to/image/file>"

Same as ["img\_path (for Gemini)"](#img_path-for-gemini) configuration option above.

### --gemini\_img\_alt "<SomePrompt>=&lt;alternative text>" | -gia "<SomePrompt>=&lt;alternative text>"

Same as ["img\_alt (for Gemini)"](#img_alt-for-gemini) configuration option above.

### --gemini\_img\_url "<SomePrompt>=&lt;img\_url>" | -giu "<SomePrompt>=&lt;img\_url>"

Same as ["img\_url (for Gemini)"](#img_url-for-gemini) configuration option above.

# EXTENDING TO NEW TARGETS

Starting from version 0.07, this distribution takes advantage of [Moose](https://metacpan.org/pod/Moose), the postmodern object system for Perl 5, allowing to easily extend `spread-revolutionary-date` to other targets than the default ones (`Mastondon`, `Bluesky`, `Twitter`, `Liberachat` and `Freenode`.

To add a new target, you should write a new class in the `App::SpreadRevolutionaryDate::Target::` namespace (that is: the class should be `App::SpreadRevolutionaryDate::Target::Mytarget` for a new `Mytarget` target), that consumes the [App::SpreadRevolutionaryDate::Target](https://metacpan.org/pod/App%3A%3ASpreadRevolutionaryDate%3A%3ATarget) role. See ["DESCRIPTION" in App::SpreadRevolutionaryDate::Target](https://metacpan.org/pod/App%3A%3ASpreadRevolutionaryDate%3A%3ATarget#DESCRIPTION) for a comprehensive description of this role.

The name of the target should be added as a value of the ["targets"](#targets) option.

Such a target class is actually just a wrapper. Usually a target has to use an existing specific  `worker` module (which can be a `Moose` class or not) to perform the actual work of posting a message according the specific target protocol, after having complied with any potential required authentication. Such authentication should be carried on by the constructor or, along with posting, by the required `spread` method of the target class.

To perform authentication and to post a message, there is a strong likelihood that the new target requires specific parameters (e.g.: tokens, keys, account name, password, channels, etc.). These parameters should be defined as required attributes of the target class. Values for such attributes should be set in the [configuration file](#configuration), inside a section named after the target in lower case (`[mytarget]`), or as [command line parameters](#command-line-parameters) prefixed with the name of the target in lower case, followed by an underscore (`--mytarget_myparam`).

Should you extend `spread-revolutionary-date` to a new target, we advise you to have a look on how default targets are implemented: [App::SpreadRevolutionaryDate::Target::Bluesky](https://metacpan.org/pod/App%3A%3ASpreadRevolutionaryDate%3A%3ATarget%3A%3ABluesky) with [App::SpreadRevolutionaryDate::Target::Mastodon](https://metacpan.org/pod/App%3A%3ASpreadRevolutionaryDate%3A%3ATarget%3A%3AMastodon) with [Mastodon::Client](https://metacpan.org/pod/Mastodon%3A%3AClient) `worker`, [App::SpreadRevolutionaryDate::BlueskyLite](https://metacpan.org/pod/App%3A%3ASpreadRevolutionaryDate%3A%3ABlueskyLite) `worker`, and [App::SpreadRevolutionaryDate::Target::Twitter](https://metacpan.org/pod/App%3A%3ASpreadRevolutionaryDate%3A%3ATarget%3A%3ATwitter) with [Twitter::API](https://metacpan.org/pod/Twitter%3A%3AAPI) `worker`. `Mastodon` and `Twitter` are using [OAuth2 protocol](https://oauth.net/2/) to perform authentication. The other default targets, <App::SpreadRevolutionaryDate::Target::Liberachat> and `App::SpreadRevolutionaryDate::Target::Freenode`, use a [chatbot](https://en.wikipedia.org/wiki/Chatbot): [App::SpreadRevolutionaryDate::Target::Liberachat::Bot](https://metacpan.org/pod/App%3A%3ASpreadRevolutionaryDate%3A%3ATarget%3A%3ALiberachat%3A%3ABot) and [App::SpreadRevolutionaryDate::Target::Freenode::Bot](https://metacpan.org/pod/App%3A%3ASpreadRevolutionaryDate%3A%3ATarget%3A%3AFreenode%3A%3ABot), subclassing [Bot::BasicBot](https://metacpan.org/pod/Bot%3A%3ABasicBot) `worker`. You can also see a very simple example with a test file provided in this distribution at `t/new_target.t`, which just prints out the revolutionary date on the standard output using core module [IO::Handle](https://metacpan.org/pod/IO%3A%3AHandle).

Your new `App::SpreadRevolutionaryDate::Target::Mytarget` target class should consumes the [App::SpreadRevolutionaryDate::Target](https://metacpan.org/pod/App%3A%3ASpreadRevolutionaryDate%3A%3ATarget) role, by specifying the `worker` class:

    use Moose;
    with 'App::SpreadRevolutionaryDate::Target'
      => {worker => 'My::Worker::Class'};

Then, you have to add a hook, being called before `Moose` constructor, so to pass as an additional argument to `Moose` constructor, an instance of your `worker` class as `obj` attribute of your new target class. You may need some configuration parameters, like `worker_param` in the example below, to create an instance of your `worker` class:

    around BUILDARGS => sub {
      my ($orig, $class) = @_;
      my $args = $class->$orig(@_);
      my $args->{obj} = My::Worker::Class->new(worker_param => $args->{worker_param});
      return $args;
    }

Starting from version 0.39, you may have noticed that `Mastodon` and `Bluesky` targets can now spread not only a text message, but also an image, with an alternative text for accessibily purpose. If the alternative text is not provided, it is set with the name of the image file. This is used by `Telechat` message maker, to post an image of Groucha, the presenter of Téléchat, and by `PromptUser` and `Gemini` to send either an image file on local disk or an external image on the web.

This feature is not available now for _IRC_ targets, `Liberachat` and `Freenode`, since theses targets are mostly for text messages.

Also, we do not plan to extend this feature to `Twitter` target, since we recommand to not use this social network for political reasons.

Starting from version 0.45, `Mastodon` and `Bluesky` classes have a `max_lenght` attribute (set to 300 for `Mastodon` and set to 250 for `Bluesky`), which is used to split a longer message into a thread of multiple posts. Again, we do not plan to extend this feature to `Twitter` target, since we recommand to not use this social network for political reasons.

# EXTENDING TO NEW MESSAGE MAKERS

It is even easier to spread whatever you want instead of the revolutionary date. You should write a new class in the `App::SpreadRevolutionaryDate::MsgMaker::` namespace (that is: the class should be `App::SpreadRevolutionaryDate::MsgMaker::MyMsgMaker` for a new `MyMsgMaker` message maker), that consumes the [App::SpreadRevolutionaryDate::MsgMaker](https://metacpan.org/pod/App%3A%3ASpreadRevolutionaryDate%3A%3AMsgMaker) role. See ["DESCRIPTION" in App::SpreadRevolutionaryDate::MsgMaker](https://metacpan.org/pod/App%3A%3ASpreadRevolutionaryDate%3A%3AMsgMaker#DESCRIPTION) for a comprehensive description of this role.

The name of the message maker should be set as a value of the ["msgmaker"](#msgmaker) option.

Such a message maker class is actually just a wrapper. Usually a message maker has to use an existing specific module (which can be a `Moose` class or not) to craft the message. [App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate](https://metacpan.org/pod/App%3A%3ASpreadRevolutionaryDate%3A%3AMsgMaker%3A%3ARevolutionaryDate) uses [DateTime::Calendar::FrenchRevolutionary](https://metacpan.org/pod/DateTime%3A%3ACalendar%3A%3AFrenchRevolutionary), while [App::SpreadRevolutionaryDate::MsgMaker::PromptUser](https://metacpan.org/pod/App%3A%3ASpreadRevolutionaryDate%3A%3AMsgMaker%3A%3APromptUser) is based on [IO::Prompt::Hooked](https://metacpan.org/pod/IO%3A%3APrompt%3A%3AHooked) and [App::SpreadRevolutionaryDate::MsgMaker::Gemini](https://metacpan.org/pod/App%3A%3ASpreadRevolutionaryDate%3A%3AMsgMaker%3A%3AGemini) just uses [LWP](https://metacpan.org/pod/LWP) to request _Gemini_ server. You may need for example [LWP](https://metacpan.org/pod/LWP) to extract the message from a fetched web page or service, or [XML::Feed](https://metacpan.org/pod/XML%3A%3AFeed) to build it from a [RSS](https://en.wikipedia.org/wiki/RSS) feed, or [DBI](https://metacpan.org/pod/DBI) to retrieve it from a database, or nothing at all to spread a fixed message, etc.

If your new message maker class needs specific parameters (other than `locale`, which comes with  [App::SpreadRevolutionaryDate::MsgMaker](https://metacpan.org/pod/App%3A%3ASpreadRevolutionaryDate%3A%3AMsgMaker) role), they should be defined as attributes of this class. Values for such attributes should be set in the [configuration file](#configuration), inside a section named after the message maker in lower case (`[mymsgmaker]`), or as [command line parameters](#command-line-parameters) prefixed with the name of the message maker in lower case, followed by an underscore (`--mymsgmaker_myparam`).

Have a look to [App::SpreadRevolutionaryDate::MsgMaker::PromptUser](https://metacpan.org/pod/App%3A%3ASpreadRevolutionaryDate%3A%3AMsgMaker%3A%3APromptUser) or [App::SpreadRevolutionaryDate::MsgMaker::Telechat](https://metacpan.org/pod/App%3A%3ASpreadRevolutionaryDate%3A%3AMsgMaker%3A%3ATelechat) classes, they show simple examples on how to extend `spread-revolutionary-date` to a new message maker.

## Gemini message maker

From version 0.45, a new message maker is included which requests _Gemini_ AI. This allows to extend `spread-revolutionary-date` just by configuring a few options. The most practical way to configure these options is to prepare everything by setting all ["Gemini options"](#gemini-options) in the configuration file, except ["process"](#process) to pickup the prompt at execution time by using the `--gemini_process <ThisPrompt>` command line parameter.

This way, you can setup different prompts in your configuration file. Here is an example with 4 different prompts configured:

    [Gemini]
    # See https://ai.google.dev/gemini-api/docs/api-key
    api_key                      = 'GEMINI_API_KEY'
    prompt   FamousBirthday      = 'Which famous people have their birthday on $month_name $day? Give a list of up to 6 people, then after the list give the unformatted URL of the Wikipedia page of only one of them, no comments and no need for an introduction like "Here are some famous people".'
    intro    FamousBirthday      = 'FamousBirthday=Famous people born on $month_name $day for better or for worse:'

    prompt   MacronJokeColuche   = 'Invente-moi une blague dans le style de Coluche sur Emmanuel Macron. Pas besoin de dire "D\'accord, voici une blague" ou "Bien sûr, voici une blague dans le style de Coluche sur Emmanuel Macron" avant la blague.'
    img_path MacronJokeColuche   = '/usr/local/share/perl/5.32.1/auto/share/dist/App-SpreadRevolutionaryDate/images/coluche_macron.png'
    img_alt  MacronJokeColuche   = 'Caricature de Coluche disant : « C’est l’histoire d’un mec… » avec une caricature de macron'

    prompt   BlanquiRevival      = 'Invente-moi un dicton révolutionnaire dans le style d\'Auguste Blanqui. Ne fais pas d\'introduction.'
    img_url  BlanquiRevival      = 'https://example.com/imgs/my_image.jgp'

    prompt   MeteoParis          = 'Quelle est la météo aujourd\'hui à Paris, avec la température, selon meteo-paris.com, ne devine pas, va chercher l\'information.'
    search   MeteoParis          =  1

and, then choose the prompt to use at execution time, like:

    $ spread-revolutionary-date --msgmaker=Gemini --gemini_process=FamousBirthday --locale=en
    $ spread-revolutionary-date --msgmaker=Gemini --gemini_process=MacronJokeColuche
    $ spread-revolutionary-date --msgmaker=Gemini --gemini_process=BlanquiRevival
    $ spread-revolutionary-date --msgmaker=Gemini --gemini_process=MeteoParis

These examples show how you can tweak your message to be spread. Let's review all these options:

First, you have to define credentials to use the _Gemini API_, by defining the ["api\_key"](#api_key) option. For this you need to get a _Gemini API key_, by following instructions on [https://ai.google.dev/gemini-api/docs/api-key](https://ai.google.dev/gemini-api/docs/api-key).

Then for each prompt, you have to choose an identifier, which is one word in camel case, like `FamousBirthday`, `MacronJokeColuche`, `BlanquiRevival` or `MeteoParis`. This prompt identifier should be the value of the `--gemini_process <ThisPrompt>` command line parameter.

All other options are relative to one particular prompt, and therefore prefixed with the corresponding identifier. Under the hood, these options are hashes keyed with prompt identifiers:

- ["prompt"](#prompt)

    This is the option where you can define your prompt. It is advised to test this prompt to have _Gemini_ answer as you wish. For instance, _Gemini_ often start its answers to your prompt by: “Sure, here is ‘what you've asked for’, and you wouldn't want to spread this introduction in your message. In this case, you should write your prompt instructing _Gemini_ to not include any introduction.

    You can test your prompt with interactive form to _Gemini_ at [https://gemini.google.com/app](https://gemini.google.com/app) or with `spread-revolutionary-date` with options `--test` and `--targets=Mastodon` for example.

    The spread message will be _Gemini_ answer, optionally prepended with a configured introduction (see bellow), and ending with hashtags `#IAGenerated` `#PromptIdentifier`.

    Prompts often need to mention informations relative to today, such as the `FamousBirthday` example below, or it could be that you wanna ask _Gemni_ for today's weather, or traffic jams occuring the same day of the week as today, etc. As a syntactic sugar, you can insert in ["prompt"](#prompt) option, any variable prefixed with a dollar sign ($) which correspond to a method of [DateTime](https://metacpan.org/pod/DateTime) module applied to `DateTime-`now()> object, and it will be replaced by the result of this method in the prompt sent to _Gemini_. For example, in the `FamousBirthday` example below, if run on June 21st, the prompt sent to _Gemini_ would be:

        'Which famous people have their birthday on June 21? Give a list of up to 6 people, then after the list give the unformatted URL of the Wikipedia page of only one of them, no comments and no need for an introduction like "Here are some famous people".'

    You should be careful that such variables are not interpreted by the `Shell` before calling `spread-revolutionary-date`, specially if specified as command line parameters. You can prevent such intepretation by the `Shell` by enclosing the option in single quotes, like the examples above.

- ["intro"](#intro)

    You may want that the spread message to start with your own introducing words before displaying _Gemini_ answer. You can specify this with the ["intro"](#intro) option.

    Likewise, this option use the same syntactic sugar relative to methods of [DateTime](https://metacpan.org/pod/DateTime) module. For example, the message spread on June 21st by the `FamousBirthday` example bellow, would be something like

        Famous people born on June 21 for better or for worse:
        First Name
        Second Name
        Third Name
        Fourth Name
        Fifth Name
        Sixth Name

        https://en.wikipedia.org/wiki/Third_Name
        #IAGenerated #FamousBirthday

- ["search"](#search)

    _Gemini_ answer is based on data that have been used to train the AI. But sometimes you want accurate answers grounded on some real time searches. In this case, you should specify the ["search"](#search) option with a true value, and _Gemini_ answers will be grounded on grounded sources (inline supporting links) and _Google Search_ suggestions.

    This is used in the `MeteoParis` example bellow, to have _Gemini_ search for today's weather in Paris from `meteo-paris.com` website.

- ["img\_path"](#img_path)

    This option allows to add a local image on the spread message.

- ["img\_alt"](#img_alt)

    This option specifies an alternative text to an image added on the spread message. If unset, the alternative text will be the name of the file specified in ["img\_path"](#img_path) or ["img\_url"](#img_url) options.

- ["img\_url"](#img_url)

    This option allows to add a remote image on the spread message.

Finally, one word of localization: you don't need it, since _Gemini_ will answer in the language you've used in your prompt. Or you can ask in your prompt to be answered in another language, like:

    prompt   FamousBirthday      = 'Which famous people have their birthday on $month_name $day? Give a list of up to 6 people, then after the list give the unformatted URL of the Wikipedia page of only one of them, no comments and no need for an introduction like "Here are some famous people" or "Hier sind 6 berühmte Persönlichkeiten,". Answer in German, please!.'

The only place where you should be concerned by localization is when you define an introduction to be prepended to _Gemini_ answer. Since it is a configured static string, it should be written in the desired language, like:

    intro    FamousBirthday      = 'FamousBirthday=Berühmte Personen, die am $day $month_name geboren wurden, im Guten wie im Schlechten:'

Also, if you use some syntactic sugars relative to methods of [DateTime](https://metacpan.org/pod/DateTime) module that are localizable, like `month_name`, you should use the ["locale"](#locale) option to have it translated in the desired language.

And now you are ready to spread whatever your like, with just some configuration tweaks!

Be aware that _Gemini_, like any other AI, has no concept of truth. It can only give formally probable answers, based on its training data. So do not ask somehing where truth matters… Also, all data you're sending to _Gemini_ are assumed to not be private anymore and could be used by _Google_ for any purpose! And finally, keep in mind that each request to Gemini AI consumes a huge amount of resources, which is detrimental to the environment.

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

Translating days, months and feasts used in the `RevolutionaryDate` message maker do not use the `gettext` system. Mainly because it uses [DateTime::Calendar::FrenchRevolutionary](https://metacpan.org/pod/DateTime%3A%3ACalendar%3A%3AFrenchRevolutionary) which proposes French and English translations in dedicated Perl modules. `spread-revolutionary-date` keeps the same way for translating expressions used in the French revolutionary calendar, but, thanks to [Moose::Role](https://metacpan.org/pod/Moose%3A%3ARole) [App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale](https://metacpan.org/pod/App%3A%3ASpreadRevolutionaryDate%3A%3AMsgMaker%3A%3ARevolutionaryDate%3A%3ALocale), translatable nominal groups have been isolated from other Perl code. Their translations lie in a consuming class in the `App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::` namespace for each translated language. These classes are named after the two-letter ([ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1)) or three-letter ([ISO 639-2](https://en.wikipedia.org/wiki/ISO_639-2) and [ISO 639-3](https://en.wikipedia.org/wiki/ISO_639-3)) lowercase abbreviation of the corresponding language. For example, a German translator would work on `App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::de` class.

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

- [App::SpreadRevolutionaryDate](https://metacpan.org/pod/App%3A%3ASpreadRevolutionaryDate)
- [DateTime::Calendar::FrenchRevolutionary](https://metacpan.org/pod/DateTime%3A%3ACalendar%3A%3AFrenchRevolutionary)
- [AppConfig](https://metacpan.org/pod/AppConfig)
- [App::SpreadRevolutionaryDate::BlueskyLite](https://metacpan.org/pod/App%3A%3ASpreadRevolutionaryDate%3A%3ABlueskyLite)
- [Twitter::API](https://metacpan.org/pod/Twitter%3A%3AAPI)
- [Mastodon::Client](https://metacpan.org/pod/Mastodon%3A%3AClient)
- [Bot::BasicBot](https://metacpan.org/pod/Bot%3A%3ABasicBot)

# AUTHOR

Gérald Sédrati <gibus@cpan.org>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2019-2026 by Gérald Sédrati.

This is free software, licensed under:

    The GNU General Public License, Version 3, June 2007

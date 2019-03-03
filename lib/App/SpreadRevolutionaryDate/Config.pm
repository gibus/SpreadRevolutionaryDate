use strict;
no warnings;
use utf8;
use open qw(:std :utf8);
package App::SpreadRevolutionaryDate::Config;

use AppConfig qw(:argcount);
use parent 'AppConfig';

sub new {
  my $class = shift;
  return AppConfig::new($class,
    'test' => {ARGCOUNT => ARGCOUNT_NONE},
    'twitter' => {ARGCOUNT => ARGCOUNT_NONE},
    'mastodon' => {ARGCOUNT => ARGCOUNT_NONE},
    'freenode' => {ARGCOUNT => ARGCOUNT_NONE},
    'twitter_consumer_key' => {ARGCOUNT => ARGCOUNT_ONE},
    'twitter_consumer_secret' => {ARGCOUNT => ARGCOUNT_ONE},
    'twitter_access_token' => {ARGCOUNT => ARGCOUNT_ONE},
    'twitter_access_token_secret' => {ARGCOUNT => ARGCOUNT_ONE},
    'mastodon_instance' => {ARGCOUNT => ARGCOUNT_ONE},
    'mastodon_client_id' => {ARGCOUNT => ARGCOUNT_ONE},
    'mastodon_client_secret' => {ARGCOUNT => ARGCOUNT_ONE},
    'mastodon_access_token' => {ARGCOUNT => ARGCOUNT_ONE},
    'freenode_nickname' => {ARGCOUNT => ARGCOUNT_ONE},
    'freenode_password' => {ARGCOUNT => ARGCOUNT_ONE},
    'freenode_test_channels' => {ARGCOUNT => ARGCOUNT_LIST},
    'freenode_channels' => {ARGCOUNT => ARGCOUNT_LIST},
  );
}

sub parse_file {
  my $self = shift;
  my $filename = shift;
  foreach my $default_path (
                $ENV{HOME} . '/.config/spread-revolutionary-date/spread-revolutionary-date.conf',
                $ENV{HOME} . '/.spread-revolutionary-date.conf') {
    $filename = $default_path if (!$filename && -f $default_path)
  }
  $self->file($filename);
}

sub parse_command_line {
  my $self = shift;
  $self->args; 
}

sub check_twitter {
  my $self = shift;
  return   $self->twitter_consumer_key
        && $self->twitter_consumer_secret
        && $self->twitter_access_token
        && $self->twitter_access_token_secret;
}

sub check_mastodon {
  my $self = shift;
  return   $self->mastodon_instance
        && $self->mastodon_client_id
        && $self->mastodon_client_secret
        && $self->mastodon_access_token;
}

sub check_freenode {
  my $self = shift;
  return   $self->freenode_nickname
        && $self->freenode_password
        && (  (  $self->freenode_test_channels && $self->test)
              || $self->freenode_channels);
}

1;

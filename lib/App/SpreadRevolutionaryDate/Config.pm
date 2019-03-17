use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
package App::SpreadRevolutionaryDate::Config;

# ABSTRACT: Companion class of L<App::SpreadRevolutionaryDate>, to handle configuration file and command line arguments, subclass of L<AppConfig>.

use Moose;
use MooseX::NonMoose;
extends 'AppConfig';
use AppConfig qw(:argcount);
use File::HomeDir;
use namespace::clean;

=method new

Constructor class method, subclassing C<AppConfig>. Takes no argument. Returns an C<App::SpreadRevolutionaryDate::Config> object.

=cut

sub new {
  my $class = shift;
  return AppConfig::new($class,
    'acab' => {ARGCOUNT => ARGCOUNT_NONE, ALIAS => 'a'},
    'test' => {ARGCOUNT => ARGCOUNT_NONE, ALIAS => 'no|n'},
    'locale' => {ARGCOUNT => ARGCOUNT_ONE, ALIAS => 'l'},
    'twitter' => {ARGCOUNT => ARGCOUNT_NONE, ALIAS => 't'},
    'mastodon' => {ARGCOUNT => ARGCOUNT_NONE, ALIAS => 'm'},
    'freenode' => {ARGCOUNT => ARGCOUNT_NONE, ALIAS => 'f'},
    'twitter_consumer_key' => {ARGCOUNT => ARGCOUNT_ONE, ALIAS => 'tck'},
    'twitter_consumer_secret' => {ARGCOUNT => ARGCOUNT_ONE, ALIAS => 'tcs'},
    'twitter_access_token' => {ARGCOUNT => ARGCOUNT_ONE, ALIAS => 'tat'},
    'twitter_access_token_secret' => {ARGCOUNT => ARGCOUNT_ONE, ALIAS => 'tats'},
    'mastodon_instance' => {ARGCOUNT => ARGCOUNT_ONE, ALIAS => 'mi'},
    'mastodon_client_id' => {ARGCOUNT => ARGCOUNT_ONE, ALIAS => 'mci'},
    'mastodon_client_secret' => {ARGCOUNT => ARGCOUNT_ONE, ALIAS => 'mcs'},
    'mastodon_access_token' => {ARGCOUNT => ARGCOUNT_ONE, ALIAS => 'mat'},
    'freenode_nickname' => {ARGCOUNT => ARGCOUNT_ONE, ALIAS => 'fn'},
    'freenode_password' => {ARGCOUNT => ARGCOUNT_ONE, ALIAS => 'fp'},
    'freenode_test_channels' => {ARGCOUNT => ARGCOUNT_LIST, ALIAS => 'ftc'},
    'freenode_channels' => {ARGCOUNT => ARGCOUNT_LIST, ALIAS => 'fc'},
  );
}

=method parse_file

Parses configuration file. Takes one optional argument: C<$filename> which should be the file path or an opened file handle of your configuration path, defaults to C<~/.config/spread-revolutionary-date/spread-revolutionary-date.conf> or C<~/.spread-revolutionary-date.conf>.

=cut

sub parse_file {
  my $self = shift;
  my $filename = shift;
  foreach my $default_path (
                File::HomeDir->my_home . '/.config/spread-revolutionary-date/spread-revolutionary-date.conf',
                File::HomeDir->my_home . '/.spread-revolutionary-date.conf') {
    $filename = $default_path if (!$filename && -f $default_path)
  }
  $self->file($filename);
}

=method parse_command_line

Parses command line options. Takes no argument.

=cut

sub parse_command_line {
  my $self = shift;
  $self->args;
}

=method check_twitter

Checks whether Twitter configuration options are set to authenticate on Twitter. Takes no argument.

=cut

sub check_twitter {
  my $self = shift;
  return   !!$self->twitter_consumer_key
        && !!$self->twitter_consumer_secret
        && !!$self->twitter_access_token
        && !!$self->twitter_access_token_secret;
}

=method check_mastodon

Checks whether Mastodon configuration options are set to authenticate on Mastodon. Takes no argument.

=cut

sub check_mastodon {
  my $self = shift;
  return   !!$self->mastodon_instance
        && !!$self->mastodon_client_id
        && !!$self->mastodon_client_secret
        && !!$self->mastodon_access_token;
}

=method check_freenode

Checks whether Freenode configuration options are set to authenticate on Freenode. Takes no argument.

=cut

sub check_freenode {
  my $self = shift;
  return   !!$self->freenode_nickname
        && !!$self->freenode_password
        && (  (  !!$self->freenode_test_channels && !!$self->test)
              || !!$self->freenode_channels);
}

=method get_target_arguments

Takes one mandatory argument: C<target> which should be either C<'twitter'>, C<'mastodon'> or C<'freenode'>. Returns a hash with configuration options relative to the passed C<target> argument.

=cut

sub get_target_arguments {
  my $self = shift;
  my $target = lc(shift);
  die "Argument to get_target_arguments should be either 'twitter', 'mastodon' or 'freenode': target $target unknown" unless $target =~ /^(?:twitter|mastodon|freenode)$/;

  my %target_args = $self->varlist("^${target}_");
  %target_args = map { s/^${target}_//r => $target_args{$_} } keys(%target_args);
  $target_args{channels} = delete $target_args{test_channels} if $target eq 'freenode' && $self->test;
  return %target_args;
}

=head1 SEE ALSO

=over

=item L<spread-revolutionary-date|https://metacpan.org/pod/distribution/App-SpreadRevolutionaryDate/bin/spread-revolutionary-date>

=item L<App::SpreadRevolutionaryDate>

=item L<App::SpreadRevolutionaryDate::Twitter>

=item L<App::SpreadRevolutionaryDate::Mastodon>

=item L<App::SpreadRevolutionaryDate::Freenode>

=item L<App::SpreadRevolutionaryDate::Freenode::Bot>

=back

=cut

no Moose;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);

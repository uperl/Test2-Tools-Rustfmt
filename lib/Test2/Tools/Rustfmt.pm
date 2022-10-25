use warnings;
use 5.020;
use experimental qw( postderef signatures );

package Test2::Tools::Rustfmt {

  # ABSTRACT: Test that bundled Rust code is formatted according to Rust style guidelines

  use Test2::API qw( context );
  use Capture::Tiny qw( capture_merged );
  use Carp qw( croak );
  use File::Which qw( which );
  use File::chdir;
  use Exporter qw( import );

  our @EXPORT = qw( rustfmt_ok cargo_fmt_ok );

  sub rustfmt_ok ($files, $name=undef)
  {
    $files = [ $files ] unless ref $files;
    croak "files must be either a string or array references" unless ref $files eq 'ARRAY';

    $name //= "rustfmt @$files";

    my @command = (which('rustfmt'), '--check', $files->@*);
    my($out, $exit) = capture_merged {
      system @command;
    };

    if($exit == 0)
    {
      context()->pass_and_release($name);
      return 1;
    }
    else
    {
      context()->fail_and_release($name, "+@command", $out);
      return '';
    }
  }

  sub cargo_fmt_ok ($dir=undef, $name=undef)
  {
    $dir = 'ffi' if (!defined $dir) && -d 'ffi';
    croak "dir must be a directory"
      unless defined $dir && -d $dir;

    $name //= "cargo fmt for $dir";

    my @command = (which('cargo'), 'fmt', '--check');
    my($out, $exit) = capture_merged {
      local $CWD = $dir;
      system @command;
    };

    if($exit == 0)
    {
      context()->pass_and_release($name);
      return 1;
    }
    else
    {
      context()->fail_and_release($name, "+cd $dir", "+@command", $out);
      return '';
    }
  }
}

1;

=head1 SYNOPSIS

 use Test2::V0;
 use Test2::Tools::Rustfmt;
 
 cargo_fmt_ok;
 
 done_testing;

=head1 DESCRIPTION

These test tools work with C<rustfmt> and C<cargo fmt> to ensure that any
bundled Rust code that you might have in your Perl Rust extension are
formatted according to the Rust style guidelines.

=head1 FUNCTIONS

Functions are exported by default.

=head2 rustfmt_ok

 rustfmt_ok $file, $test_name;
 rustfmt_ok \@files, $test_name;
 rustfmt_ok $file;
 rustfmt_ok \@files;

Tests the given rust files to see if they are formatted according to the
Rust style guidelines.

=head2 cargo_fmt_ok

 cargo_fmt_ok $dir, $test_name;
 cargo_fmt_ok $dir;
 cargo_fmt_ok;

Tests the rust crate in the given directory to see if they are formatted
according to the Rust style guidelines.  If no directory is given, and
if a C<ffi> directory exists, then that will be used.  This works
nicely with L<FFI::Build> and L<FFI::Build::File::Cargo> when writing
Perl extensions in Rust.

=cut

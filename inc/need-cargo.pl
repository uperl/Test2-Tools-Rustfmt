use strict;
use warnings;
use File::Which qw( which );

unless(which('cargo') && which('rustfmt'))
{
  print "This distribution requires that you have cargo/rust installed\n";
  exit;
}

# Test2::Tools::Rustfmt ![static](https://github.com/uperl/Test2-Tools-Rustfmt/workflows/static/badge.svg) ![linux](https://github.com/uperl/Test2-Tools-Rustfmt/workflows/linux/badge.svg)

Test that bundled Rust code is formatted according to Rust style guidelines

# SYNOPSIS

```perl
use Test2::V0;
use Test2::Tools::Rustfmt;

cargo_fmt_ok;

done_testing;
```

# DESCRIPTION

These test tools work with `rustfmt` and `cargo fmt` to ensure that any
bundled Rust code that you might have in your Perl Rust extension are
formatted according to the Rust style guidelines.

# FUNCTIONS

Functions are exported by default.

## rustfmt\_ok

```
rustfmt_ok $file, $test_name;
rustfmt_ok \@files, $test_name;
rustfmt_ok $file;
rustfmt_ok \@files;
```

Tests the given rust files to see if they are formatted according to the
Rust style guidelines.

## cargo\_fmt\_ok

```
cargo_fmt_ok $dir, $test_name;
cargo_fmt_ok $dir;
cargo_fmt_ok;
```

Tests the rust crate in the given directory to see if they are formatted
according to the Rust style guidelines.  If no directory is given, and
if a `ffi` directory exists, then that will be used.  This works
nicely with [FFI::Build](https://metacpan.org/pod/FFI::Build) and [FFI::Build::File::Cargo](https://metacpan.org/pod/FFI::Build::File::Cargo) when writing
Perl extensions in Rust.

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2022 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

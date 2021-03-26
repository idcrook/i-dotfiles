perl and CPAN
=============

Install on macOS
----------------

```console
$ brew install perl
$ which perl
Apple Silicon macOS: /opt/homebrew/bin/perl
Intel macOS: /usr/local/bin/perl
```

The `brew` command above will show a message like the following:

> By default non-brewed cpan modules are installed to the Cellar. If you wish for your modules to persist across updates we recommend using `local::lib`.
>
> You can set that up like this:

```shell
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib
echo 'eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"' >> ~/.zshrc
```

So, recommendation is `$HOME` `local::lib`-style installation and with that, will store any user-installed perl modules in `~/perl5/` directory. and there will need to be appropriate incantations in your shell startup files (in this case `zshrc`) to set up corresponding environment. The **zprezto** `perl` module and the bash startup files in this repo handle that.

**IMPORTANT**: Boostrap the recommended `local::lib` setup:

```console
$ PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib
...
  /usr/bin/make install  -- OK
```

### Install something from CPAN

in newly sourced shell,  confirm that the envariables have been setup for `local::lib`.

an example:

```console
$ env | grep PERL
PERL5LIB=/Users/dpc/perl5/lib/perl5
PERL_LOCAL_LIB_ROOT=/Users/dpc/perl5
PERL_MB_OPT=--install_base "/Users/dpc/perl5"
PERL_MM_OPT=INSTALL_BASE=/Users/dpc/perl5
$ echo $PATH | grep perl5/bin
```

#### Setup CPAN itself

```console
$ perl -MCPAN -Mlocal::lib -e 'CPAN::install(Term::ReadLine::Perl)'
```

That will run `cpan` non-interactively, installing the recommended module `Term::ReadLine::Perl` for the CPAN interactive shell, and exit

#### Install a CPAN module

```console
$ perl -MCPAN -e "shell"
cpan> install Graphics::Color
```

Accept any prompted defaults along the way...  then, after some time, this will have downloaded, built, tested, and installed that requested module from CPAN (in this case `Graphics::Color`) as well as all of its dependencies.

#### test it out

```perl
#!/usr/bin/env perl

use local::lib;
use Graphics::Color::HSV;

# the red primary at 0°,
# the green primary at 120°
# the blue primary at 240°
# then wrapping back to red at 360°.
my $color = Graphics::Color::HSV->new({ hue => (240 + 360)/2 , # in degrees
                                        saturation  => 0.75,
                                        value  => 1,});
my $c = $color->to_rgb();

warn("CSS HSV values: " . $color->as_percent_string() . "\n");
warn("CSS hex value: " . $c->as_css_hex() . "\n");
```

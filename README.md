My i-dotfiles
=============

Install
-------

Installation instructions are present in `README.md` files, including any special instructions. 

Starting points: 

- [macOS](%40macos/README-macos.md)
- [Ubuntu](%40ubuntu/README.md) variants including on [WSL2](%40ubuntu/README-Ubuntu-WSL2-20.04.md) or [Raspberry Pi](%40ubuntu/README-Ubuntu-on-RasPi.md), and [Raspberry Pi OS](%40ubuntu/README-Raspbian.md).

Overview

1.	Assumes GNU `stow` is installed
2.	Clone this repository:
	```
	git clone --recurse-submodules https://github.com/idcrook/i-dotfiles.git \
		~/.dotfiles
	cd ~/.dotfiles
	```
3.	Setup GNU `stow`, *inception style*:
	-	probably need to first update home directory path in `~/.stowrc`
	```
	stow -t ~ stow
	```
4.	Install desired package via `stow <directory>` <sup id="a1">[1](#f1)</sup> 
    - Covered with explicit details in each `README.md`, including any special install instructions.

Background
----------

I used to manage my macOS/Linux/WSL dotfiles in a "`homedir.git`" repository. This left things to be desired, and syncing multiple platforms sometimes presented unresolvable conflicts. Now I use GNU Stow and this repository.

*i-dotfiles is an opiniated dotfiles organization scheme based on stow. (Originally an implementation of [F-dotfiles](https://github.com/Kraymer/F-dotfiles)\) High priorities are ease-of-maintenance and deployment on both Linux and macOS.*

-	**`stow` powered:** symlink dotfiles and thus keep them always up-to-date in your repository
-	**topical organization:** organize dotfiles by application facilitating reuse across different machines
-	**naming scheme:** the repository architecture is easy to browse while staying compatible with `stow` symlinking mechanism
-	**KISS:** there is deliberately no build script involved at all, the repository consist of dotfiles all installable using same modus operandi (`stow <directory>`\)
-	**documentation:** each package has a *`README.md`* which present its purpose. Install notes and requirements can also be listed. a *`TODO.md`* may be enlisted to track things to be done.

Inspired heavily by:

-	https://github.com/Kraymer/F-dotfiles
	-	https://github.com/andschwa/dotfiles
	-	http://dotfiles.github.io


Rules
-----

### Directories naming

-	lowercase for packages to install in `$HOME` (the default)
-	titlecase for packages to install as root in `/`, eg[`@Daemon-macos`](https://github.com/Kraymer/F-dotfiles/blob/master/attic/@Daemon-osx)
-	leading `@` for environment packages and subpackages, eg[`@macos`](https://github.com/idcrook/i-dotfiles/blob/master/%40macos/)
-	leading `_` for non packages, eg [`_pip`](https://github.com/idcrook/i-dotfiles/blob/master/_pip) meaning that these directories must not be *stowed*

Having a convention for subpackage naming enable us to write a [`.stow-global-ignore`](https://github.com/idcrook/i-dotfiles/blob/master/stow/.stow-global-ignore#L6) file so that subpackages are not symlinked when stowing parent package.

### Ignore files

Quoting stow [documentation](https://www.gnu.org/software/stow/manual/html_node/Installing-Packages.html#Installing-Packages) :

> if Stow can create a single symlink that points to an entire subtree within the package tree, it will choose to do that rather than create a directory in the target tree and populate it with symlinks.

`.gitignore` can be present in packages because of this behaviour, in order to avoid having your repository cluttered with unknown files

### Secrets files

Secrets files, ie files that should not be commited/published, must have `*.secrets*` or `*/secrets/*` in their filepath to be ignored by the root `.gitignore` file.

Each *secrets* file should be accompanied by an `*.example*` file that is instead commited to repository, to illustrate the use.

Keep your secrets files as short as possible to limit their influence as it complicates deployments (as they cannot be just pulled from github).

See [example](https://github.com/idcrook/i-dotfiles/blob/master/git/.config/git/config.secrets.example).

### Multi-platforms paths

**Where to save a file that is installed at different locations depending on the OS ?**

The trick is to have one package per OS, just to create each specific directories structure properly. Then create the part of the filepath that is common to the two OS in `<package>/_common`, put the files in it, symlink from the subpackages to that location.

Feel confused ? Check [example](https://github.com/Kraymer/F-dotfiles/tree/master/_sublime_text_3/%40linux/.config/sublime-text-3)

---

<i id="f1">1</i> it's because we installed `stow` package at step 2 that the flag `-t ~` can be omitted here, see [.stowrc](https://github.com/idcrook/i-dotfiles/blob/master/stow/.stowrc) [⤸](#a1)

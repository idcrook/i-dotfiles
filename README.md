My i-dotfiles
=============

`i-dotfiles` is an opinionated dotfiles organization scheme based on stow.

Install
-------

Starting points:

-	[macOS](%40macos/README-macos.md)
-	[Raspberry Pi OS](%40linux/README-Raspbian.md) (based on Debian)
-	[Ubuntu](%40linux/README.md) variants including on [WSL2](%40linux/README-Ubuntu-WSL2-20.04.md) or [Raspberry Pi](%40linux/README-Ubuntu-on-RasPi.md)

#### General Idea

Refer to specific "Starting point" `README.md` files above for specific details.

Assumes `git` and GNU `stow` are available/installed (usually via a package manager). In general, it will go as follows:

1.	Clone this repository:

	```console
	$ git clone --recurse-submodules \
	  https://github.com/idcrook/i-dotfiles.git \
	  ~/.dotfiles
	$ cd ~/.dotfiles
	```

1.	Install GNU `stow` config itself

	```console
	$ stow -t ~ stow
	```

    **IMPORTANT**: Confirm that the hard-coded home directory path in `~/.stowrc` matches your system

2.	Use `stow` to install desired package(s) via `stow <directory>` <sup id="a1">[1](#f1)</sup>

	-	Additional installation instructions are present in respective package `README.md` files.


Rules
-----

### Sub-Directory Naming

-   *`lowercase`* - for packages to install in `$HOME` (the default)

-	*`TitleCase`* - for packages which need `root` permissions, e.g. top-level of filesysyem at `/` [`@Daemon-macos`](https://github.com/Kraymer/F-dotfiles/blob/master/attic/@Daemon-osx)
-	leading `@` - for environment packages and subpackages, e.g. [`@macos`](https://github.com/idcrook/i-dotfiles/blob/master/%40macos/)
-	leading `_` - for non-`stow`-able packages, e.g. [`_pip`](https://github.com/idcrook/i-dotfiles/blob/master/_pip) which describes python package installation

Having a convention for sub-package naming enables a [`.stow-global-ignore`](https://github.com/idcrook/i-dotfiles/blob/master/stow/.stow-global-ignore#L6) file such that sub-packages are not symlinked when stowing parent package.

### Ignore files

Quoting stow [documentation](https://www.gnu.org/software/stow/manual/html_node/Installing-Packages.html#Installing-Packages) :

> if Stow can create a single symlink that points to an entire subtree within the package tree, it will choose to do that rather than create a directory in the target tree and populate it with symlinks.

Using `.gitignore` in packages because of this behaviour, can be useful for avoiding having this git repository cluttered with unknown files, when language package managers or App configs introduce files in certain directories.

### Secrets files

Secrets files, i.e., files that should not be committed to git repository, must have `*.secrets*` or `*/secrets/*` in their filepath to be ignored by the root `.gitignore` file.

Each *secrets* file should be accompanied by an `*.example*` file that is, itself, instead commited to repository, to illustrate the contents.

Keep your secrets files as short as possible to limit their influence as it complicates deployments (as they are not available in the git repository).

See [example](https://github.com/idcrook/i-dotfiles/blob/master/git/.config/git/config.secrets.example).

### Multi-platforms paths

**Where to save a file that is installed at different locations depending on the OS?**

The trick is to have one sub-package per OS, just to create each specific directory structure properly.

Then create the part of the filepath that is common to the two OS-es in `<package>/_common`, put the files in it, symlink from the subpackages to that location.

Feel confused ? Check [example](https://github.com/Kraymer/F-dotfiles/tree/master/_sublime_text_3/%40linux/.config/sublime-text-3)

Background
----------

I used to manage my macOS/Linux/WSL *dotfiles* in an "`homedir.git`" repository that was directly overlayed. This left things to be desired, and syncing multiple platforms sometimes presented unresolvable conflicts. Now, I use GNU Stow and this repository instead.

`i-dotfiles` is an opinionated dotfiles organization scheme based on stow. Its priorities are ease-of-maintenance and deployment on both Linux and macOS. It was created originally as an implementation of [F-dotfiles](https://github.com/Kraymer/F-dotfiles), borrowing its philosophy as follows:

-	**`stow` powered:** symlink dotfiles and thus keep them always up-to-date in git repository
-	**topical organization:** organize dotfiles by application facilitating reuse across different machines
-	**naming schemas:** the repository architecture is easy to browse while staying compatible with `stow` symlinking mechanism
-	**KISS:** there is deliberately no build script involved at all, the repository consist of dotfiles all installable using same modus operandi (`stow <directory>`\)
-	**documentation:** each "package" directory has a *`README.md`* which presents its purpose. Install notes and requirements can be included. A separate  *`TODO.md`* may be enlisted to track things still to be implemented.

Inspired heavily by:

-	https://github.com/Kraymer/F-dotfiles
-	https://github.com/andschwa/dotfiles
-	http://dotfiles.github.io


---

<i id="f1">1</i> it's because we installed `stow` package at step 2 that the flag `-t ~` can be omitted here, see [.stowrc](https://github.com/idcrook/i-dotfiles/blob/master/stow/.stowrc) [⤸](#a1)

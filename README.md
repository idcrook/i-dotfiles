i-dotfiles
==========

An opinionated dotfiles organization scheme based on `stow`.

-	Supports BASH and `zsh`.

-	Supports Linux: x86 or amd64 or armhf or arm64.

-	Supports macOS, both Intel and Apple Silicon.

-	Includes configs for **emacs** [emacs.d](https://github.com/idcrook/.emacs.d) and **zsh** [zprezto](https://github.com/idcrook/prezto) (managed as `git submodule` repos).

Install
-------

Starting points:

-	[macOS](%40macos/README-macos.md) (Both Intel and Apple Silicon)
-	[Linux](%40linux/README.md) variants including [Raspberry Pi OS](%40linux/README-RasPiOS.md) (based on Debian) and Ubuntu flavors [WSL2](%40linux/README-Ubuntu-WSL2-20.04.md) or [Ubuntu on Raspberry Pi](%40linux/README-Ubuntu-on-RasPi.md)

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

1.	Install config for `stow`  itself

	```console
	$ stow -t ~ stow
	```

	**IMPORTANT**: Confirm the hard-coded home directory path in `~/.stowrc` matches your system

2.	Use `stow` to install desired package(s) via `stow <directory>` <sup id="a1">[1](#f1)</sup>

	-	Additional installation instructions are present in respective platform and package `README.md`.

Rules
-----

### Sub-Directory Naming

-	*`lowercase`* - for packages to `stow` install in `$HOME` (the default)

-	leading `_` - for non-`stow`-able packages, e.g. [`_pip`](https://github.com/idcrook/i-dotfiles/blob/main/_pip) which describes python package installation

-	*`TitleCase`* - for packages which need `root` permissions, e.g. top-level of filesysyem at `/` [`@Apt`](https://github.com/idcrook/i-dotfiles/tree/main/%40linux/%40Apt)

-	leading `@` - for environment packages and subpackages, e.g. [`@macos`](https://github.com/idcrook/i-dotfiles/blob/main/%40macos/)

Having a convention for sub-package naming enables a [`.stow-global-ignore`](https://github.com/idcrook/i-dotfiles/blob/main/stow/.stow-global-ignore#L6) file such that sub-packages are not symlinked when stowing parent package.

### Ignore files

Quoting stow [documentation](https://www.gnu.org/software/stow/manual/html_node/Installing-Packages.html#Installing-Packages) :

> if Stow can create a single symlink that points to an entire subtree within the package tree, it will choose to do that rather than create a directory in the target tree and populate it with symlinks.

 Because of this, using `.gitignore` in packages (which do not themselves get stow-ed, due to `stow-global-ignore`) can help avoid this `i-dotfiles` git repository getting cluttered with unknown files. For example, this happens when language package managers add files to certain directories.

### Secrets files

Secrets files, i.e., files that should not be committed to git repository, must have `*.secrets*` or `*/secrets/*` in their filepath to be ignored by the root `.gitignore` file.

Each *secrets* file should be accompanied by an `*.example*` file that is, itself, instead commited to repository, to illustrate its contents by example.

Keep your secrets files as short as possible to limit their influence as it complicates deployments (as they will not be available in `i-dotfiles` git repository).

See [example](https://github.com/idcrook/i-dotfiles/blob/main/git/.config/git/config.secrets.example).

Background
----------

I used to manage my macOS/Linux/WSL *dotfiles* in an "`homedir.git`" repository that was directly overlayed. This left things to be desired, and syncing multiple platforms sometimes presented unresolvable conflicts. Now, I use GNU Stow and this repository instead.

`i-dotfiles` is an opinionated dotfiles organization scheme based on stow. Its priorities are ease-of-maintenance and deployment on both Linux and macOS. It was created originally as an implementation of [F-dotfiles](https://github.com/Kraymer/F-dotfiles), borrowing its philosophy as follows:

-	**`stow` powered:** symlink dotfiles and thus keep them always up-to-date in git repository
-	**topical organization:** organize dotfiles by application
-	**naming schemas:** the repository architecture is easy to browse while staying compatible with `stow` symlinking mechanism
-	**documentation:** each "package" directory has a *`README.md`* which presents its purpose. Install notes and requirements can be included. A separate *`TODO.md`* may be enlisted to track things still to be implemented.

Inspired heavily by:

-	https://github.com/Kraymer/F-dotfiles
-	https://github.com/andschwa/dotfiles
-	http://dotfiles.github.io

---

<i id="f1">1</i> it's because we installed `stow` package at step 2 that the flag `-t ~` can be omitted here, see [.stowrc](https://github.com/idcrook/i-dotfiles/blob/main/stow/.stowrc) [⤸](#a1)

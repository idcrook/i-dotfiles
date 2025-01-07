My prezto zsh modules
=====================

Collections of modules

-	`kubernetes` aliases I use in bash ported to zsh
-	`mojo` Computer language/SDK like Python from [Modular](https://docs.modular.com/mojo/)
-	`emacs-action` do things in emacs from terminal command line

How to load prezto modules, from README [sorin-ionescu/prezto: The configuration framework for Zsh](https://github.com/sorin-ionescu/prezto#readme):

### External Modules

1.	By default modules will be loaded from *`/modules`* and *`/contrib`*\.
2.	Additional module directories can be added to the`:prezto:load:pmodule-dirs` setting in *`${ZDOTDIR:-$HOME}/.zpreztorc`*\.

	Note that module names need to be unique or they will cause an error when loading.

	```sh
	zstyle ':prezto:load' pmodule-dirs $HOME/.zprezto-contrib
	```

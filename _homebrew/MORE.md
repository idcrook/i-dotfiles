App Config
==========

`iTerm2`
--------

-	font: \[Profiles] toolbar item
	-	`>Text<` Tab
		-	:: Font : `Ubuntu Nerd Font Mono`, size `16`\+
	-	`>Window<` Tab
		-	:: Settings for New Windows : Columns `XX` Rows `YY`
	-	`>Terminal<` Tab
		-	:: Scrollback Buffer : [x] Unlimited scrollback
-	In System Preferences...Security & Privacy / Privacy : Give Full Disk Access, etc. to iTerm2

`TerminalWidget`
----------------

run from terminal

```shell
mkdir -p "$HOME/.local/bin" && ln -sf '/Applications/TerminalWidget.app/Contents/MacOS/TerminalWidget' "$HOME/.local/bin/terminal-widget"
```

use as shell function

```zsh
#
terminal-widget() {
  '/Applications/TerminalWidget.app/Contents/MacOS/TerminalWidget' "$@"
}
```

Magnet
------

Needs `Accessibility` turned on.

Install manually
================

Basics
------

-	Litle Snitch - [Download – Little Snitch](https://www.obdev.at/products/littlesnitch/download.html)
-	Google Chrome - https://www.google.com/chrome/
-	Firefox - https://www.mozilla.org/firefox/download/
-	Marked 3
-	AppZapper 3000
-   No longer have license - Sip (v4) https://sipapp.io/updates/#sip-4

Utilities
---------

There are casks for these

-	Geekbench 7 - https://www.geekbench.com/download/
-	Keyboard Maestro 10 - [Keyboard Maestro 10.0: Work Faster with Macros for macOS](https://www.keyboardmaestro.com/main/)
-	Transmit - https://panic.com/transmit/#download
-	carbon-copy-cloner - [Mac Backup Software | Carbon Copy Cloner | Bombich Software](https://bombich.com/)
-	Google Gemini, Antigravity

Hardware support
----------------

-	Cura Lulzbot Edition - https://www.lulzbot.com/learn/tutorials/cura-lulzbot-edition-installation-macos
-	Simplify3D - https://www.simplify3d.com/software/features/
-	OrcaSlicer, Anycubic Slicer Next, PrusaSlicer, Creality Slicer

### Rogue Amoeba

See macOS readiness status : https://www.rogueamoeba.com/status/

-	(cask) Airfoil - https://www.rogueamoeba.com/airfoil/mac/
-	(cask) Fission - https://www.rogueamoeba.com/fission/
-	(cask) Audio Hijaak - https://www.rogueamoeba.com/audiohijack/
-	(cask) SoundSource - https://www.rogueamoeba.com/soundsource/
	-	Version 4: [Rogue Amoeba | Legacy Software](https://www.rogueamoeba.com/legacy/#soundsource)

Ideas / Substitutes
-------------------

-	anybar - OS X menubar status indicator
-	aria2d - Simple Aria2 GUI for macOS.
-	ariang (ariang-native) - A better aria2 desktop frontend than AriaNg
-	asciidocfx - Asciidoc Editor and Toolchain to build books, documents and slides
-	aural - Aural Player is an audio player for macOS.
-	banksiagui - Chess GUI
-	beaconscanner - iBeacon Scanning Utility App for OSX - https://github.com/mlwelles/BeaconScanner
-	bespoke - software modular synthesizer (DAW) - https://www.bespokesynth.com/docs/index.html
-	betterdisplay - Software Dummy Display Adapter https://github.com/waydabber/BetterDisplay
-	blockbench - A boxy 3D model editor
-	bluetility - Bluetooth Low Energy browser
-	bonjeff - Shows a live display of the Bonjour services published on your network
-	boop - Scriptable scratchpad for developers
-	bossa - flash programming utility for Atmel's SAM family of flash-based ARM microcontrollers
-	brave-browser - Web browser focusing on privacy
-	breaktimer - Tool to manage periodic breaks
-	bricklink-studio - Build, render, and create LEGO instructions
-	brooklyn - Screen saver based on animations presented during Apple Special Event Brooklyn
-	browserosaurus - Open-source browser prompter
	-	Open links in any browser
-	buildsettingextractor - Xcode build settings extractor
-	bunch - Automation tool
-	burp-suite - Web security testing toolkit
-	butt - broadcast using this tool Shoutcast and Icecast streaming client
-	buttercup - Javascript Secrets Vault - Multi-Platform Desktop Application
-	calibre - E-books management software
-	camed - XML editor
-	camo - Use your phone as a high-quality webcam with image tuning controls
-	cantata - Qt5 Graphical MPD Client
-	captin - Tool to show caps lock status
-	caption - Finds and sets up subtitles automatically
-	catch - Broadcatching made easy
-	catlight - Action center for developers
-	cd-to - Finder Toolbar app to open the current directory in the Terminal
-	celestia - Space simulation for exploring the universe in three dimensions
-	chalk - Calculator software
-	cheatsheet - Tool to list all active shortcuts of the current application
-	chessx - Chess database
-	chirp - Tool for programming amateur radio
-	circuitjs1 - Electronic circuit simulator
-	clock-signal - Latency-hating emulator of 8- and 16-bit platforms
-	clone-hero - Guitar Hero clone
-	cloudcompare - 3D point cloud and mesh processing software Open Source Project
-	cloudytabs - Menu bar application that lists iCloud Tabs
-	cncjs - Interface for CNC milling controllers
-	cncnet - CnCNet is one of the largest Command & Conquer multiplayer platforms.
-	cockatrice - Virtual tabletop for multiplayer card games
-	coffitivity-offline - Ambient sound generator
-	colorpicker-developer - from Panic (discontinued)
-	colorpicker-materialdesign - Material Design Color Picker is a custom color picker plugin for macOS
-	colorpicker-propicker - Pro Picker is a native macOS color picker plugin
-	colorpicker-skalacolor - Skala Color is a standard macOS color picker
-	colorwell - macOS Color Theme generator.
-	colour-contrast-analyser
-	compositor - latex WYSIWYG: Compositor is no longer available for purchase.
-	conferences - App to watch conference videos
-	Contraste - for checking the accessibility of text against WCAG
-	corelocationcli - Core Location CLI
-	couleurs - app for grabbing and tweaking the colors you see on your screen.
-	coverload - Download high quality artwork for movies, music albums, and more
-	cr - cool reader XML/CSS based eBook reader
-	crosspack-avr - CrossPack for AVR® Development
-	crunch - Insane(ly slow but wicked good) PNG image optimization
-	cursorcerer - allows you to hide the cursor at any time by use of a global hotkey
-	cutter - Reverse engineering platform powered by Rizin
-	deepgit - Tool to investigate the history of source code
-	desmume - Nintendo DS emulator
-	desktoputility - Quick access to useful system tasks
-	desktoppr - Command-line tool to set the desktop picture
-	developerexcuses - Developer Excuses Screensaver
-	devdocs - Full-featured desktop app for DevDocs.io
-	devkinsta -Local WordPress Development Suite by Kinsta
-	dexed - multi platform, multi format plugin synth
-	diagnostics - Diagnostic (crash) reports viewer
-	digikam - Digital photo manager
-	digital - (java) Logic designer and circuit simulator
-	discretescroll - Utility to fix a common scroll wheel problem
-	DiskCatalogMaker - Toast-bundled version of DiskCatalogMaker
-	displaperture - Rounds your display corners
-	dolphin - Emulator to play GameCube and Wii games
-	doomsday-engine - Enhanced source port of Doom, Heretic, and Hexen
-	dosbox-x - Fork of the DOSBox project
-	doteditor - GUI tools for graphviz.
-	drop-to-gif - Zero-click animated Gifs
-	dropdmg - Create DMGs and other archives

-	hyper - terminal emulator

-	pacifist -

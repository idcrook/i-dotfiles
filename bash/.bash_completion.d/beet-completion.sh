# This file is part of beets.
# Copyright (c) 2014, Thomas Scholtes.
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.



# Completion for the `beet` command
# =================================
#
# Load this script to complete beets subcommands, options, and
# queries.
#
# If a beets command is found on the command line it completes filenames and
# the subcommand's options. Otherwise it will complete global options and
# subcommands. If the previous option on the command line expects an argument,
# it also completes filenames or directories.  Options are only
# completed if '-' has already been typed on the command line.
#
# Note that completion of plugin commands only works for those plugins
# that were enabled when running `beet completion`. It does not check
# plugins dynamically
#
# Currently, only Bash 3.2 and newer is supported and the
# `bash-completion` package is requied.
#
# TODO
# ----
#
# * There are some issues with arguments that are quoted on the command line.
#
# * Complete arguments for the `--format` option by expanding field variables.
#
#     beet ls -f "$tit[TAB]
#     beet ls -f "$title
#
# * Support long options with `=`, e.g. `--config=file`. Debian's bash
#   completion package can handle this.
#


# Determines the beets subcommand and dispatches the completion
# accordingly.
_beet_dispatch() {
  local cur prev cmd=

  COMPREPLY=()
  _get_comp_words_by_ref -n : cur prev

  # Look for the beets subcommand
  local arg
  for (( i=1; i < COMP_CWORD; i++ )); do
      arg="${COMP_WORDS[i]}"
      if _list_include_item "${opts___global}" $arg; then
        ((i++))
      elif [[ "$arg" != -* ]]; then
        cmd="$arg"
        break
      fi
  done

  # Replace command shortcuts
  if [[ -n $cmd ]] && _list_include_item "$aliases" "$cmd"; then
    eval "cmd=\$alias__${cmd//-/_}"
  fi

  case $cmd in
    help)
      COMPREPLY+=( $(compgen -W "$commands" -- $cur) )
      ;;
    list|remove|move|update|write|stats)
      _beet_complete_query
      ;;
    "")
      _beet_complete_global
      ;;
    *)
      _beet_complete
      ;;
  esac
}


# Adds option and file completion to COMPREPLY for the subcommand $cmd
_beet_complete() {
  if [[ $cur == -* ]]; then
    local opts flags completions
    eval "opts=\$opts__${cmd//-/_}"
    eval "flags=\$flags__${cmd//-/_}"
    completions="${flags___common} ${opts} ${flags}"
    COMPREPLY+=( $(compgen -W "$completions"  -- $cur) )
  else
    _filedir
  fi
}


# Add global options and subcommands to the completion
_beet_complete_global() {
  case $prev in
    -h|--help)
      # Complete commands
      COMPREPLY+=( $(compgen -W "$commands" -- $cur) )
      return
      ;;
    -l|--library|-c|--config)
      # Filename completion
      _filedir
      return
      ;;
    -d|--directory)
      # Directory completion
      _filedir -d
      return
      ;;
  esac

  if [[ $cur == -* ]]; then
    local completions="$opts___global $flags___global"
    COMPREPLY+=( $(compgen -W "$completions" -- $cur) )
  elif [[ -n $cur ]] && _list_include_item "$aliases" "$cur"; then
    local cmd
    eval "cmd=\$alias__${cur//-/_}"
    COMPREPLY+=( "$cmd" )
  else
    COMPREPLY+=( $(compgen -W "$commands" -- $cur) )
  fi
}

_beet_complete_query() {
  local opts
  eval "opts=\$opts__${cmd//-/_}"

  if [[ $cur == -* ]] || _list_include_item "$opts" "$prev"; then
    _beet_complete
  elif [[ $cur != \'* && $cur != \"* &&
          $cur != *:* ]]; then
    # Do not complete quoted queries or those who already have a field
    # set.
    compopt -o nospace
    COMPREPLY+=( $(compgen -S : -W "$fields" -- $cur) )
    return 0
  fi
}

# Returns true if the space separated list $1 includes $2
_list_include_item() {
  [[ " $1 " == *[[:space:]]$2[[:space:]]* ]]
}

# This is where beets dynamically adds the _beet function. This
# function sets the variables $flags, $opts, $commands, and $aliases.
complete -o filenames -F _beet beet
_beet() {
  local commands='fields help import list update remove stats version modify move write config completion embedart extractart clearart play web duplicates'

  local aliases='upd up imp mv im ls dup rm mod'
  local alias__upd=update
  local alias__up=update
  local alias__imp=import
  local alias__mv=move
  local alias__im=import
  local alias__ls=list
  local alias__dup=duplicates
  local alias__rm=remove
  local alias__mod=modify

  fields='mb_releasetrackid lyrics album_id albumstatus disctitle lyricist month channels genre original_day albumartist mb_trackid composer year albumdisambig samplerate albumartist_sort id album mb_artistid bitdepth disctotal title media artist_sort mb_albumid arranger comments tracktotal rg_track_peak mb_releasegroupid mtime acoustid_id mb_albumartistid rg_album_peak albumartist_credit catalognum added original_month asin track comp artpath encoder composer_sort initial_key rg_track_gain path bitrate day original_year language r128_album_gain artist country script bpm label r128_track_gain rg_album_gain length disc albumtype artist_credit acoustid_fingerprint format grouping'
  local flags__web='-d --debug'
  local flags__play='-a --album -y --yes'
  local opts__play='-A --args'
  local flags__stats='-e --exact'
  local flags___common='-h --help'
  local flags__duplicates='-c --count -d --delete -F --full -s --strict -M --merge -a --album'
  local opts__duplicates='-C --checksum -k --key -m --move -o --copy -t --tag -p --path -f --format'
  local flags__move='-c --copy -p --pretend -t --timid -e --export -a --album'
  local opts__move='-d --dest'
  local flags__list='-a --album'
  local opts__list='-p --path -f --format'
  local flags__update='-a --album -m --move -M --nomove -p --pretend'
  local opts__update='-f --format -F --field'
  local flags__remove='-d --delete -f --force -a --album'
  local flags__write='-p --pretend -f --force'
  local flags__modify='-m --move -M --nomove -w --write -W --nowrite -a --album -y --yes'
  local opts__modify='-f --format'
  local flags__embedart='-y --yes'
  local opts__embedart='-f --file'
  local flags__extractart='-a'
  local opts__extractart='-o -n'
  local flags__import='-c --copy -C --nocopy -m --move -w --write -W --nowrite -a --autotag -A --noautotag -p --resume -P --noresume -q --quiet -s --singletons -t --timid -L --library -i --incremental -I --noincremental --from-scratch --flat -g --group-albums --pretend'
  local opts__import='-l --log -S --search-id --set'
  local flags__config='-p --paths -e --edit -d --defaults -c --clear'
  local flags__clearart='-y --yes'
  local flags___global='-v --verbose'
  local opts___global='-l --library -c --config -d --directory -h --help'
  _beet_dispatch
}

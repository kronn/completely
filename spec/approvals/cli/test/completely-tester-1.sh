#!/usr/bin/env bash
if [[ -n $ZSH_VERSION ]]; then
  autoload -U +X bashcompinit && bashcompinit
  autoload -U +X compinit && compinit
fi

# === COMPLETION SCRIPT START ===

# mygit completion                                         -*- shell-script -*-

# This bash completions script was generated by
# completely (https://github.com/dannyben/completely)
# Modifying it manually is not recommended

_mygit_completions_filter() {
  local words="$1"
  local cur=${COMP_WORDS[COMP_CWORD]}
  local result=()

  if [[ "${cur:0:1}" == "-" ]]; then
    echo "$words"
  
  else
    for word in $words; do
      [[ "${word:0:1}" != "-" ]] && result+=("$word")
    done

    echo "${result[*]}"

  fi
}

_mygit_completions() {
  local cur=${COMP_WORDS[COMP_CWORD]}
  local compwords=("${COMP_WORDS[@]:1:$COMP_CWORD-1}")
  local compline="${compwords[*]}"

  local original_comp_wordbreaks="$COMP_WORDBREAKS"
  COMP_WORDBREAKS="${COMP_WORDBREAKS//[:=]/}"

  case "$compline" in
    'status'*)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_mygit_completions_filter "--help --verbose --branch $(git branch 2> /dev/null)")" -- "$cur" )
      ;;

    'commit'*)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -A file -W "$(_mygit_completions_filter "--help --message --all -a --quiet -q")" -- "$cur" )
      ;;

    'init'*)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -A directory -W "$(_mygit_completions_filter "--bare")" -- "$cur" )
      ;;

    *)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_mygit_completions_filter "--help --version status init commit")" -- "$cur" )
      ;;

  esac

  COMP_WORDBREAKS="$original_comp_wordbreaks"
} &&
complete -F _mygit_completions mygit

# ex: filetype=sh


# === COMPLETION SCRIPT END ===

COMP_WORDS=( mygit -- )
COMP_LINE="mygit --"
COMP_POINT=${#COMP_LINE}
COMP_CWORD=1

_mygit_completions
for suggestion in "${COMPREPLY[@]}"; do
  echo "$suggestion"
done


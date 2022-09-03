# cli completion                                           -*- shell-script -*-

# This bash completions script was generated by
# completely (https://github.com/dannyben/completely)
# Modifying it manually is not recommended

_cli_completions() {
  local cur=${COMP_WORDS[COMP_CWORD]}
  local compwords=("${COMP_WORDS[@]:1:$COMP_CWORD-1}")
  local compline="${compwords[*]}"

  case "$compline" in
    'command childcommand'*)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "--quiet --verbose -q -v" -- "$cur" )
      ;;

    'command subcommand'*)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "--force --quiet" -- "$cur" )
      ;;

    'command'*)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "subcommand childcommand" -- "$cur" )
      ;;

    *)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "--help --version command conquer" -- "$cur" )
      ;;

  esac
} &&
complete -F _cli_completions cli

# ex: filetype=sh

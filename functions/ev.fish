set -g DEFAULT_EV_DIR ~/.config/env

# Display general usage
function __ev_usage
  echo "EV_DIR is $EV_DIR"
  echo 'Usage:'
  echo ' ev DIR           # Load environment variables'
  echo ' ev -u DIR        # Unload environment variables'
  echo ' ev (-h | --help) # Show this message'
  return 1
end

function __ev_update_completions
  set -q EV_DIR ; or set -g EV_DIR $DEFAULT_EV_DIR

  complete -c ev -n '__fish_use_subcommand' -r -a '-u' -d 'Unset environment variables'
  if test -d "$EV_DIR"
    for d in (ls -1d $EV_DIR/*)
      complete -c ev -n 'test -d' -r -a (basename "$d")
    end
  end
end

function ev -d 'Load environment variables from directory'
  set -q EV_DIR ; or set -g EV_DIR $DEFAULT_EV_DIR

  if test (count $argv) -lt 1
    __ev_usage
    return 1
  end

  switch $argv[1]
    case '-u'
      if not test (count $argv) -eq 2
        echo "Usage: ev -u DIR"
        return 1
      end
  end

  switch $argv[1]
    case -h --help
      __ev_usage
      return 0

    case -u
      set -l dname "$argv[2]"
      set -l d "$EV_DIR/$dname"
      if test -d "$d"
        for fn in (ls -1 $d)
          set -e "$fn"
        end
      end

    case '*'
      set -l dname "$argv[1]"
      set -l d "$EV_DIR/$dname"
      if test -d "$d"
        for fn in (ls -1 $d)
          set -gx "$fn" (cat "$d/$fn")
          echo "$fn"
        end
      else
        echo "$d not found."
        return 1
      end
  end
end

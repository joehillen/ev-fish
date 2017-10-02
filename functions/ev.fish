set -g DEFAULT_EVPATH ~/.config/env

# Display general usage
function __ev_usage
  echo "EVPATH is $EVPATH"
  echo 'Usage:'
  echo ' ev DIR           # Load all environment variables from DIR'
  echo ' ev FILE          # Load a single environment variable from a FILE'
  echo ' ev -u DIR        # Unload all environment variables from DIR'
  echo ' ev (-h | --help) # Show this message'
  return 1
end

function __ev_update_completions
  set -q EVPATH ; or set -g EVPATH $DEFAULT_EVPATH

  complete -c ev -n '__fish_use_subcommand' -r -a '-u' -d 'Unset environment variables'
  for evdir in $EVPATH
    if test -d "$evdir"
      for d in (command ls -1d $evdir/*)
        complete -c ev -n 'test -d' -r -a (basename "$d")
        for f in (command ls -1 $d)
            complete -c ev -n 'test -f' -r -a "(basename $d)/$f"
        end
      end
    end
  end
end

function __ev_load_path
    set -l path "$argv[1]"
    if test -d "$path"
        for fn in (command ls -1 $path)
            set -l f "$path/$fn"
            if test -x "$f"
                set -gx "$fn" (eval $f)
            else if test -f "$f"
                echo $fn
                set -gx "$fn" (cat "$f")
            end
        end
        return 0
    else if test -f "$path"
        echo (basename $path)
        if test -x "$path"
            set -gx (basename $path) (eval $path)
        else
            set -gx (basename $path) (cat "$path")
        end
        return 0
    end
    return 1
end

function ev -d 'Load environment variables from directory'
  set -q EVPATH ; or set -g EVPATH $DEFAULT_EVPATH

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
      for evdir in $EVPATH
          set -l d "$evdir/$dname"
          if test -d "$d"
              for fn in (command ls -1 $d)
                  echo $fn
                  set -e "$fn"
              end
              break
          end
      end


    case '*'
      set -l name "$argv[1]"
      for evdir in $EVPATH
          set -l path "$evdir/$name"
          __ev_load_path "$path"
          if test $status -eq 0
              return 0
          end
      end
      __ev_load_path "$name"
      if test $status -eq 0
          return 0
      end
      echo "$name not found."
      return 1
  end
end

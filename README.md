# ev-fish

[envdir](https://cr.yp.to/daemontools/envdir.html) for fish shell

Load environment variables from directories and files.

# Usage

By default, `ev` looks for environment variable directories in `$XDG_CONFIG_HOME/env`.  
Set `EVPATH` to change this. `EVPATH` can also be a list of directories.

```
$ ev -h
Load environment variables from files and directories, like envdir

EVPATH=/home/joe/.config/env

Usage:
   ev [-q] PATH ...
   ev [-q] -u PATH ...

Options:
 -q            No output
 -u PATH       Unset environment variables in PATH
 -h --help     Show this message
```

## Example

```
$ env | grep FOO
$ env | grep BAR
$ tree ~/.config/env/foo/
/home/joe/.config/env/foo/
├── FOO
└── BAR

0 directories, 2 files
$ ev foo
FOO
BAR
$ env | grep FOO
FOO=foo123
$ env | grep BAR
BAR=bar
$ ev -u foo
FOO
BAR
$ env | grep FOO
$ env | grep BAR
```

## Executables

If a file is executable, `ev` will run the file and store the result.

```
$ echo >IP "\
   #!/bin/sh
   curl -s ifconfig.co"
$ chmod +x IP
$ ./IP
8.8.8.8
$ env | grep IP
$ ev IP
IP
$ env | grep IP
IP=8.8.8.8
```

## Recursive

`ev` will recursively add environment variables from subdirectories.

```
$ env | grep FOO
$ env | grep BAR
$ env | grep BAZ
$ tree envvars/
envvars/
└── foo
    ├── FOO
    └── bar
        ├── BAR
        └── baz
            └── BAZ

3 directories, 3 files
$ ev envvars
FOO
BAR
BAZ
$ env | grep FOO
FOO=foo
$ env | grep BAR
BAR=bar
$ env | grep BAZ
BAZ=baz
$ ev -u envvars
FOO
BAR
BAZ
$ env | grep FOO
$ env | grep BAR
$ env | grep BAZ
```

# Installation


## [fisherman](https://github.com/fisherman/fisherman) (recommended)

```
fisher joehillen/to-fish
```

## Using [fundle](https://github.com/tuvistavie/fundle)

Add the following to `~/.config/fish/config.fish` and run `fundle install`.

```
fundle plugin 'joehillen/ev-fish'
```

## Manually

Run `make` or

```
cp functions/ev.fish ~/.config/fish/functions/
cp completions/ev.fish ~/.config/fish/completions/
```


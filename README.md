# ev-fish

[envdir](https://cr.yp.to/daemontools/envdir.html) for fish shell

Load environment variables from directories and files.

## Usage

By default, `ev` looks for environment variable directories in `~/.config/env`,
set `EVPATH` to change this. `EVPATH` can be a list of directories.

```
Usage:
 ev DIR           # Load all environment variables from DIR
 ev FILE          # Load a single environment variable from a FILE
 ev -u DIR        # Unload all environment variables from DIR
 ev (-h | --help) # Show this message
```

### Example

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
```

If a file is executable, `ev` will run the file to retrieve the environment variables.

```
$ echo -e '#!/bin/sh\ncurl -s ifconfig.co' > IP
$ chmod +x IP
$ ./IP
8.8.8.8
$ env | grep IP
$ ev ./IP
IP
$ env | grep IP
IP=8.8.8.8
```

## Installation

### Using [fundle](https://github.com/tuvistavie/fundle) (recommended)

Add

```
fundle plugin 'joehillen/ev-fish'
```

to your `config.fish` and run `fundle install`.

### Manually

Put `functions/ev.fish` in `~/.config/fish/functions/` directory,
and put `completions/ev.fish` in `~/.config/fish/completions/`.

or run `make`

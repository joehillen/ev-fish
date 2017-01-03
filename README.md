# ev-fish

envdir for fish

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

## Usage

By default, `ev` looks for environment variable directories in `~/.config/env`,
set `EV_DIR` to change this.

```
Usage:
 ev DIR           # Load environment variables
 ev -u DIR        # Unload environment variables
 ev (-h | --help) # Show this message
```

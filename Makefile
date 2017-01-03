all:
	cp functions/ev.fish ~/.config/fish/functions/
	mkdir -p ~/.config/fish/completions/
	cp completions/ev.fish ~/.config/fish/completions/

uninstall:
	rm -f ~/.config/fish/functions/ev.fish
	rm -f ~/.config/fish/completions/.fish

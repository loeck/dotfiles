#!/usr/bin/env bash

function doIt() {
	rsync \
		--exclude ".DS_Store" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
    --exclude ".editorconfig" \
    --exclude ".git/" \
    --exclude ".gitignore" \
    --exclude "Brewfile" \
    --exclude "install.sh" \
		-avh --no-perms . ~;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/N) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;

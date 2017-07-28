# dotfiles

Copy all config files in `~` directory
```
./bootstrap.sh
```

Install soft
```
./install.sh
```

# Git credentials
Copy paste configuration in `.extra`
```
GIT_AUTHOR_NAME="Loëck Vézien"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="loeck.vezien@gmail.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```

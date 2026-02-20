# unix-config

## Installation

Clone this repo somewhere, and then run `./make_links`.

## Local Secrets And Overrides

This repo intentionally keeps secrets out of tracked files.

- `.zshrc` loads untracked local files if they exist:
  - `~/.zshrc.local`
  - `~/.zshrc.d/*.local.zsh`
  - Example split: `~/.zshrc.d/mozi.local.zsh` and `~/.zshrc.d/mozi.secrets.local.zsh`
Create local files as needed, then customize locally. The `*.local.*` files are ignored by git.

## Git Config Split

- `.gitconfig` includes `~/.gitconfig.local` for all machine-specific and org-specific overrides.
- Keep Mozi-specific includes/rules in `~/.gitconfig.local`.
- `~/.gitconfig.local` can use conditional includes. Example:

```ini
[includeIf "gitdir:~/Documents/mozi/"]
    path = ~/.gitconfig.mozi
```

- Put Mozi-only settings (for example, user identity) in `~/.gitconfig.mozi`:

```ini
[user]
    name = Julian Lo
    email = julian@mozi.app
```

## More stuff to install on new machines

```

# Install warp: https://www.warp.dev/ (and enable PS1 honouring)
# Install homebrew: https://docs.brew.sh/Installation
# Install vundle: https://github.com/VundleVim/Vundle.vim
# Edit bash_profile to put unix-config/scripts directory on the path

brew install git
brew install git-delta
brew install yarn
brew install --cask visual-studio-code
brew install --cask slack
brew install --cask spotify
brew install --cask zoom

# Look at `.gitconfig` for useful aliases

```

### Visual Studio Code

#### vscodevim
- Install from Extensions pane
- Follow instructions there to fix key-repeating behaviour

#### Settings sync
- Install from Extensions pane
- Login with github, select existing gist

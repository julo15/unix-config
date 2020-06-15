# unix-config

## Installation

Clone this repo somewhere, and then run `./make_links`.

## More stuff to install on new machines

```

# Install homebrew: https://docs.brew.sh/Installation
# Install vundle: https://github.com/VundleVim/Vundle.vim
# Edit bash_profile to put unix-config/scripts directory on the path

brew install git
brew install yarn
brew cask install visual-studio-code

git config --global push.default current
git config --global alias.lo 'log --oneline -5'
git config --global alias.new 'checkout -b'
git config --global alias.amend 'commit --amend'
git config --global alias.discard 'checkout HEAD'

```

### Visual Studio Code

#### vscodevim
- Install from Extensions pane
- Follow instructions there to fix key-repeating behaviour

#### Settings sync
- Install from Extensions pane
- Login with github, select existing gist


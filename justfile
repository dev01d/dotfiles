brew:
  ./scripts/brew_maint.py

setup:
  ./scripts/setup.py

stow:
  cd ~/.dotfiles && stow . --dotfiles

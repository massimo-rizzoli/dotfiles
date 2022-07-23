export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
export PATH="$PATH:$HOME/.local/bin"


export EDITOR="alacritty --option font.size=16.0 font.normal.style=Normal --title Neovim --working-directory=. --command nvim"
export FILE_BROWSER="alacritty --title=Ranger --working-directory=. --command ranger"

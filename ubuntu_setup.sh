echo "Update and Upgrade..."
sudo apt update && sudo apt upgrade -y
echo

echo "Directories creation..."
mkdir -p ~/.local/bin ~/.config
ln -s /mnt/c/Users/wassi/Downloads ~/Downloads
echo

echo "Basic tools installation..."
sudo apt install -y build-essential fd-find git lf nodejs npm openjdk-21-jdk python-is-python3 python3-pip python3-venv ripgrep sqlite3 tree unzip
wget https://github.com/neovim/neovim/releases/download/v0.10.3/nvim-linux64.tar.gz
tar xzf nvim-linux64.tar.gz -C ~/.local/bin --strip-components=1
rm -rf nvim-linux64.tar.gz
echo

echo ".bash modifications"
cat << 'EOF' >> ~/.bash_aliases
alias v='nvim'
alias g='git'
alias d='cd ~/Documents && ls'
alias D='cd ~/Downloads && ls'
alias ..='cd ..'
alias a='source $(pwd)/.venv/bin/activate'
alias dea='deactivate'
alias j='jupyter lab'
alias f='cd ~/Documents/Fanshawe/S2 && ls'
alias e='explorer.exe .'
alias s='sqlite3'
alias c='cd ~/.config && ls'
EOF

cat << 'EOF' >> ~/.bashrc

# PERSO
# Enable vi mode for bash
set -o vi

# Path
export PATH="$PATH:$(find $HOME/.local/bin -type d | tr '\n' ':')"
export PATH="${PATH%:}"

# Start tmux if not already inside a tmux session
if [ -z "$TMUX" ]; then
    tmux attach-session -t default || tmux new-session -s default
fi

# Remove zone identifier files on startup
find ~ -name "*Zone.Identifier" -type f -delete 2>/dev/null

# Keybinds
bind '"\C-o":"lf\n"'
EOF
echo

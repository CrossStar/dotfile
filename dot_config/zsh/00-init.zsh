# clashctl
if [[ -r /mnt/home/wuzhixin/clashctl/scripts/cmd/clashctl.sh ]]; then
  source /mnt/home/wuzhixin/clashctl/scripts/cmd/clashctl.sh
fi

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="bira"
plugins=(z extract zsh-syntax-highlighting zsh-autosuggestions)

if [[ -r "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
fi

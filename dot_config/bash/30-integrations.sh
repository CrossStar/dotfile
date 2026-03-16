[ -f "$HOME/.fzf.bash" ] && source "$HOME/.fzf.bash"

# clashctl START
if [ -r /mnt/home/wuzhixin/clashctl/scripts/cmd/clashctl.sh ]; then
  . /mnt/home/wuzhixin/clashctl/scripts/cmd/clashctl.sh
fi
# 自动开启代理环境
# watch_proxy
# clashctl END

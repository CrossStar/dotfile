path_prepend() {
  case ":$PATH:" in
    *":$1:"*) ;;
    *) [ -d "$1" ] && PATH="$1:$PATH" ;;
  esac
}

path_prepend "/opt/anaconda3/bin"
path_prepend "$HOME/.local/bin"
path_prepend "/mnt/home/wuzhixin/.pixi/bin"

export PATH

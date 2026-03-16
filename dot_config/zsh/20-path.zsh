typeset -U path

_get_vscode_remote_cli_path() {
  local latest
  latest="$(command ls -1t "$HOME/.vscode-server/bin" 2>/dev/null | head -n 1 || true)"
  if [[ -n "$latest" && -d "$HOME/.vscode-server/bin/$latest/bin/remote-cli" ]]; then
    print -- "$HOME/.vscode-server/bin/$latest/bin/remote-cli"
  fi
}

local vscode_remote_cli
vscode_remote_cli="$(_get_vscode_remote_cli_path)"

path=(
  "$HOME/.local/bin"
  "$HOME/bin"
  "$HOME/clashtui"
  "$HOME/.pixi/bin"
  "$HOME/.pixi/envs/nodejs/bin"
  ${vscode_remote_cli:+$vscode_remote_cli}
  $path
)

export PATH

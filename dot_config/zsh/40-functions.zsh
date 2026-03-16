export RESEARCH_LOCAL_PATH="/mnt/home/wuzhixin/Workspace/Research"
export RESEARCH_GDRIVE_PATH="mygdrive:Research"
export RESEARCH_GPU_PATH="rivermind:Research"
export RESEARCH_FILTER_FILE="/mnt/home/wuzhixin/Workspace/Research/.rclone-ignore"

_confirmed_rclone_sync() {
  local source_path="$1"
  local target_path="$2"
  local prompt_message="$3"
  local color_code="${4:-33}"

  printf "\033[%sm%s\033[0m\n" "$color_code" "$prompt_message"
  echo "Source: $source_path"
  echo "Dest:   $target_path"
  printf "Proceed? (y/N): "
  read -r answer

  if [[ "$answer" =~ ^[Yy]$ ]]; then
    rclone sync "$source_path" "$target_path" -P --filter-from "$RESEARCH_FILTER_FILE"
  else
    echo "Cancelled."
  fi
}

colab-push() {
  _confirmed_rclone_sync \
    "$RESEARCH_LOCAL_PATH" \
    "$RESEARCH_GDRIVE_PATH" \
    "[Confirm] Push local changes to Google Drive?" \
    33
}

colab-pull() {
  _confirmed_rclone_sync \
    "$RESEARCH_GDRIVE_PATH" \
    "$RESEARCH_LOCAL_PATH" \
    "[WARNING] Pull from Google Drive? This may delete local files not on remote!" \
    31
}

gpu-push() {
  _confirmed_rclone_sync \
    "$RESEARCH_LOCAL_PATH" \
    "$RESEARCH_GPU_PATH" \
    "[Confirm] Push local changes to remote GPU Drive?" \
    33
}

gpu-pull() {
  _confirmed_rclone_sync \
    "$RESEARCH_GPU_PATH" \
    "$RESEARCH_LOCAL_PATH" \
    "[WARNING] Pull from remote GPU Drive? This may delete local files not on remote!" \
    31
}

y() {
  local tmp cwd
  tmp="$(mktemp -t yazi-cwd.XXXXXX)" || return 1
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp" 2>/dev/null)" && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
    builtin cd -- "$cwd" || return
  fi
  rm -f -- "$tmp"
}

# ~/.config/zsh/fns/tmux.zsh

# =========================================================
# Tmux helpers
# =========================================================

# Create a Tmux Dev Layout with editor, AI, and terminal.
# Usage: tdl <c|cx|codex|other_ai> [<second_ai>]
tdl() {
  if [[ -z "$1" ]]; then
    echo "Usage: tdl <c|cx|codex|other_ai> [<second_ai>]"
    return 1
  fi

  if [[ -z "$TMUX" ]]; then
    echo "You must start tmux to use tdl."
    return 1
  fi

  local current_dir="$PWD"
  local editor_pane="$TMUX_PANE"
  local ai="$1"
  local ai2="${2:-}"
  local ai_pane ai2_pane

  tmux rename-window -t "$editor_pane" "$(basename "$current_dir")"
  tmux split-window -v -p 15 -t "$editor_pane" -c "$current_dir"
  ai_pane=$(tmux split-window -h -p 30 -t "$editor_pane" -c "$current_dir" -P -F '#{pane_id}')

  if [[ -n "$ai2" ]]; then
    ai2_pane=$(tmux split-window -v -t "$ai_pane" -c "$current_dir" -P -F '#{pane_id}')
    tmux send-keys -t "$ai2_pane" "$ai2" C-m
  fi

  tmux send-keys -t "$ai_pane" "$ai" C-m
  tmux send-keys -t "$editor_pane" "$EDITOR ." C-m
  tmux select-pane -t "$editor_pane"
}

# Create multiple tdl windows with one per subdirectory in the current directory.
# Usage: tdlm <c|cx|codex|other_ai> [<second_ai>]
tdlm() {
  if [[ -z "$1" ]]; then
    echo "Usage: tdlm <c|cx|codex|other_ai> [<second_ai>]"
    return 1
  fi

  if [[ -z "$TMUX" ]]; then
    echo "You must start tmux to use tdlm."
    return 1
  fi

  local ai="$1"
  local ai2="${2:-}"
  local base_dir="$PWD"
  local first=1
  local session_name

  session_name="$(basename "$base_dir" | tr '.:' '--')"
  tmux rename-session "$session_name"

  local dir dirpath pane_id
  for dir in "$base_dir"/*/; do
    [[ -d "$dir" ]] || continue
    dirpath="${dir%/}"

    if (( first )); then
      tmux send-keys -t "$TMUX_PANE" "cd ${(q)dirpath} && tdl ${(q)ai} ${(q)ai2}" C-m
      first=0
    else
      pane_id=$(tmux new-window -c "$dirpath" -P -F '#{pane_id}')
      tmux send-keys -t "$pane_id" "tdl ${(q)ai} ${(q)ai2}" C-m
    fi
  done
}

# Create a multi-pane swarm layout with the same command started in each pane.
# Usage: tsl <pane_count> <command...>
tsl() {
  if (( $# < 2 )); then
    echo "Usage: tsl <pane_count> <command...>"
    return 1
  fi

  if [[ -z "$TMUX" ]]; then
    echo "You must start tmux to use tsl."
    return 1
  fi

  local count="$1"
  shift
  local cmd="$*"
  local current_dir="$PWD"
  local -a panes

  tmux rename-window -t "$TMUX_PANE" "$(basename "$current_dir")"
  panes=("$TMUX_PANE")

  while (( ${#panes[@]} < count )); do
    local new_pane
    local split_target="${panes[-1]}"
    new_pane=$(tmux split-window -h -t "$split_target" -c "$current_dir" -P -F '#{pane_id}')
    panes+=("$new_pane")
    tmux select-layout -t "${panes[1]}" tiled
  done

  local pane
  for pane in "${panes[@]}"; do
    tmux send-keys -t "$pane" "$cmd" C-m
  done

  tmux select-pane -t "${panes[1]}"
}

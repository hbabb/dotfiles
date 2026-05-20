# ~/.config/zsh/fns/ssh-port-forwarding.zsh

# =========================================================
# SSH port forwarding
# =========================================================

fip() {
  if (( $# < 2 )); then
    echo "Usage: fip <host> <port1> [port2] ..."
    return 1
  fi

  local host="$1"
  shift

  local port
  for port in "$@"; do
    ssh -f -N -L "$port:localhost:$port" "$host" && echo "Forwarding localhost:$port -> $host:$port"
  done
}

dip() {
  if (( $# == 0 )); then
    echo "Usage: dip <port1> [port2] ..."
    return 1
  fi

  local port
  for port in "$@"; do
    pkill -f "ssh.*-L $port:localhost:$port" && echo "Stopped forwarding port $port" || echo "No forwarding on port $port"
  done
}

lip() {
  pgrep -af 'ssh.*-L [0-9]+:localhost:[0-9]+' || echo 'No active forwards'
}

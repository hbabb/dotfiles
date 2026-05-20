# ~/.config/zsh/fns/compression.zsh

# =========================================================
# Compression
# =========================================================

compress() {
  if (( $# != 1 )); then
    echo "Usage: compress <file-or-directory>"
    return 1
  fi

  local target="${1%/}"
  tar -czf "${target}.tar.gz" "$target"
}

decompress() {
  if (( $# != 1 )); then
    echo "Usage: decompress <file.tar.gz>"
    return 1
  fi

  tar -xzf "$1"
}

# ~/.config/zsh/fns/transcoding.zsh

# =========================================================
# Transcoding helpers
# =========================================================

_require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Error: missing command: $1"
    return 1
  fi
}

_output_stem() {
  local input="$1"
  echo "${input%.*}"
}

transcode-video-1080p() {
  if (( $# != 1 )); then
    echo "Usage: transcode-video-1080p <video>"
    return 1
  fi

  _require_command ffmpeg || return 1
  ffmpeg -i "$1" -vf 'scale=-2:1080' -c:v libx264 -crf 23 -preset medium -c:a aac -b:a 192k "$(_output_stem "$1")-1080p.mp4"
}

transcode-video-4K() {
  if (( $# != 1 )); then
    echo "Usage: transcode-video-4K <video>"
    return 1
  fi

  _require_command ffmpeg || return 1
  ffmpeg -i "$1" -vf 'scale=-2:2160' -c:v libx264 -crf 23 -preset medium -c:a aac -b:a 192k "$(_output_stem "$1")-4k.mp4"
}

transcode-video-gif() {
  if (( $# != 1 )); then
    echo "Usage: transcode-video-gif <video>"
    return 1
  fi

  _require_command ffmpeg || return 1
  ffmpeg -i "$1" -vf 'fps=12,scale=-2:1080:flags=lanczos' "$(_output_stem "$1").gif"
}

_img_convert() {
  if (( $# != 3 )); then
    echo "Usage: _img_convert <input> <format> <quality>"
    return 1
  fi

  _require_command magick || return 1

  local input="$1"
  local format="$2"
  local quality="$3"

  magick "$input" -quality "$quality" "$(_output_stem "$input").$format"
}

img2jpg() {
  img2jpg-large "$@"
}

img2jpg-small() {
  if (( $# != 1 )); then
    echo "Usage: img2jpg-small <image>"
    return 1
  fi

  _img_convert "$1" jpg 70
}

img2jpg-medium() {
  if (( $# != 1 )); then
    echo "Usage: img2jpg-medium <image>"
    return 1
  fi

  _img_convert "$1" jpg 85
}

img2jpg-large() {
  if (( $# != 1 )); then
    echo "Usage: img2jpg-large <image>"
    return 1
  fi

  _img_convert "$1" jpg 95
}

img2png() {
  if (( $# != 1 )); then
    echo "Usage: img2png <image>"
    return 1
  fi

  _require_command magick || return 1
  magick "$1" "$(_output_stem "$1").png"
}

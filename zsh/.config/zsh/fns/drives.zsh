# ~/.config/zsh/fns/drives.zsh

# =========================================================
# Drive helpers
# =========================================================

_partition_one() {
  local device="$1"

  case "$device" in
    *nvme*|*mmcblk*) echo "${device}p1" ;;
    *) echo "${device}1" ;;
  esac
}

_select_drive() {
  echo "Available block devices:"
  lsblk -dpno NAME,SIZE,MODEL,TRAN | grep -E '^/dev/(sd|nvme|mmcblk)' || return 1
  echo
  printf 'Device path: '

  local drive
  read -r drive

  if [[ ! -b "$drive" ]]; then
    echo "Error: '$drive' is not a block device."
    return 1
  fi

  echo "$drive"
}

# Write an ISO file to a removable drive.
iso2sd() {
  if (( $# < 1 || $# > 2 )); then
    echo "Usage: iso2sd <input_file.iso> [output_device]"
    echo "Example: iso2sd ~/Downloads/Fedora.iso /dev/sda"
    return 1
  fi

  local iso="$1"
  local drive="${2:-}"

  if [[ ! -f "$iso" ]]; then
    echo "Error: ISO not found: $iso"
    return 1
  fi

  if [[ -z "$drive" ]]; then
    drive="$(_select_drive)" || return 1
  fi

  echo "WARNING: This will erase $drive."
  printf 'Continue? [y/N]: '

  local confirm
  read -r confirm

  if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    return 0
  fi

  sudo dd bs=4M status=progress oflag=sync if="$iso" of="$drive"
  sync
  sudo eject "$drive" 2>/dev/null || true
}

# Format an entire drive as one exFAT partition.
format-drive() {
  if (( $# != 2 )); then
    echo "Usage: format-drive <device> <label>"
    echo "Example: format-drive /dev/sda 'My Stuff'"
    echo
    echo "Available block devices:"
    lsblk -dpno NAME,SIZE,MODEL,TRAN | grep -E '^/dev/(sd|nvme|mmcblk)'
    return 1
  fi

  local device="$1"
  local label="$2"

  if [[ ! -b "$device" ]]; then
    echo "Error: '$device' is not a block device."
    return 1
  fi

  echo "WARNING: This will completely erase $device and label it '$label'."
  printf 'Continue? [y/N]: '

  local confirm
  read -r confirm

  if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    return 0
  fi

  sudo wipefs -a "$device"
  sudo dd if=/dev/zero of="$device" bs=1M count=100 status=progress
  sudo parted -s "$device" mklabel gpt
  sudo parted -s "$device" mkpart primary 1MiB 100%
  sudo parted -s "$device" set 1 msftdata on

  local partition
  partition="$(_partition_one "$device")"

  sudo partprobe "$device" || true
  sudo udevadm settle || true
  sudo mkfs.exfat -n "$label" "$partition"

  echo "Drive $device formatted as exFAT and labeled '$label'."
}

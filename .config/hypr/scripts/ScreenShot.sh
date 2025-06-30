##!/bin/bash
## /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
## Screenshots scripts
#
## variables
#time=$(date "+%d-%b_%H-%M-%S")
#dir="$(xdg-user-dir)/Pictures/Screenshots"
#file="Screenshot_${time}_${RANDOM}.png"
#
#iDIR="$HOME/.config/swaync/icons"
#iDoR="$HOME/.config/swaync/images"
#sDIR="$HOME/.config/hypr/scripts"
#
#active_window_class=$(hyprctl -j activewindow | jq -r '(.class)')
#active_window_file="Screenshot_${time}_${active_window_class}.png"
#active_window_path="${dir}/${active_window_file}"
#
#notify_cmd_base="notify-send -t 10000 -A action1=Open -A action2=Delete -h string:x-canonical-private-synchronous:shot-notify"
#notify_cmd_shot="${notify_cmd_base} -i ${iDIR}/picture.png "
#notify_cmd_shot_win="${notify_cmd_base} -i ${iDIR}/picture.png "
#notify_cmd_NOT="notify-send -u low -i ${iDoR}/note.png "
#
## notify and view screenshot
#notify_view() {
#    if [[ "$1" == "active" ]]; then
#        if [[ -e "${active_window_path}" ]]; then
#			"${sDIR}/Sounds.sh" --screenshot
#            resp=$(timeout 5 ${notify_cmd_shot_win} " Screenshot of:" " ${active_window_class} Saved.")
#            case "$resp" in
#				action1)
#					xdg-open "${active_window_path}" &
#					;;
#				action2)
#					rm "${active_window_path}" &
#					;;
#			esac
#        else
#            ${notify_cmd_NOT} " Screenshot of:" " ${active_window_class} NOT Saved."
#            "${sDIR}/Sounds.sh" --error
#        fi
#
#    elif [[ "$1" == "swappy" ]]; then
#		"${sDIR}/Sounds.sh" --screenshot
#		resp=$(${notify_cmd_shot} " Screenshot:" " Captured by Swappy")
#		case "$resp" in
#			action1)
#				swappy -f - <"$tmpfile"
#				;;
#			action2)
#				rm "$tmpfile"
#				;;
#		esac
#
#    else
#        local check_file="${dir}/${file}"
#        if [[ -e "$check_file" ]]; then
#            "${sDIR}/Sounds.sh" --screenshot
#            resp=$(timeout 5 ${notify_cmd_shot} " Screenshot" " Saved")
#			case "$resp" in
#				action1)
#					xdg-open "${check_file}" &
#					;;
#				action2)
#					rm "${check_file}" &
#					;;
#			esac
#        else
#            ${notify_cmd_NOT} " Screenshot" " NOT Saved"
#            "${sDIR}/Sounds.sh" --error
#        fi
#    fi
#}
#
## countdown
#countdown() {
#	for sec in $(seq $1 -1 1); do
#		notify-send -h string:x-canonical-private-synchronous:shot-notify -t 1000 -i "$iDIR"/timer.png  " Taking shot" " in: $sec secs"
#		sleep 1
#	done
#}
#
## take shots
#shotnow() {
#	cd ${dir} && grim - | tee "$file" | wl-copy
#	sleep 2
#	notify_view
#}
#
#shot5() {
#	countdown '5'
#	sleep 1 && cd ${dir} && grim - | tee "$file" | wl-copy
#	sleep 1
#	notify_view
#}
#
#shot10() {
#	countdown '10'
#	sleep 1 && cd ${dir} && grim - | tee "$file" | wl-copy
#	notify_view
#}
#
#shotwin() {
#	w_pos=$(hyprctl activewindow | grep 'at:' | cut -d':' -f2 | tr -d ' ' | tail -n1)
#	w_size=$(hyprctl activewindow | grep 'size:' | cut -d':' -f2 | tr -d ' ' | tail -n1 | sed s/,/x/g)
#	cd ${dir} && grim -g "$w_pos $w_size" - | tee "$file" | wl-copy
#	notify_view
#}
#
#shotarea() {
#	tmpfile=$(mktemp)
#	grim -g "$(slurp)" - >"$tmpfile"
#
#  # Copy with saving
#	if [[ -s "$tmpfile" ]]; then
#		wl-copy <"$tmpfile"
#		mv "$tmpfile" "$dir/$file"
#	fi
#	notify_view
#}
#
#shotactive() {
#    active_window_class=$(hyprctl -j activewindow | jq -r '(.class)')
#    active_window_file="Screenshot_${time}_${active_window_class}.png"
#    active_window_path="${dir}/${active_window_file}"
#
#    hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | grim -g - "${active_window_path}"
#	sleep 1
#    notify_view "active"
#}
#
#shotswappy() {
#	tmpfile=$(mktemp)
#	grim -g "$(slurp)" - >"$tmpfile"
#
#  # Copy without saving
#  if [[ -s "$tmpfile" ]]; then
#		wl-copy <"$tmpfile"
#    notify_view "swappy"
#  fi
#}
#
#if [[ ! -d "$dir" ]]; then
#	mkdir -p "$dir"
#fi
#
#if [[ "$1" == "--now" ]]; then
#	shotnow
#elif [[ "$1" == "--in5" ]]; then
#	shot5
#elif [[ "$1" == "--in10" ]]; then
#	shot10
#elif [[ "$1" == "--win" ]]; then
#	shotwin
#elif [[ "$1" == "--area" ]]; then
#	shotarea
#elif [[ "$1" == "--active" ]]; then
#	shotactive
#elif [[ "$1" == "--swappy" ]]; then
#	shotswappy
#else
#	echo -e "Available Options : --now --in5 --in10 --win --area --active --swappy"
#fi
#
#exit 0
#

#!/bin/bash

# Variables
time=$(date "+%d-%b_%H-%M-%S")
dir="$HOME/Pictures/Screenshots"
file="Screenshot_${time}_${RANDOM}.png"
full_path="${dir}/${file}"

# Ensure directory exists
mkdir -p "$dir"

# Notification function
notify_shot() {
  if [[ -e "$1" ]]; then
    notify-send -t 10000 -A action1=Open -A action2=Delete "Screenshot" "Saved as $1"
    # Optional: Play sound
    # "${sDIR}/Sounds.sh" --screenshot
  else
    notify-send -u low "Screenshot" "Not saved!"
    # "${sDIR}/Sounds.sh" --error
  fi
}

# Handle notification actions (for rofi/notify-send)
notify_action() {
  case "$1" in
  action1) xdg-open "$2" ;;
  action2) rm "$2" ;;
  esac
}

# Shot now (full screen)
shotnow() {
  flameshot full -p "$full_path"
  notify_shot "$full_path"
}

# Shot with delay (full screen)
shotdelay() {
  local delay=$1
  echo "Taking screenshot in $delay seconds..."
  sleep "$delay"
  flameshot full -p "$full_path"
  notify_shot "$full_path"
}

# Shot window (active window)
shotwin() {
  # Flameshot does not natively support window selection, but you can use GUI mode
  # For CLI, grim is better for window selection. For flameshot, use GUI:
  flameshot gui -p "$full_path"
  notify_shot "$full_path"
}

# Shot area
shotarea() {
  flameshot gui -p "$full_path"
  notify_shot "$full_path"
}

# Shot active window (not natively supported in flameshot CLI)
# For flameshot, use GUI and manually select the window
shotactive() {
  flameshot gui -p "$full_path"
  notify_shot "$full_path"
}

# Main logic
case "$1" in
"--now") shotnow ;;
"--in5") shotdelay 5 ;;
"--in10") shotdelay 10 ;;
"--win") shotwin ;;
"--area") shotarea ;;
"--active") shotactive ;;
*)
  echo "Available Options: --now --in5 --in10 --win --area --active"
  echo "Note: --win and --active use GUI mode in flameshot (manual selection)."
  ;;
esac

exit 0

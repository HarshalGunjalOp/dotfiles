#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Playerctl - Modified for Spotify priority with fallback

music_icon="$HOME/.config/swaync/icons/music.png"

# Smart player selection - prioritize Spotify, fallback to any available player
get_player_cmd() {
  if playerctl -p spotify status &>/dev/null; then
    echo "playerctl -p spotify"
  else
    echo "playerctl"
  fi
}

# Play the next track
play_next() {
  $(get_player_cmd) next
  show_music_notification
}

# Play the previous track
play_previous() {
  $(get_player_cmd) previous
  show_music_notification
}

# Toggle play/pause
toggle_play_pause() {
  $(get_player_cmd) play-pause
  show_music_notification
}

# Stop playback
stop_playback() {
  $(get_player_cmd) stop
  notify-send -e -u low -i $music_icon " Playback:" " Stopped"
}

# Display notification with song information
show_music_notification() {
  player_cmd=$(get_player_cmd)
  status=$($player_cmd status)

  if [[ "$status" == "Playing" ]]; then
    song_title=$($player_cmd metadata title)
    song_artist=$($player_cmd metadata artist)

    # Show which player is being controlled
    if [[ "$player_cmd" == *"spotify"* ]]; then
      notify-send -e -u low -i $music_icon "🎵 Spotify:" "$song_title by $song_artist"
    else
      notify-send -e -u low -i $music_icon "🎵 Now Playing:" "$song_title by $song_artist"
    fi
  elif [[ "$status" == "Paused" ]]; then
    if [[ "$player_cmd" == *"spotify"* ]]; then
      notify-send -e -u low -i $music_icon "🎵 Spotify:" " Paused"
    else
      notify-send -e -u low -i $music_icon " Playback:" " Paused"
    fi
  fi
}

# Get media control action from command line argument
case "$1" in
"--nxt")
  play_next
  ;;
"--prv")
  play_previous
  ;;
"--pause")
  toggle_play_pause
  ;;
"--stop")
  stop_playback
  ;;
*)
  echo "Usage: $0 [--nxt|--prv|--pause|--stop]"
  exit 1
  ;;
esac

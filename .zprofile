# Session
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_PICTURES_DIR=$HOME/Pictures

# Wayland Stuff
export QT_QPA_PLATFORM=wayland-egl
export ELM_DISPLAY=wl
export SDL_VIDEODRIVER=wayland
export MOZ_ENABLE_WAYLAND=1
export WLR_NO_HARDWARE_CORSORS=1

# Cursors
export XCURSOR_SIZE=48
export XCURSOR_THEME=default

# GTK Theme
export GTK_THEME=Gruvbox-Material-Dark-HIDPI

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

dbus-run-session sway

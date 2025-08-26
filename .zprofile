# Session
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_PICTURES_DIR=$HOME/Pictures
export XDG_DATA_DIRS=/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
export XDG_RUNTIME_DIR=/run/user/$(id -u)

# Wayland Stuff
export QT_QPA_PLATFORM=wayland-egl
export ELM_DISPLAY=wl
export SDL_VIDEODRIVER=wayland,x11
export MOZ_ENABLE_WAYLAND=1
export WLR_NO_HARDWARE_CURSORS=1

# Cursors
export XCURSOR_SIZE=24
export XCURSOR_THEME=Adwaita

# Default Applications
export EDITOR=hx
export VISUAL=$EDITOR
export BROWSER=firefox
export PDFVIEWER=zathura
export TERM=foot
export TERMINAL=foot

# GTK Theme
export GTK_THEME=Gruvbox-Material-Dark-HIDPI

[[ -z $SSH_AUTH_SOCK ]] && eval "$(ssh-agent -s)" >/dev/null
ssh-add -q ~/.ssh/id_ed25519 >/dev/null

# Setup the runtime dir
mkdir -p "$XDG_RUNTIME_DIR"
chmod 700 "$XDG_RUNTIME_DIR"

# Create a user dbus session at a nice standard address
if [ ! -S "$XDG_RUNTIME_DIR/bus" ]; then
  dbus-daemon --session \
    --address="unix:path=$XDG_RUNTIME_DIR/bus" \
    --nofork --nopidfile \
    > "$XDG_RUNTIME_DIR/dbus.log" 2>&1 &
fi

export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"

# Launch into sway
exec sway --unsupported-gpu

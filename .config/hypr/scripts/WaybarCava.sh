#!/usr/bin/env bash

if ! command -v cava >/dev/null 2>&1; then
    echo "cava not found"
    exit 1
fi

bar=" ▂▃▄▅▆▇█"
dict="s/;//g"
bar_length=${#bar}

for ((i = 0; i < bar_length; i++)); do
    dict+=";s/$i/${bar:$i:1}/g"
done

config_file=$(mktemp /tmp/cava_waybar.XXXXXX)
trap 'rm -f "$config_file"' EXIT

cat > "$config_file" <<EOF
[general]
framerate = 60
bars = 12

[input]
method = pipewire
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

cava -p "$config_file" | sed -u "$dict"

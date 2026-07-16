#!/usr/bin/env bash
export PATH="/opt/homebrew/bin:$PATH"
pid="$(aerospace list-windows --focused --format '%{app-pid}')"
[ -n "$pid" ] && kill "$pid"

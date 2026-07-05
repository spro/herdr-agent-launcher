#!/usr/bin/env bash
set -euo pipefail
CMD=$1
NAME=${2:-${CMD%% *}}
herdr="${HERDR_BIN_PATH:-herdr}"
# Plugin actions inject HERDR_WORKSPACE_ID; shell keybinds inject HERDR_ACTIVE_WORKSPACE_ID
WORKSPACE_ID="${HERDR_WORKSPACE_ID:-${HERDR_ACTIVE_WORKSPACE_ID:?no herdr workspace id in environment}}"
NAME_TITLE="$(tr '[:lower:]' '[:upper:]' <<< "${NAME:0:1}")${NAME:1}"
TAB_NAME=$("$herdr" input --prompt "$NAME_TITLE tab name")
if [ -z "$TAB_NAME" ]; then
  TAB_NAME=$NAME
fi
TAB_JSON=$("$herdr" tab create --workspace "$WORKSPACE_ID" --label "$TAB_NAME")
TAB_ID=$(echo "$TAB_JSON" | python3 -c 'import sys,json; print(json.load(sys.stdin)["result"]["tab"]["tab_id"])')
PANE_ID=$(echo "$TAB_JSON" | python3 -c 'import sys,json; print(json.load(sys.stdin)["result"]["root_pane"]["pane_id"])')
"$herdr" tab focus "$TAB_ID"
"$herdr" pane run "$PANE_ID" "$CMD"

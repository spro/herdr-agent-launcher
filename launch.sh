#!/usr/bin/env bash
set -euo pipefail
MODEL=$1
CMD=${2:-"claude --model $MODEL"}
herdr="${HERDR_BIN_PATH:-herdr}"
MODEL_TITLE="$(tr '[:lower:]' '[:upper:]' <<< "${MODEL:0:1}")${MODEL:1}"
TAB_NAME=$("$herdr" input --prompt "$MODEL_TITLE tab name")
if [ -z "$TAB_NAME" ]; then
  TAB_NAME=$MODEL
fi
TAB_JSON=$("$herdr" tab create --workspace "$HERDR_WORKSPACE_ID" --label "$TAB_NAME")
TAB_ID=$(echo "$TAB_JSON" | python3 -c 'import sys,json; print(json.load(sys.stdin)["result"]["tab"]["tab_id"])')
PANE_ID=$(echo "$TAB_JSON" | python3 -c 'import sys,json; print(json.load(sys.stdin)["result"]["root_pane"]["pane_id"])')
"$herdr" tab focus "$TAB_ID"
"$herdr" pane run "$PANE_ID" "$CMD"

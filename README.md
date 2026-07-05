# Agent Launcher

Herdr plugin for opening a new named tab and running an agent command in it.

## Usage

Run `launch.sh` with the command to execute:

```sh
./launch.sh "codex"
./launch.sh "claude --model sonnet" "sonnet"
```

The first argument is the command Herdr should run in the new pane. The optional
second argument is the default tab name. If no name is provided, the launcher uses
the first word of the command.

When launched, the script prompts for a tab name. Leaving the prompt blank uses
the default name.

## Environment

The launcher expects a Herdr workspace ID from one of these variables:

- `HERDR_WORKSPACE_ID`, injected by Herdr plugin actions.
- `HERDR_ACTIVE_WORKSPACE_ID`, injected by shell keybindings.

The Herdr binary defaults to `herdr` on `PATH`. To use a different binary, set
`HERDR_BIN_PATH`.

## How It Works

`launch.sh` creates a tab in the current workspace, focuses it, and runs the
provided command in the tab's root pane.

The plugin metadata lives in `herdr-plugin.toml`.

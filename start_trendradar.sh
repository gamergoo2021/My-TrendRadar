#!/bin/bash
# Fixed startup script for TrendRadar
export PATH="$HOME/.local/bin:$PATH"

# Ensure dependencies are installed
# We check if uv is in path, if not we assume user has it or we installed it in .local/bin
if ! command -v uv &> /dev/null; then
    echo "uv not found in path, trying ~/.local/bin"
    export PATH="$HOME/.local/bin:$PATH"
fi

uv sync --quiet
echo "Starting TrendRadar..."
uv run python -m trendradar

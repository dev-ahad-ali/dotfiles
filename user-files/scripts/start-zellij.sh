#!/bin/bash

# Get the most recent session (last in the list)
last_session=$(zellij list-sessions -s 2>/dev/null | tail -n1)

if [ -n "$last_session" ]; then
  # Attach to the last session
  zellij attach "$last_session"
else
  # No sessions exist, create a new one
  zellij
fi

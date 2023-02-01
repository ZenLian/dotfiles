#!/usr/bin/env bash

# ensure correct working directory
cd "$(dirname "$0")" || exit 1
CWD="$(pwd)"
printf 'source dir: %s\n' "$CWD"

# ensure chezmoi is installed
version=$(chezmoi --version)
$! || (echo 'chezmoi: not installed' && exit 1)
printf '%s\n' "$version"

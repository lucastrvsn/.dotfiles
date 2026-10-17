#!/usr/bin/env bash

# gpg writes private keys here and requires 700; keep it a real folder, not a link into the repo.
mkdir -p "$HOME/.gnupg"
chmod 700 "$HOME/.gnupg"

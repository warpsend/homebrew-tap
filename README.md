# WarpSend Homebrew Tap

Official Homebrew tap for [WarpSend](https://warpsend.io) — fast, encrypted
NAS-to-NAS file transfer.

## Install

```bash
brew install warpsend/tap/warpsend
```

This installs the `warpsend` CLI (~4MB), which is the single entry point
on every platform. The CLI manages all other components:

```bash
warpsend login          # Sign in
warpsend gui install    # (macOS only) install the Desktop app
warpsend run            # Start the supervisor (auto-downloads the agent daemon)
```

The supervisor (`warpsend run`) automatically downloads and manages the
heavy agent daemon from `app.warpsend.io/_agent/`. On macOS, the optional
Desktop GUI (`warpsend gui install`) gives you a native window for the
same web UI.

## Upgrade

```bash
brew upgrade warpsend
warpsend gui update     # if you installed the Desktop app
```

## Uninstall

```bash
warpsend gui uninstall  # remove the Desktop app
warpsend agent stop     # stop the agent daemon
brew uninstall warpsend # remove the CLI
```

## About this tap

This repository contains the Homebrew formula that points to the `warpsend`
CLI binary hosted at `app.warpsend.io/_agent/downloads/`. All other WarpSend
components (agent daemon, Desktop app, web bundle) are downloaded on demand
by the CLI itself — the tap only ships one formula.

Source: https://github.com/warpsend/warpsend

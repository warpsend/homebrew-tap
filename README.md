# WarpSend Homebrew Tap

Official Homebrew tap for [WarpSend](https://warpsend.io) — fast, encrypted
NAS-to-NAS file transfer.

## Install

### Desktop app (macOS)

```bash
brew install --cask warpsend/tap/warpsend
```

Installs the WarpSend Desktop GUI to `/Applications`. Brew automatically
removes the Gatekeeper quarantine attribute, so the app opens without the
"unidentified developer" warning.

### CLI (macOS / Linux)

```bash
brew install warpsend/tap/warpsend
```

Installs the `warpsend` thin CLI. On first run, it auto-downloads and
supervises the agent daemon.

```bash
warpsend login          # sign in
warpsend run            # start the agent supervisor
warpsend status         # check status
```

## Upgrade

```bash
brew upgrade --cask warpsend     # Desktop
brew upgrade warpsend            # CLI
```

## Uninstall

```bash
brew uninstall --cask warpsend   # Desktop
brew uninstall warpsend          # CLI
```

## About this tap

This repository contains Homebrew formulas that point to binaries hosted at
`app.warpsend.io/_agent/`. The actual distribution is self-hosted — this tap
is metadata only.

Source: https://github.com/warpsend/warpsend

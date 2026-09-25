# WarpSend Homebrew Tap

Official Homebrew tap for WarpSend (https://warpsend.io), the large-file transfer service by Luxira Limited.

WarpSend is large-file transfer for creative teams — browser download links, file requests, and transfers and sync between computers and Synology NAS. The `warpsend` cask in this tap installs the WarpSend desktop app for Macs with Apple silicon.

## Install

```bash
brew install --cask warpsend/tap/warpsend
```

This puts `WarpSend.app` in `/Applications` and links the `warpsend` command-line tool it bundles onto your `PATH`. The app also bundles the background agent, so there is nothing else to download.

Open WarpSend and sign in. On first launch, macOS asks for an administrator password so WarpSend can install its background service, which starts when the Mac boots, before anyone logs in.

The cask requires a Mac with Apple silicon. Homebrew won't install it on an Intel Mac.

## Upgrade

```bash
brew upgrade --cask warpsend
```

The background agent keeps itself up to date; `brew upgrade` updates the app and the `warpsend` command. The upgrade stops WarpSend's background service while it replaces the app, so open WarpSend afterwards and approve the administrator prompt if macOS shows one. The app then sets the service up again.

## Uninstall

```bash
brew uninstall --cask warpsend
```

This stops and removes the background service, the app, and the `warpsend` command. Homebrew may ask for your password to remove the service.

WarpSend's configuration stays on the Mac, including its pairing with your WarpSend account, so reinstalling doesn't require pairing again. To remove the configuration as well:

```bash
brew uninstall --zap --cask warpsend
```

## Other platforms

WarpSend also runs on Windows 10 and later (x64 and Arm64), Debian and Ubuntu Linux (x86_64), and x86_64 Synology NAS with DSM 7 or later. Download those installers from https://warpsend.io/download/.

## About this tap

`Casks/warpsend.rb` is updated with each WarpSend release and installs the DMG from `download.warpsend.io`. `Formula/warpsend-staging.rb` is for testing pre-release builds against WarpSend's staging environment and isn't meant for general use.

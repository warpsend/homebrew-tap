cask "warpsend" do
  version "0.1.0.202607090407"
  sha256 "7093e4a9d3ddf1e025f4b636fb1b9915287a68ce6aacabc7c2b33f9b63df95fa"

  url "https://download.warpsend.io/desktop/8a17160ab5b7/WarpSend-0.1.0-macos-aarch64.7093e4a9d3dd.dmg"
  name "WarpSend"
  desc "NAS-to-NAS cross-region file transfer"
  homepage "https://warpsend.io"

  depends_on arch: :arm64

  app "WarpSend.app"
  # The .app bundles the supervisor CLI at Contents/MacOS/bin/warpsend; link it
  # onto PATH so `warpsend ...` works in the terminal too. It also bundles the
  # agent daemon, so first run seeds the slot locally — no post-install fetch.
  binary "#{appdir}/WarpSend.app/Contents/MacOS/bin/warpsend"

  caveats <<~EOS
    WarpSend is in /Applications and `warpsend` is on your PATH. Launch the
    app and sign in — it bundles the agent daemon and CLI, so there are no
    extra downloads.
    After `brew upgrade`, launch WarpSend once and approve the admin prompt if
    macOS asks; the app self-heals the background service on launch.
  EOS

  # First launch installs a root LaunchDaemon (io.warpsend.agent) + machine-wide
  # data. Without an uninstall/zap, `brew uninstall` would orphan a root daemon
  # and its root-owned files (the "Trash doesn't fully uninstall" problem).
  uninstall launchctl: "io.warpsend.agent",
            delete:    "/Library/LaunchDaemons/io.warpsend.agent.plist"

  zap trash: [
    "/Library/Application Support/warpsend",
    "~/Library/Application Support/warpsend",
  ]
end

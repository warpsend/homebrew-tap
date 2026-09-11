cask "warpsend" do
  version "1.0.0.202609111257"
  sha256 "fdbb2ac6b2647b8e73e6bee5f3f83cb960c229b79f113deb8b3e5a8df1a41237"

  url "https://download.warpsend.io/desktop/66c076a1fa2c/WarpSend-1.0.0-macos-aarch64.fdbb2ac6b264.dmg"
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

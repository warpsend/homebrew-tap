cask "warpsend" do
  version "1.0.0.202609250837"
  sha256 "c7df042d3429695c68ea9f210731cdd5c383aeec8a378704082ef6cac48f9d0a"

  url "https://download.warpsend.io/desktop/ea3ed8b5cb9b/WarpSend-1.0.0-macos-aarch64.c7df042d3429.dmg"
  name "WarpSend"
  desc "Large-file transfer with download links, file requests and computer-to-NAS sync"
  homepage "https://warpsend.io/"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "WarpSend.app"
  # The .app bundles the supervisor CLI at Contents/MacOS/bin/warpsend; link it
  # onto PATH so `warpsend ...` works in the terminal too. It also bundles the
  # agent daemon, so first run seeds the slot locally — no post-install fetch.
  binary "#{appdir}/WarpSend.app/Contents/MacOS/bin/warpsend"

  # First launch installs a root LaunchDaemon (io.warpsend.agent) + machine-wide
  # data. Without an uninstall/zap, `brew uninstall` would orphan a root daemon
  # and its root-owned files (the "Trash doesn't fully uninstall" problem).
  uninstall launchctl: "io.warpsend.agent",
            delete:    "/Library/LaunchDaemons/io.warpsend.agent.plist"

  zap trash: [
    "/Library/Application Support/warpsend",
    "~/Library/Application Support/warpsend",
  ]

  caveats <<~EOS
    WarpSend is in /Applications and `warpsend` is on your PATH. Launch the
    app and sign in — it bundles the agent daemon and CLI, so there are no
    extra downloads.
    After `brew upgrade`, launch WarpSend once and approve the admin prompt if
    macOS asks; the app self-heals the background service on launch.
  EOS
end

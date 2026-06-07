class Warpsend < Formula
  desc "WarpSend thin CLI — single entry point for transfers and agent lifecycle"
  homepage "https://warpsend.io"
  version "0.1.0.202606062131"
  license "MIT"

  on_macos do
    on_arm do
      url "https://download.warpsend.io/downloads/879d3509ee08/warpsend-aarch64-apple-darwin.24ddf88c1e00.tar.gz"
      sha256 "24ddf88c1e0012f60df5b7cdbabc0ec32c5a832a61dc944272b63295ee1a9f39"
    end

    on_intel do
      odie "WarpSend does not support Intel macOS. Apple Silicon (M1/M2/M3/M4) only."
    end
  end

  on_linux do
    odie "WarpSend on Linux is installed via apt-get, not Homebrew. See: https://app.warpsend.io/download"
  end

  def install
    libexec.install "warpsend"
    # NOTE: write_env_script the wrapper at bin/"warpsend" (a FILE), not on bin
    # (the directory). Calling `bin.write_env_script` turns bin itself into a
    # file under current Homebrew, so `brew link` finds nothing to link and the
    # CLI never lands on PATH.
    (bin/"warpsend").write_env_script libexec/"warpsend", {
      "WARPSEND_API_URL" => "https://api.warpsend.io",
      "WARPSEND_BREW_FORMULA" => "warpsend",
    }
  end

  # No post_install: Homebrew's sandbox blocks writes to
  # ~/Library/Application Support/ on macOS. The wrapper injects the cloud
  # channel at runtime instead, so staging and production can share one binary.

  def caveats
    <<~EOS
      To get started:

        warpsend run

      This downloads the agent daemon, opens the login UI, and starts
      transferring. On macOS, you can also install the desktop app:

        warpsend gui install
        open /Applications/WarpSend.app
    EOS
  end

  test do
    assert_match "warpsend", shell_output("#{bin}/warpsend --version")
  end
end

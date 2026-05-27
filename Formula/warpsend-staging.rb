class WarpsendStaging < Formula
  desc "WarpSend thin CLI — single entry point for transfers and agent lifecycle"
  homepage "https://warpsend.io"
  version "23e316d0b472"
  license "MIT"

  on_macos do
    on_arm do
      url "https://app-staging.warpsend.io/_agent/downloads/warpsend-aarch64-apple-darwin.tar.gz"
      sha256 "757e57b1758d27b943a28f7cc169e1a3026b586eaf305ab084f294d96f0eae5d"
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
    bin.write_env_script libexec/"warpsend", {
      "WARPSEND_API_URL" => "https://api-staging.warpsend.io",
      "WARPSEND_BREW_FORMULA" => "warpsend-staging",
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

class WarpsendStaging < Formula
  desc "WarpSend thin CLI — single entry point for transfers and agent lifecycle"
  homepage "https://warpsend.io"
  version "44e2062"
  license "MIT"

  on_macos do
    on_arm do
      url "https://app-staging.warpsend.io/_agent/downloads/warpsend-aarch64-apple-darwin.tar.gz"
      sha256 "492ef2a340e7360c28cbe1d1989df943409cfa31b7f4f9fd9b1574f0594185b4"
    end

    on_intel do
      odie "WarpSend does not support Intel macOS. Apple Silicon (M1/M2/M3/M4) only."
    end
  end

  on_linux do
    odie "WarpSend on Linux is installed via apt-get, not Homebrew. See: https://app.warpsend.io/download"
  end

  def install
    bin.install "warpsend"
  end

  # No post_install: the api_url for this deployment is baked into the
  # binary at build time via option_env!("WARPSEND_BUILD_API_URL"). Earlier
  # versions wrote api_url into config.toml here, but Homebrew's sandbox
  # blocks writes to ~/Library/Application Support/ on macOS so it silently
  # failed and the CLI fell back to the hardcoded production URL. The
  # compile-time embed makes this step unnecessary on every platform.

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

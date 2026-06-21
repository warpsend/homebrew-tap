class WarpsendStaging < Formula
  desc "WarpSend thin CLI — single entry point for transfers and agent lifecycle"
  homepage "https://warpsend.io"
  version "0.1.0.202606211752"
  license "MIT"

  on_macos do
    on_arm do
      url "https://download-staging.warpsend.io/downloads/b2172d072e39/warpsend-aarch64-apple-darwin.9386a38f5955.tar.gz"
      sha256 "9386a38f5955f4a5434abca97095455277031d596b68a9e4d58ee6ab1067a2ea"
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

      This installs the agent daemon, opens the login UI, and starts
      transferring.
    EOS
  end

  test do
    assert_match "warpsend", shell_output("#{bin}/warpsend --version")
  end
end

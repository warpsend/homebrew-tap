class WarpsendStaging < Formula
  desc "WarpSend thin CLI — single entry point for transfers and agent lifecycle"
  homepage "https://warpsend.io"
  version "1.0.0.202609062352"
  license "MIT"

  on_macos do
    on_arm do
      url "https://download-staging.warpsend.io/downloads/391d73a45251/warpsend-aarch64-apple-darwin.5b1cef64c066.tar.gz"
      sha256 "5b1cef64c06600f5f98e902397a4d927a90951c917ab9b5838af53476f2a8198"
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

class Warpsend < Formula
  desc "WarpSend thin CLI — single entry point for transfers and agent lifecycle"
  homepage "https://warpsend.io"
  version "18e442f"
  license "MIT"

  on_macos do
    on_arm do
      url "https://app.warpsend.io/_agent/downloads/warpsend-aarch64-apple-darwin.tar.gz"
      sha256 "4f294b0da50625c226715ef6f2d91aaf99ccf320eab0c91ff446574d08da19be"
    end

    on_intel do
      odie "WarpSend does not support Intel macOS. Apple Silicon (M1/M2/M3/M4) only."
    end
  end

  on_linux do
    on_intel do
      url "https://app.warpsend.io/_agent/downloads/warpsend-x86_64-unknown-linux-musl.tar.gz"
      sha256 "22e4adfe0f4b4c2db2fb98a24e846385d1cbe1846853f99872c09da3c04a0815"
    end
  end

  def install
    bin.install "warpsend"
  end

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

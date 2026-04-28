class WarpsendStaging < Formula
  desc "WarpSend thin CLI — single entry point for transfers and agent lifecycle"
  homepage "https://warpsend.io"
  version "1f2bb4d"
  license "MIT"

  on_macos do
    on_arm do
      url "https://app-staging.warpsend.io/_agent/downloads/warpsend-aarch64-apple-darwin.tar.gz"
      sha256 "7f8df0312da43dbc4bcabc5d3783e514bbb905fb709c772f6461e8ddc33b6cec"
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

  def post_install
    # Auto-point the CLI at the deployment that served this formula. The
    # thin CLI uses dirs::config_dir() which is platform-dependent —
    # ~/Library/Application Support/warpsend on macOS, ~/.config/warpsend
    # on Linux. Earlier versions of this formula hardcoded the Linux
    # path, so the override silently no-op'd on macOS and the daemon
    # kept hitting whatever was baked at compile time (production)
    # regardless of which formula the user picked. Match dirs::config_dir
    # exactly so warpsend-staging actually points at staging.
    config_dir = if OS.mac?
      Pathname.new(Dir.home)/"Library/Application Support/warpsend"
    else
      Pathname.new(Dir.home)/".config/warpsend"
    end
    config_dir.mkpath
    config_file = config_dir/"config.toml"
    api_url_line = 'api_url = "https://api-staging.warpsend.io"'
    if config_file.exist? && config_file.read.match?(/^api_url\s*=/)
      # Idempotent: rewrite the existing api_url line
      new_content = config_file.read.gsub(/^api_url\s*=.*/, api_url_line)
      config_file.atomic_write(new_content)
    else
      File.open(config_file, "a") { |f| f.puts api_url_line }
    end
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

class Warpsend < Formula
  desc "WarpSend thin CLI — single entry point for transfers and agent lifecycle"
  homepage "https://warpsend.io"
  version "72dbc61"
  license "MIT"

  on_macos do
    on_arm do
      url "https://app.warpsend.io/_agent/downloads/warpsend-aarch64-apple-darwin.tar.gz"
      sha256 "4fed1dffc5c556bbf0cc8999c2201fda8e31016124848636813537b9e4aaa811"
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
    # Auto-point the CLI at the deployment that served this formula. The thin
    # CLI reads `api_url` from ~/.config/warpsend/config.toml on every run; we
    # write it here so users don't need to set WARPSEND_API_URL manually.
    config_dir = Pathname.new(Dir.home)/".config/warpsend"
    config_dir.mkpath
    config_file = config_dir/"config.toml"
    api_url_line = 'api_url = "https://api.warpsend.io"'
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

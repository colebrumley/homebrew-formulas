class Srvrmgr < Formula
  desc "Server management daemon using Claude Code AI agents"
  homepage "https://github.com/colebrumley/srvrmgr"
  url "https://github.com/colebrumley/srvrmgr.git", branch: "main"
  version "0.1.0"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/"srvrmgrd", "./cmd/srvrmgrd"
    system "go", "build", "-o", bin/"srvrmgr", "./cmd/srvrmgr"
    prefix.install "install/com.srvrmgr.daemon.plist"
  end

  def caveats
    <<~EOS
      To complete installation:
        1. Initialize config:
             srvrmgr init

        2. Copy the launchd plist:
             sudo cp #{opt_prefix}/com.srvrmgr.daemon.plist /Library/LaunchDaemons/

        3. Start the daemon:
             sudo launchctl load /Library/LaunchDaemons/com.srvrmgr.daemon.plist

      To uninstall completely:
        sudo srvrmgr uninstall
    EOS
  end

  test do
    assert_match "srvrmgr", shell_output("#{bin}/srvrmgr help")
  end
end

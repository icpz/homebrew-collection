class Iterm2Zmodem < Formula
  desc "Zmodem trigger for iTerm2"
  homepage "https://github.com/robberphex/iTerm2-zmodem"
  license "GPL-3.0"
  head "https://github.com/robberphex/iTerm2-zmodem.git"

  depends_on "lrzsz"

  keg_only "should not be called directly"

  def install
    inreplace "iterm2-recv-zmodem.sh", "/usr/local/bin/rz", "#{Formula["lrzsz"].opt_bin}/rz"
    inreplace "iterm2-send-zmodem.sh", "/usr/local/bin/sz", "#{Formula["lrzsz"].opt_bin}/sz"

    bin.install "iterm2-recv-zmodem.sh"
    bin.install "iterm2-send-zmodem.sh"
  end
end

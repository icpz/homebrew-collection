class Iterm2Zmodem < Formula
  desc "Zmodem trigger for iTerm2"
  homepage "https://github.com/robberphex/iTerm2-zmodem"
  license "GPL-3.0"
  head "https://github.com/robberphex/iTerm2-zmodem.git"

  keg_only "should not be called directly"

  def install
    bin.install "iterm2-recv-zmodem.sh"
    bin.install "iterm2-send-zmodem.sh"
  end
end

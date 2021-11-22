cask "wechattweak-cli" do
  version "1.2i"
  sha256 "8a3275a8b3bce9006cc125fd92bfab02082441e46206dc3bbd1b067716854942"
  url "https://github.com/icpz/WeChatTweak-CLI/releases/download/#{version}/wechattweak-cli"

  name "WeChatTweak-CLI"
  desc "A command line utility to work with WeChatTweak-macOS."
  homepage "https://tweaks.app"

  binary "wechattweak-cli"
  depends_on macos: ">= :el_capitan"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{HOMEBREW_PREFIX}/bin/wechattweak-cli"
  end
end

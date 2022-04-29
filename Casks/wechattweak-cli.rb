cask "wechattweak-cli" do
  version "1.4i"
  sha256 "4a4c34fd1f1b40b31e00fee7bce351fc9ff3f5f7090427605026c6cdb70e50fe"
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

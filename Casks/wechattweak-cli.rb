cask "wechattweak-cli" do
  version "integrated"
  sha256 "f505632dd00c7a751804f723e9f1cb89ec321b43350a20d24205d62aa4eb7eb4"
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

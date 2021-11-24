class SftpBridge < Formula
  desc "command-line utility to bridge sftp behind a jump server"
  homepage "https://github.com/icpz/sftp-bridge"
  url "https://github.com/icpz/sftp-bridge/archive/v0.1.tar.gz"
  sha256 "78e91701b6ffe45843e4e5f34e5c5bc4606172e78f7562f90e77a97eb86c60b7"

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-s -w -X github.com/icpz/sftp-bridge/common.DefaultConfigFile=#{etc/"sftp-bridge.json"}", "-trimpath", "-o", "build/sftp-bridge"
    (buildpath/"build/sftp-bridge.json").write <<~EOS
      {
        "listen-port": 8123
      }
    EOS

    bin.install "build/sftp-bridge"
    etc.install "build/sftp-bridge.json" => "sftp-bridge.json"
  end

  service do
    run [opt_bin/"sftp-bridge", "--config", etc/"sftp-bridge.json"]
  end
end

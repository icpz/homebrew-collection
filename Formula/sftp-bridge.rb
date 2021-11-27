class SftpBridge < Formula
  desc "command-line utility to bridge sftp behind a jump server"
  homepage "https://github.com/icpz/sftp-bridge"
  url "https://github.com/icpz/sftp-bridge/archive/v0.2.tar.gz"
  sha256 "1fe6b8bb2ba9c3bcc415fe83c5278f0244ab8829c04d0cc3fdbda133ce4e009a"

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-s -w -X github.com/icpz/sftp-bridge/common.DefaultConfigFile=#{etc/"sftp-bridge.json"} -X github.com/icpz/sftp-bridge/common.Version=#{version}", "-trimpath", "-o", "build/sftp-bridge"
    (buildpath/"build/sftp-bridge.json").write <<~EOS
      {
        "instances": [
        ]
      }
    EOS

    bin.install "build/sftp-bridge"
    etc.install "build/sftp-bridge.json" => "sftp-bridge.json"
  end

  service do
    run [opt_bin/"sftp-bridge", "--config", etc/"sftp-bridge.json"]
  end
end

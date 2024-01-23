class ReresolveWireguardDns < Formula
  desc "Re-resolve DNS for Wireguard"
  license "GPL-3.0-only"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version "1.0"

  keg_only "no export"

  resource "reresolve-dns" do
    url "https://gist.githubusercontent.com/icpz/d33a888eed84c76dd59e33a85cc8f1d6/raw/8c8d4b138564fc42b2004b2347e3c4fa70e984a4/reresolve-dns-darwin.sh"
    sha256 "675aba5c78119db025d1a13b850a597b7491cbcdf37846250acf0544f8228838"
  end

  resource "reresolve-wireguard-dns" do
    url "https://gist.githubusercontent.com/icpz/b7db078f60947bbe81cba56d4f4b7bd5/raw/dc161c6bc82bd1c88d45a5855d269d45c01456cc/reresolve-wireguard-dns.sh"
    sha256 "ae71de6db0f5c0e78c002361f35e6d349762b95e918a7912807005de639558c2"
  end

  def install
    resources.each do |r|
      chmod "+x", r.cached_download
      cp r.cached_download, buildpath/r.name
      bin.install buildpath/r.name
    end
  end

  service do
    run [opt_bin/"reresolve-wireguard-dns"]
    run_type :interval
    interval 180
    environment_variables WG_CONF_DIR: etc/"wireguard",
                          WG_RRDNS:    opt_bin/"reresolve-dns"
  end
end

#!/bin/bash
#
# install-bugbounty.sh
# Cài đặt bộ tool bug bounty / pentest hoàn chỉnh trên Ubuntu.
# Chạy: chmod +x install-bugbounty.sh && ./install-bugbounty.sh
# Sau khi xong: source ~/.bashrc  (hoặc mở terminal mới)
#
# LƯU Ý PHÁP LÝ: chỉ dùng các tool này trên hệ thống bạn sở hữu
# hoặc trong scope của chương trình bug bounty đã cho phép.

set -e   # dừng nếu có lệnh lỗi nghiêm trọng
TOOLS_DIR="$HOME/tools"
mkdir -p "$TOOLS_DIR"

echo "=============================================="
echo " [0/5] Cập nhật hệ thống & cài gói nền"
echo "=============================================="
sudo apt update
sudo apt install -y \
  git curl wget jq unzip build-essential \
  python3 python3-pip python3-venv pipx \
  libpcap-dev nmap
pipx ensurepath || true

echo "=============================================="
echo " [1/5] Cài Go (phiên bản mới nhất)"
echo "=============================================="
if command -v go >/dev/null 2>&1; then
  echo "Go đã có: $(go version) — bỏ qua."
else
  GO_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -n1)
  ARCH=$(dpkg --print-architecture)
  cd /tmp
  wget -q --show-progress "https://go.dev/dl/${GO_VERSION}.linux-${ARCH}.tar.gz"
  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf "${GO_VERSION}.linux-${ARCH}.tar.gz"
  rm -f "${GO_VERSION}.linux-${ARCH}.tar.gz"
fi

# Thiết lập biến môi trường Go (dùng nháy đơn để không expand sớm)
if ! grep -q 'GOROOT=/usr/local/go' ~/.bashrc; then
  {
    echo 'export GOROOT=/usr/local/go'
    echo 'export GOPATH=$HOME/go'
    echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH'
  } >> ~/.bashrc
fi
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
/usr/local/go/bin/go version

echo "=============================================="
echo " [2/5] Cài tool Go (recon / fuzzing / khai thác)"
echo "=============================================="

# --- ProjectDiscovery ---
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
go install -v github.com/projectdiscovery/katana/cmd/katana@latest
go install -v github.com/projectdiscovery/uncover/cmd/uncover@latest
go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest

# --- tomnomnom & cộng đồng ---
go install -v github.com/tomnomnom/anew@latest
go install -v github.com/tomnomnom/gf@latest
go install -v github.com/tomnomnom/waybackurls@latest
go install -v github.com/tomnomnom/qsreplace@latest
go install -v github.com/tomnomnom/assetfinder@latest

# --- URL / param / XSS ---
go install -v github.com/lc/gau/v2/cmd/gau@latest
go install -v github.com/hahwul/dalfox/v2@latest
go install -v github.com/Emoe/kxss@latest
go install -v github.com/ffuf/ffuf/v2@latest

echo "=============================================="
echo " [3/5] Cài tool Python (qua pipx - cô lập môi trường)"
echo "=============================================="
# pipx cài mỗi tool trong venv riêng, tránh lỗi 'externally-managed'
pipx install arjun    || true   # tìm hidden parameter
pipx install dirsearch || true  # brute-force thư mục

# sqlmap & một số tool nên clone từ GitHub cho bản mới nhất
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git "$TOOLS_DIR/sqlmap" 2>/dev/null || \
  (cd "$TOOLS_DIR/sqlmap" && git pull)
# feroxbuster (binary chính thức)
if ! command -v feroxbuster >/dev/null 2>&1; then
  curl -sL https://raw.githubusercontent.com/epi052/feroxbuster/main/install-nix.sh | bash -s "$HOME/.local/bin" || true
fi

echo "=============================================="
echo " [4/5] Tải wordlist & payload"
echo "=============================================="
git clone --depth 1 https://github.com/danielmiessler/SecLists.git "$TOOLS_DIR/SecLists" 2>/dev/null || \
  echo "SecLists đã có."
git clone --depth 1 https://github.com/swisskyrepo/PayloadsAllTheThings.git "$TOOLS_DIR/PayloadsAllTheThings" 2>/dev/null || \
  echo "PayloadsAllTheThings đã có."

echo "=============================================="
echo " [5/5] Cập nhật template & pattern"
echo "=============================================="
"$GOPATH/bin/nuclei" -update-templates || true
# Tải gf pattern
mkdir -p "$HOME/.gf"
git clone --depth 1 https://github.com/1ndianl33t/Gf-Patterns.git /tmp/gf-patterns 2>/dev/null || true
cp /tmp/gf-patterns/*.json "$HOME/.gf/" 2>/dev/null || true

echo ""
echo "=============================================="
echo " HOÀN TẤT!"
echo "=============================================="
echo "Chạy tiếp:  source ~/.bashrc"
echo ""
echo "Wordlist / payload nằm ở: $TOOLS_DIR"
echo "sqlmap:   python3 $TOOLS_DIR/sqlmap/sqlmap.py -u <url>"
echo ""
echo "CÒN THIẾU (cài thủ công vì có GUI / license):"
echo "  - Burp Suite: https://portswigger.net/burp/communitydownload"
echo "  - Firefox profile riêng + FoxyProxy để test web"
echo ""
echo "Kiểm tra nhanh:"
echo "  subfinder -version; httpx -version; nuclei -version; ffuf -V"

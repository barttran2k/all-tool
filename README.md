# Install golang
~~~
# Lấy phiên bản Go mới nhất
GO_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -n1)
ARCH=$(dpkg --print-architecture)   # amd64 hoặc arm64
echo "Đang cài $GO_VERSION ($ARCH)..."

# Tải về thư mục tạm
cd /tmp
wget -q --show-progress "https://go.dev/dl/${GO_VERSION}.linux-${ARCH}.tar.gz"

# Xoá bản cũ và giải nén trực tiếp vào /usr/local
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "${GO_VERSION}.linux-${ARCH}.tar.gz"
rm "${GO_VERSION}.linux-${ARCH}.tar.gz"

# Thêm biến môi trường nếu chưa có (dùng nháy đơn để không bị expand sớm)
if ! grep -q 'GOROOT=/usr/local/go' ~/.bashrc; then
  echo 'export GOROOT=/usr/local/go' >> ~/.bashrc
  echo 'export GOPATH=$HOME/go' >> ~/.bashrc
  echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.bashrc
fi

/usr/local/go/bin/go version
~~~

# all-tool
get tool and install

```
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
go install github.com/lc/gau/v2/cmd/gau@latest
go install github.com/tomnomnom/gf@latest
go install github.com/tomnomnom/waybackurls@latest
go install -v github.com/projectdiscovery/uncover/cmd/uncover@latest
go install github.com/Emoe/kxss@latest
go install github.com/hahwul/dalfox/v2@latest
go install github.com/projectdiscovery/katana/cmd/katana@latest
go install -v github.com/tomnomnom/anew@latest

pip install dirsearch sqlmap

nuclei -update -ut
subfinder -update
httpx -update
katana -update

```
# Install GCC for Win
`[mingw64](https://github.com/gorvgoyl/MinGW64/releases)`

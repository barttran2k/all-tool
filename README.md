# Install golang
~~~
GO_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -n1)
ARCH=$(dpkg --print-architecture)   # amd64 hoặc arm64
echo "Đang cài $GO_VERSION ($ARCH)..."
cd /tmp
wget -q --show-progress "https://go.dev/dl/${GO_VERSION}.linux-${ARCH}.tar.gz"

sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "${GO_VERSION}.linux-${ARCH}.tar.gz"
rm "${GO_VERSION}.linux-${ARCH}.tar.gz"

if ! grep -q 'GOROOT=/usr/local/go' ~/.bashrc; then
  echo 'export GOROOT=/usr/local/go' >> ~/.bashrc
  echo 'export GOPATH=$HOME/go' >> ~/.bashrc
  echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.bashrc
fi

/usr/local/go/bin/go version
sudo apt install -y python3-pip
~~~

# all-tool
get tool and install

```
go install -v github.com/projectdiscovery/pdtm/cmd/pdtm@latest

if ! grep -q '.pdtm/go/bin' ~/.bashrc; then
  echo 'export PATH=$PATH:$HOME/.pdtm/go/bin' >> ~/.bashrc
fi
export PATH=$PATH:$HOME/.pdtm/go/bin

pdtm -ia

go install github.com/lc/gau/v2/cmd/gau@latest
go install github.com/tomnomnom/gf@latest
go install github.com/tomnomnom/waybackurls@latest
go install github.com/Emoe/kxss@latest
go install github.com/hahwul/dalfox/v2@latest
go install -v github.com/tomnomnom/anew@latest

pip install dirsearch sqlmap

pdtm -update      # cập nhật toàn bộ tool PD
nuclei -update-templates
pip install dirsearch sqlmap

nuclei -update -ut
subfinder -update
httpx -update
katana -update

```

# if fail pdtm
```
if ! grep -q '$HOME/go/bin' ~/.bashrc; then
  echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc
fi
export PATH=$PATH:$HOME/go/bin

# --- Tool ProjectDiscovery (cài thẳng, bỏ qua pdtm) ---
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
go install -v github.com/projectdiscovery/katana/cmd/katana@latest
go install -v github.com/projectdiscovery/uncover/cmd/uncover@latest

# --- Tool khác ---
go install github.com/lc/gau/v2/cmd/gau@latest
go install github.com/tomnomnom/gf@latest
go install github.com/tomnomnom/waybackurls@latest
go install github.com/Emoe/kxss@latest
go install github.com/hahwul/dalfox/v2@latest
go install -v github.com/tomnomnom/anew@latest

# --- Python tool ---
sudo apt install -y python3-pip git
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git ~/tools/sqlmap || true
git clone --depth 1 https://github.com/maurosoria/dirsearch.git ~/tools/dirsearch || true

# --- Cập nhật (sau khi đã cài) ---
nuclei -update-templates
```

# Install GCC for Win
`[mingw64](https://github.com/gorvgoyl/MinGW64/releases)`

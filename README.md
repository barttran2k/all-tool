# Install golang
mkdir temp<br>
cd temp ( to the folder you created in previous step)<br>
wget https://dl.google.com/go/go1.20.linux-amd64.tar.gz<br>
sudo tar -xvf go1.20.linux-amd64.tar.gz<br>
sudo mv go /usr/local<br>
export GOROOT=/usr/local/go<br>
export GOPATH=$HOME/go<br>
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH<br>
source ~/.profile<br>
<br>
# all-tool
get tool and install<br>

go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest<br>
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest<br>
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest<br>
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest<br>
go install github.com/lc/gau/v2/cmd/gau@latest<br>
go install github.com/tomnomnom/gf@latest<br>
go install github.com/tomnomnom/waybackurls@latest<br>
go install -v github.com/projectdiscovery/uncover/cmd/uncover@latest

# Install GCC for Win
https://udomain.dl.sourceforge.net/project/mingw-w64/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/8.1.0/threads-win32/sjlj/x86_64-8.1.0-release-win32-sjlj-rt_v6-rev0.7z

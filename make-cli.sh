#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
TZ='UTC'; export TZ
umask 022
set -e
_tmp_dir="$(mktemp -d)"
cd "${_tmp_dir}"
#wget -c -t 9 -T 9 "https://github.com/moby/moby/archive/refs/tags/v23.0.15.tar.gz"
#tar -xof v*.tar*
#sleep 1
#rm -vf v*.tar*
#cd moby*


_install_go() {
    umask 022
    set -e
    cd /tmp
    _tmp_dir="$(mktemp -d)"
    cd "${_tmp_dir}"
    # Latest version of go
    #_go_version="$(wget -qO- 'https://golang.org/dl/' | grep -i 'linux-amd64\.tar\.' | sed 's/"/\n/g' | grep -i 'linux-amd64\.tar\.' | cut -d/ -f3 | grep -i '\.gz$' | sed 's/go//g; s/.linux-amd64.tar.gz//g' | grep -ivE 'alpha|beta|rc' | sort -V | uniq | tail -n 1)"
    # Go1.17.X
    #_go_version="$(wget -qO- 'https://golang.org/dl/' | grep -i 'linux-amd64\.tar\.' | sed 's/"/\n/g' | grep -i 'linux-amd64\.tar\.' | cut -d/ -f3 | grep -i '\.gz$' | sed 's/go//g; s/.linux-amd64.tar.gz//g' | grep -ivE 'alpha|beta|rc' | sort -V | uniq | grep '^1\.17\.' | tail -n 1)"
    #wget -q -c -t 0 -T 9 "https://dl.google.com/go/go${_go_version}.linux-amd64.tar.gz"
    # Go1.18.X
    #_go_version="$(wget -qO- 'https://golang.org/dl/' | grep -i 'linux-amd64\.tar\.' | sed 's/"/\n/g' | grep -i 'linux-amd64\.tar\.' | cut -d/ -f3 | grep -i '\.gz$' | sed 's/go//g; s/.linux-amd64.tar.gz//g' | grep -ivE 'alpha|beta|rc' | sort -V | uniq | grep '^1\.18\.' | tail -n 1)"
    #wget -q -c -t 0 -T 9 "https://dl.google.com/go/go${_go_version}.linux-amd64.tar.gz"
    # Go1.20.X
    #_go_version="$(wget -qO- 'https://golang.org/dl/' | grep -i 'linux-amd64\.tar\.' | sed 's/"/\n/g' | grep -i 'linux-amd64\.tar\.' | cut -d/ -f3 | grep -i '\.gz$' | sed 's/go//g; s/.linux-amd64.tar.gz//g' | grep -ivE 'alpha|beta|rc' | sort -V | uniq | grep '^1\.20\.' | tail -n 1)"
    #wget -q -c -t 0 -T 9 "https://dl.google.com/go/go${_go_version}.linux-amd64.tar.gz"

    # Go1.22.X
    _go_version="$(wget -qO- 'https://golang.org/dl/' | grep -i 'linux-amd64\.tar\.' | sed 's/"/\n/g' | grep -i 'linux-amd64\.tar\.' | cut -d/ -f3 | grep -i '\.gz$' | sed 's/go//g; s/.linux-amd64.tar.gz//g' | grep -ivE 'alpha|beta|rc' | sort -V | uniq | grep '^1\.22\.' | tail -n 1)"
    wget -q -c -t 0 -T 9 "https://dl.google.com/go/go${_go_version}.linux-amd64.tar.gz"

    rm -fr /usr/local/go
    sleep 1
    install -m 0755 -d /usr/local/go
    tar -xof "go${_go_version}.linux-amd64.tar.gz" --strip-components=1 -C /usr/local/go/
    install -m 0755 -d /usr/local/go/home
    sleep 1
    cd /tmp
    rm -fr "${_tmp_dir}"
    # Go programming language
    export GOROOT='/usr/local/go'
    export GOPATH="$GOROOT/home"
    export GOTMPDIR='/tmp'
    export GOBIN="$GOROOT/bin"
    export PATH="$GOROOT/bin:$PATH"
    alias go="$GOROOT/bin/go"
    alias gofmt="$GOROOT/bin/gofmt"
    echo
    go version
    echo
}
# Go programming language
export GOROOT='/usr/local/go'
export GOPATH="$GOROOT/home"
export GOTMPDIR='/tmp'
export GOBIN="$GOROOT/bin"
export PATH="$GOROOT/bin:$PATH"
alias go="$GOROOT/bin/go"
alias gofmt="$GOROOT/bin/gofmt"
rm -fr ~/.cache/go-build
_install_go

git clone https://github.com/docker/cli.git
cd cli
git checkout v26.1.5
export VERSION='26.1.5'

docker buildx bake

echo
echo ' done '
echo
echo
exit


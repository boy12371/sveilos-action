#!/bin/bash
#
apt-get update
apt-get -y install build-essential asciidoc gawk gettext git libncurses5-dev \
  zlib1g-dev subversion gnupg2 software-properties-common flex uglifyjs \
  p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev upx-ucl \
  libelf-dev autoconf libtool autopoint device-tree-compiler antlr3 gperf \
  curl swig rsync apt-transport-https golang-go libncursesw5-dev \
  libsepol1-dev checkpolicy policycoreutils selinux-basics dialog
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get -y install docker-ce docker-ce-cli containerd.io
BIN_SH="$(ls -la /bin/sh)"
echo "${BIN_SH}"
if [ "${BIN_SH}" = *"bash"* ]; then
  echo "we already use bash"
else
  echo "we want to change dash to bash"
  echo "dash dash/sh boolean false" | debconf-set-selections
  dpkg-reconfigure -f noninteractive dash
fi
go get github.com/github-release/github-release
export PATH=$PATH:$HOME/go/bin
export GOPATH=$HOME/go
export GO_VERSION=go1.11.6
export GOOS=linux
export GOARCH=arm64
export ARCH=arm64
echo $ARCH
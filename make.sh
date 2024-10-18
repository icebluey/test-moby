#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
TZ='UTC'; export TZ
umask 022
_tmp_dir="$(mktemp -d)"
cd "${_tmp_dir}"
#wget -c -t 9 -T 9 "https://github.com/moby/moby/archive/refs/tags/v23.0.15.tar.gz"
#tar -xof v*.tar*
#sleep 1
#rm -vf v*.tar*
#cd moby*

git clone https://github.com/moby/moby.git
cd moby
git checkout v26.1.5
#make all
make binary
echo
echo ' done '
echo
find /tmp | grep -i dockerd
echo
echo
echo ' pwd:'
pwd
echo
find bundles
echo
echo ' ps -a:'
docker ps -a
echo
echo ' images:'
docker images
echo
echo
exit

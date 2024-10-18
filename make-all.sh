#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
TZ='UTC'; export TZ
umask 022
_tmp_dir="$(mktemp -d)"
cd "${_tmp_dir}"
wget -c -t 9 -T 9 "https://github.com/moby/moby/archive/refs/tags/v23.0.15.tar.gz"
tar -xof v*.tar*
sleep 1
rm -vf v*.tar*
cd moby*
make all
exit



#!/bin/sh -e
VERSION=1.0.1

rm -f default.nix node-packages.nix node-env.nix
rm -rf riot-web
wget https://github.com/vector-im/riot-web/archive/v${VERSION}.tar.gz -O- |tar xz
mv riot-web-${VERSION} riot-web
patch -p1 -d riot-web < require-olm.patch
nix run -f ./node2nix.nix -c node2nix \
  --development \
  --nodejs-8 \
  --input node-packages.json \
  --composition default.nix \
  --node-env node-env.nix \
  --lock riot-web/package-lock.json

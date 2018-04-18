#!/bin/sh -e

rm -f default.nix node-packages.nix node-env.nix
nix run -f ./node2nix.nix -c node2nix \
  --development \
  --nodejs-6 \
  --input node-packages.json \
  --composition default.nix \
  --node-env node-env.nix \
  --lock ../riot-web/package-lock.json

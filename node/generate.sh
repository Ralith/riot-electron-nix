#!/bin/sh -e

# Remove this section if upstream gets its act together
pushd ../riot-web
nix run nixpkgs.nodejs-8_x -c npm install
nix run nixpkgs.nodejs-8_x -c npm shrinkwrap --dev
popd

rm -f default.nix node-packages.nix node-env.nix
nix run -f ./node2nix.nix -c node2nix \
  --development \
  --nodejs-8 \
  --input node-packages.json \
  --composition default.nix \
  --node-env node-env.nix \
  --lock ../riot-web/npm-shrinkwrap.json

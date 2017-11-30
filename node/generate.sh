#!/bin/sh -e

rm -f default.nix node-packages.nix node-env.nix
node2nix -d -6 -i node-packages.json -c default.nix -e node-env.nix

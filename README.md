This package is unsuitable for upstreaming into nixpkgs due to the somewhat esoteric build process. It could still
conceivably be improved by building riot-web from source, thanks to node2nix.

Riot is incompatible with the version of electron packaged in the `nixos-17.03` channel. The package currently must be
built against `nixos-unstable`.

If this package is defined as `riot` is defined in your packageOverrides, it can be installed against unstable with
`nix-env -f https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz -iA riot`

To update to a new version, update the riot-web submodule and run `./generate.sh` in the node
subdirectory, then update the root default.nix as usual.

# Installation

Riot requires a newer electron than is available in the nixos-18.09
channel. As of this writing, electron 4.0 from nixpkgs master works.

This is a standard Nix package, which can be included in any
expression by using `callPackage`. For example, you can add `riot =
pkgs.callPackage /path/to/riot-electron-nix {};` to `packageOverrides`
in `~/.config/nixpkgs/config.nix` to enable installing with `nix-env
-i`.

# Updating

To generate a new version of this package, update the riot-web
submodule to the appropriate revision.

# Troubleshooting

Ensure that the riot-web submodule is checked out and up to date.

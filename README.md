This package is unsuitable for upstreaming into nixpkgs because the build phase accesses the network with npm. In lieu
of the nixpkgs npm infrastructure getting sorted out, however, it's good enough to use.

Riot is incompatible with the version of electron packaged in the `nixos-16.09` channel. The package currently must be
built against `nixos-unstable`.

You can make this package available by, for example, using a `~/.nixpkgs/config.nix` like the following:
```nix
{
  packageOverrides = orig: with orig; rec {
    riot-package = pkgs.fetchFromGitHub {
      owner = "Ralith";
      repo = "riot-electron-nix";

      # Update these hashes as necessary
      rev = "cef24f083e4b270f5dcfc4566de46cc73fa73ec3";
      sha256 = "1db7zgfzqzj46kxpwhp2spfh9027aqixfz1x6ndrxvkgc2jncsqb";
    };
    riot = pkgs.callPackage riot-package {};
  };
}
```

If `riot` is defined in your overrides, it can be installed against unstable with
`nix-env -f https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz -iA riot`

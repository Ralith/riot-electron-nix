This package is unsuitable for upstreaming into nixpkgs because the build phase accesses the network with npm. In lieu
of the nixpkgs npm infrastructure getting sorted out, however, it's good enough to use.

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

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
      rev = "a18ffeb00b6653a19e893c3ebed3d4cf81ece0a7";
      sha256 = "181rjy0g24913qv8v4p7766f5nnybgwamppyl25cnndb4i04l5yi";
    };
    riot = pkgs.callPackage riot-package {};
  };
}
```

If `riot` is defined in your overrides, it can be installed against unstable with
`nix-env -f https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz -iA riot`

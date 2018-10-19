{ nixpkgs ? <nixpkgs>, system ? builtins.currentSystem }:

with (import nixpkgs { inherit system; });

(import ((fetchFromGitHub {
  owner = "svanderburg";
  repo = "node2nix";
  rev = "node2nix-1.6.0";
  sha256 = "0ns92b332aycjyc7qshkqrgg3qga762dxd479pn1kirz4nkcf6cp";
})) {}).package

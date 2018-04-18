{ nixpkgs ? <nixpkgs>, system ? builtins.currentSystem }:

with (import nixpkgs { inherit system; });

(import ((fetchFromGitHub {
  owner = "svanderburg";
  repo = "node2nix";
  rev = "node2nix-1.5.3";
  sha256 = "10pmn3fa6rmpqqr7z5si7zpvjfqrcwrrx666f0bld6w8m4fszmbg";
})) {}).package

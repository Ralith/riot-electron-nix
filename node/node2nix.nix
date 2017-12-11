{ nixpkgs ? <nixpkgs>, system ? builtins.currentSystem }:

with (import nixpkgs { inherit system; });

(import ((fetchFromGitHub {
  owner = "svanderburg";
  repo = "node2nix";
  rev = "acc5a50c2e9a838b1ae9e7dcbf53898b4e4ea9c5";
  sha256 = "1xlrkiihl6716ac8drv9pzix7n4npgwphkyxsy51baa94p81jrzi";
})) {}).package

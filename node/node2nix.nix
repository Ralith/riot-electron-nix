{ nixpkgs ? <nixpkgs>, system ? builtins.currentSystem }:

with (import nixpkgs { inherit system; });

(import ((fetchFromGitHub {
  owner = "svanderburg";
  repo = "node2nix";
  rev = "c876bb8f8749d53ef759de809ce2aa68a8cce20e";
  sha256 = "0zb0yjygmm9glihkhzkax3f223dzqzhpmj25243ygkgzl1pb8sg1";
})) {}).package

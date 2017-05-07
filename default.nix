{ stdenv, fetchurl, fetchFromGitHub, writeScriptBin, electron, bash, gnutar }:
let
riot = stdenv.mkDerivation rec {
  name = "riot-desktop-${version}";
  version = "0.9.9";

  src = fetchFromGitHub {
    owner = "vector-im";
    repo = "riot-web";
    rev = "v${version}";
    sha256 = "1fbnv0bwsh76saghnc1qd56sqajdp65bmxrswnqbj7pncxdg0v96";
  };

  packaged = fetchurl {
    url = "https://github.com/vector-im/riot-web/releases/download/v${version}/vector-v${version}.tar.gz";
    sha256 = "0yy9lzqq6nr0221171rx6z2b0wblcrc4a77cp3ghihj1x3pd7710";
  };

  buildInputs = [ gnutar ];

  dontBuild = true;

  installPhase = ''
    mkdir -p "$out/webapp"
    tar xf ${packaged} -C "$out/webapp" --strip-components 1
    cp -r electron "$out"
    cp package.json "$out"
  '';
};
in writeScriptBin "riot" ''
  #!${bash}/bin/sh
  ${electron}/bin/electron "${riot}" "$@"
''

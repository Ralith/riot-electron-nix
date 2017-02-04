{ stdenv, fetchurl, fetchFromGitHub, writeScriptBin, electron, bash, gnutar }:
let
riot = stdenv.mkDerivation rec {
  name = "riot-desktop-${version}";
  version = "0.9.7";

  src = fetchFromGitHub {
    owner = "vector-im";
    repo = "riot-web";
    rev = "v${version}";
    sha256 = "0qcf8g8mvvjgmg79mdk7a2b7g2jw6py4ws087ir79y3z3k7zfs34";
  };

  packaged = fetchurl {
    url = "https://github.com/vector-im/riot-web/releases/download/v${version}/vector-v${version}.tar.gz";
    sha256 = "14x6ndrnvb50qhmw43yhdrk25jqh7ac7ym3g0gf5zzr609455717";
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

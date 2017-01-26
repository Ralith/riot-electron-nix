{ stdenv, fetchurl, fetchFromGitHub, writeScriptBin, electron, bash, gnutar }:
let
riot = stdenv.mkDerivation rec {
  name = "riot-${version}";
  version = "0.9.6";

  src = fetchFromGitHub {
    owner = "vector-im";
    repo = "riot-web";
    rev = "v${version}";
    sha256 = "1vxssmkd85qga35wdrr0ffimbh2q4nl1lsv9mzzbrlyqkmx8rq4p";
  };

  packaged = fetchurl {
    url = "https://github.com/vector-im/riot-web/releases/download/v${version}/vector-v${version}.tar.gz";
    sha256 = "0yds1idp49lb6x2gss5mklfmkcqyswzvp5x2629pxyyrvdi60j0c";
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

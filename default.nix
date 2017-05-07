{ stdenv, fetchurl, fetchFromGitHub, writeScriptBin, electron, bash, gnutar }:
let
riot = stdenv.mkDerivation rec {
  name = "riot-desktop-${version}";
  version = "0.9.8";

  src = fetchFromGitHub {
    owner = "vector-im";
    repo = "riot-web";
    rev = "v${version}";
    sha256 = "0j5jdkvxic912hfbvh63l5f2rqad8vvp0bjdq9fbspp5gdlc0w39";
  };

  packaged = fetchurl {
    url = "https://github.com/vector-im/riot-web/releases/download/v${version}/vector-v${version}.tar.gz";
    sha256 = "0rrqdhr81f7kz9qcwhi5f5n7ng21c6zcn53xvygcr401pv69057f";
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

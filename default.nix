{ stdenv, fetchurl, fetchFromGitHub, electron, bash, gnutar }:
stdenv.mkDerivation rec {
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

  buildInputs = [ electron bash gnutar ];

  dontBuild = true;

  installPhase = ''
    DATA_DIR="$out/share/riot"
    mkdir -p "$DATA_DIR/webapp"
    tar xf ${packaged} -C "$DATA_DIR/webapp" --strip-components 1
    cp -r electron "$DATA_DIR"
    cp package.json "$DATA_DIR"
    mkdir -p "$out/bin"
    electron=${electron}
    bash=${bash}
    substituteAll ${./wrapper.sh} "$out/bin/riot"
    chmod +x "$out/bin/riot"
  '';
}

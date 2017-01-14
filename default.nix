{ stdenv, fetchurl, fetchFromGitHub, electron, bash, gnutar }:
stdenv.mkDerivation rec {
  name = "riot-${version}";
  version = "0.9.6-rc.1";

  src = fetchFromGitHub {
    owner = "vector-im";
    repo = "riot-web";
    rev = "v${version}";
    sha256 = "1icygbvxp2szzhsvkkjwcnac604457l4irgw9xy8bv108aad5mfv";
  };

  packaged = fetchurl {
    url = "https://github.com/vector-im/riot-web/releases/download/v${version}/vector-v${version}.tar.gz";
    sha256 = "1jqjj18dsnrnrz8cgzhgiaxbq5323w9281n5r9zv2gnp9bm0l1d9";
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

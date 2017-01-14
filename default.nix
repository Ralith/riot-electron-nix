{ stdenv, fetchurl, fetchFromGitHub, electron, bash, nodePackages, git, nodejs }:
stdenv.mkDerivation rec {
  name = "riot-${version}";
  version = "0.9.6-rc.1";

  src = fetchFromGitHub {
    owner = "vector-im";
    repo = "riot-web";
    rev = "v${version}";
    sha256 = "1icygbvxp2szzhsvkkjwcnac604457l4irgw9xy8bv108aad5mfv";
  };

  buildInputs = [ nodePackages.npm electron bash git nodejs ];

  buildPhase = ''
    export HOME="$TEMP"
    npm install
    npm run build
  '';

  installPhase = ''
    DATA_DIR="$out/share/riot"
    mkdir -p "$DATA_DIR"
    cp -r webapp "$DATA_DIR"
    cp -r electron "$DATA_DIR"
    cp package.json "$DATA_DIR"
    mkdir -p "$out/bin"
    electron=${electron}
    bash=${bash}
    substituteAll ${./wrapper.sh} "$out/bin/riot"
    chmod +x "$out/bin/riot"
  '';
}

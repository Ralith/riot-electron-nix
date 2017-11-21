{ stdenv, fetchurl, runCommand, writeScriptBin, electron, bash, pkgs, system, nodejs }:
let
nodePackages = import ./node { inherit pkgs system nodejs; };
riot-web = nodePackages."riot-web-file:../riot-web".override (old: {
  postInstall = ''
    echo "building..."
    npm run build
  '';
});
riot = stdenv.mkDerivation rec {
  name = "riot-desktop-${version}";
  version = "0.13.1";

  buildCommand = ''
    mkdir -p "$out"
    cp -r '${riot-web}/lib/node_modules/riot-web/webapp' "$out/webapp"
    chmod +w "$out/webapp"
    echo '${version}' > "$out/webapp/version"
    cp -r '${nodePackages."riot-web-file:../riot-web/electron_app"}/lib/node_modules/riot-web/' "$out/electron"
  '';
};
in writeScriptBin "riot" ''
  #!${bash}/bin/sh
  "${electron}/bin/electron" "${riot}/electron" "$@"
''

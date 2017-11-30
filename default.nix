{ stdenv, electron, pkgs, system, nodejs }:
let
nodePackages = import ./node { inherit pkgs system nodejs; };
riot-web = nodePackages."riot-web-file:../riot-web".override (old: {
  postInstall = ''
    echo "building..."
    npm run build
  '';
});
in stdenv.mkDerivation rec {
  name = "riot-desktop-${version}";
  version = "0.13.1";

  buildCommand = ''
    mkdir -p "$out"
    cp -r '${riot-web}/lib/node_modules/riot-web/webapp' "$out/webapp"
    chmod +w "$out/webapp"
    echo '${version}' > "$out/webapp/version"
    cp -r '${nodePackages."riot-web-file:../riot-web/electron_app"}/lib/node_modules/riot-web/' "$out/electron"

    for i in 16 24 48 64 96 128 256 512; do
      install -Dm644 $out/electron/build/icons/''${i}x''${i}.png \
        $out/share/icons/hicolor/''${i}x''${i}/apps/riot.png
    done

    mkdir -p $out/share/applications
    cat > $out/share/applications/riot.desktop <<EOF
    [Desktop Entry]
    Name=Riot
    Comment=A feature-rich client for Matrix.org
    Exec=riot
    Terminal=false
    Type=Application
    Icon=riot
    StartupWMClass="Riot"
    Categories=Network;InstantMessaging;Chat
    EOF

    mkdir -p $out/bin
    cat > $out/bin/riot <<EOF
    #!${stdenv.shell}
    ${electron}/bin/electron "$out/electron" "$@"
    EOF
    chmod +x $out/bin/riot
  '';
}

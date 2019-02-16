{ stdenv, electron, pkgs, system, nodejs, makeDesktopItem }:
let
nodePackages = import ./node { inherit pkgs system nodejs; };
riot-web = nodePackages."riot-web-file:riot-web".override (attrs: {
  postInstall = ''
    echo "building..."
    patchShebangs .
    npm run build
    echo '${attrs.version}' > "webapp/version"
  '';
});
desktopItem = makeDesktopItem {
  name = "riot";
  desktopName = "Riot";
  genericName = "Matrix Client";
  exec = "riot";
  comment = "A feature-rich client for Matrix.org";
  icon = "riot";
  categories = "Network;InstantMessaging;Chat;";
  extraEntries = ''
    StartupWMClass="Riot"
  '';
};
in stdenv.mkDerivation {
  name = "riot-desktop-${riot-web.version}";
  inherit (riot-web) version;

  buildCommand = ''
    mkdir -p "$out/share/riot"
    ln -s '${riot-web}/lib/node_modules/riot-web/webapp' "$out/share/riot/webapp"
    ln -s '${riot-web}/lib/node_modules/riot-web/origin_migrator' "$out/share/riot/origin_migrator"
    cp -r '${nodePackages."riot-web-file:riot-web/electron_app"}/lib/node_modules/riot-web/' "$out/share/riot/electron"

    for i in 16 24 48 64 96 128 256 512; do
      mkdir -p "$out/share/icons/hicolor/''${i}x''${i}/apps"
      ln -s "$out/share/riot/electron/build/icons/''${i}x''${i}.png" \
        "$out/share/icons/hicolor/''${i}x''${i}/apps/riot.png"
    done

    cp -r '${desktopItem}/.' "$out"
    mkdir -p "$out/bin"
    cat > "$out/bin/riot" <<EOF
    #!${stdenv.shell}
    '${electron}/bin/electron' "$out/share/riot/electron" "$@"
    EOF
    chmod +x "$out/bin/riot"
  '';
}

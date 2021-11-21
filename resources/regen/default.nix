{ pkgs, regen-src }:

pkgs.buildGoApplication {
  name = "regen";
  src = "${regen-src}";
  modules = ./go-modules.toml;
  preCheck = ''
    export HOME="$(mktemp -d)"
  '';
  postConfigure = ''
    rm -rf ./orm
    rm -rf ./types
    rm -rf ./x
  '';
  customVendorSrc = pkgs.stdenv.mkDerivation {
    name = "source";
    src = "${regen-src}";
    buildPhase = ''
      ls
      mkdir -p $out/github.com/regen-network/regen-ledger
      cp -r ./types $out/github.com/regen-network/regen-ledger/
      cp -r ./x $out/github.com/regen-network/regen-ledger/
      cp -r ./orm $out/github.com/regen-network/regen-ledger/
      ls $out/github.com/regen-network/regen-ledger/
    '';
    installPhase = "true";
  };
}

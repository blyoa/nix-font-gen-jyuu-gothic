{
  description = "The GenJyuuGothic font";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    gen-jyuu-gothic = {
      url = "https://ftp.iij.ad.jp/pub/osdn.jp/users/8/8636/genjyuugothic-20150607.7z";
      flake = false;
    };
    gen-jyuu-gothic-x = {
      url = "https://ftp.iij.ad.jp/pub/osdn.jp/users/8/8638/genjyuugothic-x-20150607.7z";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      gen-jyuu-gothic,
      gen-jyuu-gothic-x,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages = {
          default = pkgs.stdenvNoCC.mkDerivation {
            pname = "gen-jyuu-gothic";
            version = "1.002.20150531";

            src = gen-jyuu-gothic;

            nativeBuildInputs = [ pkgs.p7zip ];

            unpackPhase = ''
              runHook preUnpack

              7z x $src -ogen-jyuu-gothic

              runHook postUnpack
            '';

            installPhase = ''
              runHook preInstall

              install -m644 -D --target $out/share/fonts/truetype/gen-jyuu-gothic gen-jyuu-gothic/GenJyuuGothic-*.ttf

              runHook postInstall
            '';
          };

          gen-jyuu-gothic-x = pkgs.stdenvNoCC.mkDerivation {
            pname = "gen-jyuu-gothic-x";
            version = "1.002.20150531";

            src = gen-jyuu-gothic-x;

            nativeBuildInputs = [ pkgs.p7zip ];

            unpackPhase = ''
              runHook preUnpack

              7z x $src -ogen-jyuu-gothic-x

              runHook postUnpack
            '';

            installPhase = ''
              runHook preInstall

              install -m644 -D --target $out/share/fonts/truetype/gen-jyuu-gothic-x gen-jyuu-gothic-x/GenJyuuGothicX-*.ttf

              runHook postInstall
            '';
          };
        };
      }
    );
}

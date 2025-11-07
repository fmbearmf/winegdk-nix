{
  description = "WineGDK";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    winegdk = {
      url = "github:Weather-OS/WineGDK";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, winegdk }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages = rec {
        wine-gdk = pkgs.wine64Packages.base.overrideAttrs (prev: {
          src = winegdk;
          patches = [];
        });
        default = wine-gdk;
      };
  });
}

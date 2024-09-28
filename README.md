# nix-font-gen-jyuu-gothic

This is a Nix flake for the [Gen Jyuu Gothic（源柔ゴシック）](http://jikasei.me/font/genjyuu/)font.


## Example Usage with Home Manager

```nix
{
  description = "Example configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    gen-jyuu-gothic.url = "github:blyoa/nix-font-gen-jyuu-gothic";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      gen-jyuu-gothic,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      homeConfigurations.user = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          {
            home.package = [
              gen-jyuu-gothic.packages.${system}.default
            ];
          }
        ];
      };
    };
}
```

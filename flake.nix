{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    screenpad-driver={
      url = "github:MatthewCash/asus-wmi-screenpad-module";
      inputs.nixpkgs.follows="nixpkgs";
    };
    flake-utils={
      url = "github:numtide/flake-utils";
    };
  };
  outputs = inputs@{self, nixpkgs, screenpad-driver, flake-utils, ...}:
  {
    nixosModules = {
      screenpad-driver = import ./driver.nix {driver=screenpad-driver;};
      default = self.nixosModules.screenpad-driver;
    };
  } // flake-utils.lib.eachDefaultSystem (system : {
    packages = let pkgScript = {pkgs, name, scriptFile, runtimeDeps} : let
      script = (pkgs.writeScriptBin "${name}" (builtins.readFile scriptFile)).overrideAttrs(old: {
        buildCommand = "${old.buildCommand}\n patchShebangs $out";
      });
      in pkgs.symlinkJoin {
        inherit name;
        paths = [script] ++ runtimeDeps;
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = "wrapProgram $out/bin/${name} --prefix PATH : $out/bin";
      };
      pkgs = import nixpkgs {inherit system;};
    in {
      default = self.packages.${system}.toggle-screenpad;
      toggle-screenpad = pkgScript {
        inherit pkgs;
        name = "toggle-screenpad";
        scriptFile = ./toggle-screenpad.sh;
        runtimeDeps = with pkgs; [
          kdePackages.libkscreen
          gnused
          python3Minimal
          gnugrep
          coreutils
        ];};
      toggle-screenpad-plasma5 = pkgScript {
        inherit pkgs;
        name = "toggle-screenpad";
        scriptFile = ./toggle-screenpad-plasma5.sh;
        runtimeDeps = with pkgs; [
          kdePackages.libkscreen
          gnused
          python3Minimal
          gnugrep
          coreutils
        ];};
    };
    overlays = [(final: prev: (nixpkgs.lib.attrsets.filterAttrs (name: val: name!="default") self.packages.${system}))];
  } );
}
{driver}:{config, lib, pkgs, ...}:
let
screenpad-driver-package = ({kernelPackage, system}: let asus-wmi-screenpad = driver.defaultPackage.${system}.override{kernel=kernelPackage;};
in [
  asus-wmi-screenpad
]);
in
{
  config= lib.mkDefault {
    boot.extraModulePackages = screenpad-driver-package {kernelPackage=config.boot.kernelPackages.kernel; system=pkgs.system;};
    boot.kernelModules = [
      "asus-wmi-screenpad"
    ];
  };
}

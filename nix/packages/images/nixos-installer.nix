{ inputs, pkgs, ... }:

inputs.nixos-generators.nixosGenerate {
  inherit pkgs;
  format = "install-iso";
  modules = [
    inputs.self.nixosModules.nix
    inputs.self.nixosModules.ssh-keys
    ./base-installer-iso.nix
  ];
}

{ inputs, ... }:
{
  system = "x86_64-linux";
  modules = [
    # 3rd party modules
    inputs.nixos-hardware.nixosModules.apple-macbook-pro
    inputs.disko.nixosModules.disko
    inputs.nixos-facter-modules.nixosModules.facter
    { config.facter.reportPath = ./facter.json; }
    # nixos modules config
    inputs.self.nixosModules.nix
    inputs.self.nixosModules.ssh-hardening
    inputs.self.nixosModules.ssh-keys
    inputs.self.nixosModules.deploy
    # host-specific modules
    ./configuration.nix
    ./disk-config.nix
    ./networking.nix
    ./users.nix
  ];
}

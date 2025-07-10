# Generic iso for installation on usb boot devices.
{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment = {
    systemPackages = with pkgs; [
      helix
      xh
      # Note: can also get this package from nixpkgs (i.e. pkgs.nixos-facter)
      inputs'.nixos-facter.packages.default
      inputs'.disko.packages.default
    ];
    variables.EDITOR = "hx";
  };

  # systemd = {
  # TODO configure networks
  # https://www.reddit.com/r/NixOS/comments/1fwh4f0/networkinginterfaces_vs_systemdnetworknetworks/
  # services.sshd.wantedBy = ["multi-user.target"]; # this is already set by default?  Here we make it explicit.
  # };

  services.openssh = {
    enable = true; # this is already set in the nixos minimal installer image?
    settings = {
      AllowUsers = [
        "root"
        "nixos"
      ]; # Only allow root and nixos suer to login via ssh
      # PermitRootLogin = "prohibit-password"; # this is default value in nixos options. adding here for explicit documentation.
      PasswordAuthentication = false;
    };
  };

  # Add authorized public key for ssh-ing to the installer as the root user
  users.users.root.openssh.authorizedKeys.keys = [ config.ssh-keys.installer ];
  users.users.nixos.openssh.authorizedKeys.keys = [ config.ssh-keys.installer ];

  system.stateVersion = "24.11";
}

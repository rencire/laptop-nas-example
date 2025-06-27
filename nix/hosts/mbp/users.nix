{ config, lib, pkgs, ...}: 
{
  # Admin user actually can't do anything more than the "deploy" user.
  # Mostly used just to ssh into the box and look around via an interactive terminal
  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "deploy" ]; 
    openssh.authorizedKeys.keys = [
      config.ssh-keys.authorizedSSHKey
    ];
    shell = pkgs.zsh; # Consider using nushell?
  };

  security.sudo.extraRules = [
    {
      users = [ "admin" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/ethtool";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/nixos-install";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}

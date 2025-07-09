{
  config,
  pkgs,
  ...
}:
{
  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      config.ssh-keys.authorizedSSHKey
    ];
    shell = pkgs.zsh;
  };
}

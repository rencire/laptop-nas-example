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
      config.ssh-keys.admin
    ];
    shell = pkgs.zsh;
  };
}

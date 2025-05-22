{lib, ...}:
with lib;
{
  # Add an ssh authroized keys var for users 
  options.ssh-keys = {
    authorizedSSHKey = mkOption {
      type = types.str;
      default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE47Jb6t4Hrn7r+lmGlPo7zdoxLxcx0Bln4hIH9sbRCs ren@laptop"; # Defaults to currrent personal public key on ren@l380y host
      description = ''
        Authorized public key for ssh access.  Intended to be assigned to
        `users.users.<user>.openssh.authorizedKeys.keys` in user configurations in
        nixos modules, and to the "deploy" group also.
      '';
    };
  };
}

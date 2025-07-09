{ lib, ... }:
with lib;
{
  # Add an ssh authroized keys var for users
  options.ssh-keys = {
    authorizedSSHKey = mkOption {
      type = types.str;
      default = "<YOUR_PUBLIC_SSH_KEY>";
      description = ''
        Authorized public key for ssh access.  Intended to be assigned to
        `users.users.<user>.openssh.authorizedKeys.keys` in user configurations in
        nixos modules, and to the "deploy" group also.
      '';
    };
  };
}

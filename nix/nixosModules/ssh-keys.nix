{ lib, ... }:
with lib;
{
  # Add an ssh authroized keys var for users
  options.ssh-keys = {
    installer = mkOption {
      type = types.str;
      default = "<YOUR_INSTALLER_USERS_PUBLIC_SSH_KEY>";
      description = ''
        Authorized public key for ssh-ing into the nixos installer image.  Intended for
        temporary use, until we go through nixos installation on target machine, and thus
        don't need thet nixos installer image anymore.
      '';
    };
    admin = mkOption {
      type = types.str;
      default = "<YOUR_ADMIN_USER_PUBLIC_SSH_KEY>";
      description = ''
        Authorized public key for ssh access for admin user.  Intended to be assigned to
        `users.users.admin.openssh.authorizedKeys.keys` in user configurations in
        nixos modules.
      '';
    };
    deploy = mkOption {
      type = types.str;
      default = "<YOUR_DEPLOY_USER_PUBLIC_SSH_KEY>";
      description = ''
        Authorized public key for ssh access for deploy user.  Intended to be assigned to
        `users.users.admin.openssh.authorizedKeys.keys` in user configurations in
        nixos modules. Also used for the deploy group.
      '';
    };
  };
}

# Background info on why we need this:
# - https://discourse.nixos.org/t/which-commands-are-required-for-remote-switch/17936/8
# - https://discourse.nixos.org/t/nixos-rebuild-use-remote-sudo-prompts-me-for-a-password-3-times/56003/3
# - https://discourse.nixos.org/t/which-commands-are-required-for-remote-switch/17936
{ config, pkgs, ... }:
{
  # See: https://github.com/NixOS/nixpkgs/issues/159082#issuecomment-1118968571
  nix.settings.trusted-users = [
    "@deploy"
  ];
  users.groups.deploy = { };
  users.users.deploy = {
    isSystemUser = true;
    group = "deploy";
    shell = pkgs.bash;

    openssh.authorizedKeys.keys = [
      "no-pty ${config.ssh-keys.deploy}"
    ];
  };

  security.sudo.extraRules = [
    {
      groups = [ "deploy" ];
      commands = [
        # List commands here that we don't need sudo for.
        # Initially populated these commands from nixos-rebuild file (https://github.com/NixOS/nixpkgs/blob/2e88dbad29664f78b4c7f89f9b54d2dd2faef8e6/pkgs/os-specific/linux/nixos-rebuild/nixos-rebuild.sh#L244)
        # Didn't look closely enough at the file to double check if all these commands need to be listed.
        {
          command = "/run/current-system/sw/bin/nix-build";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/nix-collect-garbage";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/nix-copy-closure";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/nix-env";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/nix-instantiate";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/nix-store";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/nixos-rebuild";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/switch-to-configuration";
          options = [ "NOPASSWD" ];
        }
        # Added so we can suspend and reboot machine
        {
          command = "/run/current-system/sw/bin/systemctl";
          options = [ "NOPASSWD" ];
        }
        # Added this so we can use `nixos-rebuild` properly.
        {
          command = "/run/current-system/sw/bin/systemd-run";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}

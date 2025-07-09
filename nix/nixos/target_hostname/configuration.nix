{ lib, pkgs, ... }:
{
  # Necessary for uefi boot
  boot.loader.systemd-boot.enable = true;

  environment = {
    systemPackages = with pkgs; [
      # Add whatever packages you want here
      helix
      xh
      ethtool
    ];
    variables.EDITOR = "hx"; # Use helix editor for editing files
  };

  # use zsh shell
  programs.zsh.enable = true;

  # Remove sleep from closing lid
  services.logind.lidSwitch = "ignore";

  # turn off "wakeonlan disable" from tlp (set by nixos-hardware.apple-macbook-pro)
  # See: https://linrunner.de/tlp/settings/network.html#wol-disable
  services.tlp.settings = {
    WOL_DISABLE = "N";
  };

  # Explicitly set to null for documentation purposes (already defaults to null). Will use UTC.
  time.timeZone = null;
  system.stateVersion = "24.11";

}

{

  networking = {
    # TODO set your host name
    # hostName = "<your_hostname>";
    # TODO enable Wake-on-lan. Set your interface name
    # 2025/01 Issues with this setting: https://github.com/NixOS/nixpkgs/issues/339082
    # Also see: https://github.com/NixOS/nixpkgs/blob/107d5ef05c0b1119749e381451389eded30fb0d5/nixos/modules/tasks/network-interfaces.nix#L1437
    # interfaces.<interface_name> = {
    #   wakeOnLan.enable = true;
    # };
    # Notes:
    # - https://www.reddit.com/r/NixOS/comments/1fwh4f0/networkinginterfaces_vs_systemdnetworknetworks/
    useNetworkd = true;
  };

  systemd.network = {
    enable = true;
    networks = {
      # TODO set other network settings here for your interface
      # <interface_name> = {
      #   # Cloudflare dns servers
      #   dns = [
      #     "1.1.1.1"
      #     "1.0.0.1"
      #     "2606:4700:4700::1111"
      #     "2606:4700:4700::1001"
      #   ];
      # };
    };
  };

}

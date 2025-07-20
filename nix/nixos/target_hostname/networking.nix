{
  # OPTIONAL: if building this configuration for an old macbook, will need
  # to use the insecure broadcom-sta driver package if also using nixos-facter
  #
  # Permitting insecure "broadcom-sta driver package".
  #
  # It seems nixos-facter pulls in this package for some reason, so we need to allow
  # it if we want to use nixos-facter and build the configuration successfully.
  # Otherwise, CVE warning will prevent configuration from being built.
  #
  # CVEs:
  # - CVE-2019-9501
  # - CVE-2019-9502
  nixpkgs.config = {
    permittedInsecurePackages = [
      "broadcom-sta-6.30.223.271-57-6.12.39"
    ];
  };
  # IMPORTANT: make sure to NOT use WIFI on the mbp2010 machine due to the unaddressed CVEs.
  # WIFI is disabled by default, but explicitly declaring it here for documenation purposes.
  networking.wireless.enable = false;

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

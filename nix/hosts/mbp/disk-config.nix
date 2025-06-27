{
  disko.devices = {
    disk = {
      sda = {
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            # Existing esp partition. Copied over attributes from running "parted /dev/sda -- print" on the macbook
            ESP = {
              type = "EF00";
              label = "EFI System Partition";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            # new partition for linux
            root = {
              label = "root";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
            # new partition for linux
            swap = {
              label = "swap";
              content = {
                type = "swap";
                discardPolicy = "both";
                # Disable hibernation in case we want to use zfs (don't trust zfs with hibernation due to issue in past, but should look further to see if this is still an issue.)
                # resumeDevice = true; # resume from hiberation from this device
              };
            };
          };
        };
      };
    };
  };
}

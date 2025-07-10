# About
This is an example repo for installing nixos on my old 2010 macbook pro, semi-remotely (need to physically add usb boot drive to machine, but all other steps are remote).
For more info, see blog post: <link to blog post>


# Quick rundown of file structure
I won't go through every detail of each files. Instead, I'll go through a quick summary and highlights of the important files:

## flake.nix
This is the base file for our flake configuration. It's mainly used to define our flake dependencies (i.e. `inputs`).
I'm using flakelight here to help reduce flake boilerplate.
`disko` and `nixos-facter` are dependencies used as part of nixos-install later.

## nix/hosts/
This directory is where we declare the configuration for the host machine.
We will add our host configuration file in later steps.

There's an `target_hostname` folder currently.  You should rename this to the hostname of your nas machine.

### nix/hosts/target_hostname/default.nix
This file collects all the nixos modules for the os we will install onto `target_hostname`.

### nix/hosts/target_hostname/configuration.nix
This file contains general nixos configuration for the target machine.
Make sure to change any relevant settings for your machine here.

### nix/hosts/target_hostname/disk-config.nix
This file contains the declarative configuration for our disk partitions.
It will be used by Disko.

### nix/hosts/target_hostname/networking.nix
This file contains networking configuration for the target machine.
Make sure settings like `hostname` is set correctly for your machine here.

### nix/hosts/target_hostname/users.nix
This file contains user configuration for the target machine.

## nix/packages/images/nixos-installer.nix
This is the entrypoint to the configuration for the "nixos-installer" image.
We use [nixos-generators](https://github.com/nix-community/nixos-generators) to create the
installer image.

## nix/packages/images/base-installer-iso.nix
This is where we define most of the configuration for the installer image itself.
We will use these settings to build an installer image that suits our needs, compared to
the default nixos installer image:


```
{config, lib, pkgs, ...}:
{
  environment = {
    systemPackages = with pkgs; [
      # Added `Helix` default text editor so we don't have to use `nano`
      helix
      inputs'.nixos-facter.packages.default
      inputs'.disko.packages.default
    ];
    variables.EDITOR = "hx";
  };

  services.openssh = {
    enable = true; 
    settings = {
      AllowUsers = ["root" "nixos"]; # Only allow root and nixos user to login via ssh
      PasswordAuthentication = false; 
    };
  };

  # Add authorized public key for ssh-ing to the installer as the root user
  users.users.root.openssh.authorizedKeys.keys = [ config.ssh-keys.installer ];
  users.users.nixos.openssh.authorizedKeys.keys = [ config.ssh-keys.installer ];

  system.stateVersion = "24.11";
}
 
```
A quick breakdown of the configuration for the installer image:

- We define `helix` as the default text editor to use system-wide, since I couldn't stand using `nano` editor.
- `nixos-facter` and `disko` are tools we use as part of the installation process. We will expand on their usage
  later.
  - Side note: this module is also a `flakelight` module, hence why it has [`pkgs.inputs'`]([1]) available.`
- In `services.openssh`, we enable ssh and specify an "allowlist" for the two default users from the
  original nixos installer. We do not allow password authentication, although this is not strictly
  necessary since I don't think these users have passwords in the first place. Still I disabled it
  out of habit of wanting to reducing attack vector, even if there's little to no threat level here.
- We set the ssh public keys to both the users.  We use the default value that we set
  to the public ssh key on our host machine (See below).
- Lastly, we set `system.stateVersion` since its required for nixos configurations.


## nix/apps/flash-nixos-installer-iso.nix
This contains our script that will flash the iso installer.

## nix/nixosModules/deploy.nix
This file contains settings for the `deploy` user (e.g. allowed commands, etc.).
We use this user only for updating our target machine's os remotely.

## nix/nixosModules/nix.nix
This file contains some common configuration for nix itself we want to include in our installer image.

## nix/nixosModules/ssh-hardening.nix
This file includes some ssh confniguration to harden security.

## nix/nixosModules/ssh-keys.nix
This file is for specifying our public ssh keys, for both the installer and also the final
nixos we install on our target machine.

There are three keys here for the 3 different users:
1. `installer`
- Key is meant for us to remote into the bootstrapped installer os, so that we can start nixos installation process.
- Not used after we are done with initial nixos installation.  Future upgrades/updates will be handled via `deploy` user.

2. `deploy` key is for our deploy user.
- As mentioned previously, this is thte main user we use for updating our target machine's os remotely.

3. `admin` key is for the admin user of our target machine.
- This is mainly meant for troubleshooting (e.g if we need to manually ssh into the target
machine and manually execute commands).

In future, would like to use a more robust solution for key management, like [`sops-nix`](https://github.com/Mic92/sops-nix) for example.
While exposing a **public** key is not unsafe compared to exposing **private** key,
I think checking in keys is a bad practice to follow.



[1]: https://github.com/nix-community/flakelight/blob/master/API_GUIDE.md#additional-pkgs-values

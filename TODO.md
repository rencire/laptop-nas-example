# TODO
- [] Figure out how to grab the networking interface name automatically
  - Similar to how facter is able to grab disk info?
- [] Add documentation saying we can use `--build-on-remote` option, if we have a powerful target machine.
  - In my case, the target macbook was too old, so faster to build on host machine.
- [] Automate creating the "installer public/private key".
  - We don't need to keep this key, since the installer is likely one-time use?
    - Although maybe there are use cases where we do want to reuse the installer, if we have multiple macboooks to install nixos onto.
    - No need to reuse however if the target machien already is linux-based, since nixos-anywhere can use kexec to bootstrap a nixos installer.
  - Can follow similar approach to [nixos-utm](https://github.com/ciderale/nixos-utm/blob/37583c7afab649e205cba6e2711ddf1b1d082cff/flake.nix#L147)

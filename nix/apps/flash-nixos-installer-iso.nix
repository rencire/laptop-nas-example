pkgs:
let
  create-flash-iso-app =
    name: image:
    let
      pv = "${pkgs.pv}/bin/pv";
      fzf = "${pkgs.fzf}/bin/fzf";
    in
    pkgs.writeShellScriptBin name ''
      set -euo pipefail

      # Build image
      nix build .#images.${image}

      # Display fzf disk selector
      iso="./result/iso/"
      iso="$iso$(ls "$iso" | ${pv})"
      dev="/dev/$(lsblk -d -n --output RM,NAME,FSTYPE,SIZE,LABEL,TYPE,VENDOR,UUID | awk '{ if ($1 == 1) { print } }' | ${fzf} | awk '{print $2}')"

      # Format
      ${pv} -tpreb "$iso" | sudo dd bs=4M of="$dev" iflag=fullblock conv=notrunc,noerror oflag=sync
    '';
in
let
  appName = "flash-nixos-installer-iso";
  imageName = "nixos-installer";
in
{
  type = "app";
  program = "${create-flash-iso-app appName imageName}/bin/${appName}";
}

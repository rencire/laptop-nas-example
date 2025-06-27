{lib, ...}:
{
  # Harden ssh settings
  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = lib.mkForce "no"; 
        # Use SSH key authentication only (disable password-based login)
        PasswordAuthentication = false;
      };
      # Additional SSH security options
      # Disable empty passwords
      # TODO: isn't this redundant with `PasswordAuthentication = false`?
      extraConfig = ''
        PermitEmptyPasswords no  # Prevent login with empty passwords
      '';
    };
  };
}

{
  inputs,
  #config,
  ...
}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  #system.autoUpgrade = {
  #  enable = true;
  #  dates = "daily";
  #};

  #nix.gc = {
  #  automatic = true;
  #  dates = "daily";
  #  options = "delete-older-than 10d";
  #};

  nix.settings.auto-optimise-store = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [1420];
  };

  environment.sessionVariables.PATH = ["/home/ggroby/.cargo/bin"];

  # hardware.opentabletdriver.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}

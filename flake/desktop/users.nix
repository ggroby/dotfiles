{...}: {
  users.users.ggroby = {
    isNormalUser = true;
    description = "ggroby";
    extraGroups = ["networkmanager" "wheel" "adbusers" "kvm" "libvirtd" "wireshark"];
  };

  users.extraGroups.vboxusers.members = ["user-with-access-to-virtualbox"];
}

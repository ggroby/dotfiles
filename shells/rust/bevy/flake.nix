{
  description = "Rust Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    fenix,
  } @ inputs: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
      config.android_sdk.accept_license = true;
    };
    linux_rust_pkgs = with pkgs; [
      (with fenix.packages.x86_64-linux;
        combine [
          stable.rustc
          stable.cargo
          stable.clippy
          stable.rust-analyzer
          stable.rustfmt
          targets.x86_64-unknown-linux-gnu.stable.rust-std
        ])
    ];
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        linux_rust_pkgs
        pkg-config
        alsa-lib
        udev
        libxkbcommon
        wayland.dev
      ];

      LD_LIBRARY_PATH = with pkgs;
        lib.makeLibraryPath [
          # load external libraries that you need in your rust project here
          pkgs.libxkbcommon
          pkgs.vulkan-loader
        ];
    };
  };
}

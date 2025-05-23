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
  in {
    devShells.x86_64-linux.default = let
      android_sdk =
        (pkgs.androidenv.composeAndroidPackages {
          toolsVersion = "26.1.1";
          platformToolsVersion = "35.0.2";
          buildToolsVersions = ["34.0.0" "35.0.1"];
          includeEmulator = true;
          emulatorVersion = "35.5.2";
          platformVersions = ["34" "35"];
          includeSources = false;
          includeSystemImages = true;
          systemImageTypes = ["google_apis" "google_apis_playstore"];
          abiVersions = ["x86" "x86_64"]; #"armeabi-v7a" "arm64-v8a"];
          cmakeVersions = ["3.31.5"];
          includeNDK = true;
          ndkVersions = ["27.0.12077973"];
          useGoogleAPIs = false;
          useGoogleTVAddOns = false;
          includeExtras = [
            "extras;google;gcm"
          ];
        })
        .androidsdk;

      packages = with pkgs; [
        curl
        wget
        pkg-config

        nodejs_20
        typescript-language-server
        tailwindcss
        tailwindcss-language-server

        (with fenix.packages."x86_64-linux";
          combine [
            complete.rustc
            complete.cargo
            complete.clippy
            complete.rustfmt
            complete.rust-analyzer
            targets.x86_64-unknown-linux-gnu.latest.rust-std
            targets.aarch64-linux-android.latest.rust-std
            targets.armv7-linux-androideabi.latest.rust-std
            targets.i686-linux-android.latest.rust-std
            targets.x86_64-linux-android.latest.rust-std
            targets.wasm32-unknown-unknown.latest.rust-std
          ])

        jdk
        trunk
        yarn
        cargo-tauri
        cargo-generate
        dart-sass

        android_sdk
      ];

      libraries = with pkgs; [
        gtk3
        libsoup_3
        cairo
        gdk-pixbuf
        glib
        gio-sharp
        dbus
        librsvg
        webkitgtk_4_1
        openssl
        glib-networking
      ];
    in
      pkgs.mkShell {
        buildInputs = packages ++ libraries;

        nativeBuildInput = with pkgs; [
          openssl
          pkg-config
          webkitgtk_4_1
          wrapGAppsHook4
        ];

        LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath libraries}:$LD_LIBRARY_PATH";
        XDG_DATA_DIRS = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:$XDG_DATA_DIRS";
        ANDROID_HOME = "${android_sdk}/libexec/android-sdk";
        NDK_HOME = "${android_sdk}/libexec/android-sdk/ndk/27.0.12077973";
        GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${android_sdk}/libexec/android-sdk/build-tools/35.0.1/aapt2";
        WEBKIT_DISABLE_DMABUF_RENDERER = 1;
      };
  };
}

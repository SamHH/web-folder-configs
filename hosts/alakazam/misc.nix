{ config, pkgs, uname, ... }:

let
  home = config.users.users.${uname}.home;
  qrcpPort = 8090;
in
{
  networking.firewall.allowedTCPPorts = [
    qrcpPort
  ];

  # Fixes Teensy loader flashing Ergodox EZ:
  #   https://github.com/zsa/docs/issues/14
  services.udev.extraRules = ''
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
    KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"
  '';

  virtualisation.podman.enable = true;

  home-manager.users.${uname} = {
    xdg.configFile."khard/khard.conf".source = ./cfg/khard.conf;
    xdg.configFile."senpai/senpai.scfg".source = ./cfg/senpai.scfg;

    home.packages = with pkgs; [
      # CLI
      bandwhich
      distrobox
      dogdns
      duf
      fd
      gdu
      gnupg
      gping
      gotop
      sway-contrib.grimshot
      hyperfine
      imv
      khard
      lftp
      libnotify
      libqalculate
      mpv
      qrcp
      ripgrep
      qrencode
      sd
      senpai
      streamlink
      tldr
      tre-command
      unzip
      vimpc
      wf-recorder
      wl-clipboard
      zathura

      # GUI
      obsidian

      # Dev
      shellcheck
      nodePackages.yalc

      # Work
      slack
    ];

    programs.password-store = {
      enable = true;
      settings.PASSWORD_STORE_DIR = "${home}/passwords/";
    };

    # Fix qrcp port so we can allow it through firewall.
    #
    # Source fish completions until this is fixed:
    #   https://github.com/nix-community/home-manager/issues/2898
    programs.fish.shellInit = ''
      set -x QRCP_PORT ${toString qrcpPort}

      source ${pkgs.pass}/share/fish/vendor_completions.d/pass.fish
    '';

    programs.git.ignores = [
      # Yalc
      ".yalc/"
      "yalc.lock"

      # PureScript
      ".psc-ide-port"
      ".psci_modules/"

      # Haskell
      "hie.yaml"

      # npm
      ".npmrc"
    ];
  };
}

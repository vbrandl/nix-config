{ config, pkgs, ... }:

let
  newNixpkgs = import (builtins.fetchTarball https://github.com/nixos/nixpkgs-channels/archive/nixos-unstable.tar.gz) {};
  rust-analyzer = newNixpkgs.rust-analyzer;
  packageOverrides = pkgs: {
    nextcloud-client = pkgs.nextcloud-client.override { withGnomeKeyring = true; libgnome-keyring = pkgs.gnome3.libgnome-keyring; };
  };
in
{
  imports = [
    # ./email.nix
    ./dunst.nix
    ./firefox.nix
    ./i3.nix
    ./qt.nix
    ./neovim.nix
    ./tmux.nix
    ./zsh.nix
  ];

  home = {
    homeDirectory = "/home/me";
    username = "$USER";
  };

  home.packages = with pkgs; [
    i3lock-fancy

    xfce.thunar
    xfce.thunar-volman
    # mounting external devices in thunar
    gvfs

    rust-analyzer
    antigen
    nodejs
    fortune
    httpie
    pass
    ripgrep
    gcc
    cargo-edit
    binutils # ar and stuff
    rustup
    sccache
  ];

  # environment.pathsToLink = [ "/share/zsh" ];

  programs.go.enable = true;

  programs.bat.enable = true;
  programs.feh.enable = true;
  programs.fzf.enable = true;
  programs.htop.enable = true;
  programs.lsd = {
    enable = true;
    enableAliases = true;
  };
  programs.man = {
    enable = true;
    generateCaches = true;
  };
  programs.zathura.enable = true;

  programs.rofi = {
    enable = true;

    fullscreen = true;

    separator = "solid";
    padding = 200;
    font = "Roboto Mono 14";
    colors = {
      window = {
        background = "argb:d2424655";
        border = "argb:d2424655";
        separator = "argb:d2525863";
      };
      rows = {
        normal = {
          background = "argb:d2424655";
          foreground = "argb:d2838c9d";
          backgroundAlt = "argb:d2424655";
          highlight = {
            background = "argb:d2424655";
            foreground = "argb:d2f3f4f5";
          };
        };
      };
    };
    extraConfig = ''
      ! "Window Format. w (desktop name), t (title), n (name), r (role), c (class)"
      rofi.window-format: {w} 	{t}

      rofi.matching: fuzzy

      rofi.line-padding: 15
      rofi.line-margin: 0
      '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    JAVA_OPTS = "-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true";
    RUSTC_WRAPPER = "sccache";
    TERM = "xterm-256color";
  };

  xdg.enable = true;

  services = {
    nextcloud-client.enable = true;

    flameshot.enable = true;

    redshift = {
      enable = true;
      longitude = "49.01315";
      latitude = "12.1119";
    };

    gnome-keyring = {
      enable = true;
      components = [
        "pkcs11"
        "secrets"
        # "ssh"
      ];
    };

    stalonetray.enable = true;

    pasystray.enable = true;
  };

  # services.compton = {
  #   enable = true;
  #   extraOptions = ''
  #     inactive-dim = 0.3;
  #   '';
  # };

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  home = {
    stateVersion = "20.09";
    keyboard = {
      layout = "eu";
      options = [
        "caps:escape"
      ];
    };
  };
}

{ config, pkgs, ... }:

let
  unstable = import <unstable> {};
in
{
  imports = [
    ./dunst.nix
    ./firefox.nix
    ./i3.nix
    ./neovim.nix
    ./polybar.nix
    ./qt.nix
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

    unstable.rust-analyzer
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
    unstable.sccache

    # to view HTML emails in mutt
    w3m

    # literature/papers
    zotero

    # to copy from (n)vim into system clipboard under X11
    # use wl-copy and wl-pate under wayland
    xclip

    # unstable.obs-studio
    # unstable.obs-v4l2sink
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

    # fullscreen = true;

    # separator = "solid";
    # padding = 200;
    font = "Roboto Mono 14";
    # colors = {
    #   window = {
    #     background = "argb:d2424655";
    #     border = "argb:d2424655";
    #     separator = "argb:d2525863";
    #   };
    #   rows = {
    #     normal = {
    #       background = "argb:d2424655";
    #       foreground = "argb:d2838c9d";
    #       backgroundAlt = "argb:d2424655";
    #       highlight = {
    #         background = "argb:d2424655";
    #         foreground = "argb:d2f3f4f5";
    #       };
    #     };
    #   };
    # };
    extraConfig = {
      window-format = "{w} 	{t}";
      matching = "fuzzy";
      line-padding = "15";
      line-margin = "0";
    };
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
    stateVersion = "21.11";
    keyboard = {
      layout = "eu";
      options = [
        "caps:escape"
      ];
    };
  };
}

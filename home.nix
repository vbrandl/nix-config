{ config, pkgs, ... }:

{
  imports = [
    # ./email.nix
    ./dunst.nix
    ./neovim.nix
    ./tmux.nix
    ./zsh.nix
  ];

  home.packages = [
    pkgs.antigen
    pkgs.fortune
    pkgs.httpie
    pkgs.pass
    pkgs.ripgrep
    pkgs.rustup
    pkgs.sccache
  ];

  # environment.pathsToLink = [ "/share/zsh" ];

  programs.bat.enable = true;
  programs.feh.enable = true;
  programs.fzf.enable = true;
  programs.htop.enable = true;
  programs.lsd = {
    enable = true;
    enableAliases = true;
  };
  programs.man.enable = true;
  programs.zathura.enable = true;

  # programs.rofi = {
  #   separator = "solid";
  #   padding = 200;
  #   font = "Roboto Mono 14";
  #   colors = {
  #     window = {
  #       background = "argb:d2424655";
  #       border = "argb:d2424655";
  #       separator = "argb:d2525863";
  #     };
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

  home.sessionVariables = {
    EDITOR = "vim";
    JAVA_OPTS = "-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true";
    RUSTC_WRAPPER = "sccache";
    TERM = "xterm-256color";
  };

  xdg.enable = true;

  services.nextcloud-client.enable = true;
  services.flameshot.enable = true;
  services.redshift = {
    enable = true;
    longitude = "49.01315";
    latitude = "12.1119";
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
}

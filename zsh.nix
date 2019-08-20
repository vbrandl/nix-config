{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;
    dotDir = ".config/zsh";
    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
    };
    oh-my-zsh = {
      enable = true;
      # theme = "robbyrussell";
      # theme = "agnoster";
      # theme = "ys";
      # theme = "lambda-mod";
      plugins = [
        "git"
        "gitignore"
        "cargo"
        "torrent"
      ];
    };
    shellAliases = {
      sudo = "sudo ";
      sprunge = "curl -F 'sprunge=<-' http://sprunge.us";
    };
    localVariables = {
      REPORTTIME = 10;
      TIMEFMT = "$'\\nreal\\t%*E\\nuser\\t%*U\\nsys\\t%*S\\nmaxmem\\t%M MB\\nfaults\\t%F'";
      NIX_PATH = "$HOME/.nix-defexpr/channels\${NIX_PATH:+:}$NIX_PATH";
      TERM = "xterm-256color";
      RUSTC_WRAPPER = "sccache";
    };
    initExtra = ''
      [ -f $HOME/.nix-profile/etc/profile.d/nix.sh ] && . $HOME/.nix-profile/etc/profile.d/nix.sh
      source ${pkgs.antigen}/share/antigen/antigen.zsh
      # TODO: remove on NixOS
      antigen bundle spwhitt/nix-zsh-completions
      antigen bundle zsh-users/zsh-autosuggestions
      antigen theme https://github.com/halfo/lambda-mod-zsh-theme lambda-mod
      antigen apply

    '';
  };
}

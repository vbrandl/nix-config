{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    historyLimit = 50000;
    keyMode = "vi";
    shortcut = "a";
    terminal = "xterm-256color";
    extraConfig = ''
      bind a last-window

      # highlight window when it has new activity
      setw -g monitor-activity on
      set -g visual-activity on

      # renumber windows when one is closed
      set -g renumber-windows on

      # mouse behavior
      set -g mouse on

      # Fix to allow mousewheel/trackpad scrolling in tmux 2.1
      bind-key -T root WheelUpPane if-shell -F -t = "#{alternate_on}" "send-keys -M" "select-pane -t =; copy-mode -e; send-keys -M"
      bind-key -T root WheelDownPane if-shell -F -t = "#{alternate_on}" "send-keys -M" "select-pane -t =; send-keys -M"

      # show tmux messages for 4 seconds
      set -g display-time 4000

      # New Pane
      bind c new-window -c "#{pane_current_path}"

      # New Session
      bind enter new

      # Split Panes
      bind h split-window -h -c '#{pane_current_path}'  # Split panes horizontal
      bind v split-window -v -c '#{pane_current_path}'  # Split panes vertically

      # focus events enabled for terminals that support them
      set -g focus-events on

      # default statusbar colors
      set -g status-fg white
      set -g status-bg default

      # default window title colors
      set-window-option -g window-status-style fg=black,bg=default,dim

      # active window title colors
      set-window-option -g window-status-current-style fg=white,bg=default,dim

      # command/message line colors
      set -g message-style fg=white,bg=black,bright

      # set -g default-terminal "xterm-256color"
      # set-option -ga terminal-overrides ",xterm-*color:Tc"

      set -g set-titles on
      set -g set-titles-string "[#S] $USER@#H:#{pane_current_path} #{pane_current_command}"

      set-window-option -g xterm-keys on
    '';
  };
}

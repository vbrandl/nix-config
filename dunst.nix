{ config, pkgs, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "Monospace 8";
        allow_markup = true;
        format = "<b>%a:</b> %s\n%b";
        sort = true;
        indicate_hidden = true;
        alignment = "left";
        bounce_freq = 0;
        show_age_threshold = 60;
        word_wrap = true;
        ignore_newline = false;
        geometry = "300x5-30+20";
        transparency = 0;
        idle_threshold = 120;
        monitor = 0;
        follow = "keyboard";
        sticky_history = true;
        line_height = 0;
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        separator_color = "frame";
        startup_notification = true;
        dmenu = "dmenu -p dunst:";
        browser = "firefox -new-tab";
      };
      frame = {
        width = 0;
        color = "#000000";
      };
      shortcuts = {
        close = "mod4+m";
        close_all = "mod4+shift+m";
        history = "mod4+n";
        context = "mod4+shift+i";
      };
      urgency_low = {
        background = "#222222";
        foreground = "#888888";
        timeout = 10;
      };
      urgency_normal = {
        background = "#285577";
        foreground = "#ffffff";
        timeout = 10;
      };
      urgency_critical = {
        background = "#900000";
        foreground = "#ffffff";
        timeout = 0;
      };
    };
  };
}

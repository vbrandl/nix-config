{ lib, config, pkgs, ... }:

{
  services.polybar = {
    enable = true;
    config = {
      "bar/top" = {
        monitor = "\${env:MONITOR:}";
        # monitor = "\${env:MONITOR:DVI-D-1}";
        width = "100%";
        height = "34";
        background = "#00000000";
        foreground = "#ccffffff";
        # line-color = "\${bar/top.background}";
        line-size = "16";
        spacing = "2";
        padding-right = "5";
        module-margin = "4";

        font-0 = "NotoSans-Regular:size=8;-1";
        font-1 = "MaterialIcons:size=10;0";
        font-2 = "Termsynu:size=8:antialias=false;-2";
        font-3 = "FontAwesome:size=10;0";

        # modules-left = "powermenu";
        modules-left = "i3";
        modules-right = "cpu memory volume wired-network date";

        tray-position = "right";
        tray-padding = "2";
      };

      "module/volume" = {
        type = "internal/pulseaudio";
        speaker-mixer = "Speaker";
        headphone-mixer = "Headphone";
        headphone-id = "9";

        format-volume = "<ramp-volume> <label-volume>";
        label-muted = " muted";
        label-muted-foreground = "#66";

        ramp-volume-0 = "";
        ramp-volume-1 = "";
        ramp-volume-2 = "";
        # ramp-volume-3 = "4";
      };

      "module/i3" = {
        type = "internal/i3";
        format = "<label-state> <label-mode>";
        index-sort = true;
        pin-workspaces = true;
      };

      "module/wired-network" = {
        type = "internal/network";
        interface = "eno1";
        interval = "3.0";

        label-connected = "%{T3}%local_ip%%{T-}";
        label-disconnected-foreground = "#66";
      };

      "module/date" = {
        type = "internal/date";
        date = "%%{F#99}%Y-%m-%d%%{F-}  %%{F#fff}%H:%M%%{F-}";
        date-alt = "%%{F#fff}%A, %d %B %Y  %%{F#fff}%H:%M%%{F#666}:%%{F#fba922}%S%%{F-}";
      };

      "module/memory" = {
        type = "internal/memory";
        format = "<label> <bar-used>";
        label = "RAM";
        bar-used-width = "30";
        bar-used-foreground-0 = "#aaff77";
        bar-used-foreground-1 = "#aaff77";
        bar-used-foreground-2 = "#fba922";
        bar-used-foreground-3 = "#ff5555";
        bar-used-indicator = "|";
        bar-used-indicator-font = "6";
        bar-used-indicator-foreground = "#ff";
        bar-used-fill = "─";
        bar-used-fill-font = "6";
        bar-used-empty = "─";
        bar-used-empty-font = "6";
        bar-used-empty-foreground = "#444444";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = "0.5";
        format = "<label> <ramp-coreload>";
        label = "CPU";

        ramp-coreload-0 = "▁";
        ramp-coreload-0-font = "2";
        ramp-coreload-0-foreground = "#aaff77";
        ramp-coreload-1 = "▂";
        ramp-coreload-1-font = "2";
        ramp-coreload-1-foreground = "#aaff77";
        ramp-coreload-2 = "▃";
        ramp-coreload-2-font = "2";
        ramp-coreload-2-foreground = "#aaff77";
        ramp-coreload-3 = "▄";
        ramp-coreload-3-font = "2";
        ramp-coreload-3-foreground = "#aaff77";
        ramp-coreload-4 = "▅";
        ramp-coreload-4-font = "2";
        ramp-coreload-4-foreground = "#fba922";
        ramp-coreload-5 = "▆";
        ramp-coreload-5-font = "2";
        ramp-coreload-5-foreground = "#fba922";
        ramp-coreload-6 = "▇";
        ramp-coreload-6-font = "2";
        ramp-coreload-6-foreground = "#ff5555";
        ramp-coreload-7 = "█";
        ramp-coreload-7-font = "2";
        ramp-coreload-7-foreground = "#ff5555";
      };
    };

    package = pkgs.polybar.override {
      pulseSupport = true;
      i3Support = true;
    };

    script = ''
      polybar top &
    '';
  };
}

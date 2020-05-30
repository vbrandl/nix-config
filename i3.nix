{ lib, config, pkgs, ... }:

let
  mod = "Mod4";
  ws1 = "1: ";
  ws2 = "2: ";
  ws3 = "3: ";
  ws4 = "4: ";
  ws5 = "5: ";
  ws6 = "6: ";
  ws7 = "7: ";
  ws8 = "8";
  ws9 = "9";
  ws10 = "10: ";

  mode_system = "System:   L :  | S :  | P :  | R :  | E : ";
in
{
  xsession.windowManager.i3 = {
    enable = true;
    # package = pkgs.i3-gaps;
    config = {
      modifier = mod;

      workspaceAutoBackAndForth = true;

      fonts = [ "NotoSans-Regular:Monospace, FontAwesome 12" ];
      # fonts = [ "DejaVu Sans Mono, FontAwesome 6" ];

      # disable titlebar
      focus.newWindow = "none";

      assigns = {
        "${ws1}" = [
          { class = "^Firefox$"; }
          { class = "firefox"; }
          { class = "Firefox"; }
        ];
        "${ws4}" = [{ class="Pidgin"; }];
        "${ws5}" = [{ class="Thunar"; }];
        "${ws6}" = [{ class="libreoffice-startcenter"; }];
        "${ws7}" = [{ class="Thunderbird"; }];
      };

      floating = {
        criteria = [
          { window_role = "pop-up"; }
          { window_role = "task_dialog"; }
          { title = "Preferences$"; }
          { class = "Keepassx2"; }
          { class = "keepassxc"; }
          { class = "^Pavucontrol$"; }
          { class = "^Pinentry-gtk-2$"; }
        ];
      };

      keybindings = lib.mkOptionDefault {
        "${mod}+Return" = "exec termite";
        "${mod}+Shift+q" = "kill";
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";
        "${mod}+b" = "split h";
        "${mod}+v" = "split v";
        "${mod}+f" = "fullscreen toggle";
        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";
        "${mod}+Shift+space" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";
        "${mod}+a" = "focus parent";
        "${mod}+d" = "exec rofi -show drun -matching fuzzy";

        "${mod}+1" = "workspace ${ws1}";
        "${mod}+2" = "workspace ${ws2}";
        "${mod}+3" = "workspace ${ws3}";
        "${mod}+4" = "workspace ${ws4}";
        "${mod}+5" = "workspace ${ws5}";
        "${mod}+6" = "workspace ${ws6}";
        "${mod}+7" = "workspace ${ws7}";
        "${mod}+8" = "workspace ${ws8}";
        "${mod}+9" = "workspace ${ws9}";
        "${mod}+0" = "workspace ${ws10}";
        "${mod}+Shift+1" = "move container to workspace ${ws1}";
        "${mod}+Shift+2" = "move container to workspace ${ws2}";
        "${mod}+Shift+3" = "move container to workspace ${ws3}";
        "${mod}+Shift+4" = "move container to workspace ${ws4}";
        "${mod}+Shift+5" = "move container to workspace ${ws5}";
        "${mod}+Shift+6" = "move container to workspace ${ws6}";
        "${mod}+Shift+7" = "move container to workspace ${ws7}";
        "${mod}+Shift+8" = "move container to workspace ${ws8}";
        "${mod}+Shift+9" = "move container to workspace ${ws9}";
        "${mod}+Shift+0" = "move container to workspace ${ws10}";

        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+r" = "restart";
        "${mod}+Shift+e" = "exec \"i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'\"";

        "${mod}+r" = "mode \"resize\"";
        "${mod}+x" = "mode \"${mode_system}\"";

        "${mod}+Shift+x" = "exec i3lock-fancy -n";
      };

      modes = {
        resize = {
          h = "resize shrink width 10 px or 10 ppt";
          j = "resize grow height 10 px or 10 ppt";
          k = "resize shrink height 10 px or 10 ppt";
          l = "resize grow width 10 px or 10 ppt";

          Left = "resize shrink width 10 px or 10 ppt";
          Down = "resize grow height 10 px or 10 ppt";
          Up = "resize shrink height 10 px or 10 ppt";
          Right = "resize grow width 10 px or 10 ppt";

          Return = "mode \"default\"";
          Escape = "mode \"default\"";
        };
        "${mode_system}" = {
          l = "exec ~/bin/lock.sh, mode \"default\"";
          s = "exec $Lock systemctl suspend, mode \"default\"";
          p = "exec systemctl poweroff -i, mode \"default\"";
          r = "exec systemctl reboot, mode \"default\"";
          e = "exec i3-msg exit, mode \"default\"";

          # back to normal: Enter or Escape or mod+x again
          Return = "mode \"default\"";
          Escape = "mode \"default\"";
          "${mod}+x" = "mode \"default\"";
        };
      };
      window = {
        hideEdgeBorders = "both";
        titlebar = false;
      };
    };

  };

  services.picom = {
    enable = true;
    inactiveDim = "0.3";
  };
}

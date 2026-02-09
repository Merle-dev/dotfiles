{ ... }:
{
  programs.niri = {
    # enable = true;
    
    settings = {
      # Input configuration
      input = {
        keyboard = {
          xkb = {
            # Layout settings - adjust as needed
            # layout = "us,ru";
            # options = "grp:win_space_toggle,compose:ralt,ctrl:nocaps";
          };
          # Enable numlock on startup
          track-layout = "global";
        };

        touchpad = {
          tap = true;
          natural-scroll = true;
        };

        mouse = { };
        
        trackpoint = { };

        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "0%";
        };
      };

      # Output configuration
      outputs = {
        "DP-1" = {
          mode = {
            width = 1920;
            height = 1080;
            refresh = 60.0;
          };
          scale = 1.0;
          transform = "normal";
          position = {
            x = 1280;
            y = 0;
          };
        };
        
        "HDMI-A-1" = {
          mode = {
            width = 1920;
            height = 1080;
            refresh = 60.0;
          };
          scale = 1.0;
          transform = "normal";
          position = {
            x = 0;
            y = 0;
          };
        };
      };

      # Layout settings
      layout = {
        gaps = 6;
        center-focused-column = "never";
        
        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];

        default-column-width = { proportion = 0.66667; };
        
        focus-ring = {
          enable = true;
          width = 2;
          active-color = "#605050";
          inactive-color = "#101010";
          active-gradient = {
            from = "#705050";
            to = "#505050";
            angle = 45;
          };
        };

        border = {
          enable = false;
          width = 3;
          active-color = "#ffc87f";
          inactive-color = "#505050";
        };

        shadow = {
          enable = false;
          softness = 30.0;
          spread = 5.0;
          offset = {
            x = 0;
            y = 5;
          };
          color = "#0007";
        };

        struts = {
          # left = 64;
          # right = 64;
          # top = 64;
          # bottom = 64;
        };
      };

      # Spawn processes at startup
      spawn-at-startup = [
        { command = ["swww-daemon"]; }
        { command = ["noctalia-shell"]; }
      ];

      # Overview settings
      overview = {
        zoom = 0.6;
        workspace-shadow = {
          enable = false;
        };
      };

      # Layer rules
      layer-rules = [
        {
          match = {
            namespace = "^swww-daemon$";
          };
          place-within-backdrop = true;
        }
      ];

      # Hotkey overlay
      hotkey-overlay = {
        skip-at-startup = true;
      };

      # Prefer no client-side decorations
      prefer-no-csd = true;

      # Screenshot path
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %d.%m.%Y %H-%M-%S.png";

      # Animations
      animations = {
        enable = true;
        slowdown = 0.6;
      };

      # Window rules
      window-rules = [
        # Rounded corners for all windows
        {
          geometry-corner-radius = 6.0;
          clip-to-geometry = true;
        }
      ];

      # Keybindings
      binds = {
        # Hotkey overlay
        "Mod+K".action.show-hotkey-overlay = { };

        # Application launchers
        "Super+Shift+Return" = {
          action.spawn = ["sh" "-c" "alacritty -e fish"];
          hotkey-overlay-title = "Open a Terminal: alacritty";
        };
        "Super+Shift+B" = {
          action.spawn = ["zen"];
          hotkey-overlay-title = "Open a Browser: Zen-Browser";
        };
        "Super+Shift+N" = {
          action.spawn = ["sh" "-c" "zen https://search.nixos.org/packages"];
          hotkey-overlay-title = "Open NixOS Packages";
        };
        "Super+Shift+R" = {
          action.spawn = ["sh" "-c" "alacritty -e crates-tui"];
          hotkey-overlay-title = "Open Crates-Tui";
        };
        "Ctrl+Shift+L" = {
          action.spawn = ["swaylock"];
          hotkey-overlay-title = "Lock the Screen: swaylock";
        };
        "Super+P" = {
          action.spawn = ["sh" "-c" "fuzzel -p \"λ \" -w 60 -l 25 --use-bold --background-color=#0c0d18cc --text-color=#a9b1d6ff"];
          hotkey-overlay-title = "Run an Application: fuzzel";
        };
        "Super+Shift+Delete" = {
          action.spawn = ["sh" "-c" "qs -c noctalia-shell ipc call sessionMenu toggle"];
          hotkey-overlay-title = "wleave";
        };

        # Media keys
        "XF86AudioRaiseVolume" = {
          action.spawn = ["sh" "-c" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+"];
          allow-when-locked = true;
        };
        "XF86AudioLowerVolume" = {
          action.spawn = ["sh" "-c" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"];
          allow-when-locked = true;
        };
        "XF86AudioMute" = {
          action.spawn = ["sh" "-c" "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"];
          allow-when-locked = true;
        };
        "XF86AudioMicMute" = {
          action.spawn = ["sh" "-c" "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"];
          allow-when-locked = true;
        };

        # Brightness keys
        "XF86MonBrightnessUp" = {
          action.spawn = ["brightnessctl" "--class=backlight" "set" "+10%"];
          allow-when-locked = true;
        };
        "XF86MonBrightnessDown" = {
          action.spawn = ["brightnessctl" "--class=backlight" "set" "10%-"];
          allow-when-locked = true;
        };

        # Overview
        "Super+Shift+S" = {
          action.toggle-overview = { };
          repeat = false;
        };

        # Window management
        "Super+Shift+C" = {
          action.close-window = { };
          repeat = false;
        };

        # Focus navigation
        "Super+Left".action.focus-column-left = { };
        "Super+Down".action.focus-window-down = { };
        "Super+Up".action.focus-window-up = { };
        "Super+Right".action.focus-column-right = { };
        "Super+H".action.focus-column-left = { };
        "Super+J".action.focus-window-down = { };
        "Super+K".action.focus-window-up = { };
        "Super+L".action.focus-column-right = { };

        # Move windows
        "Alt+Shift+Left".action.move-column-left = { };
        "Alt+Shift+Down".action.move-window-down = { };
        "Alt+Shift+Up".action.move-window-up = { };
        "Alt+Shift+Right".action.move-column-right = { };
        "Alt+Shift+H".action.move-column-left = { };
        "Alt+Shift+J".action.move-window-down = { };
        "Alt+Shift+K".action.move-window-up = { };
        "Alt+Shift+L".action.move-column-right = { };

        # Column navigation
        "Mod+Home".action.focus-column-first = { };
        "Mod+End".action.focus-column-last = { };
        "Mod+Ctrl+Home".action.move-column-to-first = { };
        "Mod+Ctrl+End".action.move-column-to-last = { };

        # Monitor focus
        "Super+Shift+Left".action.focus-monitor-left = { };
        "Super+Shift+Down".action.focus-monitor-down = { };
        "Super+Shift+Up".action.focus-monitor-up = { };
        "Super+Shift+Right".action.focus-monitor-right = { };
        "Super+Shift+H".action.focus-monitor-left = { };
        "Super+Shift+J".action.focus-monitor-down = { };
        "Super+Shift+K".action.focus-monitor-up = { };
        "Super+Shift+L".action.focus-monitor-right = { };

        # Move to monitor
        "Super+Shift+Ctrl+Left".action.move-column-to-monitor-left = { };
        "Super+Shift+Ctrl+Down".action.move-column-to-monitor-down = { };
        "Super+Shift+Ctrl+Up".action.move-column-to-monitor-up = { };
        "Super+Shift+Ctrl+Right".action.move-column-to-monitor-right = { };
        "Super+Shift+Ctrl+H".action.move-column-to-monitor-left = { };
        "Super+Shift+Ctrl+J".action.move-column-to-monitor-down = { };
        "Super+Shift+Ctrl+K".action.move-column-to-monitor-up = { };
        "Super+Shift+Ctrl+L".action.move-column-to-monitor-right = { };

        # Workspace navigation
        "Super+Page_Down".action.focus-workspace-down = { };
        "Super+Page_Up".action.focus-workspace-up = { };
        "Super+U".action.focus-workspace-down = { };
        "Super+I".action.focus-workspace-up = { };
        "Super+Ctrl+Page_Down".action.move-column-to-workspace-down = { };
        "Super+Ctrl+Page_Up".action.move-column-to-workspace-up = { };
        "Super+Ctrl+U".action.move-column-to-workspace-down = { };
        "Super+Ctrl+I".action.move-column-to-workspace-up = { };

        # Move workspace
        "Super+Shift+Page_Down".action.move-workspace-down = { };
        "Super+Shift+Page_Up".action.move-workspace-up = { };
        "Super+Shift+U".action.move-workspace-down = { };
        "Super+Shift+I".action.move-workspace-up = { };

        # Mouse wheel bindings
        "Mod+WheelScrollDown" = {
          action.focus-workspace-down = { };
          cooldown-ms = 150;
        };
        "Mod+WheelScrollUp" = {
          action.focus-workspace-up = { };
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollDown" = {
          action.move-column-to-workspace-down = { };
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollUp" = {
          action.move-column-to-workspace-up = { };
          cooldown-ms = 150;
        };

        "Mod+WheelScrollRight".action.focus-column-right = { };
        "Mod+WheelScrollLeft".action.focus-column-left = { };
        "Super+Alt+WheelScrollRight".action.move-column-right = { };
        "Super+Alt+WheelScrollLeft".action.move-column-left = { };

        "Mod+Shift+WheelScrollDown".action.focus-column-right = { };
        "Mod+Shift+WheelScrollUp".action.focus-column-left = { };
        "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = { };
        "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = { };

        # Workspace by number
        "Super+1".action.focus-workspace = 1;
        "Super+2".action.focus-workspace = 2;
        "Super+3".action.focus-workspace = 3;
        "Super+4".action.focus-workspace = 4;
        "Super+5".action.focus-workspace = 5;
        "Super+6".action.focus-workspace = 6;
        "Super+7".action.focus-workspace = 7;
        "Super+8".action.focus-workspace = 8;
        "Super+9".action.focus-workspace = 9;

        "Super+Ctrl+1".action.move-column-to-workspace = 1;
        "Super+Ctrl+2".action.move-column-to-workspace = 2;
        "Super+Ctrl+3".action.move-column-to-workspace = 3;
        "Super+Ctrl+4".action.move-column-to-workspace = 4;
        "Super+Ctrl+5".action.move-column-to-workspace = 5;
        "Super+Ctrl+6".action.move-column-to-workspace = 6;
        "Super+Ctrl+7".action.move-column-to-workspace = 7;
        "Super+Ctrl+8".action.move-column-to-workspace = 8;
        "Super+Ctrl+9".action.move-column-to-workspace = 9;

        # Window consume/expel
        "Mod+BracketLeft".action.consume-or-expel-window-left = { };
        "Mod+BracketRight".action.consume-or-expel-window-right = { };
        "Super+Comma".action.consume-window-into-column = { };
        "Super+Period".action.expel-window-from-column = { };

        # Window sizing
        "Mod+R".action.switch-preset-column-width = { };
        "Mod+Ctrl+R".action.reset-window-height = { };
        "Super+Tab".action.maximize-column = { };
        "Super+Shift+Tab".action.fullscreen-window = { };
        "Mod+Ctrl+C".action.center-visible-columns = { };

        "Super+Minus".action.set-column-width = "-10%";
        "Super+Plus".action.set-column-width = "+10%";
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Plus".action.set-window-height = "+10%";

        # Floating windows
        "Mod+V".action.toggle-window-floating = { };
        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = { };

        # Tabbed display
        "Mod+W".action.toggle-column-tabbed-display = { };

        # Screenshots
        "Print".action.screenshot = { };
        "Ctrl+Print".action.screenshot-screen = { };
        "Alt+Print".action.screenshot-window = { };

        # Misc
        "Mod+Escape" = {
          action.toggle-keyboard-shortcuts-inhibit = { };
          allow-inhibiting = false;
        };
        "Super+Shift+Q".action.quit = { };
        "Alt+Shift+P".action.power-off-monitors = { };
      };
    };
  };
}

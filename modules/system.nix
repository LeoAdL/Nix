{ pkgs, ... }:

###################################################################################
#
#  macOS's System configuration
#
#  All the configuration options are documented here:
#    https://daiderd.com/nix-darwin/manual/index.html#sec-options
#
###################################################################################
{
  system = {
    stateVersion = 5;
    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      menuExtraClock.Show24Hour = true; # show 24 hour clock
      NSGlobalDomain.AppleInterfaceStyle = "Dark";
      # other macOS's defaults configuration.
      # ......
      dock = {
        autohide = true;
        autohide-delay = 0.24;
      };
      finder.AppleShowAllExtensions = true;
      screencapture.type = "png";
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;
  # Create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;

  services.skhd = {
    enable = true;
    skhdConfig = "# change window focus within space
        alt - j : yabai -m window --focus south
        alt - k : yabai -m window --focus north
        alt - h : yabai -m window --focus west
        alt - l : yabai -m window --focus east
        #
        #change focus between external displays (left and right)
        alt - s: yabai -m display --focus south
        alt - d: yabai -m display --focus north
        alt - a: yabai -m display --focus west
        alt - f: yabai -m display --focus east
        # move window to display left and right
        shift + alt - d : yabai -m window --display north; yabai -m display --focus north;
        shift + alt - s : yabai -m window --display south; yabai -m display --focus south;
        shift + alt - a : yabai -m window --display west; yabai -m display --focus west;
        shift + alt - f : yabai -m window --display east; yabai -m display --focus east;
        # rotate layouj clockwise
        shift + alt - r : yabai -m space --rotate 270

        # flip along y-axis
        shift + alt - y : yabai -m space --mirror y-axis

        # flip along x-axis
        shift + alt - x : yabai -m space --mirror x-axis

        # toggle window float
        alt - f : yabai -m window --toggle float --grid 4:4:1:1:2:2
        # maximize a window
        alt - m : yabai -m window --toggle zoom-fullscreen

        # balance out tree of windows (resize to occupy same area)
        shift + alt - e : yabai -m space --balance
        # swap windows
        shift + alt - j : yabai -m window --swap south
        shift + alt - k : yabai -m window --swap north
        shift + alt - h : yabai -m window --swap west
        shift + alt - l : yabai -m window --swap east
        #move window to prev and next space
        shift + alt - p : yabai -m window --space prev;
        shift + alt - n : yabai -m window --space next;
        # move window and split
        ctrl + alt - j : yabai -m window --warp south
        ctrl + alt - k : yabai -m window --warp north
        ctrl + alt - h : yabai -m window --warp west
        ctrl + alt - l : yabai -m window --warp east
        # move window to space #
        shift + alt - 1 : yabai -m window --space 1;
        shift + alt - 2 : yabai -m window --space 2;
        shift + alt - 3 : yabai -m window --space 3;
        shift + alt - 4 : yabai -m window --space 4;
        shift + alt - 5 : yabai -m window --space 5;
        shift + alt - 6 : yabai -m window --space 6;
        shift + alt - 7 : yabai -m window --space 7;
        shift + alt - 8 : yabai -m window --space 8;
        shift + alt - 9 : yabai -m window --space 9;


        alt - 1 : yabai -m space --focus 1
        alt - 2 : yabai -m space --focus 2
        alt - 3 : yabai -m space --focus 3
        alt - 4 : yabai -m space --focus 4
        alt - 5 : yabai -m space --focus 5
        alt - 6 : yabai -m space --focus 6
        alt - 7 : yabai -m space --focus 7
        alt - 8 : yabai -m space --focus 8
        alt - 9 : yabai -m space --focus 9

        # stop/start/restart yabai
        ctrl + alt - q : yabai --stop-service
        ctrl + alt - s : yabai --start-service
        ctrl + alt - r : yabai --restart-service";
  };

  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    config = {
      external_bar = "all:35:0";
      menubar_opacity = 0.5;
      mouse_follows_focus = "off";
      focus_follows_mouse = "off";
      display_arrangement_order = "default";
      window_origin_display = "default";
      window_placement = "second_child";
      window_zoom_persist = "on";
      window_shadow = "on";
      window_animation_duration = 0.1;
      window_animation_easing = "ease_out_expo";
      window_opacity_duration = 0.2;
      active_window_opacity = 1.00;
      normal_window_opacity = 0.95;
      window_opacity = "on";
      insert_feedback_color = "0xffd75f5f";
      split_ratio = 0.50;
      split_type = "auto";
      auto_balance = "off";
      top_padding = 3;
      bottom_padding = 3;
      left_padding = 3;
      right_padding = 3;
      window_gap = 3;
      layout = "bsp";
      mouse_modifier = "alt";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      mouse_drop_action = "swap";
    };
    extraConfig = ''
      yabai -m signal --add event=dock_did_restart action=" sudo yabai --load-sa "
      sudo yabai --load-sa
    '';

  };

  services.sketchybar = {
    enable = true;
  };

  services.jankyborders = {
    enable = true;
    hidpi = true;
    active_color = "0xFFF2CDCD";
    inactive_color = "0xff494d64";
    width = 5.0;
  };

  # Optimize storage
  # You can also manually optimize the store via:
  #    nix-store --optimise
  # Refer to the following link for more details:
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store

}

{
  config,
  pkgs,
  stable,
  ...
}:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "leoap";
  home.homeDirectory = "/Users/leoap";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Leo Aparisi de Lannoy";
    userEmail = "laparisidelannoy@uchicago.edu";
    diff-so-fancy = {
      enable = true;
    };
  };

  programs.fzf =
    let
      defaultCommand = "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git";
    in
    {
      inherit defaultCommand;
      enable = true;
      enableZshIntegration = true;
      defaultOptions = [
        "--layout=reverse --height 70% --info=inline --border --margin=1 --padding=1 \
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
        --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
      ];
      fileWidgetCommand =
        defaultCommand
        + "
--preview 'bat --color=always --style=numbers {}'
--bind 'ctrl-/:change-preview-window(down|hidden|)'";
    };

  home.sessionVariables = {
    COLORTERM = "truecolor";
    TERM = "xterm-256color";
    FZF_PREVIEW_ADVANCED = "true";
  };

  programs.zsh = {
    enable = true;
    initExtra = ''
      source ~/.p10k.zsh
      eval "$(/usr/libexec/path_helper)"
      export PATH="$PATH:/Library/TeX/texbin/"
    '';
    antidote = {
      enable = true;
      plugins = [

        # .zsh_plugins.txt
        "jeffreytse/zsh-vi-mode"

        "olets/zsh-abbr    kind:defer"

        #    # set up Zsh completions with plugins
        "mattmc3/ez-compinit"
        "zsh-users/zsh-completions kind:fpath path:src"

        # prompts:
        #   with prompt plugins, remember to add this to your .zshrc:
        #   `autoload -Uz promptinit && promptinit && prompt pure`
        # or lighter-weight ones like zsh-utils
        "belak/zsh-utils path:editor"
        "belak/zsh-utils path:history"
        "belak/zsh-utils path:prompt"
        "belak/zsh-utils path:utility"

        "romkatv/powerlevel10k"

        # popular fish-like plugins
        "unixorn/fzf-zsh-plugin"
        "wfxr/forgit"
        "Aloxaf/fzf-tab"
        "mattmc3/zfunctions"
        "zsh-users/zsh-autosuggestions"
        "zdharma-continuum/fast-syntax-highlighting kind:defer"

      ];
    };
  };
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Iosevka Nerd Font" ];
      sansSerif = [ "Iosevka Nerd Font" ];
      serif = [ "Lato" ];
    };

  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-macport; # replace with pkgs.emacs-gtk, or a version provided by the community overlay if desired.
    extraPackages =
      epkgs: with epkgs; [
        mu4e
        vterm
        jinx
        pdf-tools
        treesit-grammars.with-all-grammars
      ];
  };

  programs.mpv = {
    enable = true;
    config = {

      border = "no";

      keep-open = "yes";
      autofit = "85%x85%";
      cursor-autohide = "100";
      screenshot-template = "%x/Screens/Screenshot-%F-T%wH.%wM.%wS.%wT-F%{estimated-frame-number}";
      screenshot-format = "png"; # Set screenshot format
      screenshot-png-compression = 4; # Range is 0 to 10. 0 being no compression.
      screenshot-tag-colorspace = "yes";
      screenshot-high-bit-depth = "yes"; # Same output bitdepth as the video

      ###########
      # OSC/OSD #
      ###########

      osc = "no"; # 'no' required for MordernX OSC
      osd-bar = "no"; # Do not remove/comment if mpv_thumbnail_script_client_osc.lua is being used.
      osd-font = "Iosevka Nerd Font"; # Set a font for OSC
      osd-font-provider = "fontconfig";
      osd-font-size = 30; # Set a font size
      osd-color = "#CCFFFFFF"; # ARGB format
      osd-border-color = "#DD322640"; # ARGB format
      osd-bar-align-y = -1; # progress bar y alignment (-1 top, 0 centered, 1 bottom)
      osd-border-size = 2; # size for osd text and progress bar
      osd-bar-h = 1; # height of osd bar as a fractional percentage of your screen height
      osd-bar-w = 60; # width of " " "

      sub-auto = "fuzzy"; # external subs don't have to match the file name exactly to autoload
      # sub-gauss=0.6					# Some settings fixing VOB/PGS subtitles (creating blur & changing yellow subs to gray)

      #########
      # Audio #
      #########

      ao = "coreaudio";
      coreaudio-change-physical-format = "yes";
      audio-file-auto = "fuzzy"; # external audio doesn't has to match the file name exactly to autoload

      # Languages #
      slang = "eng,en";

      ##################
      # Video Profiles #
      ##################

      profile = "high-quality"; # mpv --show-profile=gpu-hq
      vo = "gpu-next";
      gpu-context = "macvk";
      macos-render-timer = "precise";
      hwdec = "videotoolbox"; # enable hardware decoding, defaults to 'no'

      hdr-peak-percentile = 99.995;
      hdr-contrast-recovery = 0.30;
      tone-mapping = "st2094-40";
      allow-delayed-peak-detect = "no";

      ###### Debanding
      deband = "yes";

      ###### Interpolation
      video-sync = "display-resample";
      interpolation = "yes";

    };
    bindings = {
      "r" = "playlist-shuffle";
    };
    scripts = with pkgs.mpvScripts; [
      thumbfast
      modernz
    ];
    scriptOpts = {
      modernz = {
        info_button = "yes";
      };
    };
  };

  programs.bat = {
    enable = true;
  };

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      local wezterm = require("wezterm")
      local gpus = wezterm.gui.enumerate_gpus()
      return {
          font = wezterm.font_with_fallback({
              "Iosevka Nerd Font",
          }),
          font_size = 16.0,
          color_scheme = "Catppuccin Mocha",
          tab_bar_at_bottom = true,
          hide_tab_bar_if_only_one_tab = true,
          window_background_opacity = 1,
          window_decorations = "RESIZE",
          inactive_pane_hsb = {
              -- NOTE: these values are multipliers, applied on normal pane values
              saturation = 0.9,
              brightness = 0.6,
          },
          leader = { key = "b", mods = "CTRL" },
          keys = {
              { key = "a", mods = "LEADER|CTRL",  action = wezterm.action { SendString = "\x01" } },
              { key = "s", mods = "LEADER",       action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
              { key = "v", mods = "LEADER",       action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
              { key = "z", mods = "LEADER",       action = "TogglePaneZoomState" },
              { key = "c", mods = "LEADER",       action = "ActivateCopyMode" },
              { key = "s", mods = "LEADER",       action = "ShowTabNavigator" },
              { key = "n", mods = "LEADER",       action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
              { key = "h", mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Left" } },
              { key = "j", mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Down" } },
              { key = "k", mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Up" } },
              { key = "l", mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Right" } },
              { key = "H", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Left", 5 } } },
              { key = "J", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Down", 5 } } },
              { key = "K", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Up", 5 } } },
              { key = "L", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Right", 5 } } },
              { key = "1", mods = "LEADER",       action = wezterm.action { ActivateTab = 0 } },
              { key = "2", mods = "LEADER",       action = wezterm.action { ActivateTab = 1 } },
              { key = "3", mods = "LEADER",       action = wezterm.action { ActivateTab = 2 } },
              { key = "4", mods = "LEADER",       action = wezterm.action { ActivateTab = 3 } },
              { key = "5", mods = "LEADER",       action = wezterm.action { ActivateTab = 4 } },
              { key = "6", mods = "LEADER",       action = wezterm.action { ActivateTab = 5 } },
              { key = "7", mods = "LEADER",       action = wezterm.action { ActivateTab = 6 } },
              { key = "8", mods = "LEADER",       action = wezterm.action { ActivateTab = 8 } },
              { key = "9", mods = "LEADER",       action = wezterm.action { ActivateTab = 8 } },
              { key = "&", mods = "LEADER|SHIFT", action = wezterm.action { CloseCurrentTab = { confirm = true } } },
              { key = "x", mods = "LEADER",       action = wezterm.action { CloseCurrentPane = { confirm = true } } },
          },
          webgpu_preferred_adapter = gpus[1],
          native_macos_fullscreen_mode = true,
          front_end = "WebGpu",
          webgpu_power_preference = "HighPerformance",
          max_fps = 120,
      }
    '';
  };
  programs.pandoc = {
    enable = true;
  };

  programs.matplotlib = {
    enable = true;
  };
  programs.ripgrep = {
    enable = true;
  };
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    plugins = {
      Miller = pkgs.fetchFromGitHub {
        owner = "Reledia";
        repo = "miller.yazi";
        rev = "40e0265";
        sha256 = "GXZZ/vI52rSw573hoMmspnuzFoBXDLcA0fqjF76CdnY=";
      };
    };
    settings = {
      manager = {
        ratio = [
          0
          4
          3
        ];
      };
      preview = {
        image_delay = 0;
      };
      plugin = {
        plugin_previewers = {
          mime = "text/csv";
          run = "miller";
        };
      };
    };
  };

  programs.mbsync = {
    enable = true;
  };

  programs.msmtp = {
    enable = true;
  };

  programs.mu = {
    enable = true;
  };

  accounts.email = {
    maildirBasePath = ".local/share/mail";
    accounts = {
      "leoaparisi@gmail.com" = {
        passwordCommand = "pass leoaparisi@gmail.com";
        primary = true;
        realName = "Leo Aparisi de Lannoy";
        address = "leoaparisi@gmail.com";
        flavor = "gmail.com";
        imap.host = "imap.gmail.com";
        imap.port = 993;
        maildir.path = "leoaparisi@gmail.com";
        folders = {
          inbox = "INBOX";
        };
        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          patterns = [ "*" ];
        };
        mu.enable = true;
        msmtp.enable = true;
        smtp = {
          host = "smtp.gmail.com";
          port = 465;
        };
      };
    };
  };

  programs.htop = {
    enable = true;
  };

  programs.fd = {
    enable = true;
  };

  programs.sioyek = {
    enable = true;
    package = stable.sioyek;
    bindings = {
      "move_up" = "k";
      "move_down" = "j";
      "move_left" = "h";
      "move_right" = "l";
      "screen_down" = [
        "d"
        "<C-d>"
      ];
      "screen_up" = [
        "u"
        "<C-u>"
      ];
    };
  };

  programs.zathura = {
    enable = true;
  };

  programs.tmux = {
    enable = true;
  };

  programs.eza = {
    enable = true;
  };

  programs.lesspipe = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtlSsh = 36000000;
    pinentryPackage = pkgs.pinentry_mac;
    extraConfig = ''
      allow-preset-passphrase
      pinentry-timeout 36000000
    '';
  };

  programs.yt-dlp = {
    enable = true;
  };

  services.syncthing = {
    enable = true;
  };

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "egehpkpgpgooebopjihjmnpejnjafefi"; } # better history
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
      { id = "cofdbpoegempjloogbagkncekinflcnj"; } # deepl
      { id = "lcfdefmogcogicollfebhgjiiakbjdje"; } # disable ext
      { id = "phaodiidhofhdmfkjiacigibgikhfafn"; } # qudelix
      { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # sponsorblock
      { id = "ekhagklcjbdpajgpjgmbionohlpdbjgc"; } # zotero
      { id = "kglhbbefdnlheedjiejgomgmfplipfeb"; } # jitsi
      { id = "mafpmfcccpbjnhfhjnllmmalhifmlcie"; } # snowflake
    ];
  };

}

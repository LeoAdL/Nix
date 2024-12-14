{ config, pkgs, ... }:

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
      osd-bar = "yes"; # Do not remove/comment if mpv_thumbnail_script_client_osc.lua is being used.
      osd-font = "Lato"; # Set a font for OSC
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
      hwdec = "auto-copy-safe"; # enable hardware decoding, defaults to 'no'

      ###### Debanding
      deband = "yes";

      ###### Interpolation
      video-sync = "display-resample";
      interpolation = "yes";

    };
    scripts = with pkgs.mpvScripts; [
      thumbfast
      modernz
    ];
  };
  programs.bat = {
    enable = true;
    themes = {
      catppuccin = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat"; # Bat uses sublime syntax for its themes
          rev = "d2bbee4f7e7d5bac63c054e4d8eca57954b31471";
          sha256 = "x1yqPCWuoBSx/cI94eA+AWwhiSA42cLNUOFJl7qjhmw=";
        };
        file = "Catppuccin-mocha.tmTheme";
      };
    };
  };
  programs.khard = {
    enable = true;
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
}

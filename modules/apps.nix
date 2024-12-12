{ pkgs, ... }:
{

  ##########################################################################
  #
  #  Install all apps and packages here.
  #
  #  NOTE: Your can find all available options in:
  #    https://daiderd.com/nix-darwin/manual/index.html
  #
  # TODO Fell free to modify this file to fit your needs.
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    git
    zstd
    antidote
    neovim
    wezterm
    fzf
    dua
    fd
    ffmpeg
    khard
    diff-so-fancy
    lazygit
    zathura
    tmux
    tidal-dl
    bat
    eza
    lesspipe
    brave
    pandoc
    ripgrep
    ripgrep-all
    wireguard-go
    yazi
    iina
    yt-dlp
    syncthing
    isync
    msmtp
    nil
    nixfmt-rfc-style

    feishin
    element-desktop
    skimpdf
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    lato
  ];

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  #
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      # cleanup = "zap";
    };

    taps = [
      "homebrew/services"
      "FelixKratz/formulae"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      {
        name = "sketchybar";
        restart_service = true;
      }
      "switchaudio-osx"
      "nowplaying-cli"
      "lua"
      "coreutils"

      # "aria2"  # download tool
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      "sf-symbols"
      "font-sf-pro"
      "font-sf-mono"
      "bitwarden"
      "raycast"
      "jellyfin-media-player"
      # "google-chrome"
    ];
  };
}

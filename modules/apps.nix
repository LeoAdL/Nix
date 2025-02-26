{
  pkgs,
  stable,
  ...
}:
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
  # nixpkgs.overlays = [
  #   (self: super: {
  #     vvenc = super.vvenc.overrideAttrs (previousAttrs: {
  #       src = pkgs.fetchFromGitHub {
  #         owner = "fraunhoferhhi";
  #         repo = "vvenc";
  #         rev = "c305325e7a7e22f337f3abd03e43508a42ae87b7";
  #         sha256 = "sha256-Et/JmF/2hh6A1EsOzvgzruMN47rd5cPgRke3uPvz298=";
  #       };
  #     });
  #   })
  # ];

  environment.systemPackages = with pkgs; [
    git
    zstd
    neovim
    dua
    ffmpeg
    tidal-dl
    ripgrep-all
    wget
    (aspellWithDicts (dicts: with dicts; [ en en-computers en-science fr es]))
    wireguard-go
    nil
    nixfmt-rfc-style

    # feishin
    pass
    kitty
    neofetch

    coreutils

    restic
    rsync
    rclone
    hugo
    go

    vale
    imagemagick
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
      autoUpdate = true;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";

    };

    masApps = {
      Bitwarden = 1352778147;
      Wireguard = 1451685025;
    };
    taps = [
      "homebrew/services"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      "switchaudio-osx"
      "ltex-ls-plus"
      "tcl-tk"
      "pyenv"
      "gpg"
      "npm"
      "mas"
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      "font-sf-pro"
      "font-sf-mono"
      "jellyfin-media-player"
      "tidal"
      "ghostty"
      "mactex-no-gui"
      "hammerspoon"
      "skim"
      "raycast"
      "element"
      "brave-browser"
      "qbittorrent"
    ];
  };
}

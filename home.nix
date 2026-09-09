{ config, pkgs, ...}:

{
  home.username = "nero";
  home.homeDirectory = "/home/nero";
  home.stateVersion = "26.05";
    
  # Avoid channel mismatch errors
  home.enableNixpkgsReleaseCheck = false;
  
  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    # Prevents Steam XWayland crispness issues
    GDK_SCALE = "1";
    NIXOS_OZONE_WL = "1";
  };

  home.pointerCursor = {
    enable = true; # Explicitly enables cursor configuration generation
    gtk.enable = true;
    x11.enable = true;
    name = "Adwaita";
    size = 24;
    package = pkgs.adwaita-icon-theme;
  };

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  programs.bash = {
    enable = true;
    shellAliases = {
# eza aliases below:
      ls = "eza -la --icons --group-directories-first";
      la = "eza -la --icons --group-directories-first";
      llm = "eza -l --sort=modified --icons --group-directories-first";
      lt = "eza --tree --icons --group-directories-first";
      nrs  = "sudo nixos-rebuild switch -I nixosconfig=$HOME/nixos-dotfiles/configuration.nix";
      nrsu = "sudo nixos-rebuild switch -I nixosconfig=$HOME/nixos-dotfiles/configuration.nix --upgrade";
      hms  = "home-manager switch";
    };
  };
  
  # normal symlinks
  xdg.configFile."mako/config".source = ./mako/config;
  xdg.configFile."wofi/style.css".source = ./wofi/style.css;
  xdg.configFile."tmux/tmux.conf".source = ./tmux/tmux.conf;
  xdg.configFile."dolphinrc" = {
      source = ./dolphin/dolphinrc;
      force = true;
    };

  # OUT OF STORE SYMLINKS
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/nvim";
  home.file.".config/btop".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/btop";
  home.file.".config/ghostty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/ghostty";
  home.file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/hypr";
  home.file.".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/waybar";
  # REMOVED: wayland.windowManager.hyprland
  # (Your system-level programs.hyprland.enable in configuration.nix already installs Hyprland.
  # Removing it here prevents Home Manager from injecting .luarc.json into your symlinked hypr directory.)

  home.packages = with pkgs; [
    # Apps and TUIs
    discord
    lazygit
    lazydocker

    # Hypr Ecosystem
    waybar
    ghostty
    eza
    hyprpaper
    wofi
    mako
    grim
    slurp
    wl-clipboard
    brightnessctl
    pavucontrol
    btop
    bat
    libnotify
    fastfetch
    
    # LazyVim tooling
    gcc
    gnumake
    unzip
    wget
    curl
    ripgrep
    fd
    
    nerd-fonts.jetbrains-mono
  ];


  # Home Manager CleanUp
  nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
}

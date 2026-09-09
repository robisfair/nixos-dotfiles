{ config, pkgs, ...}:

{
  home.username = "nero";
  home.homeDirectory = "/home/nero";
  home.stateVersion = "26.05";
    
  # Avoid channel mismatch errors
  home.enableNixpkgsReleaseCheck = false;

  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = ''echo "this isn't arch btw"'';
      nrs = "sudo nixos-rebuild switch";
      nrsu = "sudo nixos-rebuild switch --upgrade";
    };
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
    waybar
    ghostty
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
      frequency = "weekly";
      options = "--delete-older-than 7d";
    };

  # Git configuration
  programs.git = {
      enable = true;
      userName = "robisfair";
      userEmail = "neroticforcode@gmail.com";
    };
}

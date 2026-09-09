{ config, lib, pkgs, ... }:

{
	imports = [
		./hardware-configuration.nix
	];
  

# unfree packages!
  nixpkgs.config.allowUnfree = true;

	# Bootloader
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "notarchbtw";
	networking.networkmanager.enable = true;

	time.timeZone = "America/Chicago";

	# Hyprland
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};

	services.greetd = {
		enable = true;
		settings = {
			default_session = {
				command = "${pkgs.hyprland}/bin/start-hyprland";
				user = "nero";
			};
		};
	};

	# Audio + Services
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		pulse.enable = true;
	};
	security.rtkit.enable = true;
	security.polkit.enable = true;

  services.flatpak.enable = true;

	xdg.portal = {
		enable = true;
		extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
	};

	# My User Account
	users.users.nero = {
		isNormalUser = true;
		extraGroups = [ "wheel" "docker" ];
		packages = with pkgs; [
			tree
		];
	};

	# Steam Configuration
	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true;
	};

	# Container Engines
	virtualisation.docker.enable = true;
	virtualisation.podman = {
		enable = true;
		dockerCompat = false;
	};

	# System Utils and Programs
	programs.firefox.enable = true;

	programs.nix-ld.enable = true;
	programs.nix-ld.libraries = with pkgs; [
		stdenv.cc.cc
		zlib
	];

	############################
	# Environment Packages
	############################

	environment.systemPackages = with pkgs; [
		vim
		ghostty
		kitty
		waybar
		git
		kdePackages.dolphin
		hyprpaper
		neovim
		wget
		tmux
		home-manager
	];

	# Garbage Collection
	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 7d";
	};
	nix.settings.auto-optimise-store = true;

	system.stateVersion = "25.05";
}

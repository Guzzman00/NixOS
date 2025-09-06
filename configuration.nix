# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
    
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking.
  networking.networkmanager.enable = true;

  # Enable network manager applet.
  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "America/Santiago";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_MX.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_CL.UTF-8";
    LC_IDENTIFICATION = "es_CL.UTF-8";
    LC_MEASUREMENT = "es_CL.UTF-8";
    LC_MONETARY = "es_CL.UTF-8";
    LC_NAME = "es_CL.UTF-8";
    LC_NUMERIC = "es_CL.UTF-8";
    LC_PAPER = "es_CL.UTF-8";
    LC_TELEPHONE = "es_CL.UTF-8";
    LC_TIME = "es_CL.UTF-8";
  };

  # Enable Flatpak package manager.
  services.flatpak.enable = true;

  # Enable the KDE Plasma  Desktop Environment.
  services.desktopManager.plasma6.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11.
  services.xserver.xkb = {
    layout = "latam";
    variant = "";
  };

  # Configure hash in X11.
  programs.bash.interactiveShellInit = ''
      set -h
    '';

  # Configuración de bajo nivel para el servidor gráfico Xorg.
    services.xserver.extraConfig = ''
      # 1. El monitor principal: HDMI-1 (encendido y primario).
      Section "Monitor"
          Identifier "HDMI-1"  
          Option "Primary" "true"
          Option "Enable" "true"
      EndSection
    
      # 2. El monitor secundario: VGA-1 (apagado).
      Section "Monitor"
          Identifier "VGA-1"
          Option "Enable" "false"
      EndSection
    
      # 3. La pantalla del laptop: LVDS-1 (apagada).
      Section "Monitor"
          Identifier "LVDS-1"
          Option "Enable" "false"
      EndSection
    '';

  # Configure console keymap.
  console.keyMap = "es";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.guzmen = {
    isNormalUser = true;
    description = "guzmen";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Install Steam.
  programs.steam.enable = true;

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget.
  environment.systemPackages = with pkgs; [
     pkgs.neofetch
     pkgs.btop
     pkgs.wget
     pkgs.corefonts
     pkgs.micro
     pkgs.xpad
     pkgs.ark
     pkgs.qpdfview
     pkgs.google-chrome
     pkgs.thunderbird
     pkgs.discord
     pkgs.jetbrains-toolbox
     pkgs.onlyoffice-bin
     pkgs.git
     pkgs.foliate
     pkgs.handbrake
     pkgs.obs-studio
     pkgs.vlc
     pkgs.caligula
     pkgs.steam
     pkgs.podman
     #vim #The Micro editor is also installed by default.
  ];
  
  # Packages Configurations.
  
  # JetBrains Toolbox.
      environment.sessionVariables = {
        PATH = "$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH";
      };
  
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}

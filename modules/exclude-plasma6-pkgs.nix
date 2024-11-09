{ pkgs, ... }:

{
  ## Remove unuse pkg, service on NixOS Gnome
  environment.plasma6.excludePackages = (with pkgs; [
    kdePackages.konsole
    # kdePackages.kate
    # kdePackages.kwrited
    #

    # kdePackages.spectacle

  ]);

}


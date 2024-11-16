# configuration.nix
{ ... }:
{

  environment.systemPackages =
    let
      winapps =
        (import (builtins.fetchTarball "https://github.com/winapps-org/winapps/archive/main.tar.gz"));
    in
    [
      winapps.winapps
      winapps.winapps-launcher # optional
    ];
}


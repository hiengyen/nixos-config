{ pkgs, ... }:
{
  # services.mongodb.enable = true;
  # services.mongodb.package = pkgs.mongodb-ce;

  # Configuration mongodb
  services.mongodb = {
    enable = true;
    package = pkgs.mongodb-ce;
    # enableAuth = true;
    # initialRootPassword = "YourSecurePassword";
    # bind_ip = "10.5.0.2";
  };


}

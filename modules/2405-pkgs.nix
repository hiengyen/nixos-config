let
  nixpkgs2405 = import <nixpkgs2405> { config = { allowUnfree = true; }; };
in
{
  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with nixpkgs2405.ibus-engines; [
      bamboo
    ];
  };


}


{ lib, ... }:
let
  PortoWeatherLocation =
    with lib.hm.gvariant;
    (mkVariant (mkTuple [
      (mkUint32 2)
      (mkVariant (mkTuple [
        "Porto"
        "LPPR"
        true
        [
          (mkTuple [
            (0.7196574224212311)
            (-0.15155275089707676)
          ])
        ]
        [
          (mkTuple [
            (0.7182029871956666)
            (-0.15038920969794223)
          ])
        ]
      ]))
    ]));
in
{
  dconf.settings = {
    # This is the weather app
    "org/gnome/Weather" = {
      locations = [ PortoWeatherLocation ];
    };

    # This is the one that appears in the gnome interface
    "org/gnome/shell/weather" = {
      locations = [ PortoWeatherLocation ];
    };

    # Forces to use the metric system for temperatures
    "org/gnome/GWeather4" = {
      temperature-unit = "centigrade";
    };
  };
}

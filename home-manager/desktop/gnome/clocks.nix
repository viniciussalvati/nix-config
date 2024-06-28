{ lib, ... }:
let
  SaoPauloWorldClock =
    with lib.hm.gvariant;
    (mkVariant (mkTuple [
      (mkUint32 2)
      (mkVariant (mkTuple [
        "São Paulo"
        "SBMT"
        true
        [
          (mkTuple [
            (-0.41044326824509736)
            (-0.8139052020289248)
          ])
        ]
        [
          (mkTuple [
            (-0.4107341448182347)
            (-0.8136143254557875)
          ])
        ]
      ]))
    ]));
in
{
  dconf.settings = {
    # This is the clocks app
    "org/gnome/clocks" = {
      world-clocks = [
        ([
          (lib.hm.gvariant.mkDictionaryEntry [
            "location"
            SaoPauloWorldClock
          ])
        ])
      ];
    };

    # This is the one that appears in the gnome interface
    "org/gnome/shell/world-clocks" = {
      locations = [ SaoPauloWorldClock ];
    };
  };
}

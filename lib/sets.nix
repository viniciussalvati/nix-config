{ lib, ... }:
{
  /*
    Recursively merge a list of attrsets into a single attrset.

    nix-repl> deepMerge [ { a = "foo"; } { b = "bar"; } ];
    { a = "foo"; b = "bar"; }
    nix-repl> deepMerge [ { a.b = "foo"; } { a.c = "bar"; } ]
    { a = { b = "foo"; c = "bar"; }; }
  */
  deepMerge = builtins.foldl' lib.recursiveUpdate { };
}

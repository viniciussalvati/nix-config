{ config, ... }:
{
  environment.systemPackages = config.settings.packages;
}

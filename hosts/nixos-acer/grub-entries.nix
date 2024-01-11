{ ... }:
{
  # Grub entry to boot Windows
  boot.loader.grub.extraEntries = ''
    menuentry 'Windows Boot Manager (on /dev/sda1)' --class windows --class os $menuentry_id_option 'osprober-efi-463D-C79B' {
      insmod part_gpt
      insmod fat
      set root='hd0,gpt1'
      if [ x$feature_platform_search_hint = xy ]; then
        search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt1 --hint-efi=hd0,gpt1 --hint-baremetal=ahci0,gpt1  463D-C79B
      else
        search --no-floppy --fs-uuid --set=root 463D-C79B
      fi
      chainloader /efi/Microsoft/Boot/bootmgfw.efi
    }
  '';
}

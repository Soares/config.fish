function nixos-rebuild --wraps nixos-rebuild
  set fwUpdatesPath /boot/EFI/nixos/fw

  # Delete fw dir to prevent issues with nixos-rebuild command
  if test -d $fwUpdatesPath
    rm -rf $fwUpdatesPath
  end

  # Add channels if not added
  if test ! -L ~/.nix-defexpr/channels_root/nixos
    echo \n"Adding nixos-19.03 channel as nixos ..."
    sudo nix-channel --add https://nixos.org/channels/nixos-19.03 nixos
    sudo nix-channel --update nixos
  end
  if test ! -L ~/.nix-defexpr/channels_root/nixos-hardware
    echo \n"Adding nixos-hardware channel ..."
    sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
    sudo nix-channel --update nixos-hardware
  end

  # Add all-hies binary cache if not installed
  if test ! -f /etc/nixos/cachix/all-hies.nix
    echo \n"Cachix for all-hies not setup, setting up now ..."
    sudo cachix use all-hies
  end

  command sudo nixos-rebuild $argv
end

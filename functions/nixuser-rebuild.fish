function nixuser-rebuild
  # Add unstable channel if not present
  if test ! -d ~/.nix-defexpr/channels/unstable
    echo \n"Unstable channel not present, adding ..."\n

    if test -f /etc/nixos/configuration.nix
      nix-channel --add https://nixos.org/channels/nixos-unstable unstable
    else
      nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
    end

    nix-channel --update
  end

  if test "$argv[1]" = '--update'
    nix-channel --update
  end

  # Install correct environment based on OS
  if test (uname) = "Darwin"
    nix-env -riA nixpkgs.myMacosEnv
    nixuser-simlink-apps
  else if test -f /etc/nixos/configuration.nix
    nix-env -riA nixos.myNixosEnv
  else
    nix-env -riA nixpkgs.myLinuxEnv
  end
end

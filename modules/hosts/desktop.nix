{inputs, self, ...}: {
    flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
        modules = [
            self.nixosModules.desktop-hardware
            self.nixosModules.basic-settings
            self.nixosModules.hyprland
            self.nixosModules.terminal
            self.nixosModules.gaming
            self.nixosModules.neovim
            self.nixosModules.kanata
        ];
    };

    flake.nixosModules.desktop-hardware = { lib, pkgs, ... }: {
        boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "thunderbolt" "usb_storage" "usbhid" "sd_mod" ];
        boot.kernelModules = [ "kvm-amd" ];
        boot.extraModulePackages = [ ];

        fileSystems."/" =
            { device = "/dev/disk/by-uuid/72742c2f-877e-4eb9-b122-f4c930b36e1f";
                fsType = "ext4";
            };

        fileSystems."/boot/efi" =
            { device = "/dev/disk/by-uuid/D02E-F1D9";
                fsType = "vfat";
                options = [ "fmask=0077" "dmask=0077" ];
            };

        fileSystems."/media/Drive2" = {
            device = "/dev/disk/by-uuid/16357b1b-cb17-424a-ab2e-459bfd7dbe98";
            fsType = "ext4";
        };

        swapDevices =
            [ { device = "/dev/disk/by-uuid/514a8d96-aa2a-4eb7-8268-0be6bd408b07"; }
            ];

        # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
        # (the default) this is the recommended approach. When using systemd-networkd it's
        # still possible to use this option, but it's recommended to use it in conjunction
        # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
        networking.useDHCP = lib.mkDefault true;
        # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;

        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.amd.updateMicrocode = true;

        hardware.graphics.enable = true;
        hardware.graphics.enable32Bit = true;
        services.xserver.videoDrivers = [ "amdgpu" ];
        hardware.graphics.extraPackages = with pkgs; [ rocmPackages.clr.icd ];

        services.hardware.openrgb = {
            enable = true;
            package = pkgs.openrgb-with-all-plugins;
            motherboard = "amd";
            server.port = 6742;
        };
    };
}

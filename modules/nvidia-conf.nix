{pkgs, config, ...}:
{

    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;

    boot.kernelParams = [
      "nvida.NVreg_EnableGpuFirmware=0"
    ];

    services.xserver.videoDrivers = ["nvidia"];

    environment.systemPackages = with pkgs; [
        vulkan-tools
    ];

    hardware.nvidia = {
        modesetting.enable = true;

        powerManagement.enable = false;
        powerManagement.finegrained = false;

        open = true;

        nvidiaSettings = true;

        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
}

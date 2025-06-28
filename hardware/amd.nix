{pkgs, config, ...}:
{

    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;

    boot.kernelParams = [ ];

    services.xserver.videoDrivers = ["amdgpu"];

    environment.systemPackages = with pkgs; [
        vulkan-tools
        clinfo
    ];

    hardware.graphics.extraPackages = with pkgs; [
        rocmPackages.clr.icd
    ];

}

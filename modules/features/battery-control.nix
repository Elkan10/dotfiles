{...}: {
    flake.nixosModules.battery-control = {...}: {
        services.tuned.enable = true;
        services.upower.enable = true;
    };
}

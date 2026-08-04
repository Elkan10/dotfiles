{lib, ...}: {
    # To merge flake.lib across files
    options.flake.lib = lib.mkOption {
        type = lib.types.lazyAttrsOf lib.types.raw;
        default = { };
    };
}

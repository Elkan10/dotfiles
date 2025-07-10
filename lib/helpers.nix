{lib}: {
  mkListOption = namespace: name: pkg: description: {
    option = lib.mkEnableOption description;
    package = pkg;
    name = name;
    namespace = namespace;
    traceOption = builtins.trace "Option created for ${namespace}.${name}: ${description}" name;  
  };

  mkOptions = packages:
    lib.foldl' (a: b: lib.recursiveUpdate a b) {} (map (opt: {
      ${opt.namespace}.${opt.name}.enable = opt.option;
    }) packages);

  mkList = packages: config: builtins.filter (pkg: pkg != null)
    (map (opt: if (
          lib.attrsets.hasAttrByPath [opt.namespace opt.name "enable"] config &&
          lib.attrsets.getAttrFromPath [opt.namespace opt.name "enable"] config
        )
          then opt.package
          else null
        )
    packages);
}

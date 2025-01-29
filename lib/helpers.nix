{lib}: {
  mkListOption = config: namespace: name: pkg: description: {
    option = lib.mkEnableOption description;
    package = lib.lists.optional (
        lib.attrsets.hasAttrByPath [namespace name "enable"] config &&
        lib.attrsets.getAttrFromPath [namespace name "enable"] config
    ) pkg;
    name = name;
    namespace = namespace;
    traceOption = builtins.trace "Option created for ${namespace}.${name}: ${description}" name;  
  };

  mkOptions = packages:
    lib.foldl' (a: b: lib.recursiveUpdate a b) {} (map (opt: {
      ${opt.namespace}.${opt.name}.enable = opt.option;
    }) packages);

  mkList = packages: builtins.concatMap (opt: opt.package) packages;
}

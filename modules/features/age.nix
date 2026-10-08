{self, inputs, ...}: {
    flake.nixosModules.age = {...}: {
        imports = [
            inputs.agenix.nixosModules.default
        ];
        
        age.identityPaths = [
            "/home/elvis/.ssh/id_ed25519"
        ];

        age.secrets.pumpkin-mc.file = ../../secrets/pumpkin-mc.age;
    };
}

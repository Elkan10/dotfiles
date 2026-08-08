{...}: {
    flake.nixosModules.ssh-server = {
        services.openssh = {
            enable = true;
            openFirewall = true;
            settings = {
                PasswordAuthentication = false;
                KbdInteractiveAuthentication = false;
                PermitRootLogin = "no";
                AllowUsers = [ "elvis" ];
                MaxAuthTries = 3;
                PerSourcePenalties = "crash:3600s authfail:3600s max:86400s";
            };
        };

        users.users."elvis".openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKQ9Reea9M197dhxIJ9tQnunzYNYyIKd1prcDf0avwcv elvis@desktop"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICo8n/jVxZrGBadpio6XJHiFJSBk/yops2Qk6S35e2rg elvis@laptop"
        ];
    };
}

let
    desktop-key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKQ9Reea9M197dhxIJ9tQnunzYNYyIKd1prcDf0avwcv";
in {
    "pumpkin-mc.age".publicKeys = [ desktop-key ];
}

{...}: {
    flake.nixosModules.kanata = {
        services.kanata = {
            enable = true;
            keyboards.main = {
                extraDefCfg = "process-unmapped-keys yes";
                config = ''
                    (defsrc
                       caps
                    )
                    (deflayer base
                        @sym
                    )
                    (defalias sym (tap-hold 200 200 esc (layer-while-held symbols)))
                    (deflayermap (symbols)
                        q (unicode r#"""#)
                        a (unicode ')
                        r (unicode "(")
                        f (unicode "[")
                        v (unicode "{")
                        y (unicode ")")
                        h (unicode "]")
                        n (unicode "}")
                    )
                '';
            };
        };
    };
}

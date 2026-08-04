{self, inputs, lib, ...}: { 
    flake.lib = {
        template = {pkgs, name, path, vars}:  
                pkgs.runCommand "${name}-cfg" ({
                    src = path;
                } // vars)
                ''
                    mkdir -p $out/${name}
                    cp -r $src/. $out/${name}
                    chmod -R +w $out
                    for f in $(find $out -type f); do
                        substituteAllInPlace $f 
                    done
                '';
    };
}

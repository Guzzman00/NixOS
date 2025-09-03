# shell.nix

{ }:

let
    # Pin para Scala 2.13.8
    scala_2_13_8 = pkgs.stdenv.mkDerivation {
      pname = "scala-bin";
      version = "2.13.8";
    
      src = pkgs.fetchurl {
        url = "https://github.com/scala/scala/releases/download/v2.13.8/scala-2.13.8.tgz";
        sha256 = "LLMdhGnGUYOfDpyDehqwZVDQMXJnUvVJBr4bneATFM8=";
      };

      installPhase = ''
        mkdir -p $out/bin $out/lib $out/share/man/man1
        cp -r lib/* $out/lib/
        cp -r bin/* $out/bin/
        cp -r man/man1/* $out/share/man/man1/
      '';
    };
    
    # Pin para Java (Zulu17, Temurin8, Zulu8, Zulu11, Zulu21)
    pkgs = import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/refs/heads/nixos-2.05.tar.gz";
      sha256 = "0zydsqiaz8qi4zd63zsb2gij2p614cgkcaisnk11wjy3nmiq0x1s";
    }) {};
  
    # Pin para Cargo 1.85.0
    pkgs_cargo = import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/88e992074d86ad50249de12b7fb8dbaadf8dc0c5.tar.gz";
      sha256 = "1k5iv13faiyar5bsfw5klaz898662kcfyn85w5jrl2qkavf6y0y7";
    }) {};
  
    # Pin para NodeJS 22.14.0
    pkgs_nodejs = import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/6ad174a6dc07c7742fc64005265addf87ad08615.tar.gz";
      sha256 = "02xrcfn2agd8zcwx0slckl3f1r0x64fjyzhlrrfxswdrq987vcxs"; 
    }) {};
  
    # Pin para Deno 2.2.3
    pkgs_deno = import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/573c650e8a14b2faa0041645ab18aed7e60f0c9a.tar.gz";
      sha256 = "0qg99zj0gb0pc6sjlkmwhk1c1xz14qxmk6gamgfmcxpsfdp5vn72";
    }) {};
  
    # Pin para JDK15
    pkgs_jdk15 = import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/dce8fc727dc2891628e4f878bb18af643b7b255d.tar.gz";
      sha256 = "01c300hi7gfia0548xqm07995vzp6g3k171vyk2bnvh2jm1s0q5p"; 
    }) {};
    
    # Pin para Zulu24
    pkgs_zulu24 = import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/a421ac6595024edcfbb1ef950a3712b89161c359.tar.gz";
      sha256 = "03m03cr0h2bfbnlz36pqzz83lgbvx48vmpzkiva1yi0s86ssyg9p"; 
    }) {};
in

# El bloque 0 define el entorno base
pkgs.mkShell {
  buildInputs = [
    scala_2_13_8
    pkgs.zulu17
    pkgs_cargo.cargo
    pkgs_nodejs.nodejs 
    pkgs_deno.deno
    pkgs.sbt
    pkgs.maven
  ];

  shellHook = ''
    echo "--- Entorno-Base Activado ---"
    export JAVA_HOME=${pkgs.zulu17}
    export PATH=$JAVA_HOME/bin:$PATH
  '';

} // {

# El bloque 1 define el entorno-1
entorno-1 = pkgs.mkShell {
  buildInputs = [
    pkgs."temurin-bin-8"
    pkgs.zulu8
    pkgs.zulu11
    pkgs_jdk15.jdk15
    pkgs.zulu21   
    pkgs_zulu24.zulu24 
  ];
    
  shellHook = ''
    echo "--- Entorno-1 Activado ---"
    export TEMURIN8_HOME=${pkgs."temurin-bin-8"}
    export ZULU8_HOME=${pkgs.zulu8}
    export ZULU11_HOME=${pkgs.zulu11}
    export JDK15_HOME=${pkgs_jdk15.jdk15}
    export ZULU24_HOME=${pkgs_zulu24.zulu24}
  '';
    
  };
}

# flake.nix

{
  description = "Entornos de desarrollo con versiones de Python";

  inputs = {
    nixpkgs.url = "https://github.com/NixOS/nixpkgs/archive/refs/heads/nixos-23.11.tar.gz";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    # Pin para Python 3.8.10
    python3_8_10 = pkgs.python38.overrideAttrs (oldAttrs: {
      version = "3.8.10";
      src = pkgs.fetchurl {
        url = "https://www.python.org/ftp/python/3.8.10/Python-3.8.10.tgz";
        hash = "sha256-s3rHTSy60lkOfNDdKzgmwpr+iac0CQqHv4wDxFBmy2U=";
      };
    }); 

    # Pin para Python 3.11.2
    python3_11_2 = pkgs.python311.overrideAttrs (oldAttrs: { 
      version = "3.11.2";
      src = pkgs.fetchurl {
        url = "https://www.python.org/ftp/python/3.11.2/Python-3.11.2.tgz";
        hash = "sha256-JBHHS9pbvPzdr0Ux9m0a3HPyR/UprumBsClROu/b+Ek=";
      };
    });
    
    # Pin para Python 3.11.5
    python3_11_5 = pkgs.python311.overrideAttrs (oldAttrs: {
      version = "3.11.5";
      src = pkgs.fetchurl {
        url = "https://www.python.org/ftp/python/3.11.5/Python-3.11.5.tgz";
        hash = "sha256-oSoKATowuEbHhsAQ8sGd02tymNiI98S9FYHZDOGLXlg=";
      };
    });

    # Pin para Python 3.10.9
    python3_10_9 = pkgs.python310.overrideAttrs (oldAttrs: {
      version = "3.10.9";
      src = pkgs.fetchurl {
        url = "https://www.python.org/ftp/python/3.10.9/Python-3.10.9.tgz";
        hash = "sha256-TM1+RsiJj0x4YpEKFwOqDmNSWROlGauy9V4mIgqRTYg=";
      };
    });
    
  in {
    devShells.${system} = {

      # El bloque 0 define el entorno por defecto
      default = pkgs.mkShell {
        buildInputs = [
          python3_8_10
          python3_11_2
          python3_11_5
        ];
        shellHook = ''
          echo "--- Entorno-Por-Defecto Activado ---"
          export PYTHON3_8_HOME=${python3_8_10}
          export PYTHON3_11_2_HOME=${python3_11_2}
          export PYTHON3_11_5_HOME=${python3_11_5}
          export PYTHON_HOME=${python3_11_5}
          export PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PYTHON_HOME/bin:$PATH"
        '';
      };

      # El bloque 1 define el entorno legacy
      legacy = pkgs.mkShell {
        buildInputs = [
          python3_10_9
        ];
        shellHook = ''
          echo "--- Entorno-Legacy Activado ---"
          export PYTHON3_10_9_HOME=${python3_10_9}
          export PYTHON_HOME=${python3_10_9}
          export PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PYTHON_HOME/bin:$PATH"
        '';
      };
    };
  };
}

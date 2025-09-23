# flake.nix

{
  description = "Entornos de desarrollo con versiones de Python";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    # Pin para Python 3.8.10
    python3_8_10 = pkgs.python38.override {
      version = "3.8.10";
      src = pkgs.fetchurl {
        url = "https://www.python.org/ftp/python/3.8.10/Python-3.8.10.tgz";
        hash = "sha256-yhb720182D+5dMvlxT4/CS232zms2pCr3sQ3kYlFq2M=";
      };
    };

    # Pin para Python 3.11.2
    python3_11_2 = pkgs.python311.override {
      version = "3.11.2";
      src = pkgs.fetchurl {
        url = "https://www.python.org/ftp/python/3.11.2/Python-3.11.2.tgz";
        hash = "sha256-u6yV+k1bs0GWPSaIys2W0U5QYj9f2jpxs1wgfH+sE1w=";
      };
    };

    # Pin para Python 3.11.5
    python3_11_5 = pkgs.python311.override {
      version = "3.11.5";
      src = pkgs.fetchurl {
        url = "https://www.python.org/ftp/python/3.11.5/Python-3.11.5.tgz";
        hash = "sha256-4OqjYFGlXH22aOksjOK3CSZ6UcN+dC/j227zx0JjYek=";
      };
    };

    # Pin para Python 3.10.9
    python3_10_9 = pkgs.python310.override {
      version = "3.10.9";
      src = pkgs.fetchurl {
        url = "https://www.python.org/ftp/python/3.10.9/Python-3.10.9.tgz";
        hash = "sha256-T2E0ba2kIZbDh3N2KKof2+a8wA+3t6r2yDUs7u/zU2A=";
      };
    };
    
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
          echo "--- Entorno-Base Activado ---"
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
          echo "--- Entorno-1 Activado ---"
          export PYTHON3_10_9_HOME=${python3_10_9}
          export PYTHON_HOME=${python3_10_9}
          export PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PYTHON_HOME/bin:$PATH"
        '';
      };
    };
  };
}

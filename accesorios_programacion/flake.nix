# flake.nix

{
  description = "Entornos de desarrollo con versiones de Python fijadas (pinned)";

  inputs = {
    # La entrada principal de paquetes, análoga al primer 'pkgs' de tu shell.nix
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    # --- Definición de Paquetes de Python Personalizados ---
    # Este bloque es el equivalente a las definiciones 'pin' en tu shell.nix.
    # Aquí fijamos cada versión de Python que necesitamos.

    python3_8_10 = pkgs.python38.override {
      version = "3.8.10";
      src = pkgs.fetchurl {
        url = "https://www.python.org/ftp/python/3.8.10/Python-3.8.10.tgz";
        hash = "sha256-yhb720182D+5dMvlxT4/CS232zms2pCr3sQ3kYlFq2M=";
      };
    };

    python3_11_2 = pkgs.python311.override {
      version = "3.11.2";
      src = pkgs.fetchurl {
        url = "https://www.python.org/ftp/python/3.11.2/Python-3.11.2.tgz";
        hash = "sha256-u6yV+k1bs0GWPSaIys2W0U5QYj9f2jpxs1wgfH+sE1w=";
      };
    };

    python3_11_5 = pkgs.python311.override {
      version = "3.11.5";
      src = pkgs.fetchurl {
        url = "https://www.python.org/ftp/python/3.11.5/Python-3.11.5.tgz";
        hash = "sha256-4OqjYFGlXH22aOksjOK3CSZ6UcN+dC/j227zx0JjYek=";
      };
    };

    python3_10_9 = pkgs.python310.override {
      version = "3.10.9";
      src = pkgs.fetchurl {
        url = "https://www.python.org/ftp/python/3.10.9/Python-3.10.9.tgz";
        hash = "sha256-T2E0ba2kIZbDh3N2KKof2+a8wA+3t6r2yDUs7u/zU2A=";
      };
    };

  in {
    # La estructura de devShells es la forma estándar en Flakes
    # de definir múltiples entornos.
    devShells.${system} = {

      # --- ENTORNO BASE / POR DEFECTO ---
      # Equivalente al "bloque 0" de tu shell.nix
      default = pkgs.mkShell {
        buildInputs = [
          # Usamos los paquetes personalizados que definimos arriba
          python3_8_10
          python3_11_2
          python3_11_5
        ];
        shellHook = ''
          echo "✅ Entorno Python Base Cargado."
          echo "   Versiones disponibles: 3.8.10, 3.11.2, 3.11.5"
          echo "   Usa python3.8 y python3.11 para acceder a ellas."
        '';
      };

      # --- ENTORNO APARTE / LEGACY ---
      # Equivalente al "entorno-1" de tu shell.nix
      legacy = pkgs.mkShell {
        buildInputs = [
          python3_10_9
        ];
        shellHook = ''
          echo "✅ Entorno Python Legacy (3.10.9) Cargado."
        '';
      };
    };
  };
}

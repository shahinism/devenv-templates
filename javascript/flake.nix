{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = { self, nixpkgs, devenv, systems, ... } @ inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      devShells = forEachSystem
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
            nodejs-packages = with pkgs.nodePackages; [
              vscode-langservers-extracted
              typescript-language-server
              yarn
            ];
          in
          {
            default = devenv.lib.mkShell {
              inherit inputs pkgs;
              modules = [
                {
                  # https://devenv.sh/basics/
                  env = {
                    GREET = "🛠️ Let's hack 🧑🏻‍💻";
                  };

                  # https://devenv.sh/reference/options/
                  packages = with pkgs;
                    [] ++ nodejs-packages;

                  # https://devenv.sh/scripts/
                  scripts.hello.exec = "echo $GREET";

                  enterShell = ''
                    hello
                  '';

                  # https://devenv.sh/languages/
                  languages.javascript = {
                    enable = true;
                  };

                  languages.typescript = {
                    enable = true;
                  };

                  # Make diffs fantastic
                  difftastic.enable = true;

                  # https://devenv.sh/pre-commit-hooks/
                  pre-commit.hooks = {
                    nixfmt.enable = true;
                    yamllint.enable = true;
                    editorconfig-checker.enable = true;
                    prettier.enable = true;
                  };

                  # Plugin configuration
                  pre-commit.settings = {
                    yamllint.relaxed = true;
                  };

                }
              ];
            };
          });
    };
}
{
  # TODO update me
  description = "Description for the project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
    nix2container.url = "github:nlewo/nix2container";
    nix2container.inputs.nixpkgs.follows = "nixpkgs";
    mk-shell-bin.url = "github:rrbutani/nix-mk-shell-bin";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
      ];
      systems = [ "x86_64-linux" "i686-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      perSystem = { config, self', inputs', pkgs, system, ... }:
        let
          nodejs-packages = with pkgs.nodePackages; [
            vscode-langservers-extracted
            typescript-language-server
            yarn
          ];
        in {
        # Per-system attributes can be defined here. The self' and inputs'
        # module parameters provide easy access to attributes of the same
        # system.
        devenv.shells.default = {
          # TODO update me
          name = "Name of the project";

          imports = [
            # This is just like the imports in devenv.nix.
            # See https://devenv.sh/guides/using-with-flake-parts/#import-a-devenv-module
            # ./devenv-foo.nix
          ];

          # https://devenv.sh/reference/options/
          packages = with pkgs;
            [] ++ nodejs-packages;

          # https://devenv.sh/basics/
          env = {
            GREET = "🛠️ Let's hack 🧑🏻‍💻";
          };

          # https://devenv.sh/scripts/
          scripts.hello.exec = "echo $GREET";

          enterShell = ''
            hello
          '';

          # https://devenv.sh/languages/
          languages.javascript.enable = true;
          languages.typescript.enable = true;

          # Make diffs fantastic
          difftastic.enable = true;

          # https://devenv.sh/pre-commit-hooks/
          pre-commit.hooks = {
            nixfmt.enable = true;
            yamllint.enable = true;
            editorconfig-checker.enable = true;
            prettier.enable = true;
          };

          # Plugin configuration
          pre-commit.settings = {
            yamllint.relaxed = true;
          };

        };

      };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.

      };
    };
}

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
      python-packages = p:
        with p; [
          pip
          python-lsp-server
          importmagic
          epc
          black
          mypy
        ];
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      devShells = forEachSystem
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
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
                    [
                      stdenv.cc.cc.lib # required by Jupyter
                      (python3.withPackages python-packages)
                    ];

                  # https://devenv.sh/scripts/
                  scripts.hello.exec = "echo $GREET";

                  enterShell = ''
                    hello
                  '';

                  # https://devenv.sh/languages/
                  languages.python = {
                    enable = true;
                    poetry = {
                      enable = true;
                      activate.enable = true;
                      install.enable = true;
                      install.allExtras = true;
                    };
                  };

                  # Make diffs fantastic
                  difftastic.enable = true;

                  # https://devenv.sh/pre-commit-hooks/
                  pre-commit.hooks = {
                    black.enable = true;
                    nixfmt.enable = true;
                    yamllint.enable = true;
                    pyright.enable = true;
                    editorconfig-checker.enable = true;
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

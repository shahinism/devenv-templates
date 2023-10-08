{
  description = "A set of very opinionated development environment configurations based on Nix!";

  outputs = { self, nixpkgs }: {
    templates = {
      python = {
        path = ./python;
        description = "Python development environment";
      };

      javascript = {
        path = ./javascript;
        description = "Javascript development environment";
      };

      terraform = {
        path = ./terraform;
        description = "Terraform development environment";
      };

      go = {
        path = ./go;
        description = "Go development environment";
      };

      rust = {
        path = ./rust;
        description = "Rust development environment";
      };
    };
  };
}

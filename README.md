# `devenv` Templates

This repository contains a collection of templates for setting up
basic project configurations using the `devenv` tool based on the Nix
ecosystem.

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [`devenv` Templates](#devenv-templates)
    - [Available Templates](#available-templates)
    - [Design Decisions](#design-decisions)
    - [Usage](#usage)
    - [Contributing](#contributing)

<!-- markdown-toc end -->

[![asciicast](https://asciinema.org/a/I6zXgwIEvYndWSK7iJvLNr7RR.svg)](https://asciinema.org/a/I6zXgwIEvYndWSK7iJvLNr7RR)


## Available Templates

Currently, the available templates are:

- Python

More templates will be added over time, based on personal
preferences. However, pull requests are more than welcome if you'd
like to contribute.

## Design Decisions

1. **Nix Flake Ecosystem**: The aim is to utilize the Nix flake
   ecosystem, centralizing as much configuration as possible in the
   `flake.nix`. This minimizes the number of config files that end up
   in the project.
2. **Guidance**: The `.editorconfig` file is used to set general
   coding rules to guide developers.
3. **Consistency**: For low-effort checks to maintain project
   consistency, mainstream linters are run on hooks.

## Usage

To use these templates, follow these steps:

1. Install `devenv`: Refer to the instructions at
   [devenv.sh/getting-started](https://devenv.sh/getting-started/).

2. Initialize your project:

   ```sh
   nix flake init --template github:shahinism/devenv-templates#python
   ```

   Replace `#python` with your desired template.

3. **Optional but Recommended**: To automatically enable the
   environment, install `direnv` and `nix-direnv`:

   - [direnv Guide](https://direnv.net/)
   - [nix-direnv Guide](https://github.com/nix-community/nix-direnv)

   Add the following to the `.envrc` file:

   ```sh
   if ! has nix_direnv_version || ! nix_direnv_version 2.2.1; then
     source_url "https://raw.githubusercontent.com/nix-community/nix-direnv/2.2.1/direnvrc" "sha256-zelF0vLbEl5uaqrfIzbgNzJWGmLzCmYAkInj/LNxvKs="
   fi

   nix_direnv_watch_file devenv.nix
   nix_direnv_watch_file devenv.lock
   if ! use flake . --impure
   then
     echo "devenv could not be built. The devenv environment was not loaded. Make the necessary changes to devenv.nix and hit enter to try again." >&2
   fi
   ```

## Tasks

- [ ] Add Nodejs template
- [ ] Add Terraform template
- [ ] Add Go Template
- [ ] Add Rust Template
- [ ] Make it modular to slice and dice and have multi-configuration
      environments also possible.

## Contributing

Pull requests are welcome! If you'd like to contribute a new template
or improve an existing one, please feel free to make a pull request.


# `devenv` Templates

This repository contains a collection of templates for setting up
basic project configurations using the [`devenv`](https://devenv.sh) tool
based on the Nix ecosystem.

[![asciicast](https://asciinema.org/a/I6zXgwIEvYndWSK7iJvLNr7RR.svg)](https://asciinema.org/a/I6zXgwIEvYndWSK7iJvLNr7RR)

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [`devenv` Templates](#devenv-templates)
    - [Available Templates](#available-templates)
    - [Design Decisions](#design-decisions)
    - [Environment Tooling](#environment-tooling)
        - [Global](#global)
        - [Python](#python)
        - [Javascript/Typescript](#javascripttypescript)
    - [Usage](#usage)
    - [Tasks](#tasks)
    - [Contributing](#contributing)

<!-- markdown-toc end -->

---

## Why Nix for Development Environments?

Using Nix to manage project-specific development environments has
brought about numerous benefits and advantages. Here's why I gravitate
towards Nix:

1. **Reproducibility**: Nix guarantees that the exact same
   dependencies and environment configurations are used every
   time. Whether it's being run on my machine, a colleague's machine,
   or in CI/CD, the environment remains consistent.

2. **Isolation**: Each project managed by Nix has its own isolated
   environment. This means that changes or installations in one
   project won't inadvertently affect another. This isolation prevents
   the classic "it works on my machine" problem.

3. **Atomicity**: Nix operations, like installations or upgrades, are
   atomic. This means that they either fully succeed or don't make any
   changes at all, ensuring that there's no in-between broken state.

4. **Versioning**: It's effortless to switch between different
   versions of tools, libraries, or even the language runtime
   itself. This flexibility is invaluable, especially when working on
   multiple projects with different requirements.

5. **Flexibility**: `devenv` and Nix are not limited to one language
   or an specific environment. This allows to craft unified workflows
   across projects. Easy onboarding with a single command + consistent
   developer helpers and dependency manager, without limiting
   developers to include their favorite tooling.

6. **No Global State**: Unlike other package managers, Nix doesn’t
   have global state. This means you can have multiple versions of a
   package, each with their dependencies, without conflicts.

7. **Declarative Configuration**: Using `flake.nix` or similar files,
   the entire project's dependencies and configurations can be
   declared in one place. This declarative approach not only ensures
   clarity but also makes setting up a new machine or onboarding a new
   developer a breeze.

8. **Cross-Platform Consistency**: Nix works across different Unix
   systems, ensuring that the environment is consistent whether you're
   using macOS, Linux, or any other Unix-like system.

By leveraging Nix for development environments, I ensure that each
project is self-contained, predictable, and free from the common
pitfalls associated with system-wide package managers or mutable
environments.

## Available Templates

Currently, the available templates are:

- Python
- JavaScript/TypeScript
- Terraform
- Go
- Rust

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


## Environment Tooling

Each template environment integrates with a set of tools to streamline
development and maintain consistency. Here's a breakdown of the tools
used for the respective environments:

### Global

- **[difftastic](https://difftastic.wilfred.me.uk/)**: A tool that
  provides a more structured approach to diffing, making it easier to
  understand changes between files.
- **[nixfmt](https://github.com/serokell/nixfmt)**: A formatter for
  Nix code, ensuring that Nix scripts are readable and adhere to a
  consistent style.
- **[yamllint](https://www.yamllint.com/)**: This tool is used to lint
  YAML files. For our environments, we use a simplified configuration.
- **[editorconfig](https://editorconfig.org/)**: Used to define and
  maintain consistent coding styles between different editors and
  IDEs.

### Python

- **[black](https://github.com/psf/black)**: The uncompromising Python
  code formatter. It ensures that Python code adheres to a consistent
  style, making it readable and clean.

### Javascript/Typescript

- **[prettier](https://prettier.io/)**: An opinionated code formatter
  that supports multiple languages, including JavaScript and
  TypeScript. It ensures that code has a consistent style, improving
  readability.

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

   watch_file devenv.nix
   watch_file devenv.lock
   if ! use flake . --impure
   then
     echo "devenv could not be built. The devenv environment was not loaded. Make the necessary changes to devenv.nix and hit enter to try again." >&2
   fi
   ```

## Tasks

- [x] Add Nodejs template
- [x] Add Terraform template
- [x] Add Go Template
- [x] Add Rust Template
- [ ] Migrate from Terraform to OpenTofu
- [ ] Make it modular to slice and dice and have multi-configuration
      environments also possible.

## Contributing

Pull requests are welcome! If you'd like to contribute a new template
or improve an existing one, please feel free to make a pull request.


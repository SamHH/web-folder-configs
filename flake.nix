{
  inputs =
    {
      agenix = {
        url = "github:ryantm/agenix";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      darwin = {
        url = "github:lnl7/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      flake-utils.url = "github:numtide/flake-utils";

      home-manager = {
        url = "github:nix-community/home-manager/master";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

      tshm-plugin = {
        url = "https://registry.yarnpkg.com/typescript-tshm-plugin/-/typescript-tshm-plugin-0.1.0.tgz";
        flake = false;
      };
    };

  outputs = { agenix, darwin, flake-utils, home-manager, nixpkgs, tshm-plugin, ... }:
    let
      selfpkgs = import ./pkgs;

      overlay-selfpkgs = final: prev: selfpkgs final // {
        agenix = agenix.defaultPackage.${final.system};

        fishPlugins = prev.fishPlugins // {
          fish-minimal-theme = final.callPackage ./pkgs/fishPlugins/fish-minimal-theme.nix { };
          z = final.callPackage ./pkgs/fishPlugins/z.nix { };
        };

        vimPlugins = prev.vimPlugins // {
          exrc-vim = final.callPackage ./pkgs/vimPlugins/exrc-vim.nix { };
          eyeliner-nvim = final.callPackage ./pkgs/vimPlugins/eyeliner-nvim.nix { };
          nvim-surround = final.callPackage ./pkgs/vimPlugins/nvim-surround.nix { };
          vim-just = final.callPackage ./pkgs/vimPlugins/vim-just.nix { };
        };
      };

      getPkgs = system: import nixpkgs {
        inherit system;

        overlays = [ overlay-selfpkgs ];

        config.allowUnfreePredicate = pkg:
          let pkgName = nixpkgs.lib.getName pkg;
          in
          builtins.elem pkgName [
            "obsidian"
            "slack"
          ] ||
          # Steam includes a few unfree packages.
          (builtins.match "^steam(-.*)?" pkgName != null);
      };

      # Usable both here and in module `config`s.
      localCfg = import ./shared/config.nix { };
      globalCfg = {
        imports = [ ./config ];
        config = localCfg;
      };

      homeManagerCfg = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        home-manager.users.${localCfg.username}.imports = [
          ./modules
        ];
      };

    in
    (flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            git
            git-crypt
            nixpkgs-fmt
          ];
        };
      }
    )) //

    (
      let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.${system} = selfpkgs pkgs;
      }
    ) //

    {
      nixosConfigurations = {
        alakazam =
          nixpkgs.lib.nixosSystem rec {
            system = "x86_64-linux";
            pkgs = getPkgs system;

            modules = [
              globalCfg

              home-manager.nixosModules.home-manager
              homeManagerCfg
              agenix.nixosModule

              ./hosts/alakazam
            ];

            specialArgs = {
              tshmPlugin = tshm-plugin;
            };
          };

        tentacool =
          nixpkgs.lib.nixosSystem rec {
            system = "x86_64-linux";
            pkgs = getPkgs system;

            modules = [
              globalCfg

              agenix.nixosModule

              ./hosts/tentacool
            ];
          };
      };

      darwinConfigurations.lapras =
        darwin.lib.darwinSystem rec {
          system = "aarch64-darwin";
          pkgs = getPkgs system;

          modules = [
            globalCfg

            home-manager.darwinModules.home-manager
            homeManagerCfg

            ./hosts/lapras
          ];

          specialArgs = {
            tshmPlugin = tshm-plugin;
          };
        };
    };
}

inputs: let
  inherit (inputs) self;
  inherit (self.lib) nixosSystem;

  sharedModules = [
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {inherit inputs self;};
        users.fz = ../home/fz;
      };
    }
  ];
in {
  lenovo = nixosSystem {
    modules =
      [
        ./lenovo
        {networking.hostName = "lenovo";}
        inputs.hyprland.nixosModules.default
      ]
      ++ sharedModules;

    specialArgs = {inherit inputs;};
    system = "x86_64-linux";
  };
}

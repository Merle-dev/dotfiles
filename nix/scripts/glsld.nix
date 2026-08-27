{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "glsld";
      runtimeInputs = [];
      text = ''~/.local/bin/glsld'';
    })
  ];
}

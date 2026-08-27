{pkgs, ...}: {
  home.packages = with pkgs; [
    # LLVM
    lldb
    # Java
    jdk25
    jdt-language-server
    # Rust
    rustup
    bacon
    rustc
    mold
    trunk
    tokio-console
    cargo-binstall
    # Python
    pyright
    # Lua
    lua
    lua-language-server
    # C / C++
    clang
    clang-tools
    gdb
    # Zig
    zig
    zls
    # asm
    nasm
    # graphics
    glslls
    glsl_analyzer
    # Haskell
    ghc
    haskell-language-server
    # JS / TS
    bun
    typescript-language-server
    # Go
    gopls
    # CSS/HTML
    sassc
    # KDL
    kdlfmt
    # Toml
    tombi
  ];
}

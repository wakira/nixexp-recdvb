{ nixpkgs ? import <nixpkgs> {} }:

nixpkgs.stdenv.mkDerivation rec {
  name = "recdvb";
  src = nixpkgs.fetchFromGitHub {
    owner = "dogeel";
    repo = "recdvb";
    rev = "86b8e8cbca68a96927f8d9719a6ca641935cbf89";
    sha256 = "1wdglm9yirh3xmhnjdw3ldfaynza55src1qwdfjdn32gwy4sz5m1";
  };
  nativeBuildInputs = with nixpkgs; [ automake autoconf ];
  buildInputs = with nixpkgs; [ pcsclite libarib25 ];
  patchPhase = ''
    sed -i '69i\	mkdir -p $(bindir)' Makefile.in
  '';
  preConfigure = ''
    ./autogen.sh
    ./configure --enable-b25
  '';
}

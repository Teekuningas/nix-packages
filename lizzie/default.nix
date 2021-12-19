{ stdenv, maven, callPackage, fetchurl }:
let
  repository = callPackage ./build-maven-repository.nix { };
in stdenv.mkDerivation rec {
  pname = "lizzie";
  version = "0.7.4";
  src = fetchurl {
    url = https://github.com/featurecat/lizzie/archive/refs/tags/0.7.4.tar.gz;
    sha256 = "9c984ebe6c44f5b4798c3396dabd337f335a91c5eca890bd03f6abef974e4c91";
  };
  nativeBuildInputs = [ maven ];

  buildPhase = ''
    echo "Using repository ${repository}"
    tar xzvf $src
    cd lizzie-*
    mvn --offline -Dmaven.repo.local=${repository} package;
  '';

  installPhase = ''

    mkdir -p $out

    mkdir $out/target
    cp target/lizzie-0.7.4-shaded.jar $out/target/

    mkdir $out/bin
    echo "#!/bin/sh" >> $out/bin/lizzie
    echo "mkdir -p ~/.config/lizzie/" >> $out/bin/lizzie
    echo "cd ~/.config/lizzie" >> $out/bin/lizzie
    echo "java -jar $out/target/lizzie-0.7.4-shaded.jar" >> $out/bin/lizzie
    chmod +x $out/bin/lizzie
  '';
}

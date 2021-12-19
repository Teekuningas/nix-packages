{ stdenv, fetchurl, maven }:
stdenv.mkDerivation {
  name = "maven-repository";
  nativeBuildInputs = [ maven ];
  src = fetchurl {
    url = https://github.com/featurecat/lizzie/archive/refs/tags/0.7.4.tar.gz;
    sha256 = "9c984ebe6c44f5b4798c3396dabd337f335a91c5eca890bd03f6abef974e4c91";
  };
  buildPhase = ''
    tar xzvf $src
    cd lizzie-*
    mvn package -Dmaven.repo.local=$out
  '';
  installPhase = ''
    find $out -type f \
      -name \*.lastUpdated -or \
      -name resolver-status.properties -or \
      -name _remote.repositories \
      -delete
  '';
  dontFixup = true;
  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
  outputHash = "0jlglxqrcssaslbjhmviz4g00mgq24s5w5lmczlrw027xcrva5ss";
}

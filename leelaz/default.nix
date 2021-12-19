{ stdenv, fetchFromGitHub, cmake, boost
, opencl-headers, ocl-icd, qtbase, zlib }:

stdenv.mkDerivation rec {
  pname = "leelaz";
  version = "0.17";

  src = fetchFromGitHub {
    owner = "gcp";
    repo = "leela-zero";
    rev = "v${version}";
    sha256 = "1k04ld1ysabxb8ivci3ji5by9vb3yvnflkf2fscs1x0bp7d6j101";
    fetchSubmodules = true;
  };

  builder = ./builder.sh;

  buildInputs = [ boost opencl-headers ocl-icd qtbase zlib ];

  nativeBuildInputs = [ cmake ];
  dontWrapQtApps = true;

}

{
  lib,
  stdenv,
  callPackage,
  cmake,
  imgui,
}:

stdenv.mkDerivation {
  pname = "implot";
  version = "0.17-instronimbus";

  src = lib.cleanSource ./.;

  buildInputs = [ imgui ];
  nativeBuildInputs = [ cmake ];

  passthru.tests = {
    implot-demos = callPackage ./demos { };
  };

  meta = {
    description = "Immediate Mode Plotting";
    homepage = "https://github.com/epezent/implot";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ SomeoneSerge ];
    platforms = lib.platforms.all;
  };
}

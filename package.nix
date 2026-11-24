{ lib, stdenv, fetchgit, cmake, ninja, qt6, vulkan-loader, makeWrapper }:

stdenv.mkDerivation (finalAttrs: {
  pname = "lsfg-vk";
  version = "2.0.0";
  src = fetchgit {
    url = "https://git.lsfg-vk.dev/lsfg-vk.git";
    rev = "2333707d55b68ddd8066fd95404c3b7d07e00d3a";
    hash = "sha256-vp0/adJdVV73C2RFjcEE90KjWiZJQhiqqOlYQ89RG+Y=";
  };
  nativeBuildInputs = [ cmake ninja qt6.wrapQtAppsHook makeWrapper ];
  buildInputs = [ qt6.qtbase qt6.qtdeclarative ];
  cmakeFlags = [
    "-DLSFGVK_BUILD_UI=ON"
    "-DLSFGVK_MANAGED=ON"
    "-DLSFGVK_LAYER_LIBRARY_PATH=${placeholder "out"}/lib/liblsfg-vk-layer.so"
  ];
  qtWrapperArgs = [ "--prefix" "LD_LIBRARY_PATH" ":" (lib.makeLibraryPath [ vulkan-loader ]) ];
  postFixup = ''
    substituteInPlace "$out/share/applications/gay.pancake.lsfg-vk-ui.desktop" \
      --replace-fail "Exec=lsfg-vk-ui" "Exec=$out/bin/lsfg-vk-ui"
    wrapProgram "$out/bin/lsfg-vk-cli" \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ vulkan-loader ]}
  '';
  meta = {
    description = "Lossless Scaling frame generation Vulkan layer and configuration tools";
    homepage = "https://lsfg-vk.dev/";
    license = lib.licenses.cc-by-nc-nd-40;
    platforms = lib.platforms.linux;
    mainProgram = "lsfg-vk-ui";
  };
})

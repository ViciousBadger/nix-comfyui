{ buildNpmPackage
, fetchFromGitHub
,
}:
buildNpmPackage {
  name = "comfyui-frontend";

  src = fetchFromGitHub {
    owner = "Comfy-Org";
    repo = "ComfyUI_frontend";
    fetchSubmodules = false;
    rev = "882506dfb16ffb3cffc3e1f8f2235b9bb03d380a";
    hash = "sha256-EurLFurseq2crDDvHbVXtucbHwvoZR9jhzTwr6kTMjk=";
  };

  npmDepsHash = "sha256-QcQNNw1q8ImiM44ENHKVJl4wupCJg2ngTjfpjFWoaQY=";

  installPhase = ''
    runHook preInstall

    mkdir --parents $out/share/comfyui
    cp --archive dist $out/share/comfyui/web

    runHook postInstall
  '';
}

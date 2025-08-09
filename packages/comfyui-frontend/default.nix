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
    rev = "2d11fb1f90489fafb104b9ac5b1e03ea721d5af2";
    hash = "sha256-rojLPEFoZkYIUsDBdljQ65pBL1kbrjvAByt/ioIyEUM=";
  };

  npmDepsHash = "sha256-R5pqJ8UheN8NKHuYOvGtaghBV0GHvM59+y/jSbAxkbA=";

  installPhase = ''
    runHook preInstall

    mkdir --parents $out/share/comfyui
    cp --archive dist $out/share/comfyui/web

    runHook postInstall
  '';
}

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
    rev = "e9ddf2950700ce5aa2c0410291c9e742ce6264ef";
    hash = "sha256-TDUQfgZTh3S33X1kkp/gZ0vBQ48PxEkDSURFjAbln2E=";
  };

  npmDepsHash = "sha256-p0GylYzU7IGea2+Off8gWYfjgRUrniYd7CBtNGTWdPs=";

  installPhase = ''
    runHook preInstall

    mkdir --parents $out/share/comfyui
    cp --archive dist $out/share/comfyui/web

    runHook postInstall
  '';
}

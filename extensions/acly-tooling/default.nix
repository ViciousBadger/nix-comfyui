{ buildExtension, fetchFromGitHub, lib, python3 }:

buildExtension {
  name = "acly-tooling";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "Acly";
    repo = "comfyui-tooling-nodes";
    fetchSubmodules = false;
    rev = "fa46b933297ef8bc8fd760674af27330b24dccd9";
    hash = "sha256-YU9KFjC0Zi8X5GEQbob1wDg5YJppmMAOSrf3wSw9PSc=";
  };

  propagatedBuildInputs = [
    python3.pkgs.aiohttp
    python3.pkgs.argostranslate
    python3.pkgs.gguf
    python3.pkgs.kornia
    python3.pkgs.numpy
    python3.pkgs.pillow
    python3.pkgs.requests
    python3.pkgs.torch
    python3.pkgs.tqdm
    python3.pkgs.transformers
  ];

  passthru = {
    comfyui.stateDirs = [
      "custom_nodes/acly-tooling/safetychecker"
    ];

    comfyui.prepopulatedStateFiles = [
      "custom_nodes/acly-tooling/safetychecker/config.json"
      "custom_nodes/acly-tooling/safetychecker/preprocessor_config.json"
    ];
  };

  meta = {
    license = lib.licenses.gpl3;
  };
}

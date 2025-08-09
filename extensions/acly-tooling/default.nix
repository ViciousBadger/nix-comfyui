{ buildExtension, fetchFromGitHub, lib, python3 }:

buildExtension {
  name = "acly-tooling";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "Acly";
    repo = "comfyui-tooling-nodes";
    fetchSubmodules = false;
    rev = "fa84eec8fc63f409cd2241f4919a121125979a3f";
    hash = "sha256-wgb/5D/pzyTcmvnLko7COo3bn3AxFpvjMgznusaVYMU=";
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

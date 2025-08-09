{ buildExtension, fetchFromGitHub, lib, python3 }:

buildExtension {
  name = "city96-gguf";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "city96";
    repo = "ComfyUI-GGUF";
    fetchSubmodules = false;
    rev = "cf0573351ac260d629d460d97f09b09ac17d3726";
    hash = "sha256-1TXKi2RvRi4fmwhdi0QWWxW0Gqc9MgCJsu1M5omHaGM=";
  };

  propagatedBuildInputs = [
    python3.pkgs.gguf
    python3.pkgs.numpy
    python3.pkgs.safetensors
    python3.pkgs.torch
    python3.pkgs.tqdm
  ];

  meta = {
    license = lib.licenses.asl20;
  };
}

{
  basePyproject,
  lib,
}:
basePyproject.override {
  content = {
    tool.poetry.dependencies = {
      pytorch-triton-rocm = {
        version = "~3.4.0";
        source = "torch-rocm";
      };
      taichi = "*";
      torch = {
        version = "~2.8.0+rocm6.4";
        source = "torch-rocm";
      };
      torchaudio = {
        version = "~2.8.0";
        source = "torch-rocm";
      };
      torchvision = {
        version = "~0.23.0";
        source = "torch-rocm";
      };
    };

    tool.poetry.source = lib.singleton {
      name = "torch-rocm";
      url = "https://download.pytorch.org/whl/rocm6.4";
      priority = "explicit";
    };
  };
}

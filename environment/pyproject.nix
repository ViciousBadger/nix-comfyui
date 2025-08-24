{
  basePython,
  content,
  emptyPyproject,
  lib,
}: let
  finalContent =
    lib.recursiveUpdate {
      tool.poetry.name = "comfyui-environment";

      tool.poetry.dependencies = {
        python = "==${basePython.version}";

        av = "*";
        accelerate = "*";
        addict = "*";
        aiohttp = "*";
        albumentations = "*";
        argostranslate = "*";
        colour-science = "*";
        diffusers = "*";
        einops = "*";
        filelock = "*";
        ftfy = "*";
        fvcore = "*";
        gguf = "*";
        huggingface-hub = "*";
        importlib-metadata = "*";
        insightface = "*";
        kornia = "*";
        matplotlib = "*";
        mediapipe = "*";
        numba = "*";
        numexpr = "*";
        numpy = "<2"; # numpy==2.0.2 gives "AttributeError: _ARRAY_API not found"
        omegaconf = "*";
        onnx = "*";
        onnxruntime = "==1.22.1";
        open-clip-torch = "*";
        opencv-python = "==4.7.0.72";
        packaging = "*";
        pandas = "*";
        pillow = "*";
        pixeloe = "*";
        psutil = "*";
        python-dateutil = "*";
        pytorch-lightning = "*";
        pyyaml = "*";
        rembg = "*";
        requests = "*";
        safetensors = "*";
        scikit-image = "*";
        scikit-learn = "*";
        scipy = "*";
        segment-anything = "*";
        sentencepiece = "*";
        soundfile = "*";
        spandrel = "*";
        spandrel-extra-arches = "*";
        svglib = "*";
        tokenizers = "*";
        torchsde = "*";
        tqdm = "*";
        transformers = "*";
        transparent-background = "*";
        trimesh = "*";
        typing-extensions = "*";
        ultralytics = "*";
        yacs = "*";
        yapf = "*";
        comfyui-frontend-package = "*";
        comfyui-workflow-templates = "*";
      };
    }
    content;
in
  emptyPyproject.override {
    content = finalContent;
  }

{ buildExtension
, fetchFromGitHub
, lib
, platform
, python3
,
}:
buildExtension {
  name = "fannovel16-frame-interpolation";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "Fannovel16";
    repo = "ComfyUI-Frame-Interpolation";
    fetchSubmodules = false;
    rev = "a969c01dbccd9e5510641be04eb51fe93f6bfc3d";
    hash = "sha256-bBtGs/LyQf7teCD7YT4dypYQTuy3ja+zV1hbQkYcGuU=";
  };

  propagatedBuildInputs =
    [
      python3.pkgs.einops
      python3.pkgs.kornia
      python3.pkgs.numpy
      python3.pkgs.opencv-python
      python3.pkgs.packaging
      python3.pkgs.pillow
      python3.pkgs.pyyaml
      python3.pkgs.requests
      python3.pkgs.scipy
      python3.pkgs.torch
      python3.pkgs.torchvision
      python3.pkgs.tqdm
    ]
    ++ (lib.optional (platform == "cuda") python3.pkgs.cupy-cuda12x)
    ++ (lib.optional (platform != "cuda") python3.pkgs.taichi);

  postPatch = ''
    ${lib.optionalString (platform != "cuda") ''
      printf 'ops_backend: "taichi"\nckpts_path: "./ckpts"\n' >config.yaml
    ''}

    rm install.py test.py

    find . -type f -name "*.py" | while IFS= read -r filename; do
      substituteInPlace "$filename" \
        --replace-quiet \
          'CATEGORY = "ComfyUI-Frame-Interpolation' \
          'CATEGORY = "frame_interpolation'
    done

    mkdir --parents ckpts
    touch ckpts/.keep
  '';

  passthru = {
    comfyui.stateDirs = [
      "custom_nodes/fannovel16-frame-interpolation/ckpts"
    ];

    check-pkgs.ignoredModuleNames =
      [
        "^mysql(\\..+)?$"
        "^pyunpack$"
        "^vapoursynth$"
        "^vfi_models(\\..+)?$"
        "^vfi_utils$"
      ]
      ++ (lib.optional (platform == "cuda") "^taichi(\\..+)?$")
      ++ (lib.optional (platform != "cuda") "^cupy(\\..+)?$");
  };

  meta = {
    license = lib.licenses.mit;
  };
}

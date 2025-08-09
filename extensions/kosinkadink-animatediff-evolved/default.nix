{ buildExtension, fetchFromGitHub, ffmpeg, lib, python3 }:

buildExtension {
  name = "kosinkadink-animatediff-evolved";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "Kosinkadink";
    repo = "ComfyUI-AnimateDiff-Evolved";
    fetchSubmodules = false;
    rev = "90fb1331201a4b29488089e4fbffc0d82cc6d0a9";
    hash = "sha256-HiaT0u8lGX3sUMluh/WtKOwGS9IaGE+y3nxeClh20ds=";
  };

  propagatedBuildInputs = [
    python3.pkgs.einops
    python3.pkgs.numpy
    python3.pkgs.pillow
    python3.pkgs.torch
    python3.pkgs.torchvision
  ];

  patches = [
    ./0001-subst-executables.patch
  ];

  postPatch = ''
    substituteInPlace animatediff/nodes_deprecated.py \
      --subst-var-by ffmpeg ${lib.getExe ffmpeg}

    find . -type f \( -name "*.py" -o -name "*.js" \) | xargs sed --in-place \
      "s/[[:space:]]*\(🎭🅐🅓①\|🎭🅐🅓\|🎭\|🧪\|🚫\|①\|②\)[[:space:]]*//g" --

    find . -type f -name "*.py" | while IFS= read -r filename; do
      substituteInPlace "$filename" \
        --replace-quiet \
          'CATEGORY = "Animate Diff' \
          'CATEGORY = "animate_diff' \
        --replace-quiet \
          'CATEGORY = ""' \
          'CATEGORY = "animate_diff/deprecated"' \
        --replace-quiet "◆" " - "
    done
  '';

  passthru = {
    comfyui.stateDirs = [
      "custom_nodes/kosinkadink-animatediff-evolved/models"
      "custom_nodes/kosinkadink-animatediff-evolved/motion_lora"
      "custom_nodes/kosinkadink-animatediff-evolved/video_formats"
    ];
  };

  meta = {
    license = lib.licenses.asl20;
  };
}

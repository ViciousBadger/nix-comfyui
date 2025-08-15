{ buildExtension, fetchFromGitHub, lib }:

buildExtension {
  name = "florestefano1975-portrait-master";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "florestefano1975";
    repo = "comfyui-portrait-master";
    fetchSubmodules = false;
    rev = "6312564f3edd80f69a20517d219cc3afa7eb7071";
    hash = "sha256-GhkpXStjO6MMDOhHnYEPIDv3LwWHOiKYDCZdx26ICms=";
  };

  postPatch = ''
    find . -type f -name "*.py" | while IFS= read -r filename; do
      substituteInPlace "$filename" \
        --replace-quiet \
          'CATEGORY = "AI WizArt/Portrait Master' \
          'CATEGORY = "portrait_master' \
        --replace-quiet "'random 🎲'" "'Random'"
    done
  '';

  meta = {
    license = lib.licenses.gpl3;
  };
}

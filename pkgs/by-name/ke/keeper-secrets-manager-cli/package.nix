{
  lib,
  fetchFromGitHub,
  python3Packages,
}:

python3Packages.buildPythonApplication rec {
  pname = "keeper-manager-cli";
  version = "1.2.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Keeper-Security";
    repo = "secrets-manager";
    rev = "release/tool/cli/v${version}";
    hash = "sha256-RCLw5UhyYRUNMjXAktTawQ6WryWSg8QzZCOslOSff3s=";
  };

  sourceRoot = "${src.name}/integration/keeper_secrets_manager_cli";

  build-system = with python3Packages; [
    setuptools
    setuptools-scm
  ];

  dependencies = with python3Packages; [
    keeper-secrets-manager-core
    keeper-secrets-manager-helper
    keeper-secrets-manager-storage
    prompt-toolkit
    jsonpath-rw
    colorama
    importlib-metadata
    click
    click-help-colors
    click-repl
    pyyaml
    update-checker
    psutil
    boto3
  ];

  nativeCheckInputs = with python3Packages; [
    pytestCheckHook
  ];

  doCheck = true;

  meta = {
    description = "The Keeper Secrets Manager command line interface";
    homepage = "https://github.com/Keeper-Security/secrets-manager/tree/master/integration/keeper_secrets_manager_cli";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ gesperon ];
    mainProgram = "keeper";
  };
}

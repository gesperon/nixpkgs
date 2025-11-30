{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  setuptools,
  keeper-secrets-manager-core,
}:

buildPythonPackage rec {
  pname = "keeper-secrets-manager-storage";
  version = "1.0.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Keeper-Security";
    repo = "secrets-manager";
    tag = "storage-python-v${version}";
    hash = "sha256-Ig8ESAyi2+EEXPegzBH6lT4QwDwf3523vIo1VrLuhLA=";
  };

  sourceRoot = "${src.name}/sdk/python/storage";
  build-system = [
    setuptools
  ];

  dependencies = [
    keeper-secrets-manager-core
  ];

  # No tests
  doCheck = true;
  pythonImportsCheck = [
    "keeper_secrets_manager_storage"
  ];

  meta = {
    description = "The Keeper Secrets Manager Storage module for working with custom key-value storages, creating and managing configuration files. To be used with keeper-secrets-manager-core.";
    homepage = "https://github.com/Keeper-Security/secrets-manager/tree/master/sdk/python/storage/keeper_secrets_manager_storages";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ gesperon ];
  };
}

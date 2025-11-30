{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  keeper-secrets-manager-core,
  pyyaml,
  iso8601,
}:

buildPythonPackage rec {
  pname = "keeper-secrets-manager-helper";
  version = "1.0.6";
  pyproject = true;

  # 1.0.6 at pypi, no version indicator on GH
  src = fetchPypi {
    pname = builtins.replaceStrings [ "-" ] [ "_" ] pname;
    inherit version;
    hash = "sha256-Px7LYhhzGDtmVbxm2e4QLQXsD326/FPhGacbABM7t3U=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    keeper-secrets-manager-core
    pyyaml
    iso8601
  ];

  # Missing tests on pypi
  doCheck = false;
  pythonImportsCheck = [ "keeper_secrets_manager_helper" ];

  meta = {
    description = "A secure, stable, and high-performance Tube API for Python, providing WebRTC-based secure tunneling with enterprise-grade security and reliability optimizations.";
    homepage = "https://pypi.org/project/keeper-pam-webrtc-rs";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ gesperon ];
  };
}

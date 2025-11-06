{
  lib,
  buildPythonPackage,
  setuptools,
  dnspython,
  ifaddr,
  fetchFromGitHub,
  unittestCheckHook,
}:

buildPythonPackage rec {
  pname = "aioice";
  version = "0.10.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "aiortc";
    repo = "aioice";
    tag = version;
    hash = "sha256-KFYPzGPm+d1QrFAW9OhTDxroV/MnFusmfy5qcYCfDiM=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    dnspython
    ifaddr
  ];

  nativeCheckInputs = [ unittestCheckHook ];
  doCheck = true;
  pythonImportsCheck = [
    "aioice"
  ];

  meta = {
    description = "Asyncio-based Interactive Connectivity Establishment (RFC 5245)";
    homepage = "https://github.com/aiortc/aioice";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ gesperon ];
  };
}

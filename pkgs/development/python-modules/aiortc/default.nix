{
  lib,
  buildPythonPackage,
  setuptools,
  aioice,
  av,
  cffi,
  cryptography,
  google-crc32c,
  pyee,
  pylibsrtp,
  pyopenssl,
  libopus,
  libvpx,
  ifaddr,
  dnspython,
  fetchFromGitHub,
  unittestCheckHook,
}:

buildPythonPackage rec {
  pname = "aiortc";
  version = "1.14.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "aiortc";
    repo = "aiortc";
    tag = version;
    hash = "sha256-ZgxSaiKkJrA5XvUT1zq8kwqB8mOvn46vLWXHyJSsHbM=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    aioice
    av
    cffi
    cryptography
    google-crc32c
    pyee
    pylibsrtp
    pyopenssl
    libopus
    libvpx
    ifaddr
    dnspython
  ];

  nativeCheckInputs = [ unittestCheckHook ];
  doCheck = true;
  pythonImportsCheck = [
    "aiortc"
  ];

  meta = {
    description = "WebRTC and ORTC implementation for Python using asyncio";
    homepage = "https://github.com/aiortc/aiortc";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ gesperon ];
  };
}

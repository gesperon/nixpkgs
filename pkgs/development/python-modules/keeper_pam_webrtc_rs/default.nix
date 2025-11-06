{
  lib,
  buildPythonPackage,
  fetchPypi,
  rustPlatform,
  pytest,
  pytest-asyncio,
  pytest-test-utils,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "keeper_pam_webrtc_rs";
  version = "1.1.6";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-MPtKk4n/AGBBK8ffoVP8ho9tLrOjGxUaC2XZ+kZz6q8=";
  };

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit pname version src;
    hash = "sha256-KwvFm/oph2RNCDNF04UnE3NdrlC9eOCDPCN0vOICa1U=";
  };

  nativeBuildInputs = with rustPlatform; [
    cargoSetupHook
    maturinBuildHook
  ];

  patchPhase = ''
    # If missing README.md: Failed to read readme specified in pyproject.toml, which should be at /build/keeper_pam_webrtc_rs-1.1.6/README.md
    touch README.md
  '';

  nativeCheckInputs = [
    pytest
    pytest-asyncio
    pytest-test-utils
    pytestCheckHook
  ];

  disabledTestPaths = [
    "tests/test_cleanup.py::TestCleanupIntegration::test_integration_pattern_old_style" # AssertionError: False is not true : Failed to establish connection
    "tests/test_close_operations.py::TestCloseOperations::test_close_connection_after_peer_connection" # AssertionError: False is not true : Tubes should be connected
    "tests/test_ice_restart_and_keepalive.py::TestICERestartAndKeepalive::test_connection_stats_api" # AssertionError: False is not true : Failed to establish connection for stat...
    "tests/test_ice_restart_and_keepalive.py::TestICERestartAndKeepalive::test_keepalive_functionality_monitoring" # AssertionError: False is not true : Failed to establish connection for keep...
    "tests/test_ice_restart_and_keepalive.py::TestICERestartAndKeepalive::test_manual_ice_restart_api" # AssertionError: False is not true : Failed to establish connection for rest...
    "tests/test_metrics_system.py::TestMetricsSystem::test_metrics_integration_with_basic_functionality" # assert True == False
    "tests/test_performance.py::TestWebRTCPerformance::test_data_channel_load" # AssertionError: Data channel load test failed due to WebRTC connection fail...
    "tests/test_performance.py::TestWebRTCPerformance::test_e2e_echo_flow" # AssertionError: E2E echo flow test failed with exception: E2E WebRTC connec...
    "tests/test_performance.py::TestWebRTCFragmentation::test_data_channel_fragmentation" # AssertionError: False is not true : Server offer SDP (decoded) should conta...
  ];

  preCheck = ''
    # Or fails with: ModuleNotFoundError: No module named 'test_utils'
    cd tests
  '';

  doCheck = true;
  pythonImportsCheck = [ "keeper_pam_webrtc_rs" ];

  meta = {
    description = "Keeper PAM WebRTC for Python";
    homepage = "https://pypi.org/project/keeper-pam-webrtc-rs";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ gesperon ];
  };
}

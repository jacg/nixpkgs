{ lib
, rustPlatform
, fetchFromGitHub
, stdenv
, darwin
, cbmc
, cbmc-viewer
, kissat
, universal-ctags
}:

rustPlatform.buildRustPackage rec {
  pname = "kani";
  version = "0.50.0";

  src = fetchFromGitHub rec {
    owner = "model-checking";
    repo = "kani";
    rev = "${repo}-${version}";
    hash = "sha256-APrl6E4nXxsvpgsGGcykG/WDQWQM9JR2MtAtM0kzGAA=";
  };

  cargoHash = "sha256-qONFvRwiyZAR8K8Fc21a+U2eNhTb3LQAJ78GrMb/904=";

  buildInputs = [
    cbmc
    cbmc-viewer
    kissat
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.SystemConfiguration
  ];

  meta = with lib; {
    description = "Rust verifier";
    longDescription = ''
      The Kani Rust Verifier is a bit-precise model checker for Rust.

      Kani is particularly useful for verifying unsafe code blocks in Rust,
      where the "unsafe superpowers" are unchecked by the compiler.
    '';
    mainProgram = "kani";
    homepage = "https://github.com/model-checking/kani";
    changelog = "https://github.com/model-checking/kani/releases/tag/${src.rev}";
    license = [ licenses.mit licenses.asl20 ];
    maintainers = with maintainers; [ jacg ];
  };
}

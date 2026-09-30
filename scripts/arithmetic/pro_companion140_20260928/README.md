# The simple companion over a cubic discriminant

**Status: COMPLETE — the requested square locus is empty, and its complete
square ideal is the unit ideal.**

The theorem concerns the exact fixed r=[9] degree-140 family on the
selected-simple-root companion J=0, with precisely the problem's original
localizations and accepted boundary exclusions. Both sheets, all geometric
nonzero scales, extension-field parameters and nonreduced schemes are covered.
The discriminant-nonzero family is outside this result.

The decisive witness is a global polynomial identity

`U*(P12/D12) + V*(P13/D13) = 1`.

P12,P13 are the complete quadratic norms of fixed-degree resultants of the
**actual companion** tails (C71,C72) and (C71,C73), with proved-unit poles
cleared. Their degrees are 1,153,010 and 1,167,742. D12,D13 have degrees
522 and 362 and consist entirely of separately justified unit factors.
All five complete coefficient rows and the factor orders are included.
`REPORT.md`, especially Sections 21–23, proves membership in the original
square ideal and accounts for every additional denominator boundary.

## File map

| Files | Content |
|---|---|
| `FULL_INPUT.md`, `data/inputs.json` | Complete specification and accepted input exclusions; no prior archive is required. |
| `REPORT.md`, `RESUME.md`, `claims.json` | Full proof, latest state and claim-to-evidence index. |
| `data/global_unit_certificate.bin`, `.json` | Complete P12,P13,U,V,G=1 coefficient rows, binary format, unit factors and exact division orders. |
| `data/projection_bounds.json`, `projection_duals.json` | Actual coefficient valuations and independently checkable Sylvester degree/pole witnesses. |
| `data/projection.meta.json`, `projection.coverage.json`, `projection_fingerprint.json` | Full Hermite construction parameters, complete chunk coverage and reproducibility hashes. |
| `data/boundary_certificate_*.json`, `opposite_certificate_*.json`, `norm_s_certificate.json` | Thirteen complete rank-24 all-scale boundary unit certificates, closing 312 allowed ratios over 168 whole q-fibres. |
| Other `data/*.json` | Exact source/Cramer reconstruction, companion formulas, finite-algebra coordinates, sample residual/tails and q=1,2 certificates. |
| `src/*.py` | Independent field/boundary verification, original source reconstruction, restartable interpolation assembly, certificate sealing and verification drivers. |
| `src/native/` | Exact field/polynomial arithmetic, companion residual, global tails, valuations, fixed-degree jet resultants, Fourier/Hermite projection and global Bézout arithmetic. |
| `EXECUTED_CHECKS.md`, `evidence/` | Executed commands, tested versions and concise evidence-bearing logs. |
| `SHA256SUMS`, `src/package.py` | Payload integrity manifest and streamed archive builder. |

`work/` is deliberately excluded. It holds regenerated executables and large
intermediates, including a coefficient-evaluation table of approximately
1.54 GB. The essential global witness is stored once, in a compact binary
format; its JSON metadata specifies every byte convention and coefficient row.
No external file, external service, SageMath or earlier conversation is needed.

## Requirements and tested versions

Linux x86-64, little-endian; CPython **3.13.5**, NumPy **2.3.5**,
GCC/g++ **14.2.0**, Boost headers **1.83.0**, GMP **6.3.0**, and OpenSSL
**3.5.6**. Native programs use C++20. OpenMP is used for parallel stages;
OpenSSL is used only for SHA-256 integrity checks. Mathematical arithmetic
is entirely exact. No other version combination is claimed to have been tested.

Do not use Python `-O` or C++ `-DNDEBUG`: the verifiers use assertions.
Run all commands below from the extracted `companion140` directory.
The native programs assume 32-bit unsigned integers and little-endian
binary storage, and check these requirements where binary files are used.

## 1. Verify all stored boundary and global certificates

```sh
python src/verify_global.py --certificate
```

This checks the manifest, all thirteen new finite-algebra unit identities
with independent Python arithmetic, the four original q=1,2 identities,
the integer Sylvester dual certificates, all authorized-factor divisions,
and the **full** global polynomial Bézout multiplication. It additionally
compares the projection normalization with the archived actual tails on
both sheets at q=1 and q=2.

This is the direct certificate check. The source-to-tail and
source-to-projection constructions can also be regenerated as follows.
They are separate from mere hash or identity checking.

## 2. Regenerate the original source and every boundary certificate

```sh
python src/verify.py --full --part 1
python src/verify.py --full --part 2
# Optional diagnostic, not needed for emptiness:
python src/verify.py --full --part 3

python src/verify_continuation.py --replay --part 1
python src/verify_continuation.py --replay --part 2
python src/verify_continuation.py --replay --part 3
python src/verify_continuation.py --replay --part 4
```

The baseline stages reconstruct the original equations, exact Cramer
solution, residual and q=1,2 certificates. The four continuation stages
respectively check the global pre-norm division, reconstruct the six
leading-tail certificates, reconstruct the norm-of-s certificate, and
reconstruct all six opposite-sheet certificates. Regenerated mathematical
JSON witnesses must be byte-identical. These stage drivers also check the
manifest; they do not modify it.

## 3. Regenerate the actual global companion tails

```sh
mkdir -p work
sh src/native/build.sh
work/companion . global-model work/global_a.json
# Optional full, untruncated source comparison; same output hash:
work/companion . global-model-full work/global_a_full.json

g++ -std=c++20 -O3 -fopenmp -DBOOST_BIND_GLOBAL_PLACEHOLDERS \
  src/native/global_tails_parallel.cpp -lgmp -o work/global_tails_parallel
work/global_tails_parallel . work/global_a.json work/global_tails.json 4
```

Expected SHA-256 values (output filenames do not affect contents):

```text
global_a.json:
8b65276894d0a7e9a26e8c17dd146c1be276f6ac9679a71d20a517edf1a6491e
global_tails.json:
e2bb01d74924fc53a13e3175c3a01eeaab5431071cc51b4f642810cbf76b18d9
```

All source denominators are tracked explicitly. An inverse with any
unlicensed pole factor aborts the computation.

## 4. Regenerate the pole/degree proof and global projection

```sh
g++ -std=c++20 -O3 -fopenmp -DBOOST_BIND_GLOBAL_PLACEHOLDERS \
  src/native/projection_bounds.cpp -lgmp -o work/projection_bounds
work/projection_bounds . work/global_tails.json work/projection_bounds.json 4
cmp work/projection_bounds.json data/projection_bounds.json

g++ -std=c++20 -O3 -DBOOST_BIND_GLOBAL_PLACEHOLDERS \
  src/native/certify_projection_bounds.cpp -lgmp -o work/certify_projection_bounds
work/certify_projection_bounds work/projection_bounds.json work/projection_duals.json
cmp work/projection_duals.json data/projection_duals.json
python src/verify_projection_duals.py

g++ -std=c++20 -O3 -fopenmp -DBOOST_BIND_GLOBAL_PLACEHOLDERS \
  src/native/projector.cpp -lgmp -lcrypto -o work/projector
work/projector prepare . work/global_tails.json work/projection_bounds.json work/projection 4
python src/project_all.py work/projection --executable work/projector --jobs 4
python src/verify_global.py --compare-projection work/projection.polynomials.json
```

The assembler resumes only chunks whose data and provenance hashes verify.
It requires complete nonoverlapping coverage before recovery. The recovery
checks every reconstructed jet, the exact degree bounds, and division by
E0^3. All 390624 nodes carry three Hermite coefficients. They determine
global polynomials over K[q]; they do **not** restrict unknown parameters to K.
At the eight erased nodes zero jets are justified by the polynomial factor
E0^3, not by deleting geometric fibres.

## 5. Reconstruct the Bézout witness, rather than merely checking it

```sh
g++ -std=c++20 -O3 -fopenmp -DBOOST_BIND_GLOBAL_PLACEHOLDERS \
  src/native/eliminate.cpp -lgmp -o work/eliminate
OMP_NUM_THREADS=4 work/eliminate . work/projection.polynomials.json work/rebuilt_gcd.json
python src/verify_global.py --compare-gcd work/rebuilt_gcd.json
```

The construction removes only factors in the proved-unit catalog, retaining
all other factors. It returns a constant gcd and directly checks its Bézout
identity and divisibility. The stored direct-certificate checker does not
rely on the half-gcd algorithm: it multiplies the complete archived rows.

## Optional exact arithmetic diagnostics

```sh
for test in fft_test jets_test; do
  g++ -std=c++20 -O3 -fopenmp src/native/$test.cpp -lgmp -o work/$test
  OMP_NUM_THREADS=4 work/$test
done
g++ -std=c++20 -O3 -fopenmp -DBOOST_BIND_GLOBAL_PLACEHOLDERS \
  src/native/polynomial_test.cpp -lgmp -o work/polynomial_test
OMP_NUM_THREADS=4 work/polynomial_test .
g++ -std=c++20 -O3 -fopenmp src/native/halfgcd_test.cpp -lgmp -o work/halfgcd_test
OMP_NUM_THREADS=4 work/halfgcd_test 65536
```

These implementation tests include degree drops, nonunit jet pivots,
nontrivial quadratic-extension coefficients and Frobenius-sparse polynomials.
They are explicitly bounded diagnostics, not parameter searches or substitutes
for the global identity. The complete square criterion uses the actual
characteristic-five tails, not an ordinary differential equation.

## Integrity and repackaging

Check the delivered manifest before modifying any files. For a modified
copy, rebuild the manifest and stream a new ZIP with:

```sh
python src/package.py
```

This is packaging, not mathematical verification. It hashes every payload
file except the manifest itself and omits only `work/`, bytecode and caches.
See `EXECUTED_CHECKS.md` for which complete constructions and replays were
actually executed; no unexecuted stage is used as evidence for the theorem.

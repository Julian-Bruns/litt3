# Historical profile-4 route index

Current work follows [Research/STATE.md](Research/STATE.md), not this older
route. This is a routing index, not a proof. Status attaches to the particular
claim described in each row; several files deliberately contain both proved
lemmas and open or transcript-only consequences.

## Folder map

```text
Research/STATE.md            current continuation record
STRUCTURE.md                 this historical per-file route index
MISSING_INPUTS.md            absent sources and reproducibility limits
tasks/                       parked profile-4 proof obligations
routes/global/               visibility and common-cover consequences
routes/profile4/             conditional degree-35/profile-4 route
  entry_one/                 entry-one branch
  no_highpoint/              no-highpoint residual proposal
  double_fiber/              conditional double-fiber tower and frontier
reference/synthesis_2026-06/ dated monolithic snapshot
```

## Global route

| File | Established content and remaining scope | Status |
| --- | --- | --- |
| `routes/global/10_PROOF_SELF_CORRESPONDENCE.md` | Proves \(S/S_3\simeq\mathbb P^1(2,3,62)\), defines visibility, and proves that visibility forces \(g\equiv1\pmod7\) for any curve sharing a finite étale cover with \(Y\). The descent cocycle and representability are included. A simultaneous-Galois/over-orbifold envelope remains open. | mixed `proved-text` / `conditional-proof` / `open` |
| `routes/global/11_PROOF_OVER_ORBIFOLD_CLASSIFICATION.md` | Proves the fiber/different formulas and that an over-orbifold has at most one wild point. The weak and non-weak wild exclusions and final classification are not proved. | mixed `proved-text` / `open` |
| `routes/global/12_PROOF_PROFINITE_ORBIFOLD_GROUP.md` | Checks the index-six inclusion numerically and proves visibility for a simultaneously liftable correspondence assuming the complex commensurator theorem. The exact classical reference and characteristic-\(5\) tame specialization are missing. | mixed `proved-text` / `conditional-proof` / `open` |
| `routes/global/13_PROOF_LOCAL_RAMIFICATION.md` | Proves wild-excess, generalized first-break Swan divisibility, tame-character divisibility, the exact leading-commutator lemma, and summation by parts. It does not perform the missing global arithmetic elimination. | `proved-text` |
| `routes/global/14_PROOF_LIFT_THROUGH_Y.md` | Proves that the smooth projective model of \(y^{31}=x(x-1)\) has genus \(15\), presents \(S\), and is a finite étale \(\mu_{31}\)-atlas. | `proved-text` |

## Profile-4 reductions

| File | Established content and remaining scope | Status |
| --- | --- | --- |
| `routes/profile4/162_PROFILE4_HIGHPOINT_FIBER_COUNT_LEMMA.md` | Proves the quotient-degree bound and field generation, excludes three high-point cells, identifies the entry-zero cells by inversion, excludes their simultaneous occurrence by a bidegree-\((5,5)\) genus bound, and classifies the degree-three/four entry-one specializations. | `proved-text` |
| `routes/profile4/entry_one/175_ENTRY1_LOGARITHMIC_EXACTNESS_TARGET.md` | Proves that Cartier fixedness yields a rational logarithmic primitive and identifies the actual divisor-lifting class in \(\operatorname{Pic}^0(C)\); the divisor of \(r-1\) is a separate condition. | necessary conditions `proved-text`; exclusion `open` |
| `routes/profile4/entry_one/176_ENTRY1_X_NORM_SHADOW.md` | Derives norm and trace identities conditional on an actual primitive with both prescribed profile divisors. | `proved-text` necessary conditions |
| `routes/profile4/entry_one/171_ENTRY1_DOUBLE_FINITE_POLE_EDGE.md` | Shows that, under the missing normal-form identities from note `165`, the first tangent equation on \(c=d\) solves a later coefficient rather than contradicting the stratum. | `conditional-proof` |
| `routes/profile4/entry_one/172_ENTRY1_SIMPLE_FINITE_POLE_ODE.md` | Exact formal calculation showing that for \(c\ne d\) the first local ODE equation prescribes \(\xi_6\); it does not prove global freedom. | `proved-text` local check |
| `routes/profile4/entry_one/174_ENTRY1_LOWZ_INFINITY_CORNER.md` | Under the missing normal form, proves \(h_{21}\ne0\) and the leading high branch. | `conditional-proof` on note `165` |
| `routes/profile4/entry_one/177_ENTRY1_PINFTY_HIGH_BRANCH_ODE.md` | Exact formal calculation showing that the first high-branch ODE equation prescribes \(a_{35}\); later and global compatibility remain open. | `proved-text` local check |
| `routes/profile4/no_highpoint/170_NO_HIGHPOINT_RESIDUAL_GATE.md` | Verifies the proposed residual family's boundary restrictions and corner coefficients. Residual extraction and normalization-aware elimination are separate open theorems. | mixed `proved-text` / `open` |

## Entry-zero double-fiber route

| File | Established content and remaining scope | Status |
| --- | --- | --- |
| `routes/profile4/double_fiber/79_ENTRY_ZERO_DOUBLE_FIBER_REDUCTION.md` | Computes the compatible boundary/norm constants and tangent leading form. It shows that the old comparisons are identities and do not establish \(\alpha^{31}=1\), \((1-c)(1-d)=1\), \(cd=-1\), or \(c=d=2\); specialization or full-branch coverage remains open. | mixed `proved-text` / `open` |
| `routes/profile4/double_fiber/layer_certificates/80_REPEATED_BRANCH_LINEAR_ALGEBRA.md` | Proves the étale-cubic determinant normalization: a common unit contributes \(N_{A/k}(p)\), not \(p^3\). | `proved-text` |
| `routes/profile4/double_fiber/layer_certificates/81_REPEATED_U5_COLUMN_RECURRENCE_CERTIFICATE.md` | Proves the triangular recurrence and common response column. The closed response and two decisive scalar identities are unreproduced transcripts. | mixed `proved-text` / `certificate-transcript` |
| `routes/profile4/double_fiber/layer_certificates/83_REPEATED_U5_REPAIRED_ATLAS_CERTIFICATE.md` | Proves the two-minor atlas implication from the scalar identities in file `81`; those premises are not proved here. | `conditional-proof` |
| `routes/profile4/double_fiber/layer_certificates/85_SIMPLE_FIVE_STEP_SOLVE_LEMMA.md` | Consolidates and proves the four simple-layer leading responses with the parameter-dependent tangent scalar retained. It does not justify the specialized tower or its incoming equations. | `proved-text` local lemma |
| `routes/profile4/double_fiber/layer_certificates/86_SIMPLE_U10_CHARTED_SOLVE_CERTIFICATE.md` | Applies file `85` at \(u^{10}\); tower use assumes the incoming conditional atlas. | `proved-text` local response |
| `routes/profile4/double_fiber/layer_certificates/92_REPEATED_U10_TWO_MINOR_CERTIFICATE.md` | Proves determinant surjectivity from recorded Schur-response identities; those identities are not reproducible here. | `conditional-proof` / `certificate-transcript` premises |
| `routes/profile4/double_fiber/layer_certificates/93_SIMPLE_U15_LEADING_SOLVE_CERTIFICATE.md` | Applies file `85` at \(u^{15}\); tower use assumes the preceding repeated layer. | `proved-text` local response |
| `routes/profile4/double_fiber/layer_certificates/96_REPEATED_U15_VERTICAL_CERTIFICATE.md` | Proves a codimension-three rank conclusion from a recorded response identity. It does not establish a three-dimensional fiber. | `conditional-proof` / `certificate-transcript` premise |
| `routes/profile4/double_fiber/layer_certificates/97_SIMPLE_U20_LEADING_SOLVE_CERTIFICATE.md` | Applies file `85` at \(u^{20}\); tower use assumes the preceding repeated layer. | `proved-text` local response |
| `routes/profile4/double_fiber/layer_certificates/100_REPEATED_U20_MISSING_GATE.md` | Records the absent repeated-\(u^{20}\) transition and the exact proof obligation. | `missing dependency` / `open` |
| `routes/profile4/double_fiber/layer_certificates/101_SIMPLE_U25_LEADING_SOLVE_CERTIFICATE.md` | Applies file `85` at \(u^{25}\), but is disconnected from the retained tower until file `100` is supplied. | `proved-text` local response; downstream use conditional |
| `routes/profile4/double_fiber/layer_certificates/104_REPEATED_U25_TWO_MINOR_CERTIFICATE.md` | Proves determinant surjectivity from recorded response identities and an incoming repeated-\(u^{20}\) solve. | `conditional-proof` with a `certificate-transcript` premise and a `missing dependency` |
| `routes/profile4/double_fiber/basin127/159_BASIN127_CAS_SETUP_AND_DISPLAYED_BASIS_CHECK.md` | Proves \(R_0/J\simeq\mathbb F_5^5\) and the base-residual cut to \(r_{129}\); given the recorded discriminant formula, it proves the displayed open check. H127, the formula's derivation from the local model, and the map to the 19-coordinate `P129` are absent. | mixed `proved-text` / `conditional-proof` / `open` |
| `routes/profile4/double_fiber/basin127/179_BASIN127_TAIL_DEPTH_REDUCTION.md` | Proves coefficient-depth bookkeeping conditional on the raw-response formula. The low-degree pivot values are transcript-only and only concern \(V(J)\). | mixed `conditional-proof` / `certificate-transcript` |
| `routes/profile4/double_fiber/terminal_strata/148_SYMBOLIC_P129_LAYER_CERTIFICATE.md` | Given the displayed matrices, proves their ranks are four by explicit nonzero minors and checks the constant final obstruction. Extraction from the local equations is absent. | mixed `proved-text` / `certificate-transcript` extraction |
| `routes/profile4/double_fiber/terminal_strata/150_TANGENT_CANDIDATE_FIELD_AND_E50_AUDIT.md` | Records four rho3 tangent candidates and their final systems; their displayed systems have no common root by direct substitution, but the tangent census and extraction are absent. | mixed `proved-text` / `certificate-transcript` |
| `routes/profile4/double_fiber/terminal_strata/156_RHO4_ALLZERO_POINT_AND_E50_KILL.md` | Records rho4 base/tangent candidates and their terminal systems; the displayed last system has no common root, but derivation and coverage are absent. | mixed `proved-text` / `certificate-transcript` |
| `routes/profile4/double_fiber/open_targets/180_G4_DOUBLE_FIBER_TAIL_COVERAGE_TARGET.md` | Gives the corrected priority charts, radical coverage direction, and terminal unit-ideal target. | `open` |
| `routes/profile4/double_fiber/open_targets/181_REPEATED_E30_IDEAL_EXTRACTION_TARGET.md` | Specifies the missing symbolic extraction of the chartwise repeated-\(e30\) ideals, including denominators and saturation. | `open missing-input target` |

## Tasks and dated synthesis

| File | Role | Status |
| --- | --- | --- |
| `tasks/00_RECOVER_REPEATED_U20.md` | Recover or reprove the missing repeated-\(u^{20}\) transition. | `open` evidence prerequisite |
| `tasks/00A_REPROVE_REPEATED_LAYER_IDENTITIES.md` | Derive or exactly certify the transcript-only identities in files `81`, `92`, `96`, and `104`. | `open` evidence prerequisite |
| `tasks/00B_ENTRY_ZERO_SPECIALIZATION_OR_COVERAGE.md` | Justify the specialization \(c=d=2\), exclude its complement, or replace the specialized tower by a full-branch argument. | `open` geometric prerequisite |
| `tasks/01_PROFILE_EXTRACTION.md` | Extract the fixed profile-4 pair from every non-visible correspondence. | `open` |
| `tasks/02_ENTRY_ONE_EXCLUSION.md` | Exclude the representative entry-one branch and all degree-three/four boundary strata. | `open` |
| `tasks/03_NO_HIGHPOINT_EXCLUSION.md` | Prove residual extraction and normalization-aware elimination, or find another argument. | `open` |
| `tasks/04_BASIN127_CONTAINMENT.md` | Reconstruct \(I_{127}\) and prove H127 with the corrected containment direction. | `open` |
| `tasks/05_DOUBLE_FIBER_TAIL_COVERAGE.md` | Prove chartwise coverage, derive terminal equations, and prove localized emptiness. | `open` |
| `tasks/06_FINAL_ASSEMBLY.md` | Audit the conditional assembly after every preceding theorem and evidence prerequisite is proved. | not currently actionable |
| `reference/synthesis_2026-06/partial_progress_note.tex` | Dated monolithic source for the June 2026 conditional reduction. | reference snapshot; not canonical status |
| `reference/synthesis_2026-06/litt3_partial_progress.pdf` | Rendered copy of the same synthesis. | human reference only |

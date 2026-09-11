# Completion audit of two fixed Heisenberg censuses

Auditor: `/root/audit_actual_heisenberg_defect`.
Date: 2026-09-11.
Verdict: PASS. Every representative rank and every census link passed.
No mathematical correction or missing completeness argument was found.

Scope: every geometric connected exponent-five Heisenberg cover of the
two fixed bad-double/active-data pairs called case 0 and case 2 in the
backup table. This is a complete 155-cover census for each of these two
pairs. It is not a census over all twelve bad doubles, all branch or
mixed data, or generic parameters. Nothing here excludes an arbitrary
unmarked common cover or proves a higher-Witt obstruction.

## 1. Geometric inputs reused with their exact scopes

The global two-chart construction, connectedness, geometric 155-class
classification, complete negative Čech tangent basis, and free six-top-
generator argument are inputs from
[the actual-cover audit](ACTUAL_HEISENBERG_DEFECT_AUDIT_2026_09_11.md).
The complete central-character Frobenius transport, reference Lang
primitive zero, degree-12 field, and 51/42 actual-cover orbit tables are
inputs from
[the Frobenius audit](HEISENBERG_FROBENIUS_AND_ADDITIONAL_RANKS_AUDIT_2026_09_11.md).
That audit independently checked all 310 central transport witnesses.

The present audit checks that the orbit, AS-character, and raw-curve
files are byte-for-byte the same inputs recorded by that independent
audit. It also checks the unchanged audited Laurent producer and ranker
source hashes. Thus the orbit reduction used here is actual coefficient
conjugacy including central characters, not just a quotient of the set
of 31 abelian planes.

The two fixed pairs both have alpha satisfying `alpha^3+alpha+1=0` and
base `B:v^2=u(u-1)(u-2)(u-3)(u-alpha)`. They are:

| Census case | Active datum | Bad double polynomial R | Table indices |
| --- | --- | --- | --- |
| 0 | branch A3 | u(u-3) | source 4, twist 7 |
| 2 | mixed A1 | u(u-2) | source 4, twist 6 |

The cover genus is 251 and its tangent dimension is 750. Calling these
two cases representative examples does not imply that their complete
nonabelian operators determine those of the other ten bad pairs.

## 2. Completeness and provenance checks

The census runner is `scripts/run_heisenberg_census.py`. Its final PASS
requires reaching the end of the supplied orbit list without failures.
The independent completion checker imposes the following stronger
conditions on the finished data:

- The case, final status, orbit count, no-failure list, and orbit-file
  path/hash all match. The result rows have every orbit index exactly
  once: 0--50 for case 0 and 0--41 for case 2.
- The orbit tables contain each of the 155 `(plane,central)` labels
  exactly once, with all 31 planes and all five central choices.
  Every saved cycle follows the previously audited full-cover Frobenius
  permutation, and every representative is the first member of its
  recorded cycle.
- Every row's Hodge, deck, and rank SHA-256 matches its actual file.
  The expected file names, rank-file path, and rank receipt's two input
  paths all agree. No pilot from a different plane or central choice is
  silently reused.
- Each Hodge receipt has exactly columns 744--749, and each deck receipt
  has exactly columns 0--749. Every monomial label, field modulus, alpha,
  case, plane, central value, and coefficient-basis/complement label is
  checked.

For every computed representative the auditor also reconstructs its
actual overlap and both affine Lang right sides independently in nested
quadratic Laurent algebras. In particular, it checks the exact AS plane,
the central primitive `j*chi3`, and the full scalar central split, rather
than relying only on the file's case and plane labels. The reference
Lang primitive is zero for each plane, as already proved by parity.

These checks connect every matrix input to the asserted actual cover.
The raw Laurent generation of all six Hodge columns for every new
representative is not independently rerun here, as specified in the
audit request. It relies on the unchanged audited producer, whose
complete top-column and deck computations were independently replayed
on the three distinct pilot covers. The present audit independently
reconstructs every complete matrix rank from the saved coefficients.

## 3. Independent complete ranks

For each representative the checker reconstructs g and the central
generator by constant binomial translation and loads the full actual
h-deck matrix. It checks `gh=c hg` and `h^5=1` on all 750 basis vectors.
The six saved top Hodge columns are then translated by all actual group
elements `g^a h^b c^d`, giving 750 image vectors. PARI dense finite-field
rank computes their complete rank over F_(5^12).

This differs from the producer's augmentation monomials and sparse
greatest-pivot elimination. The free-generator theorem applies to every
actual cover in these families, including nonzero central choices;
its norm identity is independent of the local Lang right sides. Hence
the computed image rank is the full Hodge rank, not a lower bound from
selected columns.

Every independently recovered rank is compared with both its individual
rank receipt and the census summary. Actual coefficient conjugacy then
propagates that rank to every label in its verified orbit. The weighted
distribution is rebuilt label by label, without using the summary's
histogram as a premise.

## 4. Distribution and the original base plane

The complete independently recovered distributions are:

| Fixed case | Independently ranked orbit representatives | Defects over all 155 covers |
| --- | --- | --- |
| 0, branch A3 | 3 of rank 713; 48 of rank 721 | 5 of defect 37; 150 of defect 29 |
| 2, mixed A1 | all 42 of rank 721 | all 155 of defect 29 |

In case 0 the three rank-713 orbit representatives have orbit sizes
1,2,2 and cover exactly `(plane 0, central j)` for all five j in F5.
No other label has defect 37. Every non-base plane has all five of its
cover classes of defect 29. In case 2 every plane and every central
choice has defect 29, so there is no distinguished high-defect plane.

The original base plane is identified geometrically, not only from the
saved Boolean flag. Pullback H1(O_B) is the subspace spanned by `v/u`
and `v/u^2`; a plane comes from B precisely when both independent AS
representatives have zero `ell/u` coefficient. The checker applies this
test to every plane and finds exactly plane 0 in each case, agreeing
with the stored `pulled_back_from_B` labels.
Thus the unique high-defect plane in the branch census is precisely
the original base plane, for a geometric reason independent of the
saved Boolean flag.

## 5. Evidence and limitations

Independent completion checker: `scripts/audit_heisenberg_census.py`.
It imports only the preceding auditor's independent base algebra and
no producer module. Each final independent receipt retains every input
hash and every representative rank, along with its 155-label defect
table. Matrix-generation files and research state/library were not
modified by this audit.

All 93 representative ranks were recomputed. The checker verified
279 Hodge/deck/rank artifacts and 291 distinct hashed inputs including
the summaries, geometric inputs, orbit tables, and audited code.
It used one CPU, sequentially: 215.52 seconds for case 2 and 270.30
seconds for case 0. The completed producer censuses took 3031.82 and
3593.36 seconds respectively; both final summaries have no failures.

Receipts in `Research/computations/`:

| File | SHA-256 |
| --- | --- |
| `heisenberg125_census_case0_independent_audit_20260911.json` | `ac056fc67bc2214226ef34c0c933e5929206f32022297c13429c2865adff872a` |
| `heisenberg125_census_case2_independent_audit_20260911.json` | `bcda29977f741c525b04b340e319b023b5ab91479f99e17e94887e9df40899d3` |

The completion checker SHA-256 is
`2a9e36eb35105780490ee7772d37c71f25bc7580d957b29b31ba74a4fcaa4340`.
The completed producer summaries are in
`/Users/julian/Documents/litt3-computation-data/heisenberg125-census-20260911/`:

| Summary | SHA-256 |
| --- | --- |
| `case0/summary.json` | `95876efc626ac221c25d5b0cc9d4d5567e92a5d9ca69ad653bbca5c7306d8979` |
| `case2/summary.json` | `def6c764dca253d79fe9f78da1c990c4851a7a573af75f478aad0fa7fe758178` |

This is exact finite-field computation and prose audit, not Lean
verification.

No extension to all twelve bad doubles follows solely from their
abelian A3/A1 germs. The two fixed nonabelian censuses are complete in
their own stated scopes. The universal Heisenberg lower bound 25 remains
the separate canonical `augmentation_width_defect` theorem; no new
uniform exact formula or original common-cover exclusion is inferred.

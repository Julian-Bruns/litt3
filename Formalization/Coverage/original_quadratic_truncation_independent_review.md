# Independent review: whole original selected-quadratic clause

Reviewer: CartierAndSpin owner, 3 October 2026. The Deformations owner
confirmed a source freeze for the twelve new original Part1 targets and
proof modules. The reviewer read those twelve files in full, plus the
six original-ideal/comparison/arithmetic dependencies listed below and
the canonical statement and the needed Part1 human proof. The genuine
[prepared quadratic truncation](prepared_quadratic_truncation_independent_review.md)
is an accepted unchanged input; its settled proof is not re-audited here.

## Accepted exact scope

The terminal `original_quadratic_frobenius_truncation_length` proves the
whole ORIGINAL selected-quadratic assertion: for any field K of prime
characteristic p with invertible two, Q=p^n odd, arbitrary positive
lower cutoffs q_i, and Σ(q_i−1)<Q−1, every ORIGINAL
f∈m²⊂K[[x₀,…,x_d]] with nonzero ORIGINAL x₀² coefficient satisfies
dim_K K[[x₀,…,x_d]]/(f,x₀^Q,x₁^(q₁),…,x_d^(q_d))=2∏q_i.
No polynomial, normal form, formal splitting, rank or higher-term
restriction is supplied. The lower cutoffs need not be p-powers, and
algebraic closure is unnecessary. They may equal one.

`original_quadratic_frobenius_truncation_length_odd_characteristic`
derives invertible two and odd Q from the actual prime characteristic
p≠2. `original_quadratic_unique_largest_frobenius_truncation_length`
derives the strict degree bound for every actual lower p-power p^(a_i),
a_i<n, n>0 and d≤p. The formal d here counts lower coordinates, so
the original source dimension is d+1≤p+1, exactly the archived unique
largest clause. It includes a_i=0, hence lower powers one. The primary
result also allows d=0. The n=0 boundary cannot satisfy its strict
degree inequality and is not accidentally admitted.

## New implication checks

- The source ideal is literally the span of the ORIGINAL variable
  powers, joined with the span of ORIGINAL f. First-overflow coefficient
  decomposition proves the full finite projection kernel; the actual
  series/polynomial equivalence preserves original polynomial classes.
- Rectangular truncation changes f by an element of that SAME power
  ideal. The proof establishes equality of the two full source ideals
  before passing to a quotient. It does not identify unrelated normal
  forms by an assumed equivalence.
- Selected-coordinate regrouping is the actual `finSuccEquiv`.
  Each original lower power maps to its coefficient-ring power, and
  the selected power maps to X^Q. Actual surjective coefficient
  reduction retains its entire original kernel and every additional
  relation. Polynomial/series comparison transports the actual f
  relation through the genuine X^Q quotient equivalence.
- The original maximal ideal is the actual constant-coefficient
  kernel. Its square implies original total order at least two, via
  ideal-product induction. Surviving truncated coefficients retain
  the original total-order bound. Consequently the selected-series
  constant coefficient is in J² and its linear coefficient is in J.
  Monomial splitting constructs the two actual augmentation factors;
  this is a whole-ideal assertion, not an assumed weight condition.
- The residue of the selected quadratic coefficient is exactly the
  ORIGINAL x₀² coefficient of f. The strict degree bound and odd Q
  imply Q>2, so it survives the selected cutoff. Positivity of each
  q_i means its lower zero exponents survive even when q_i=1. The
  actual residue kernel is J, hence this coefficient is outside J.
- Those derived three original coefficients are exactly the inputs
  of the accepted genuine Weierstrass/prepared quadratic result. The
  final algebra equivalence preserves the original source and every
  relation, so finrank transport gives the displayed original length.
- The unique-largest arithmetic uses p^(a_i)≤p^(n−1), d≤p and the
  genuine p-factor exponent gap. There is no bounded enumeration.

No scope defect was found. The entire archived
`frobenius_truncated_hypersurfaces` remains **partial**: this acceptance
covers Part1 and its unique-largest specialization, not balanced node,
actual toric/Morse, or actual rank-one-plane clauses. Existing useful
split/prepared special cases are retained.

## Evidence and exact pins

Focused report:
`../../../litt3-computation-data/formalization-20261003/verification/20261003T123123Z/report.json`.
It builds the terminal and checks 205 transitive Litt3 theorem
declarations, only Classical.choice, Quot.sound and propext, zero
forbidden dependencies and zero source changes. The reviewer independently
rehashed all 46 captured local sources against that report: zero
mismatches. No numerical or settled kernel-check replay was performed.
Report SHA256: 04459115a543aa52cc2181862382197532833eee937277dfe0c9baf7dc46d210.

Canonical Version1 statement SHA256:
21d69d2df228f7ddb710cdbe03485f55ad0538e92ae8bd43f15589e4ce36f00b.
Human proof SHA256:
9553c138536962078745d7dbe8745c18409efc4b77b0fcbe8c6894da4639ed38.

All paths below are relative to `Formalization/`.

| Reviewed source | SHA256 |
| --- | --- |
| Solutions/Deformations/SeriesTruncatedHypersurfaceEquivalence.lean | c36bc44a7f64a6719576190a8534ed35dbafb86adc18e86b2e348e297b45e130 |
| Solutions/Deformations/TruncatedPolynomialRegrouping.lean | 01bc2f226fc8e5e5b72a5fbde9c4ee5e6bae30c24e000dadcad6d2ed8049d482 |
| Solutions/Deformations/PolynomialCoefficientQuotients.lean | c67ab0a19ef97f88a547e666e9b6d3f5383d5c645655a7b2ac4eb723f550b200 |
| Solutions/Deformations/SurjectiveRelationQuotients.lean | a4fd404daa621f4b977b10a7701e1345e002f28646c839de6cd12c88d83d02f1 |
| Solutions/Deformations/PolynomialSeriesPowerCutoffRelations.lean | df341cef8ecece870adb1a747c4cdf68ffced97b515f532a3dfba21c09d1f832 |
| Solutions/Deformations/SelectedTruncatedHypersurfaceQuotients.lean | e1a0f11d6d90d919d61eb28ad7927e4f71a1f680c45453df0b0e246d339f70c4 |
| Solutions/Deformations/OriginalQuadraticSeriesOrders.lean | 9df994c151418c4853abdb9c063072a58aadcbaae52cbcc58d957970605a8cb7 |
| Solutions/Deformations/TruncatedMonomialQuadraticAugmentation.lean | 65585d246470fb5cc2b5972684ecc3fa4e24e1da1cda832a9ca0b3b441a38f35 |
| Solutions/Deformations/SelectedOriginalQuadraticCoefficients.lean | bca38580efd154d8e52adbad23faeceb925175c6222ac3b8c631fdbbb5ec4b11 |
| Solutions/Deformations/OriginalQuadraticFrobeniusTruncation.lean | 55acd9203964bf4cab127f6a6d315c158a0da9ff08ffc54c3d7c9f1cbb942d7b |
| Definitions/Deformations/SelectedTruncatedCoefficientPolynomial.lean | 96e519133c57b2c2d28203e4ae7a941cc8d7bdfcc99736aa704c7d520160fcb5 |
| Theorems/Deformations/OriginalQuadraticFrobeniusTruncation.lean | 9ac134dd459a582ee7d978bb44c3a82adf924313876ded81f4b5895966a91c5e |
| Solutions/Deformations/SeriesTruncatedAdditionalRelations.lean | 1539f0ae4766f5a7b89e7b1ae127dbf67284a4a6969aa90e7c38b8e264befb44 |
| Solutions/Deformations/SeriesTruncatedPolynomialEquivalence.lean | e378337d6b122066c8fdb47fd9b99f181c9f851863162cb72a4391f04db32f7c |
| Solutions/Deformations/SeriesFirstOverflowCoefficient.lean | 076a5988541d044e6d3b3560eaafafaf96e5a0d0f0dbde85062cc8f4fcb17dd4 |
| Solutions/Deformations/SeriesVariablePowerKernel.lean | ec2caecfe6b2c104c072653ed26879ebaac141e527879c8c755c10c5d18382a7 |
| Solutions/Deformations/FrobeniusTruncationArithmetic.lean | 874cbb9e4848c60f49cb2a02f3f76361fbe388f78728b0306f50be84c5f4c08e |
| Definitions/Deformations/SeriesVariablePowerIdeal.lean | 2ac3c62408c0010076dba311dbaafcbfbb3af6a29b5766f4c2db463a247b4d0c |

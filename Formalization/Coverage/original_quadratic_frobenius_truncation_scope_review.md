# Original selected-quadratic Frobenius truncation

The current canonical source is `frobenius_truncated_hypersurfaces`, Version 1,
statement SHA256 `21d69d2df228f7ddb710cdbe03485f55ad0538e92ae8bd43f15589e4ce36f00b`,
human proof SHA256 `9553c138536962078745d7dbe8745c18409efc4b77b0fcbe8c6894da4639ed38`.
Both complete current files were read. Its original selected-quadratic
Part1 and unique-largest addendum are now proved. The **whole canonical
theorem remains partial**: its balanced-node, toric and restricted-rank
arbitrary-source clauses retain the gaps stated below.

## Exact original theorem

Let K be any field of odd prime characteristic p, Q=p^n, and let
q_i be arbitrary positive integers. Let f be an arbitrary original
multivariate formal series in K[[x_0,...,x_d]], lying in the square of its
actual maximal ideal, with its literal original x_0^2 coefficient nonzero.
If sum_i(q_i-1)<Q-1, then the unchanged original quotient
K[[x_0,...,x_d]]/(f,x_0^Q,x_1^(q_1),...,x_d^(q_d))
has K-dimension 2 product_i(q_i).

`original_quadratic_frobenius_truncation_length_odd_characteristic`
proves this statement. It derives invertibility of two and oddness of Q
from the actual characteristic. The preceding general theorem makes
those two inputs explicit. Neither theorem assumes algebraic closure,
a formal coordinate change, a normal equation, a quotient equivalence,
a nilpotence conclusion or a length conclusion.

`original_quadratic_unique_largest_frobenius_truncation_length` proves the
source's unique-largest addendum: q_i=p^(a_i), a_i<n, n>0 and d<=p imply
the strict degree bound and the same original length. The q_i=1 case is
included. The canonical condition that the total number of variables
is at most p+1 is precisely d<=p here. Specializing d=1 and q_1=P<Q
also proves the canonical unequal binary length 2P whenever the original
selected quadratic coefficient is nonzero; that conclusion does not
require the stronger nondegeneracy hypothesis of the binary source clause.

## Actual source bridge

The proof keeps the original series and every variable-power relation.

- `OriginalQuadraticSeriesOrders` derives the actual maximal ideal as
  the kernel of the original constant coefficient, then proves total
  order at least two from actual membership in its square.
- `SeriesTruncatedHypersurfaceEquivalence` proves that the difference
  between f and its rectangular polynomial truncation lies in the actual
  original variable-power ideal. The resulting algebra equivalence
  retains the arbitrary additional original equation.
- `TruncatedPolynomialRegrouping` applies the actual `finSuccEquiv` and
  identifies the whole original power ideal as the lower-coefficient
  power ideal plus the selected X^Q relation. `PolynomialCoefficientQuotients`
  derives the full coefficient-reduction kernel. `PolynomialSeriesPowerCutoffRelations`
  retains the arbitrary extra relation under the actual polynomial/series
  power-cutoff equivalence. `SelectedTruncatedHypersurfaceQuotients`
  combines these into the actual original quotient equivalence with
  A[[X]]/(X^Q,g), where A=K[y_i]/(y_i^(q_i)) and g is the unchanged
  original rectangular polynomial after actual coefficient reduction.
- `SelectedOriginalQuadraticCoefficients` derives g_0 in J^2, g_1 in J
  and g_2 outside J for the actual original augmentation ideal J.
  Original support degree, the actual regrouping coefficients and
  rectangular truncation are checked explicitly. The whole monomial
  class is factored into two actual augmentation elements when proving
  J^2 membership. Lower powers one are handled. The terminal proof
  derives Q>2 from the strict bound and oddness, so the original selected
  quadratic coefficient survives truncation.
- The independently accepted `PreparedQuadraticTruncation` applies to
  this actual g. Its genuine Weierstrass polynomial and unit derive
  redundancy of the original X^Q relation and the free rank-two quotient
  over the SAME A. The original coefficient ring's constructed dimension
  gives the stated K-dimension. No finite coefficient enumeration is used.

The stronger coefficient-only arbitrary-series result is retained in
`prepared_quadratic_truncation_scope_review.md`; its independent accepted
scope is recorded in `prepared_quadratic_truncation_independent_review.md`.
The earlier scope note's remaining original multivariate bridge was the
then-current gap and is closed by the present theorem.

## Remaining canonical clauses

The balanced binary nondegenerate quadratic clause still requires an
actual permissible node change from the original rank hypothesis. The
original node quotient basis and length, formal-series quotient transport
and conditional coordinate-change consequence are already proved.

The three-variable nondegenerate-plane toric clause requires the original
source reduction and an actual `xy-z^s` quotient basis with proved
independence and exact floor/remainder length. Its p=5 consequences must
follow from that actual quotient. The restricted-rank clause still needs
to carry the actual original hypersurface to a quadratic equation with
the actual remainder in (y^3,yz,z^2); the weighted nilpotence and resulting
literal split quotient length are already proved. These unresolved clauses
prevent promotion of the whole canonical source.

## Verification and exact frozen sources

Focused report
`../../../litt3-computation-data/formalization-20261003/verification/20261003T123123Z/report.json`
built `Solutions.Deformations.OriginalQuadraticFrobeniusTruncation` and
audited 205 transitive Litt3 theorem declarations. Build and audit returned
zero, the only axioms are `Classical.choice`, `Quot.sound`, `propext`,
forbidden dependencies are zero and changed sources are zero. The owner
independently rehashed all 46 captured local sources with zero mismatches;
root independently checked all 46 with the same result. The independent
CartierAndSpin reviewer read the twelve new frozen files and six needed
original-ideal/comparison/arithmetic dependencies in full, matched the
canonical Part1 and human proof, and accepted the exact original scope
with no defect. That reviewer also independently rehashed all 46 sources
with zero mismatches. The full accepted readback is in
`original_quadratic_truncation_independent_review.md`; settled preparation
foundations were reused. Report SHA256:
`04459115a543aa52cc2181862382197532833eee937277dfe0c9baf7dc46d210`.

All following paths are relative to `Formalization/`.

| Source | SHA256 |
| --- | --- |
| `Theorems/Deformations/OriginalQuadraticFrobeniusTruncation.lean` | `9ac134dd459a582ee7d978bb44c3a82adf924313876ded81f4b5895966a91c5e` |
| `Definitions/Deformations/SelectedTruncatedCoefficientPolynomial.lean` | `96e519133c57b2c2d28203e4ae7a941cc8d7bdfcc99736aa704c7d520160fcb5` |
| `Solutions/Deformations/SurjectiveRelationQuotients.lean` | `a4fd404daa621f4b977b10a7701e1345e002f28646c839de6cd12c88d83d02f1` |
| `Solutions/Deformations/PolynomialCoefficientQuotients.lean` | `c67ab0a19ef97f88a547e666e9b6d3f5383d5c645655a7b2ac4eb723f550b200` |
| `Solutions/Deformations/TruncatedPolynomialRegrouping.lean` | `01bc2f226fc8e5e5b72a5fbde9c4ee5e6bae30c24e000dadcad6d2ed8049d482` |
| `Solutions/Deformations/PolynomialSeriesPowerCutoffRelations.lean` | `df341cef8ecece870adb1a747c4cdf68ffced97b515f532a3dfba21c09d1f832` |
| `Solutions/Deformations/SeriesTruncatedHypersurfaceEquivalence.lean` | `c36bc44a7f64a6719576190a8534ed35dbafb86adc18e86b2e348e297b45e130` |
| `Solutions/Deformations/SelectedTruncatedHypersurfaceQuotients.lean` | `e1a0f11d6d90d919d61eb28ad7927e4f71a1f680c45453df0b0e246d339f70c4` |
| `Solutions/Deformations/OriginalQuadraticSeriesOrders.lean` | `9df994c151418c4853abdb9c063072a58aadcbaae52cbcc58d957970605a8cb7` |
| `Solutions/Deformations/TruncatedMonomialQuadraticAugmentation.lean` | `65585d246470fb5cc2b5972684ecc3fa4e24e1da1cda832a9ca0b3b441a38f35` |
| `Solutions/Deformations/SelectedOriginalQuadraticCoefficients.lean` | `bca38580efd154d8e52adbad23faeceb925175c6222ac3b8c631fdbbb5ec4b11` |
| `Solutions/Deformations/OriginalQuadraticFrobeniusTruncation.lean` | `55acd9203964bf4cab127f6a6d315c158a0da9ff08ffc54c3d7c9f1cbb942d7b` |

The target proposition states only the exact original quotient conclusion;
it is a definition, not an assumed theorem. The terminal solution proves
it from the actual original series hypotheses and the displayed bounds.

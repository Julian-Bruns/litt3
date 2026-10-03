# Original rank-one quadratic truncation: independent core review

Cartier read the six new rank-one solution modules and the target in full
on3October2026. This review covers the coefficient/preparation/power-ideal
argument, its selected original-series bridge and the statement of the
whole original rank-one endpoint. Verdict: **PASS at the exact stated
scopes**. Deformations separately reviews the final arbitrary-frame wrapper
integration; the actual generic coordinate construction is already accepted
in [original_plane_quadratic_frames_independent_review.md](original_plane_quadratic_frames_independent_review.md).

The retained archive statement is version1,13September2026, at
[frobenius_truncated_hypersurfaces.md](../../Theorems/deformations/abelian_covers/frobenius_truncated_hypersurfaces.md).
Its SHA256 is
`21d69d2df228f7ddb710cdbe03485f55ad0538e92ae8bd43f15589e4ce36f00b`;
the corresponding human proof SHA256 is
`9553c138536962078745d7dbe8745c18409efc4b77b0fcbe8c6894da4639ed38`.
This review accepts the rank-one assertion of Part3 and its p≥5 unequal
Frobenius specialization, with the original source and cutoffs retained.

The checked endpoint in `OriginalRankOneFrobeniusTruncation` takes any field
K of odd prime characteristic p, Q=p^n and T>0, with Q odd and
4T<Q+3. Its literal original input is any f∈(x,y,z)^2 in K[[x,y,z]],
with original a=[x²]f,b=[xy]f,c=[y²]f, b²=4ac and a≠0∨c≠0. It proves
dim_K K[[x,y,z]]/(f,x^Q,y^Q,z^T)=2QT. Under odd characteristic these
quadratic hypotheses express precisely a nonzero rank-one binary plane:
if both diagonal coefficients vanish then b²=0 forces b=0. Arbitrary
higher terms and every original scalar and displayed power are retained.

The important new argument has been checked at its actual ideal scope.

- `SelectedPolynomialQuadraticCoefficients` derives all coefficient
  conditions for the actual selected-variable series from the entire
  original polynomial. With original xy and y² coefficients zero,
  its constant coefficient lies in I=weight≥3, and its linear coefficient
  lies in J=weight≥2, using weights wt(y)=1,wt(z)=2. The excluded low
  terms are derived from the original degree≥2 condition and the unchanged
  original quadratic coefficients. No normal-form shape is assumed.
- The actual weighted ideals satisfy I≤J and J²≤I. These are ideal
  inclusions in A=K[y,z]/(y^Q,z^T), not just statements about selected
  monomials or a proposed support.
- `PreparedQuadraticCoefficientIdeals` uses the genuine factorization
  g=f·h, with h a series unit, to derive f0∈I and f1∈J. The constant
  coefficient is recovered by multiplying by the inverse actual unit
  constant. The coefficient-one equation then gives f1 after subtracting
  the term involving f0. This preserves the original weighted conditions
  over the nonreduced base; neither prepared condition is inserted as an
  assumption about the original source.
- Q=2m+1 and 4T<Q+3 imply that the largest surviving weighted degree
  (Q−1)+2(T−1) is strictly smaller than3m. The accepted whole weighted
  ideal nilpotence theorem therefore gives c^m=0 for every c∈I.
  This implication was checked against the full actual truncated weighted
  ideal, including cancellations and arbitrary original coefficients.
- For the actual monic quadratic f, its half-linear translation t is in J,
  t²∈I, and the actual square-completed remainder lies in I. Hence the
  remainder's mth power and t^Q vanish. The characteristic-p Frobenius
  substitution fixes the original X^Q relation. The proof transports
  redundancy back through the genuine Weierstrass map and proves the
  literal equality of original ideals (g,X^Q)=(g).
- The genuine monic quadratic quotient is free of rank2 over the same A.
  Its field dimension is 2·Q·T using the actual finite monomial algebra
  dimension. The selected original polynomial and series bridges preserve
  all three powers and the entire original equation.
- The whole endpoint first transports the original arbitrary series to
  its actual rectangle polynomial. The strict bound with T>0 implies Q>2,
  so all original binary quadratic coefficients survive. The accepted
  invertible linear-plane frame fixes z and preserves the actual equal
  x/y Frobenius powers, deriving a'≠0,b'=c'=0 from the original rank-one
  conditions. Thus its use meets the selected polynomial theorem's exact
  hypotheses without assuming a formal normal form.

The Q=1 boundary is correctly excluded by the displayed hypotheses:
T≥1 would require4T<4. The lower cutoff T=1 is retained wherever the
strict bound holds. The `original_rank_one_unequal_frobenius_truncation_length`
specialization takes actual T=p^a, Q=p^n, p≥5 and T<Q, derives the strict
bound using 5T≤Q, and proves the same literal original quotient length.
It includes a=0 and requires no algebraic closure, perfection, enumeration
or supplied rank/length computation.

Focused final evidence:
[report.json](../../../litt3-computation-data/formalization-20261003/verification/20261003T190500Z/report.json).
This report checks both `OriginalRankOneFrobeniusTruncation` and
`OriginalToricFormalType`; the present mathematical verdict covers the
rank-one chain only. Build and axiom audit exit0, with436transitive
declarations and76local source hashes. The only axioms are
`Classical.choice`, `Quot.sound`, `propext`; forbidden dependencies and
changes during checking are empty. Cartier independently rehashed every
one of the76captured local sources after readback: zero mismatches.
Report SHA256:
`79fba6b4e2ee56e557588ff04b71d0d23746992dd064e46d4a5717179eb3e4e3`.

Exact new source pins; paths are relative to `Formalization/`.

| Source | SHA256 |
| --- | --- |
| `Solutions/Deformations/PreparedQuadraticCoefficientIdeals.lean` | `f7245d7f3dbf1c4945b4640429bb445e2bd9a187d1fe47cea745f9ce64a9be21` |
| `Solutions/Deformations/SelectedPolynomialQuadraticCoefficients.lean` | `83b2330e518d1b5f7008e01f8610e185955627b7a69b872f2d5bac16aca5c095` |
| `Solutions/Deformations/RankOnePreparedTruncation.lean` | `bf6976266ddb16305ff91338c578c37a05f2670a9e4eb64b57ba5dcbc4f2a3d5` |
| `Solutions/Deformations/OriginalSeriesRectangularQuadraticCoefficients.lean` | `d34ccbdcab3ab60122b5afbf420c85ab3aaae9896812edc88986ef637835380c` |
| `Solutions/Deformations/OriginalSelectedRankOneTruncation.lean` | `261295d5a4a31cacb9956f1c581a75303b7c13fbec6250cc97b33a006725d12b` |
| `Solutions/Deformations/OriginalRankOneFrobeniusTruncation.lean` | `0104382ae77b08468476e873ad98d779b83d63cc67f34f6b1eb8dbbde54fedb2` |
| `Theorems/Deformations/OriginalRankOneFrobeniusTruncation.lean` | `b93a80182163d8a9d1632a40823258900eb1c736ceae7ddde697a7038362f35d` |

`TruncatedWeightedNilpotence`, `WeightedMonomialIdeal`, the original
source quotient maps and the previously accepted genuine preparation are
reused inputs. Their settled audits were not replayed. The new weighted
inequality and its use on the actual whole ideals were inspected directly.

This accepts the entire original rank-one clause under the explicit
inequality and its actual p≥5 unequal-Frobenius specialization. It does
not accept an unequal-power nondegenerate residual formal normalization,
the toric component merely because it shares the focused report, or the
whole multi-clause archive record. Those scopes remain separately tracked.

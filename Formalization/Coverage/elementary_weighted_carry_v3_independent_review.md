# Independent whole-source review: elementary weighted carries Version3

The current Version3 of `elementary_weighted_carry` is accepted at its full
algebraic scope. This review read the complete canonical statement, the
complete current human proof, the complete quantified Lean specification
and aggregate proof, the specialization module, and all 97 new or
generalized local source files in dependency order. The previously
accepted Version1 foundations were reused; no settled numerical check or
old Lean audit was replayed.

The statement SHA256 is
`cda41fd6c6462a23892b6c351df16937e8802e6d4d26349bd592c60d168d9da6`.
The human proof SHA256 is
`77c92644335b2736832ba86bef8d45a0f8992ba3ece74d7b6689494bdb2d260b`.
The source paths are
[the canonical statement](../../Theorems/deformations/elementary_covers/elementary_weighted_carry.md)
and [the human proof](../../Proofs/deformations/elementary_covers/elementary_weighted_carry.md).
This acceptance applies to these exact sources and the exact audited Lean
closure, and must be invalidated or reviewed again if their mathematical
scope changes.

## Exact inputs and generality

The formal result `ElementaryPrimeWeightedCarryResult` is proved by
`elementary_prime_weighted_carry`. It concerns the literal additive group
algebra of the unchanged original group `Fin r → ZMod p`, with actual
coefficient ring `TruncatedWittVector p N k`. The input operator is an
additive homomorphism; its higher coefficient operators need neither
coefficient linearity nor mutual commutativity.

`ElementaryPrimeWittReduction` contains exactly deck equivariance,
homogeneity of the principal polynomial q, higher monomial degree at
least a+1, and the full actual coefficient reduction identity
L mod p = (q+h) times coefficient Frobenius. That Frobenius fixes the
original group generators. The anisotropy input tests every nonzero
original prime-field tuple. No graded presentation, kernel bound,
surjectivity, norm-solubility, dimension, detector vanishing, or repair
conclusion is supplied as an input.

The terminal theorem assumes p prime, p>2, positive rank, perfect
characteristic-p coefficients, 2≤a and a+1≤p−1. It contains the complete
canonical p≥5, r≥2, 2≤a≤p−2 scope and also proves rank-one and
precision-one instances. The grading statement holds at every positive
precision, independently of the operator. There are no project-specific
axioms or accepted-literature interfaces in the argument.

## Whole-source clause readback

| Source conclusion | Literal formal conclusion and reviewed argument |
| --- | --- |
| Actual graded algebra and original parameters | `grading` uses the genuine Wd/W(d+1) quotient. Its denominator is an actual next-weight subgroup. The exact kernel and full range are proved before constructing the equivalence. Residue-field scalars agree with actual Witt coefficient multiplication; quotient products agree with actual representative multiplication. Original ei and actual p map to Ei and tau; the actual coefficient quotient and monic parameter quotients satisfy tau^N=0 and Ei^p=−tau Ei. The complete degreewise comparison and multiplication data realize the displayed graded presentation. |
| Kernel threshold at precision m≤r | `precision` excludes each lower weight using the actual principal action q times coefficient Frobenius and the proved anisotropic homogeneous kernel bound, including the augmented truncation boundary. |
| Final precision kernel threshold D | `final.kernel` uses the sharper final homogeneous kernel bound, with D=(p−1)r. |
| W(D+a) lies in L(WD) | `final.tail` constructs genuine corrections successively and terminates at the actual nilpotent weight cutoff 2D+1. It proves an entire operator image statement. |
| Reduction of WD is exactly the full norm line | `final.normLine` identifies the literal sum of all original group elements with the top original augmentation monomial and realizes every coefficient through an actual residue lift. |
| Integral norm at precision r | `integral.normTarget` derives the true integral norm weight, then W(D−a) for every solution and zero actual coefficient-sum augmentation. |
| Divisible integral norm at precision r | `integral.divisibleNormTarget` uses the actual residue kernel to raise the norm target by p−1 and derives W(D−a+1). |
| Leading ideal powers and annihilators | The actual augmentation ideal kernel equals the degree-one ideal; its actual powers equal the original degree spans. Actual complementary monomial products extract each top coefficient. This proves Ann(J^s)=J^(D+1−s), even for arbitrary nontrivial commutative characteristic-p coefficient rings, and then both required leading-reduction identities. No pairing or ideal presentation is assumed. |
| Final integral norm solvability iff eta mod p=0 | `normNecessary` derives augmented image zero from deck equivariance and additivity, uses the genuine nonterminal Witt annihilator to force divisibility, and bounds every solution by WD. `normSoluble` proves the reverse implication by actual tail correction. |
| Entire final norm fiber, with every leading coefficient | `fullNormFiber` uses the explicit literal norm lift of a prescribed coefficient c. Deck equivariance makes its image another literal norm target. The additional correction has weight D+p−1−a>D, so its entire reduction is zero and the prescribed c is preserved. This is stronger than merely obtaining one solution or containment in the norm line. |
| Projective representative independence | `projectiveIndependence` checks the actual homogeneous scaling character and original prime-field unit powers; every critical summand is independent of its representative. |
| Critical detectors and actual repair image | `detector` is an iff for the full original residual R and the actual subgroup pLambda+WD. The forward proof constructs an actual graded lift, applies actual inverse coefficient Frobenius, and removes all higher residuals. The reverse proof excludes every lower preimage weight and identifies the true initial polynomial below the first killed parameter weight. |
| Critical source and target dimensions | `dimensions` uses genuine original normal interpolation and finite-field unit cyclicity to identify both homogeneous components with scalar-character functions on actual projective lines. The precise quotient truncation bounds transfer this to the actual Witt graded classes. Both dimensions are (p^r−1)/(p−1). |
| Unique critical preimage and extracted coefficients | `criticalDivision` proves existence and uniqueness of ordinary qH=Z in weight D−1. `detectorCoefficients` gives inverse Frobenius of the exact coefficient at exponent p−2 in index i and p−1 elsewhere. This equals the corresponding coefficient of the genuine semilinear preimage. |
| Exact sign, Frobenius order, and p=5 specializations | Full vector moments contribute (−1)^r; passage to projective lines contributes another minus sign. The definition applies inverse Frobenius after the entire signed sum. The specialization module proves both parity signs and the full p=5,a=2 result, including the rank-three weights 7,11,12,14,13. |

The formal proof uses direct homogeneous interpolation and division for
the high-image arguments. It need not supply a numerical Hilbert-series
certificate from the human proof. Every required image conclusion is
proved by the actual division and correction chain. Symbolic arguments
work uniformly in p and r; ground arithmetic only evaluates the displayed
prime-five and rank-three specialization data.

## Trust and provenance

The focused report
[20261003T105531Z](../../../litt3-computation-data/formalization-20261003/verification/20261003T105531Z/report.json)
passed `Solutions.Deformations.ElementaryPrimeWeightedCarrySpecializations`
and all 1,217 transitive Litt3 theorem declarations, with 219 local source
hashes. The only recorded axioms are `Classical.choice`, `Quot.sound` and
`propext`; forbidden dependencies and source changes are both zero.

The independent readback list and SHA pins are
[the 97-file inventory](../../../litt3-computation-data/formalization-20261003/weighted-carry-v3-readback/new_import_closure.json)
and [dependency order](../../../litt3-computation-data/formalization-20261003/weighted-carry-v3-readback/new_import_closure_dependency_order.txt).
All 97 current hashes matched that inventory at the end of reading. The
entire 219-file current closure also matched the focused report, and all
97 readback hashes were contained with identical values in that report.
The current canonical statement and human proof hashes were checked again.
The owner scope map is
[the Version3 clause card](elementary_weighted_carry_v3_scope_review.md).

The acceptance covers this entire additive algebraic theorem. It supplies
no estimate for a whole nonlinear geometric Witt residual and no
automatic vanishing of its detectors. It supplies no formal nodal
coordinate, discriminant, geometric descent, or common-cover solution.

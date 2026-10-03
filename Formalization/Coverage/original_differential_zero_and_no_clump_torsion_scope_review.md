# Original differential zeros and no-clump primary torsion

This is a proved component of the original two-map problem, not a
completion of `saturated_divisor_relations`. All geometric conclusions
retain a literal `FiniteEtaleSpan X Y`, its SAME integral source, BOTH
original finite étale surjective maps, and their common original
coefficient-field structure. The unmarked common-cover problem remains
unsolved.

## Actual objects and hypotheses

The endpoint schemes are integral smooth curves over an algebraically
closed field `k`, with the original structure morphisms. Unless the
individual statement says otherwise they are proper. The characteristic
is arbitrary for zeros, differential regularity, ratios, clumps, and
shared-form vanishing. Only the terminal characteristic-primary unit
quotient theorem assumes prime characteristic `p`.

An original differential zero means an element in the image of
`maximalIdeal R • ⊤` in the ENTIRE actual stalk module `Ω_k(R)`, under
the actual universal map to `Ω_k(K)`. It is not defined by a presumed
valuation or by a supplied compatible frame. Its literal residue-fiber
interpretation is proved using the actual tensor-quotient equivalence.
The genuine `H0` module is the global sections of the original associated
differential sheaf, with its original coefficient-field action. The
dimension hypothesis below is `2 ≤ Module.rank k H0` on ONE endpoint.
No genus or canonical-degree identification is assumed.

## Claim mapping

| Module | Checked claim |
| --- | --- |
| `Definitions.CartierAndSpin.DifferentialZeroLattices` | Literal original maximal-ideal submodule image in entire universal differentials. |
| `Definitions.CartierAndSpin.SchemeDifferentialZeros` | Actual original closed-point zero set. |
| `DifferentialZeroCoordinates` | Any true rank-one coordinate carries ideal times the entire module to that ideal; genuine zero is exactly a maximal-ideal coefficient. |
| `PrimitiveDifferentialRatios` | A regular differential outside the original zero lattice is a local frame, so the ratio of any other regular form is an ORIGINAL stalk element. |
| `DVRDifferentialZeroValuation` | Original zero membership iff the actual normalized DVR valuation of the genuine field coordinate is strictly below one. Full localization compatibility is derived. |
| `DifferentialZeroResidueFibers` | For any commutative ring and module, ideal-submodule membership iff the actual residue tensor is zero; specializes to the original differential zero lattice without freeness or rank assumptions. |
| `SmoothAffineDifferentialCoordinates` | Genuine standard-smooth dimension-one charts produce actual free rank-one coordinates of their ENTIRE differential modules. |
| `DifferentialCoordinateLocalizations` | The original chart-to-stalk-to-generic universal differential maps give compatible coordinates by full composition, not an assumed frame equation. |
| `UnramifiedDifferentialZeros` | Actual unramified local DVR maps reflect and preserve maximal-ideal differential zeros. |
| `SmoothEtaleDifferentialZeros` | The original finite étale maps preserve and reflect actual closed-point zeros; literal zero-set pullback equality is a conclusion. |
| `RationalDifferentialFiniteZeros` | EVERY nonzero rational form has finite original zero support on an actual quasi-compact smooth integral curve. Actual chart covers and finite principal supports are derived. Zero forms are excluded here, as required. |
| `ProperDifferentialRatioConstants` | A nowhere-zero nonzero globally regular form spans all globally regular forms over the ORIGINAL constants, through actual stalk ratios and proper global constants. |
| `GlobalDifferentialDimensionZeros` | Such a form forces genuine H0 rank at most one; genuine H0 rank at least two forces every nonzero global regular form to have a true original zero. |
| `SharedDifferentialZeroClumps` | A nonzero shared form with an actual zero gives a genuine nonempty finite clump for BOTH original maps. Finite support and equal pullbacks are proved. |
| `NoClumpSharedDifferentialVanishing` | Literal `IsEmpty s.fiberClump` plus ONE genuine H0 rank at least two implies the ENTIRE actual shared rational subspace is zero, in any characteristic. Endpoint regularity, zeros and clumps are derived. |
| `NoClumpConstantIntersection` | No-clump implies literal intersection of the two actual embedded function fields consists of the same original constants. The first endpoint is proper; the second needs only quasi-compactness. Actual principal-divisor pullbacks and the proper principal kernel derive the result. |
| `NoClumpPrimaryTorsionVanishing` | In prime characteristic, no-clump plus ONE genuine H0 rank at least two eliminates the ENTIRE actual characteristic-primary component of `K(source)^*/(K(X)^* K(Y)^*)`. Constant intersection, Cartier/logarithmic converse, field generation, separability and shared vanishing are all derived. |

All unprefixed modules in the table lie in `Solutions.CartierAndSpin`.
The last theorem has no finite-primary, bounded-exponent, fixed-cardinality,
supplied Cartier or supplied field-intersection premise.

## Verification and remaining scope

Focused verification captured
`Solutions.CartierAndSpin.NoClumpPrimaryTorsionVanishing` and
`Solutions.CartierAndSpin.DifferentialZeroResidueFibers`:
`../litt3-computation-data/formalization-20261003/verification/20261003T085639Z/report.json`.
Both roots build; 1,330 transitive Litt3 theorem declarations use only
`Classical.choice`, `Quot.sound`, and `propext`; there are zero forbidden
dependencies and zero source changes. The report preserves the exact
transitive source hashes. The earlier twelve-file regularity/H0 chain
has separately accepted independent readback and audits 832/895.

This component does not identify genus with genuine differential H0,
prove a clump-count theorem, prove canonical-power existence, assert root
existence from root uniqueness, or prove finiteness of an entire primary
component in the nonvanishing branch. Those remain separate scope gaps.
No accepted literature premise is used in the displayed formal chain;
the mathematical library dependencies are recorded transitively.
No numerical enumeration or external computational certificate is used.

The two subsequent uniqueness wrappers and stronger arbitrary-rational
zero/at-most-one-clump extension are outside this exact 08:56 snapshot;
their distinct later focused audit and scope card must be cited instead.

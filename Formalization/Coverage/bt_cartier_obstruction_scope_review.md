# Actual coefficient obstruction comparison

Canonical scope: Parts 2–5 of
`Theorems/deformations/bt_p_cover_cartier_obstruction.md`, Version3,
and the five-group comparison clause of
`Theorems/deformations/versal_bt_extension_torsor.md`, Version2.
Both current statements and the Cartier proof were read through the
canonical workspace interface on 3 October2026. Their geometric
statements remain partial.

`InvariantDescentSquare` retains two actual upper spaces L,U and two
actual downstairs spaces DL,DU. Its maps are actual linear maps, its
upper map is equivariant, and its square commutes. The source and target
pullbacks have full invariant images. Only target injectivity is needed
for the obstruction comparison; source injectivity is needed for
identifying downstairs kernel dimensions.

`InvariantCokernelObstruction` constructs the genuine induced map
DU/range(lowerMap)→U/range(upperMap). A point b of L whose actual upper
image is invariant gives the actual kernel cocycle g↦g·b−b. Its image
has a unique actual downstairs descent, whose cokernel class lies in
the kernel of the induced pullback. The two maps out of these actual
primitives have exactly the same full kernels. Actual ambient cocycle
primitives make the genuine mathlib H¹ map onto; the actual cokernel
kernel map is onto independently. Their quotient isomorphisms construct
the full linear equivalence H¹(G,ker(upperMap))≃ker(cokernelPullback).
Its application lemma proves the precise connecting representative on
every primitive. No supplied cohomology model or dimension comparison
is used to replace this map.

`InvariantKernelPullback` restricts the actual source pullback to the
actual lower kernel and proves its full image is the actual upper-kernel
invariant space. If source pullback is injective, it gives their actual
linear equivalence. `InvariantCokernelCriteria` combines that equivalence
with the fully proved characteristic-p finite p-group module criterion.
It proves the two actual kernel dimension inequalities and the complete
chain of equivalences: maximal growth, actual group-algebra freeness,
genuine H¹ vanishing, and actual cokernel pullback injectivity. Dimension
assumptions occur only in the numerical growth clauses.

`ScalarTwistedRepresentations` defines a distinct wrapper ScalarTwist σ V
with unchanged underlying addition and scalar action a·v=σ(a)v. Actual
σ-semilinear maps become linear into this distinct target. Actual deck
representations and actual pullback maps are transported directly, and
their full invariant-image and injectivity properties are proved.
`SemilinearInvariantCokernel` constructs the actual linear square from
actual equivariant σ-semilinear operators commuting with the actual
pullback. It proves that its two kernel submodules are exactly the
original semilinear kernels. There is no basis choice or identification
of a Frobenius twist with the original vector space. This permits the
actual inverse-Frobenius automorphism as σ.

`RepresentationAffineTorsors` starts from an actual full AddTorsor for
the actual representation module and an actual group action compatible
with that representation. The actual deck differences form a genuine
mathlib cocycle. Its full H¹ class is independent of every point of the
torsor, and vanishes exactly when some actual fixed torsor point exists.
`InvariantCokernelTorsors` applies the actual connecting isomorphism to
this class. It constructs the intrinsic cokernel obstruction, proves
its full point independence, and proves zero is equivalent to existence
of some fixed point. Actual ambient primitives are constructed from the
full torsor cocycle, and every such primitive gives exactly the stated
downstairs cokernel representative. Existence concerns some point;
the supplied point is not required to be fixed.

These results prove the complete coefficient algebra of the Cartier
comparison and the actual affine-torsor class formula. The following
geometric bridges remain: actual curve section spaces and their full
invariant descent; actual semilinear logarithmic Cartier operators and
their étale compatibility; actual ambient section-module freeness;
identification of every normalized marked BT next-extension class with
the full kernel torsor and its actual affine deck action; effective
descent of a fixed actual BT object; comparison with the absolute
coherent-cohomology class. Geometric
alternating tangent pairing, augmentation/Jennings conclusions and
both original common-cover problems are also outside this package.

The subsequent actual cyclic coefficient package constructs the Hom
comparison from the genuine periodic free resolution, and uses mathlib's
actual derived group-cohomology comparison. It proves the genuine H¹
norm-kernel/augmentation-image formula and its dimension identity over
every field. In characteristic p, the actual full norm on a cyclic group
of order p^a is the actual augmentation operator to power p^a−1.
The quotient block k[z]/z^j has its actual full cyclic deck action,
one-dimensional full invariant space for every positive j, norm rank
one exactly for j=p^a, and genuine H¹ dimension one exactly for j<p^a.
Actual finite products and full equivariant equivalences preserve these
counts. `NilpotentPositiveBlocks` constructs the complete quotient-block
decomposition of every actual finite-dimensional nilpotent operator
over every field. It applies mathlib's actual PID primary decomposition
to the actual polynomial module, proves every length is bounded by the
full nilpotence exponent, and removes only the genuine zero quotients.
`ActualCyclicBlockExistence` proves that the actual cyclic augmentation
operator is nilpotent and constructs the full equivariant decomposition
of the actual deck representation. Generator intertwining is promoted
to every actual deck element. `CyclicPGroupBlockExistence` constructs
the required group isomorphism from actual cyclicity and cardinality.

`CyclicCokernelBlockExistence` therefore constructs the decomposition
with exactly the actual downstairs kernel dimension many positive
blocks and proves all four exact counts in (5–6), including the literal
actual cokernel-pullback rank. No block model, presumed invariant
dimension or supplied cohomology computation is a hypothesis.
`SemilinearCyclicCokernelBlocks` applies this result to the canonical
actual distinct-twist square and retains every actual semilinear
operator and pullback. The only outstanding bridge for Part5 is the
actual geometric realization of that square and its ambient freeness.

`InvariantCokernelRank` proves the actual cokernel-rank identity for any
actual comparison square with equal finite downstairs dimensions.
`SemilinearInvariantCokernelRank` applies it to the canonical square of
distinct scalar twists. An auxiliary basis equivalence proves equality
of the two finite dimensions; that equivalence does not replace any
actual operator, pullback or canonical obstruction map.

Root's focused readback on 3 October2026 accepted the full coefficient
connecting proof, complete common kernel, primitive-surjectivity scope,
target-injectivity requirement and distinct scalar twists. It found no
new scope or sign issue. This review preserves every actual geometric
bridge listed above and does not promote a BT geometric theorem.

Validation: checkpoint `20261003T022820Z` built the two stable solution
roots `SemilinearInvariantCokernel` and `InvariantCokernelTorsors`, and
transitively audited 209 Litt3 theorem declarations. The only axioms
are Classical.choice, Quot.sound and propext; there are zero forbidden
dependencies and zero source changes during the check. All proofs are
symbolic and use actual group cochains, linear maps and quotients.
Evidence: `../litt3-computation-data/formalization-20261003/verification/20261003T022820Z/report.json`.
The separate finite-module/norm package has its earlier focused
89-declaration checkpoint `20261003T021450Z`.

`TraceSectionDescent` now retains actual injective section pullback,
its full invariant image, and a literal trace map with the exact
pullback-times-trace full group norm identity. It proves that actual
group-algebra freeness is equivalent to actual trace surjectivity.
`TraceSectionCohomology` obtains surjectivity from an actual exact
trace/boundary sequence and vanishing of its actual boundary target.
`TraceSectionFreeRank` constructs the actual group-algebra basis
indexed by the genuine downstairs section dimension. It does not
assume the desired regular-module conclusion. The actual coherent
trace-kernel sequence, its vanishing theorem, and Riemann--Roch
identification of that rank with 3g−3 remain geometric bridges.
The checkpoint `20261003T031414Z` built `TraceSectionFreeRank` and
`NilpotentSeriesQuotient` and audited 150 transitive Litt3 theorem
declarations with only the standard three logical axioms, zero
forbidden dependencies and zero source changes.

The later checkpoint `20261003T030356Z` built the stable roots
`SemilinearCyclicCokernelBlocks` and `CyclicPGroupBlockExistence` and
transitively audited 442 Litt3 theorem declarations. It checks the
complete actual block-existence and exact-count package in addition
to the actual semilinear comparison imported by that package. Only
Classical.choice, Quot.sound and propext occur; there are zero forbidden
dependencies and zero source changes. Evidence:
`../litt3-computation-data/formalization-20261003/verification/20261003T030356Z/report.json`.

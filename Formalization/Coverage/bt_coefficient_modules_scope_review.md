# Actual finite-p-group coefficient modules

Canonical algebraic input: the finite-module lemma and norm criterion in
`Proofs/deformations/versal_bt_extension_torsor.md`, under “Five-group
coefficient modules”; its consequences occur in
`Theorems/deformations/versal_bt_extension_torsor.md` and
`Theorems/deformations/bt_p_cover_cartier_obstruction.md`.

The single package statement is
`Litt3.Deformations.Specifications.FinitePGroupModuleCriteria`, proved by
`Litt3.Deformations.finite_p_group_module_criteria` in
`Solutions.Deformations.FinitePGroupModuleCriteria`. It uses an actual
finite p-group G, an arbitrary characteristic-p field k, an actual
representation ρ on an actual finite-dimensional k-vector space V,
its full actual invariant subspace and its genuine k[G]-module structure.
It proves both inequalities
dim(V^G)≤dim(V)≤|G|dim(V^G), and equivalence of maximal growth with
actual module freeness, genuine H¹ vanishing and surjectivity of the
actual group norm onto the entire invariant space.

The freeness/H¹ and freeness/norm equivalences are in fact proved for
modules of arbitrary dimension. Only the finrank formulation requires
finite dimension. Zero modules and trivial groups are included.

The proof constructs the whole embedding. `InvariantOrbitEmbedding`
chooses an ordinary linear retraction π onto the actual invariant
subspace, and sends v to the actual function g↦π(ρ(g)v).
`PGroupEssentialSocle` proves its injectivity: every nonzero actual
subrepresentation has a nonzero invariant, using the already proved
prime-field orbit-span argument. Every invariant of the actual function
representation is already in the image. No assumed minimal free
embedding, Nakayama conclusion, radical nilpotence or group-specific
table appears among the hypotheses.

`RegularFunctionTensor` constructs the full actual k[G]-linear
equivalence k[G]⊗k W≃(G→W), where the right side carries actual right
translation and inversion in the group identifies the two actions.
An arbitrary coefficient basis extends to an actual group-algebra basis.
The basis may be infinite. This proves actual freeness, rather than
equality of coefficient dimensions.

`RepresentationCocycles` identifies the full primitive property with
vanishing of mathlib’s actual degree-one group cohomology, defined by
its inhomogeneous cochain complex. Every cocycle of the function
representation has the explicit primitive x↦c(x)(1).
`EquivariantCocycleDescent` constructs the actual quotient of an
equivariant embedding; an invariant quotient point gives an actual
source cocycle. Its primitive corrects the actual lift to an invariant,
so the quotient has no invariants and therefore vanishes. This proves
surjectivity of the constructed embedding from actual H¹ vanishing.

`RegularFunctionNorm` computes the actual finite-group norm and proves
every invariant coefficient is reached by a single-supported function.
Every invariant linear functional on the full function module factors
through that norm. `PGroupNormFreeness` applies actual nonzero p-group
invariants to the dual of the actual quotient. A hypothetical nonzero
quotient would supply an invariant functional annihilating the image;
norm surjectivity makes every one of its coefficient values zero.
The quotient must therefore vanish. This works for noncommutative
group algebras without invoking a commutative Nakayama theorem.

The complete algebraic finite-module and norm clauses are now proved.
Actual curve section modules, the associated trace-kernel bundle and
its coherent filtration, geometric trace surjectivity, Riemann–Roch,
actual invariant section descent and the marked BT realization remain
separate geometric bridges. The package alone does not prove ambient
freeness for a curve, evaluate an actual BT class, or settle an actual
two-map common-cover problem.

Validation: all listed modules and the package build with the pinned
Lean/mathlib toolchain. Focused checkpoint `20261003T021450Z` built
the stable package and transitively audited 89 Litt3 theorem declarations.
Its only transitive axioms are Classical.choice, Quot.sound and propext;
there are no forbidden escapes or source changes during verification.
Evidence: `../litt3-computation-data/formalization-20261003/verification/20261003T021450Z/report.json`.
The preceding full snapshot `20261003T015422Z` predates this package.

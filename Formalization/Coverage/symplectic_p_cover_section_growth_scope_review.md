# First socle section growth: exact partial scope

Canonical target: `Theorems/deformations/section_growth/symplectic_p_cover_section_growth.md`,
Version7. This is a partial component formalization, not full-source completion.

`Definitions.Deformations.SocleCupForms` constructs the actual boundary
δ : (ι → V) → V*, δ(x)=Σᵢ Bᵢ(xᵢ,-), and the complete common radical
R=⋂ᵢ ker Bᵢ. `SocleSectionSequence` contains actual linear maps V→W→V^ι,
injectivity of the first map and both exact range-kernel equalities. It
contains no dimension formula, preservation conclusion or chosen radical.

`socle_boundary_coannihilator` proves (range δ)^⊥=R for any finite family of
actual reflexive bilinear forms over any field. Testing an actual single
coordinate gives one inclusion; reflexivity and the actual sum give the
other. Rank-nullity and the finite-dimensional dual coannihilator identity
then prove `first_socle_section_count`, dim W=d r+dim R. This is the exact
linear algebra underlying proof Section1 and the equality in source Clause1.
The generality is stronger than the source: alternation, algebraic closure,
characteristic p and a group do not enter this identity.

`first_socle_section_lower_bound` uses an actual injective W→U to establish
the source's numerical upstairs bound. `socle_bound_preservation` proves
that an upper bound r with r>0 and d>0 forces d=1 and R=0.
`socle_bound_preservation_even` then obtains a genuinely nondegenerate
single alternating form and proves r even when 2≠0. This covers the
parity part of Clause1, without assuming group cyclicity.

`odd_first_socle_strict_growth` proves dim U≥r+1 for odd r and d>0.
`alternating_one_dimensional_radical` derives vanishing in dimension one
from an actual radical complement and its even nondegenerate dimension.
Consequently `one_dimensional_first_socle_lower_bound` proves dim U≥1+d.
`first_socle_generator_dimension_bound` combines this with the r≥2 case
to prove d+1≤dim U whenever r,d>0. These are the numerical implications
used in proof Sections2-3 and source Clauses1-3.

All these solution modules build with symbolic arguments. Their hypotheses
are actual maps, forms, exactness and injectivity; no local project result
is encoded as an axiom and no asserted dimension conclusion is supplied
as input.

The actual curve extension F_C⊂h_*O_T, Serre-dual identification H¹(E)=V*,
its alternating cup representatives, exact cohomology maps and actual
section embedding are still geometric realization obligations. The
source's d=dim Hom(P,F_p) and Burnside cyclicity implication still require
actual group-theoretic realization. General Galois closure/intermediate
cover, deck quotient/descent, quadratic character, normal complement,
connection-defect applications, both-leg strictness and exact semilinear
tower formulas remain separate full-source obligations. No arbitrary
group action or numerical coincidence is asserted to realize those maps.

`nonzero_p_group_invariants` builds the finite F_p orbit span of a
specified nonzero vector, proves its positive rank and p-divisible
cardinality, and applies the actual p-group fixed-point congruence to
obtain a nonzero invariant. `nonzero_characteristic_p_group_invariants`
constructs the prime-field module and actual restricted representation
from any representation over a commutative characteristic-p ring.
Neither finite dimension nor finite coefficients are required.
`p_group_invariants_eq_bot_iff` proves zero invariants iff the entire
module is zero. With an actual injective pullback whose range equals
the actual invariant space, `p_group_zero_section_preservation` gives
the source's zero-dimension implication. Actual Galois invariant descent
and passage through a source-dominated intermediate remain geometric
obligations, especially for non-Galois covers.

`ReciprocalCharacterSections` contains two actual nonzero eigensections,
one for χ and one for χ⁻¹. It does not assume χ²=1. The one-dimensional
eigenvalue uniqueness lemma and `reciprocal_character_sections_quadratic`
prove χ(g)²=1 for every g, over every field. Actual curve duality and
Riemann--Roch must still provide the reciprocal section in Clause4;
the actual distinguished étale double and remaining neutral cover
are not represented by an arbitrary quotient of an abstract group.

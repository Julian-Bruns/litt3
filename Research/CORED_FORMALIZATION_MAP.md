# No-cored-common-cover formalization map

Snapshot: 2026-09-08. This is a target-selection and dependency map, not a
Lean development. The active pair is unchanged and Litt's unrestricted
common-cover problem is UNSOLVED. Root owns strategy and the registry.

## Recommendation and exact deliverable

**Choose fixed X and the high-prime-degree genus-two partner for the
mathematically complete target. Choose C_alpha for the promising small
computation, not for an already proved no-cored theorem.**

Work over k=bar(F5), with X the exact smooth projective curve in
[fixed_pair](../Definitions/Def_fixed_pair.md). For the chosen partner C,
the desired theorem is:

> For every smooth projective connected curve Z/k and every pair of
> actual finite etale surjections f:Z->X and g:Z->C, the intersection
> f^*k(X) intersect g^*k(C), inside the SAME k(Z), equals k.

Equivalently no such span has a transcendence-degree-one core.
Do not replace either actual map by Jacobian data, a separable map, or
a presumed simultaneous Galois closure. Joint minimality is unnecessary
in the final statement. This theorem ALLOWS coreless common covers.

| Partner, with the same X | Present mathematical status | Principal remaining issue |
| --- | --- | --- |
| Active Y25: z²=(t²⁵+t⁵+t)(t²⁵+t⁵+t−1)(t−4) | No-cored theorem OPEN | Untwisted atlas tests, nontrivial twists, and smaller cored cases |
| Small C_alpha: v²=u(u−1)(u−2)(u−3)(u−alpha), alpha³+alpha+1=0/F125 | All Hermitian atlas tests COMPLETE AND AUDITED; no-cored OPEN | Seven tame and three small-wild profiles |
| C_t in that same genus-two family, with prime deg_F25(t)>max(K,120) below | No-cored conclusion already follows from library proofs | Formalize the substantial geometric chain; no new atlas emptiness computation |

“Already proved” here means author/audited prose with the stated exact
computational inputs. None of these results is currently Lean-verified.

## Complete target: high-prime-degree C_t

Use [bounded_atlas_partner_finiteness](../Theorems/Thm_bounded_atlas_partner_finiteness.md)
v2 with q=25, g=9, h=2 and B=336000. Concretely set

    D=335999!, G=1+8D, L=336000², M=42000,
    K=D*(D!)^18*3^(4G²L)*(42000!)^(2G+L).

For ANY prime r>max(K,120) and ANY t of degree r over F25, the displayed
C_t is smooth, ordinary, genus two and has no cored common cover with X.
This is not the small C_alpha: its degree over F25 is only three.

Existence of a suitable prime and an irreducible polynomial of degree r
gives two actual curves without materializing gigantic coefficients.
Taking the least prime and first monic irreducible polynomial in a fixed
coefficient order gives a deterministic finite prescription; it is not
a practical small explicit model. A chosen root in k suffices, and the
theorem holds for every such root. Absolute simplicity of J(C_t) is neither
claimed nor needed. Ordinarity can be omitted from the no-cored deliverable.

The minimal logical chain is:

1. [cored_orbifold_bridge](../Theorems/Thm_cored_orbifold_bridge.md), author prose:
   a CORE first supplies a finite normal envelope. Alternating endpoint
   Galois closures inside it yield an actual common ETale refinement W.
   The two free deck subgroups A,B give X,Y->S=[W/<A,B>].
2. [fixed_x_orbifold_bound](../Theorems/Thm_fixed_x_orbifold_bound.md), audited prose:
   EVERY effective atlas X->S has degree<=336000, including wild,
   non-Galois and characteristic-divisible atlases.
3. [bounded_atlas_partner_finiteness](../Theorems/Thm_bounded_atlas_partner_finiteness.md)
   v2, separately audited finiteness and effective-count/avoidance scopes:
   at most K genus-two geometric partner classes, stable under F25-Frobenius.
   Each family isomorphism class contains at most120 parameters. The prime
   degree r therefore forces C_t's moduli orbit to have length r>K.

No A14/A18, Hermitian classification, oper enumeration, cubic-torsion
exhaustion, clump existence or outstanding Pro answer is required.

### What the fixed-X bound actually imports

Use [its proof](../Solutions/Sol_fixed_x_orbifold_bound.md), Sections1–3,
not its additional cored/coreless corollaries. Its proof-local inputs are:

| Input IDs | Needed content and evidence |
| --- | --- |
| fixed_pair_arithmetic | X's model, genus, canonical frame and actual Frobenius polynomial; author prose/exact Sage arithmetic, NOT a whole-statement audit |
| fixed_x_cartier_eigenforms | Every nonzero-eigenvalue Cartier form has simple zeros; audited finite-algebra certificate. The bound itself handles uniform Cartier-zero forms directly |
| contact_degree_bound | Full reduced self-correspondence contact bound, including different components; audited |
| fixed_x_two_branch_bound | Exhaustive low-different two-branch bound N<=2240 or N=112000,336000, on X alone; audited |
| integral_jump_bound v2; wild_first_layer; translation_rank_bound | Swan/first-layer, HKG and translation arguments plus finite exact numerical reductions; audited statements with proof-local inputs |
| two_primary_w3, Sections1–2 | Trace-pencil/odd-ramification argument and actual Tate-module Frobenius calculation imply W3[2^infinity]={0}; audited |

The last row is used only to exclude a two-point divisor in the non-large
wild case. Its later three-point/coreless applications are unnecessary.
The registry DAG is whole-record bookkeeping: it includes
cartier_generator/canonical_intersection and other corollary inputs that
this proof slice does NOT need. Likewise the two Jacobian absolute-simplicity
proofs and all Y25 arithmetic can be omitted from this complete target.

The local proof chain also has UNPROMOTED inputs explicitly listed by
the registry: [signature reduction](../routes/global/CORED_ZERO_ONE_FORM_INTERSECTION_AND_WILD_SIGNATURE_REDUCTION.md),
[first-break Swan argument](../routes/global/13_PROOF_LOCAL_RAMIFICATION.md),
and [bounded-denominator note](../routes/global/BOUNDED_WILD_JUMP_DENOMINATORS_BOUND_ATLAS_DEGREES.md).
Read the actual required lemma, not the inventory status as proof.
The conditional bounded-index/deeper-group corollary is not needed for
the final unrestricted genus-nine bound.

## Concrete computational targets: what is still OPEN

### Active X/Y25

Use [AFTER_ENUMERATION](AFTER_ENUMERATION.md) for the exact implication chain
and [CORED_COMPUTATION_STATUS](CORED_COMPUTATION_STATUS.md) for chart evidence.

The audited local/global classification
completed_local_orbifold_rigidity identifies the two large signatures
with the PSU/PGU Hermitian stacks. The audited
hermitian_atlas_extension_criterion and intrinsic_atlas_incidence give
exact atlas tests. dormant_rank_two_candidates is author prose with
primary-source inputs; fixed_x_oper_enumeration has an audited algebra
certificate, with additional author factorization/symmetry consequences.

The census is COMPLETE:28990 distinct opers, total length29375, comprising
55 local-length-eight points and28935 reduced points. Eighteen representatives
suffice ONLY for the untwisted test. They are not eighteen atlas solutions
or eighteen exclusions. At the linked snapshot no whole representative is
excluded. A14 and A18 are hypotheses, not certificates.

Even proving every untwisted system empty leaves every required nontrivial
tau in Pic(X)[3] (3^18 choices before symmetry) and smaller common-orbifold
degrees N<=2240. cored_quotient_torsion_sieves is an author proof excluding
N<=8 for THIS pair only; it is not a bound on deg(Z/Y). Thus the remaining
small range is9<=N<=2240, with additional necessary signature restrictions.
An atlas found on just one endpoint does not supply a common cover.

### Small C_alpha

The [backup entrypoint](BACKUP_CANDIDATE.md) and
[candidate comparison](ALTERNATIVE_CURVE_CANDIDATES.md) own this changing
calculation. The complete Hermitian exclusion now has a fresh audit and
the canonical record backup_hermitian_atlas_exclusion. Smaller-signature
arithmetic/proofs remain author work with their explicitly scoped replays.

[Preparation data](computations/backup_genus_two_preparation.json) certify
the ordinary simple genus-two curve, Hom-zero with J(X), six nonzero
Weierstrass Cartier-eigen tests and a reduced length-five oper algebra.
[Cubic-torsion data](computations/backup_genus_two_torsion.json) give the
complete reduced length40 norm algebra and all80 nonzero classes, with
F125-Frobenius orbit lengths8,24,24,24; repeated support was retained in
the equations and proved absent in the result. Together with the degree-five
oper orbit, all405 oper/twist pairs reduce to five joint representatives.

Each intrinsic system has8 variables and13 equations. All405 pairs and
all20 original projective charts are now excluded. The last three use
exact length8 finite algebras and factored polynomial unit identities
in the ORIGINAL equations. The fresh medium audit passed the complete
geometric bridge, candidate exhaustion, local bounds and all certificates.
Both large Hermitian cases are therefore unconditionally excluded.

The actual common-orbifold degrees obey n_C=N_X/8 and8|N_X. The September8
backup snapshot records nine tame and nine small-wild author exclusions,
including W1 torsion, automorphism and cyclic-cover ordinarity arguments;
the latter have all40 cyclic3 and all600 cyclic6 arithmetic tests.
The additional240 exact-order-four classes and1,200 Bol-minor tests have
a separate no-solver replay PASS (21.41 seconds), including distinctness
and the original operator/minor identities; see the
[replay receipt](computations/backup_genus_two_four_torsion_verification.json).
This checks the author computation, not the remaining geometric hypotheses.
Their exact hypotheses, certificates and remaining necessary profiles
belong to that entrypoint. Neither these author results nor the new
nilpotent census constitute an independently audited no-cored theorem.
The completed all405 exclusion eliminates the large Hermitian alternatives,
not arbitrary common covers. The current smaller remainder is seven tame
and three small-wild profiles. Fixed-Y25 exclusions do not transfer.

## Lean work packages and exact certificate boundary

No Lean installation, implementation or mathlib availability audit was
performed for this map. The following are required mathematics, NOT claims
that matching mathlib declarations already exist.

1. **Curves and actual maps.** Smooth projective models/function fields,
   finite etale covers, normalization, intersections inside one field,
   cored finite envelope and terminating alternating closures. Effective
   wild quotient stacks and their finite-etale covering category must be
   implemented or replaced by a PROVED equivalent finite-group/groupoid
   formulation. Omitting effectivity or either unramified leg is invalid.
2. **Uniform atlas bound.** Riemann--Hurwitz with the different, canonical
   divisors, surface intersection/adjunction/Hodge index and local contact
   orders; Cartier and semilinear finite-algebra elimination; trace-zero
   pencil bundles; Jacobians/Tate modules/Frobenius; HKG realization,
   ramification filtrations, Swan integrality and the all-degree first-layer
   argument. Finite signature tables are not substitutes for their bounds.
3. **Partner count.** Genus-g etale pi1 has<=2g generators via lifting and
   the FULL specialization SURJECTION; covers via permutation actions;
   Galois closure degree<= (B−1)!; faithful Aut(W) action on3-torsion,
   including wild automorphisms, and torsion-free3-adic congruence kernel;
   quotient coverings and genus-dependent degree. A prime-to-p pi1 bound
   alone does not count the wild covers required here.
4. **Avoidance.** Finite-field descent and Frobenius action on geometric
   isomorphism classes, hyperelliptic branch-set/Mobius bound120, finite
   orbit arithmetic, arbitrarily large primes and finite-field irreducibles.
   These are reusable finite arguments; no gigantic partner list or value
   of K needs to be computed.
5. **Only for the two small explicit partners:** dormant opers, Frobenius
   bundles and Ext/Cech models, local Hermitian identification, complete
   torsion/symmetry coverage, plus a proof excluding EVERY residual small
   signature. This fifth package is unnecessary for the complete target.

For fixed-X arithmetic, retain the sources
[model/Frobenius](../routes/global/76_EXPLICIT_R3_REDESIGN_CERTIFICATE.sage),
[eigenforms](../routes/global/GENUS9_CARTIER_EIGENFORM_SIMPLE_ZERO_TEST.sage),
[W3](../routes/global/GENUS9_W3_CARTIER_CERTIFICATE.sage),
[first-layer signatures](../routes/global/GENUS9_FIRST_LAYER_SIGNATURE_CERTIFICATE.py),
[single jump](../routes/global/TWO_BRANCH_SINGLE_JUMP_SIGNATURE_CERTIFICATE.py)
and [integral carry](../routes/global/INTEGRAL_WILD_JUMP_CARRY_CERTIFICATE.py).
A Lean checker needs exact finite-field moduli/embeddings; Bezout or
irreducibility/factorization witnesses; Cartier norm squarefreeness over
the ENTIRE finite algebra; Frobenius polynomial identification on the
ACTUAL Tate module; and exhaustive bounded integer-case proofs.
A displayed Weil polynomial plus modular arithmetic is insufficient without
its identification with this curve. The present Sage p-adic reconstruction
is an external computation, not already a kernel-checkable certificate.

For atlas emptiness the portable certificate is, for EACH required oper,
twist and chart, an identity sum_i H_i f_i=1 in the specified polynomial
ring over a certified finite field, using ORIGINAL chart equations.
Record sparse coefficient/exponent arrays, variable/row order, field tower
and embeddings, chart substitution/inverses, and source-tensor hashes.
The checker must establish the identity and the geometric derivation and
exhaustiveness of the charts. Hashes and verified flags only identify data.
The independent known dimension plus original-equation substitutions and
separator certify the oper algebra; retain local multiplicities as in
[finite_algebra_completion_certificates](../Theorems/Thm_finite_algebra_completion_certificates.md).
Root evaluations alone, a solver exit code, finite sampling or a generic
full-rank minor cannot prove algebraic-closure emptiness.

A suitable first Lean milestone is the finite-partner/prime-orbit avoidance
lemma. It is NOT the requested two-curve theorem until the fixed-X geometric
hypotheses above are discharged. Final completion must have no 'sorry' or
project-specific axioms standing in for the atlas bound, cored bridge,
Frobenius arithmetic or finite partner count. No publication is authorized.

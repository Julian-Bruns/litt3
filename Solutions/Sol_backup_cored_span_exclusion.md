# Complete cored exclusion for the small backup

Version 1, 2026-09-11. This assembles the exact 38 common-orbifold cases.
It preserves both actual maps and makes no coreless conclusion.

## Proof

Write B=C_alpha as in the statement and O for its point at infinity.
The arithmetic and finite tests used below are geometric: the saved
field models parameterize complete finite etale torsion schemes, or
give polynomial identities valid over the algebraic closure. They are
not searches over a bounded field of map coefficients.

### 1. Exhaustive reduction

Suppose there is a cored finite bi-etale span X<-Z->B. The
[core theorem](../Theorems/Thm_cored_orbifold_bridge.md), with precisely
that hypothesis, produces a common smooth proper effective orbifold S
with actual finite etale atlases from X and B. Conversely it suffices
to exclude every such S. No simultaneous Galois refinement is presumed
for a span without a core.

The coarse curve of S has genus at most two, since it receives a finite
separable map from B. If its genus were positive, its Jacobian would
be a nonzero quotient of the absolutely simple nine-dimensional J(X),
contradiction. Thus its coarse curve is P1. Canonical degrees give
N=8n, where N=deg(X/S) and n=deg(B/S). Each inertia order divides n.

The [fixed-X bound](../Theorems/Thm_fixed_x_orbifold_bound.md) gives
N<=672 in the tame case. The integer Hurwitz equation

    2=n*(-2+sum_i(1-1/e_i)),  e_i|n,  n<=84

has exactly the 24 rows partitioned in Section 2.

There is at most one wild branch. A sole wild branch makes the pullback
of a coordinate differential a nonzero regular exact differential on
ordinary B, impossible. If another branch exists and delta/e>=2, the
Hurwitz equation gives n<=4, contradicting 5|n. In the remaining range
1<delta/e<2, three tame branches give n<4. Two tame branches of orders
(2,2) give 2=(n/e)(delta-e), impossible because delta-e is positive
and congruent to 3 modulo 4. Any other pair gives n<12; the possible
n=5,10 leave no admissible pair. Hence there is one wild and one tame
branch.

Use the full [two-branch fixed-X proof](Sol_fixed_x_two_branch_bound.md):
in its small range q=5 and N<=2240. Write e=5t, with lower break j.
Then 5 does not divide j, t divides 4j, delta-e=4j-1, and

    n*((delta-e)/e-1/d)=2,  n<=280.

Exactly twelve rows result, as in Section 3. The only large alternatives
are the two q=125 rows in Section 4. The fresh assembly script independently
enumerates these integer equations, including the tame lengths three
through six; it obtains exactly 24+12+2.

### 2. The 24 tame profiles

Each row below denotes (n; complete inertia list), and occurs once.

| Profiles | Exclusion |
|---|---|
| (2;2,2,2,2,2,2) | [Complete actual Prym sieve](../Theorems/Thm_backup_degree_two_atlas_exclusion.md); uses X |
| (3;3,3,3,3), (4;2,2,4,4), (6;3,6,6), (8;2,8,8) | Two singleton Weierstrass fibers, below |
| (4;2,2,2,2,2) | V4 monodromy, below |
| (6;2,2,2,6), (9;3,3,9), (12;2,4,12), (18;2,3,18) | One singleton Weierstrass fiber, below |
| (8;2,2,2,4) | Prym branch translation, below |
| (12;3,3,6), (12;2,6,6), (24;2,3,12) | Ordinary cyclic covers, below |
| (8;4,4,4) | Complete fourth-power secants, below |
| (6;2,2,3,3), (12;2,2,2,3) | [Quadrangular elliptic/Hecke obstruction](../Theorems/Thm_quadrangular_genus_two_hecke_obstruction.md) |
| (12;3,4,4) | [Frobenius orbit obstruction](../Theorems/Thm_triangle344_frobenius_obstruction.md) |
| (16;2,4,8), (36;2,3,9) | [Radical quadratic obstruction](../Theorems/Thm_radical_quadratic_atlas_obstruction.md) |
| (24;3,3,4) | [Actual Hessian quotient](../Theorems/Thm_hermitian_monodromy_genus_sieve.md), then [Hermitian exclusion](../Theorems/Thm_backup_hermitian_atlas_exclusion.md) |
| (24;2,4,6) | [Degree24 elliptic/real-multiplication obstruction](../Theorems/Thm_triangle246_frobenius_quotient_obstruction.md) |
| (48;2,3,8) | [Degree48 factor and Frobenius obstruction](../Theorems/Thm_triangle238_frobenius_factor_obstruction.md) |
| (84;2,3,7) | [Complete degree84 exclusion](../Theorems/Thm_triangle237_backup_exclusion.md) |

Here are the previously author-only small-packet arguments, now covered
by the coherent audit.

**Arithmetic and singleton tests.** B is ordinary and has absolutely
simple Jacobian, Aut(B)=C2, and moduli Frobenius orbit length three.
Its Weil polynomial is T^4-8T^3+182T^2-1000T+15625. The point counts,
root-ratio simplicity test and branch-set automorphism argument are
retained in the preparation and canonical small-triangle proofs.
The real endomorphism field is Q(sqrt21).

Put W1={O(P-O):P in B}. The only W1 points killed by each of
4,6,8,12,16,18,24,36 are the six Weierstrass classes. For order 4 this
is L(4O)=<1,u,u^2>. The complete cubic norm algebra gives all 80
nonzero J[3] classes with no repeated degree-two support, which settles
order 6. The other orders use freshly replayed Hasse-jet identities:
polynomial combinations of the ORIGINAL maximal minors equal a power
of the branch polynomial F, excluding every nonbranch point. Thus no
general torsion-rigidity or mixed-primary projection theorem is needed.

For a tame uniform map f, the fiber-torsion identity obtained from
Hurwitz forces the indicated singleton fibers into these W1 torsion
sets. With two singleton fibers P,Q, div(f)=n(P-Q). At distinct
Weierstrass points n must be even, and f=c*h^(n/2) with div(h)=2(P-Q).
For n>2, uniformity makes the cyclic h-line action preserve the entire
hyperelliptic branch divisor, so it lifts to an extra automorphism of B.
The odd-degree n=3 case is already impossible.

For one singleton fiber, write n=3m, put it at infinity P, and choose
eta with div(eta)=2P. The finite inertia lists are
(m;e_i)=(2;2,2,2),(3;3,3),(4;2,4),(6;2,3). With H=df/eta, set

    y=H^(m-1)/product_i(f-a_i)^(m-1-m/e_i).

The actual divisors give, after a scalar normalization,
y^m=product_i(f-a_i)^(m/e_i). This connected Kummer curve has genus one
and receives an actual separable degree-three map from B. Absolute
simplicity of J(B) excludes it.

For n=4 with five order-two fibers, the inertia permutations are double
transpositions. Their normal V4 subgroup exhausts monodromy, since the
remaining quotient would be an unramified cover of P1. Transitivity
forces V4 and contradicts Aut(B)=C2.

**Prym branch translation.** For (8;2,2,2,4), pull back the elliptic
double of the target branched at its four branch values. The resulting
D->B is an actual connected etale double: splitting would give B an
elliptic map. D is genus three and has a biquadratic presentation with
quotients B, a rational curve, and an elliptic curve E'. The degree-eight
map D->E factors through E' because Hom(J(B),E)=0; the quotient
involution has fixed points, so the possible translation constant is
zero. The resulting E'->E is an etale degree-four isogeny. Its fiber
is exactly the four-point branch divisor of D->E'. A nonzero two-torsion
translation in its kernel preserves that divisor and the square-root
line of degree two. It lifts to D, commutes with the biquadratic
involutions, and induces an automorphism of B other than 1 or the
hyperelliptic involution. This is the contradiction.

**Ordinary cyclic covers.** All connected cyclic etale covers of B of
degrees 1,2,3,6 are ordinary. The fifteen doubles are checked by their
complementary elliptic quotients. The complete forty-point cubic norm
algebra gives each cubic cover z^3=v-A, with extra forms z*eta,U*eta/z.
The two Cartier arrows are nonzero by an explicit inverse for
gamma=[u^14]((F+A^2)*F^2) in the full algebra. Translating its forty
points by all fifteen nonzero two-classes gives all 600 exact-order-six
cyclic covers. Their primitive character arrows have analogous saved
nonzero coefficient inverses; the other characters are the already
ordinary lower-degree quotients.

The supersingular elliptic curve y^2=x^3+1 has cyclic quotients with
profiles (3,3,3) and (2,3,6). For the three indicated tame rows, actual
tame base change gives a connected component D etale over B of degree
1,2,3 or 6, and an actual nonconstant separable D->E. Pullback of a
nonzero Cartier-zero form contradicts the just-proved ordinarity of D.
Full-degree connectedness of the base change is not presumed.

**Fourth-power secants.** In profile (8;4,4,4), all three reduced
degree-two fibers give J[4] classes. The 255 nonzero classes each have
one reduced representative and an explicit fourth-power section in
H0(8O). The zero class contributes the ENTIRE canonical pencil's
rational normal quartic, not one selected section. The 32,385 secants
between the isolated sections are distinct and none meets this full
quartic at a finite parameter; all strata are checked. Two canonical
fibers force a fourth power of the hyperelliptic pencil and incompatible
order-two ramification at the remaining Weierstrass points. This
excludes the required three collinear sections, including the
positive-dimensional Abel-fiber boundary.

### 3. The twelve small-wild profiles

Rows are (n,e,delta,d), with d the other, tame inertia order.

| Profiles | Exclusion |
|---|---|
| (10,10,17,2), (20,20,27,4), (40,40,47,8) | Singleton Weierstrass/exact form |
| (40,20,31,2), (60,30,41,3), (120,60,71,6) | Ordinary cyclic torsor/exact form |
| (20,5,8,2) | [Cartier dormant secant](../Theorems/Thm_cartier_dormant_secants.md), reduced five-oper scheme |
| (40,10,13,4) | Complete J[2]-twisted Bol test |
| (80,20,23,8) | Complete J[4]-twisted Bol test |
| (120,20,27,3) | [Conductor-two exclusion](../Theorems/Thm_backup_wild120_atlas_exclusion.md) |
| (240,40,47,6) | [Two-torsion-twisted conductor-two exclusion](../Theorems/Thm_backup_wild240_atlas_exclusion.md) |
| (280,20,23,7) | [Actual A7/Hermitian reduction](../Theorems/Thm_single_jump_a7_hermitian_reduction.md) |

For the singleton rows, put the wild point P at infinity. The actual
different gives dK_B~2dP, so 2d(P-O)=0, with 2d=4,8,16. P is
Weierstrass by the preceding exact tests. Choose div(eta)=2P and
H=df/eta. Divisors give z=(f-a)/H and z^d=c(f-a). Differentiating
makes eta a nonzero scalar multiple of dz, contrary to ordinarity.

For the next three rows dK_B~dD_w. The actual torsor of
O(D_w)*omega^(-1) has degree dividing 2,3 or 6. On it a regular form
eta has divisor the pullback of D_w, and delta-e-e/d=1 gives the same
H,z identity and exact form. Every possible connected component is
ordinary by the complete cyclic tests above.

For the remaining three elementary rows, the tensors have divisors
D_w,2D_w,4D_w. Taking the required quadratic root on the actual
order-at-most-two or order-at-most-four etale torsor produces a
quadratic differential q with four simple zeros and C_1(q^3)=0.
The latter identity follows on a further separable radical, where q
is a scalar multiple of (dt)^2. That radical is not substituted for
an etale leg. The character-invariant scalar q''/q descends to a
regular dormant oper on B. For the untwisted row this contradicts
the reduced five-oper scheme; for the twisted rows it contradicts
the complete twisted Bol kernels.

For clarity those tests cover every twist, not just sampled fields:
the sixteen J[2] classes have complete regular three-section bases,
checked by finite and infinite valuations. Each nonzero J[2] class
has sixteen distinct, nonsingular explicit halves, exhausting the
degree-sixteen multiplication-by-two fiber. These give all 240
exact-order-four classes. The regular character space is L(D+2O)
of dimension three, represented on the actual torsor by
z*(1,u,(v+V)/U)*eta^2. All matrices at all five opers have certified
invertible minors. The cubic analogue used in the canonical radical
theorem likewise covers all 400 nontrivial oper/twist pairs.

### 4. The two large profiles and conclusion

The two rows (N,n,e,delta,d) are

    (112000,14000,1000,1143,7),
    (336000,42000,3000,3143,21).

The [completed-local rigidity theorem](../Theorems/Thm_completed_local_orbifold_rigidity.md)
and [actual atlas extension criterion](../Theorems/Thm_hermitian_atlas_extension_criterion.md)
identify their orbifolds as [H/PSU3(5)] and [H/PGU3(5)]. These are
identifications of ACTUAL stacks, not numerical-signature substitutions.
Both contradict the complete backup Hermitian atlas exclusion.

Every possible S is now excluded. The core theorem proves the stated
no-cored result. Nothing in this argument applies the core theorem to
a span whose endpoint-field intersection is k.

## Evidence and replay boundaries

The coherent audit is PASS, auditor `/root/audit_backup_cored_completion`,
2026-09-11. Its small-packet geometric checks and fresh bounded replays
are recorded in
[the audit](../Research/audits/BACKUP_CORED_COMPLETION_AUDIT_2026_09_11.md).
The separate degree84 prerequisite is now proved, including a fresh
full replay of all 127 identity certificates, 35 source/provenance
nodes and the final unit in 390.486 seconds. Degree2 excludes all
1533 actual carrier labels, with full higher-precision and Cartier replays.

The assembly/small-packet replay script is
[audit_backup_cored_small_packet.py](../scripts/audit_backup_cored_small_packet.py).
Its receipt at the external computation root,
backup-cored-audit-20260911/assembly_receipt.json, has SHA256
677432ff5bdd3ac7167503a2beaf17db1d05dcecabe7840e985f1964da25e1b2.
It independently partitions the cases, checks all fifteen doubles,
the original-minor identities and fresh-replay hashes. Other replay
receipts there cover all cubic and cyclic-six torsors, twisted J[2]/J[4]
matrices and fourth-power secants. See the audit for exact names/times.

The retained standalone evidence is under Research/computations/:
backup_genus_two_preparation.json, backup_genus_two_torsion.json,
backup_genus_two_double_covers.json, backup_genus_two_cyclic_covers.json,
backup_genus_two_twisted_tangents.json, backup_genus_two_four_torsion.json,
backup_genus_two_tame444.json and backup_genus_two_cubic_tangents.json,
plus the fresh original-minor certificates for 8,12,16,18,24,36.
No dependence on the more general, author-only low-pencil torsion
rigidity assertion or mixed-primary extension is used here.

Inherited theorems retain their recorded verification scopes. In
particular this assembly is not a new proof of the external core
theorem, fixed-X local classification, every earlier finite monodromy
census or every Hecke argument. The audits and exact replays are not
Lean verification. The original common-cover problem is UNSOLVED.

# Complete cored exclusion for the small backup

[Statement](../../../Theorems/quotient_geometry/endpoint_exclusions/backup_cored_span_exclusion.md).

## Proof

Write B=C_alpha as in the statement and O for its point at infinity.
### 1. Exhaustive reduction

Suppose there is a cored finite bi-etale span X<-Z->B. The
[core theorem](../../../Theorems/quotient_geometry/cored_orbifold_bridge.md), with precisely
that hypothesis, produces a common smooth proper effective orbifold S
with actual finite etale atlases from X and B. Conversely it suffices
to exclude every such S. No simultaneous Galois refinement is presumed
for a span without a core.

The coarse curve of S has genus at most two, since it receives a finite
separable map from B. If its genus were positive, its Jacobian would
be a nonzero quotient of the absolutely simple nine-dimensional J(X),
contradiction. Thus its coarse curve is P1. Canonical degrees give
N=8n, where N=deg(X/S) and n=deg(B/S). Each inertia order divides n.

The [fixed-X bound](../../../Theorems/quotient_geometry/local_actions/fixed_x_orbifold_bound.md) gives
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

Use the full [two-branch fixed-X proof](../../shared_tensors/fixed_x_two_branch_bound.md):
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
| (2;2,2,2,2,2,2) | [Complete actual Prym sieve](../../../Theorems/jacobians/isogeny_sieves/backup_double_cover_exclusion.md); uses X |
| (3;3,3,3,3), (4;2,2,4,4), (6;3,6,6), (8;2,8,8) | Two singleton Weierstrass fibers, below |
| (4;2,2,2,2,2) | V4 monodromy, below |
| (6;2,2,2,6), (9;3,3,9), (12;2,4,12), (18;2,3,18) | One singleton Weierstrass fiber, below |
| (8;2,2,2,4) | Prym branch translation, below |
| (12;3,3,6), (12;2,6,6), (24;2,3,12) | Ordinary cyclic covers, below |
| (6;2,2,3,3), (12;2,2,2,3) | [Quadrangular elliptic/Hecke obstruction](../../../Theorems/quotient_geometry/triangles/quadrangular_genus_two_hecke_obstruction.md) |
| (12;3,4,4) | [Frobenius orbit obstruction](../../../Theorems/quotient_geometry/triangles/triangle344_frobenius_obstruction.md) |
| (16;2,4,8), (36;2,3,9) | [Radical quadratic obstruction](../../../Theorems/quotient_geometry/triangles/radical_quadratic_atlas_obstruction.md) |
| (8;4,4,4), (24;3,3,4) | [Symmetry quotient](../../../Theorems/quotient_geometry/triangles/orbifold_symmetry_quotients.md), then the actual Hessian/Hermitian target, below |
| (24;2,4,6) | [Degree24 elliptic/real-multiplication obstruction](../../../Theorems/quotient_geometry/triangles/triangle246_frobenius_quotient_obstruction.md) |
| (48;2,3,8) | [Degree48 factor and Frobenius obstruction](../../../Theorems/quotient_geometry/triangles/triangle238_frobenius_factor_obstruction.md) |
| (84;2,3,7) | [Complete degree84 exclusion](../../../Theorems/quotient_geometry/triangles/triangle237_backup_exclusion.md) |

Here are the previously author-only small-packet arguments, now covered
by the coherent audit.

**Arithmetic and singleton tests.** The
[backup arithmetic theorem](../../../Theorems/curve_arithmetic/backup_curve_arithmetic.md)
gives ordinarity, geometric simplicity, Aut(B)=C2, moduli orbit3 and
Rosati-fixed field Q(sqrt21). Its two-primary criterion and the
retained order24/36 jet identities put every W1 point killed by one
of4,6,8,12,16,18,24,36 among the six Weierstrass classes.

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

**Ordinary cyclic covers.** The
[complete character tests](../../jacobians/ordinary_covers/backup_small_abelian_ordinarity.md)
make every cyclic etale cover of B of degree1,2,3 or6 ordinary.

The supersingular elliptic curve y^2=x^3+1 has cyclic quotients with
profiles (3,3,3) and (2,3,6). For the three indicated tame rows, actual
tame base change gives a connected component D etale over B of degree
1,2,3 or 6, and an actual nonconstant separable D->E. Pullback of a
nonzero Cartier-zero form contradicts the just-proved ordinarity of D.
Full-degree connectedness of the base change is not presumed. More
generally this excludes any tame map with three selected branch-index
lists divisible, point by point, by(3,3,3) or(2,3,6), respectively.

**Hessian target.** The degree3 symmetry quotient gives an actual chain

    P1(4,4,4) -> P1(3,3,4) = [H/Hess_216] -> [H/PGU3(5)].

The [Hessian identification](hermitian_monodromy_genus_sieve.md)
and the subgroup map are maps of actual stacks. An atlas from B of
either indicated profile would compose to a representable finite etale
B->[H/PGU3(5)], contradicting the
[Hermitian atlas exclusion](../../../Theorems/quotient_geometry/endpoint_exclusions/backup_hermitian_atlas_exclusion.md).

### 3. The twelve small-wild profiles

Rows are (n,e,delta,d), with d the other, tame inertia order.

| Profiles | Exclusion |
|---|---|
| (10,10,17,2), (20,20,27,4), (40,40,47,8) | Singleton Weierstrass/exact form |
| (40,20,31,2), (60,30,41,3), (120,60,71,6) | Ordinary cyclic torsor/exact form |
| (20,5,8,2) | [Cartier dormant secant](../../../Theorems/projective_connections/cartier_dormant_secants.md), reduced five-oper scheme |
| (40,10,13,4) | Complete J[2]-twisted Bol test |
| (80,20,23,8) | Complete J[4]-twisted Bol test |
| (120,20,27,3) | [Conductor-two exclusion](../../../Theorems/quotient_geometry/endpoint_exclusions/backup_wild120_atlas_exclusion.md) |
| (240,40,47,6) | [Two-torsion-twisted conductor-two exclusion](../../../Theorems/quotient_geometry/endpoint_exclusions/backup_wild240_atlas_exclusion.md) |
| (280,20,23,7) | [Actual A7/Hermitian reduction](../../../Theorems/quotient_geometry/local_actions/single_jump_a7_hermitian_reduction.md) |

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

The [completed-local rigidity theorem](../../../Theorems/quotient_geometry/local_actions/completed_local_orbifold_rigidity.md)
and [actual atlas extension criterion](../../../Theorems/atlases/hermitian_atlas_extension_criterion.md)
identify their orbifolds as [H/PSU3(5)] and [H/PGU3(5)]. These are
identifications of ACTUAL stacks, not numerical-signature substitutions.
Both contradict the complete backup Hermitian atlas exclusion.

Every possible S is now excluded. The core theorem proves the stated
no-cored result. Nothing in this argument applies the core theorem to
a span whose endpoint-field intersection is k.

## Evidence

The [assembly audit](../../../Research/audits/BACKUP_CORED_COMPLETION_AUDIT_2026_09_11.md)
records the38-profile partition, small-packet geometry and original
torsion/Cartier/secant replays. The degree2 and degree84 prerequisites
have their own complete certificates. Their verification scopes are
unchanged.

The [assembly checker](../../../scripts/genus_two/audit_backup_cored_small_packet.py)
and the audit identify the original computation records and external
replay receipts. The two-primary argument and surviving order24/36
identities suffice for singleton tests; the symmetry quotient replaces
the fourth-power secants. Original receipts retain their earlier test lists.

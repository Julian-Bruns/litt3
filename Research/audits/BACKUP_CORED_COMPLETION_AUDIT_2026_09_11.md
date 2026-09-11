# Backup cored-completion assembly audit

Verdict: PASS for the complete numerical reduction, the small-signature
packet checked below, and the assembly from the named inherited inputs.
The sole condition on the new conclusion is completion/registration of the
degree84 exclusion in the separate final-unit audit. No additional missing
case or hypothesis was found. Auditor: `/root/audit_backup_cored_completion`,
2026-09-11. Scoped prose and exact-computation audit, not Lean verification
or a fresh audit of every inherited theorem.

The resulting statement is precisely this: for the fixed genus-nine X and
the specified genus-two C_alpha, alpha^3+alpha+1=0 in characteristic five,
there is no smooth proper connected effective orbifold S with actual
representable finite etale atlases from BOTH X and C_alpha. Consequently
there is no CORED finite bi-etale span between these endpoints. This says
nothing about an arbitrary coreless span or its simultaneous liftability.

## Exhaustive reduction

The canonical `cored_orbifold_bridge` retains both original etale maps and
uses the core hypothesis to obtain the common effective orbifold. Its
simultaneous Galois refinement is not asserted without that hypothesis.
The canonical `fixed_pair_arithmetic` makes J(X) absolutely simple; a
positive-genus coarse quotient admitting the other genus-two atlas would
give a positive-dimensional quotient of J(X) of dimension at most two.
Thus the coarse curve is P1. Canonical degrees give N=8n, for the X and
C_alpha atlas degrees respectively. Each inertia order divides n, because
every coarse atlas completion has that common local Galois extension.

The canonical `fixed_x_orbifold_bound` and `fixed_x_two_branch_bound` are
used with their audited one-endpoint scopes. In the tame case N<=672,
hence n<=84. Enumerating the integer Hurwitz equation gives exactly the
24 rows below. This audit independently enumerated ordered multiplicity
lengths three through six by the reciprocal-sum equation, rather than
reusing the preparation script's weighted-partition recursion.

For completeness the reduction in the wild case does not omit the
small high-different cases. There is at most one wild branch by the
fixed-X theorem. A sole wild branch would give a nonzero regular exact
form on the ordinary C_alpha, impossible. With another branch and
delta/e>=2, Hurwitz gives n<=4, incompatible with 5|n. For
1<delta/e<2, three or more tame branches give n<4. With two tame
branches, the pair (2,2) gives 2=(n/e)(delta-e), impossible since
delta-e is positive and congruent to 3 modulo 4. Any other pair gives
n<12; n=5 or 10 leaves no allowable tame pair except (2,2). Thus exactly
one wild and one tame branch remain.

The full proof of `fixed_x_two_branch_bound`, not its degree bound alone,
gives q=5 in the small case. With e=5t and lower break j its conditions
are t prime to 5, 5 not dividing j, t|4j, delta-e=4j-1, and
n*((delta-e)/e-1/d)=2. Independent enumeration by (n,e,j,d), with n<=280,
returns exactly the twelve displayed rows. The only large alternatives
are the two audited q=125 Hermitian signatures. Hence the split is
24 tame + 12 small wild + 2 large, with no unenumerated range of q.

## Complete exclusion map

Here a row is (degree on C_alpha; complete tame inertia list). Each row
appears exactly once in the independently checked partition.

| Rows | Exclusion input |
|---|---|
| (2;2,2,2,2,2,2) | `backup_degree_two_atlas_exclusion`; the X leg is essential |
| (3;3,3,3,3), (4;2,2,4,4), (6;3,6,6), (8;2,8,8) | Two totally ramified Weierstrass fibers; packet below |
| (4;2,2,2,2,2) | V4 monodromy; packet below |
| (6;2,2,2,6), (9;3,3,9), (12;2,4,12), (18;2,3,18) | One Weierstrass fiber constructs an elliptic map; packet below |
| (8;2,2,2,4) | Prym branch translations; packet below |
| (12;3,3,6), (12;2,6,6), (24;2,3,12) | Ordinary cyclic covers versus a supersingular elliptic quotient |
| (8;4,4,4) | Complete J[4] secants including the canonical pencil |
| (6;2,2,3,3), (12;2,2,2,3) | `quadrangular_genus_two_hecke_obstruction` |
| (12;3,4,4) | `triangle344_frobenius_obstruction` |
| (16;2,4,8), (36;2,3,9) | `radical_quadratic_atlas_obstruction` |
| (24;3,3,4) | `hermitian_monodromy_genus_sieve`, Hessian quotient identity, then `backup_hermitian_atlas_exclusion` |
| (24;2,4,6) | `triangle246_frobenius_quotient_obstruction` |
| (48;2,3,8) | `triangle238_frobenius_factor_obstruction` |
| (84;2,3,7) | Separate new degree84 unit assembly, with its inherited census and dormant-decoration inputs |

The small-wild rows are (n,e,delta,d).

| Rows | Exclusion input |
|---|---|
| (10,10,17,2), (20,20,27,4), (40,40,47,8) | Singleton Weierstrass fiber makes a regular form exact |
| (40,20,31,2), (60,30,41,3), (120,60,71,6) | Actual cyclic torsion cover makes a regular form exact |
| (20,5,8,2) | `cartier_dormant_secants` plus complete reduced five-oper scheme |
| (40,10,13,4) | Complete J[2]-twisted Bol kernel test |
| (80,20,23,8) | Complete J[4]-twisted Bol kernel test |
| (120,20,27,3) | `backup_wild120_atlas_exclusion` |
| (240,40,47,6) | `backup_wild240_atlas_exclusion` |
| (280,20,23,7) | `single_jump_a7_hermitian_reduction` and the Hermitian exclusion |

The two large rows (N,n,e,delta,d)=(112000,14000,1000,1143,7) and
(336000,42000,3000,3143,21) are the ACTUAL stacks [H/PSU3(5)] and
[H/PGU3(5)] by `completed_local_orbifold_rigidity` and its inherited
local-normality input. Both are excluded by
`backup_hermitian_atlas_exclusion`, using
`hermitian_atlas_extension_criterion`. Matching numerical ramification
alone is not substituted for these actual-stack identifications.

## Small-packet geometric checks

I read the author arguments in `Research/BACKUP_CANDIDATE.md`, checked
their divisor calculations and exceptional cases, and inspected/replayed
the exact scripts. The following points matter for validity.

* Backup arithmetic: the preparation rebuilds the curve, Cartier matrix,
  point counts 118 and 15926, irreducible Weil polynomial
  T^4-8T^3+182T^2-1000T+15625, and absence of nontrivial cyclotomic
  root-ratio factors. Thus its ordinary Jacobian is geometrically simple.
  Its real endomorphism subfield is Q(sqrt21): pi+125/pi satisfies
  s^2-8s-68=0; no eigenvalue ratio becoming a root of unity enlarges the
  Frobenius centralizer after a finite extension. The elementary
  branch-set proof of Aut=C2 and moduli Frobenius orbit three in
  `Sol_triangle344_frobenius_obstruction.md` is valid. In particular the
  stabilizer of the five F5 branch points has order 20, excluding an
  element inducing their degree-three conjugation.
* All singleton torsion bounds used here are supplied directly. L(4O)
  gives the six Weierstrass classes at order 4. The complete 40-point
  cubic norm algebra gives 80 distinct nonzero J[3] classes, with no
  repeated reduced support; hence W1[6] has only those Weierstrass
  classes. Exact Hasse-jet original-minor identities were freshly checked
  for orders 8,12,16,18,24,36. Their right sides are powers of F and
  cover every nonbranch point over the algebraic closure. No general
  `low_pencil_torsion_rigidity` theorem, mixed-primary projection, or
  finite coefficient-field point search is needed for this assembly.
* Two singleton Weierstrass fibers force f=c*h^(n/2), with h the
  hyperelliptic coordinate. Uniform inertia makes the cyclic h-line
  deck action preserve the entire branch divisor, so it lifts and
  contradicts Aut=C2. The odd-degree case is already impossible.
  The single-Weierstrass construction retains the actual f: its
  displayed Kummer equation has finite indices (2,2,2), (3,3), (2,4)
  or (2,3) and infinity index m=2,3,4 or 6. Each is connected of
  genus one and receives an actual separable degree-three map from C.
* The degree-four five-branch monodromy is indeed V4: every inertia is
  a double transposition, and the quotient by the generated normal
  V4-part would be an unramified cover of P1. Transitivity forces V4.
* For the degree-eight (2,2,2,4) row, the normalized pullback of the
  four-branch elliptic double is an actual connected etale double of C.
  Every genus-two etale double has the indicated biquadratic presentation
  with an elliptic complementary quotient E'. The map to the first
  elliptic curve factors through E', since the other Jacobian factor
  is J(C) and Hom(J(C),E)=0; the quotient involution has fixed points,
  removing the possible translation constant. The resulting isogeny
  E'->E has degree four and is etale. Its kernel has nonzero 2-torsion
  preserving the branch divisor and the degree-two square-root line.
  The lifted translation commutes with both involutions and descends
  to an automorphism of C distinct from 1 and its hyperelliptic
  involution. No order-four lift assumption is needed.
* All cyclic covers of orders 1,2,3,6 used in the ordinary argument are
  actual Kummer torsors. The fifteen doubles reduce to their elliptic
  factors, all ordinary. For z^3=v-A the two extra regular forms are
  z*eta and U*eta/z. Cartier sends the first to a nonzero scalar times
  the second precisely when the saved gamma is nonzero; using
  (v-A)(v+A)=-lambda^(-1)U^3 gives the reverse arrow with a nonzero
  scalar multiple of the same gamma. For z^6=A6+wB3 the norm cU^6
  gives the same two-arrow test, while the other character spaces
  are the degree-two and degree-three quotients. The fifteen full
  40-point translates exhaust all 600 exact-order-six cyclic covers.
  Thus every connected component in the supersingular-elliptic
  base change has one of the tested degrees; full connectedness is
  not presumed. Its nonconstant separable projection pulls back the
  nonzero Cartier-zero form, contradicting ordinarity.
* In each singleton wild row the actual different gives
  dK~2dP and then eta is a scalar multiple of dz. In each two-point
  row dK~dD_w; the actual torsor of O(D_w)omega^(-1) has degree
  dividing 2,3 or 6. On it the identity
  delta-e-e/d=1 gives the same regular exact form. The cover is
  ordinary by the preceding complete test, not by any purported
  preservation of ordinarity under arbitrary etale maps.
* In the next three wild rows the tensors have divisors D_w, 2D_w,
  and 4D_w, respectively. Taking the required quadratic root on
  the actual order-at-most-two or order-at-most-four etale torsor
  gives four simple zeros. The further separable radical is used
  only to establish the Cartier identity. The resulting scalar
  q''/q is invariant under the character and descends to a regular
  dormant oper. The complete twisted bases are spaces L(D+2O),
  dimension three, with every finite sheet and infinity checked.
  The sixteen J[2] matrices and 240 exact-order-four matrices cover
  all five opers. This checks the previously author-only twisted
  divisor/basis dictionary needed for these rows and the J[4] part
  of `radical_quadratic_atlas_obstruction`. The cubic version uses
  exactly the same valuation dictionary; its four original minors
  were freshly replayed, covering all 400 nontrivial pairs.
* For (8;4,4,4), Hurwitz puts all three reduced degree-two fibers
  in J[4]. The 255 nonzero classes have unique reduced representatives;
  the zero class contributes the ENTIRE canonical pencil, not just
  a selected point. Three fibers require three collinear fourth-power
  sections in H0(8O). The 32,385 secants are all distinct, and none
  meets the full canonical fourth-power quartic at a finite parameter.
  Two canonical fibers would instead force a fourth power through
  the hyperelliptic pencil, producing incompatible order-two
  ramification at the remaining Weierstrass points. Thus the
  positive-dimensional Abel-fiber exception is fully covered.

## Replays and evidence boundaries

Fresh outputs are in
`/Users/julian/Documents/litt3-computation-data/backup-cored-audit-20260911`.
The independent assembly script is
`scripts/audit_backup_cored_small_packet.py`; its receipt is
`assembly_receipt.json`, SHA256
`677432ff5bdd3ac7167503a2beaf17db1d05dcecabe7840e985f1964da25e1b2`.
It checks all row partitions, rebuilds all fifteen elliptic doubles,
replays the final original-minor identities, and checks semantic equality
and hashes linking the fresh computations to the original packets.
Its runtime was 0.311 seconds, excluding Sage startup.

Fresh bounded original-script runs: preparation 0.279 seconds; complete
cubic norm algebra 0.454; all cyclic-six translates 13.777; sixteen
J[2]-twisted matrices 1.211; the independently written no-solver
order-four verifier 14.375; full tame444 secants 1.408; one-point
orders 8/12/16/18/24/36 all PASS, the largest 9.087 seconds.
The independent no-solver cubic-tangent replay passed all four original
minors and 400 pairs in 2.481 seconds. These computations used one core
sequentially and did not overwrite the original certificates.

Standalone packet dependencies are explicitly:
`backup_genus_two_preparation.json`, `backup_genus_two_torsion.json`,
`backup_genus_two_double_covers.json`, `backup_genus_two_cyclic_covers.json`,
`backup_genus_two_twisted_tangents.json`, `backup_genus_two_four_torsion.json`,
`backup_genus_two_tame444.json`, and `backup_genus_two_cubic_tangents.json`
under `Research/computations/`, together with the fresh original-minor
order certificates above. The old `backup_genus_two_small_torsion.json`
is not necessary once the direct order-12 Hasse-jet identity is used.

The canonical dependencies in the two tables retain their stated
verification levels. In particular this is not a new enumeration of
the quadrangular or triangle censuses or a new whole-proof audit of
their endomorphism arguments, the Hermitian atlas proof, the fixed-X
local classification, or the core theorem. The new degree84 step is
governed separately by
`DEGREE84_FINAL_EXCLUSION_AUDIT_2026_09_11.md`, including its provenance
manifest; it was not duplicated here. With those named inputs the
24+12+2 assembly is exhaustive and the no-cored conclusion follows.
The original unmarked common-cover problem remains UNSOLVED.

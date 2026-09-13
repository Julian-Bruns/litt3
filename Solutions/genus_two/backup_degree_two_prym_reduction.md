# Degree2 backup: an actual A4 carrier and a finite two-torsion orbit reduction

2026-09-11. [Statement](../../Theorems/genus_two/backup_degree_two_prym_reduction.md).
Focused audit passed after the Frobenius/isogeny distinction
below was corrected. NO exclusion
of the degree2 row. The main pair and current backup choice are unchanged.

## The actual remaining map

Write B=C_alpha for the backup genus-two curve, and X for the fixed
genus-nine cyclic trigonal curve. B's degree2 hyperelliptic map already
exists. A common atlas in this row requires an ACTUAL degree16 map

                     f:X→P1(2,2,2,2,2,2)

to B's same six branch points. Base change of B→P1 gives an etale
double X'→X and an etale degree16 map X'→B. If the double splits,
each component gives an etale degree8 map X→B, contradicting
Hom(JX,JB)=0. Thus an actual atlas supplies a nonzero L∈JX[2].

## The cubic orbit produces an A4 cover

Let rho be the order3 deck automorphism of X→P1_x. Since its quotient
has genus0, 1+rho+rho²=0 on JX. In particular rho has no nonzero
invariants on JX[2], and

                A=<L,rho*L>_F2={0,L,rho*L,rho²*L}

has rank2. Its associated V4 etale cover U→X is connected and
dominates the ORIGINAL X'→X. One may construct it by pulling back
[2]:JX→JX along the Abel map based at the rational fixed point O, then
quotienting by the annihilator of A. The equivariance of this pointed
Abel map lifts rho to an order3 automorphism of U. It acts on V4 by
cycling its three nonidentity elements. Therefore

                     U→P1_x is A4-Galois.

The original eleven inertia groups are still order3: U→X is etale,
so no new ramification occurs. The quotient R=U/<rho> is an ACTUAL
degree4 cover of P1_x. Its eleven complete branch fibers have type
(3,1). Riemann–Hurwitz gives g(U)=33 and g(R)=8. The actual diagram
retains U→X'→B and U→X; U→B has degree32 and is etale.

## The remaining Jacobian test is on genus8, not on X itself

Put P=Prym(X'/X), of dimension8. Prime-to5 character idempotents of
V4 give

                    J(U) ~ J(X) × P_L × P_(rho L) × P_(rho² L).

The three Pryms are isomorphic under the lifted rho. On the first
summand rho has no invariants because X/<rho>=P1. On the other three
it acts cyclically, so its invariant abelian subvariety is isogenous
to one Prym. The quotient map U→R therefore gives

                             J(R) ~ P.

These are isogenies induced by finite group correspondences, not a
claim of an actual R→B map. The original X'→B injects J(B) up to
finite kernel into J(X'). Since Hom(JX,JB)=0 (and likewise in the
other direction by polarizations), it follows that

                      J(B) is an isogeny factor of J(R).

Consequently, excluding that factor for EVERY such R would exclude
the actual degree2 atlas row. Excluding it just for X would not.

## Exact Frobenius reduction of the search labels

The established P_X(T) modulo2 is the irreducible degree18 polynomial

 T18+T16+T15+T12+T11+T9+T7+T6+T3+T2+1.

The [binary checker](../../scripts/arithmetic/check_degree2_frobenius_orbits.py) verifies
irreducibility and that T has EXACT order171 in its quotient field:
T171=1, T57≠1 and T9≠1. Thus every nonzero two-torsion class has
Frob25 orbit171, giving1533orbits of marked etale double-cover labels.

Because rho commutes with Frob25, it belongs to the centralizer field
F_(2^18). Its order3 makes it Frob25^57 or Frob25^114 on JX[2].
The rank2 groups A above are exactly F4-lines in that field. There
are87381of them, each of Frob25 orbit57, hence1533orbits of A4-carrier
labels. This is not a count of nonisomorphic abstract curves R.

For the GEOMETRIC ISOGENY-FACTOR test, these1533 carrier representatives
suffice even against the fixed J(B). Relative Frobenius is an isogeny,
so J(B), J(B^(25)) and J(B^(25^2)) are geometrically isogenous; likewise
J(R) and J(R^(25)). The factor condition is therefore constant on each
Frobenius orbit. This does not identify the underlying curves.

For a stronger ACTUAL MAP or CURVE ISOMORPHISM test the distinction
matters: the backup curve has Frobenius25 orbit3. Such a test must keep
all three backup conjugates for each of1533 carrier representatives,
or use4599 Frobenius25^3 carrier orbits against fixed B. A purely
inseparable Frobenius isogeny cannot replace a required finite etale
map. The [complete Prym sieve](../../Theorems/genus_two/backup_degree_two_atlas_exclusion.md)
now excludes every carrier by the isogeny-factor test.

Inputs are [fixed-X arithmetic](../arithmetic/fixed_pair_arithmetic.md),
[backup arithmetic](backup_curve_arithmetic.md), and the actual
same-source orbifold base-change diagram. The label periods concern
covers marked over X, not moduli periods of the abstract source curves.

Focused audit: [record](../../Research/audits/DEGREE2_A4_PRYM_AUDIT_2026_09_11.md),
/root/audit_degree2_a4_prym,2026-09-11. The geometric carrier, Prym,
factor-only implication and exact label counts pass. The original note
overcounted conjugate targets for the isogeny-only test; corrected above.

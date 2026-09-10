# Small examples are tests of mechanisms, not a new degree-by-degree campaign

2026-09-10. Latest user explicitly asks for understanding that transfers
from a playground to the actual common-cover problem. Main endpoints,
paused A18 and paused backup source comparisons are unchanged.

## 1. Tested first: a trace-zero pencil versus a plane

For an actual bi-etale X<-f-Z-g->Y with g(Y)=2 and g_*f^*=0 on
Jacobians, set n=deg f. The family D_x=g_*f^*(x) in Sym^n(Y) has
constant Abel class, hence lies in one complete system |L|, deg L=n.
It moves nontrivially and has no common base point: a fixed point of
Y would otherwise force the finite set g^-1(P) to meet EVERY f-fiber.

If the family lies in a pencil, its parameter map a:X->P1 is
surjective, that pencil is basepointfree, and its map b:Y->P1 satisfies
a f=b g on the ACTUAL source. Thus the span has a core. For n<=3,
Riemann--Roch on Y forces a pencil or impossibility. More generally a
coreless norm-zero span requires n at least d_2(Y), the least degree of
a line bundle with three independent sections. This is an elementary
extension of the existing norm-zero gonality argument, not a new norm
method: see routes/global/75_ORTHOGONAL_COMPLEMENT_DIVISOR_SIEVE.md,
Section1. The older44 norm/nonpencil theorem treats a different diamond.

Degree4 is the first plane case. A coreless span here is jointly minimal:
an inessential factor of the source would leave a degree1 or2 joint
leg, already cored. Its joint image is a divisor of A external-tensor L
in X times Y, with deg L=4, h0(L)=3, deg A=4(g(X)-1), given by an
incidence equation in three pairs of sections. Put m=g(X)-1. Then

    deg f=4, deg g=4m, g(Z)=4m+1, delta(joint image)=20m.

The degree-four map defined by L is either twice the canonical conic
(L=omega_Y^2) or a birational plane quartic. The latter may have a
node OR a cusp; neither boundary may be suppressed. Both maps from
the normalization are etale, but the joint image is necessarily very
singular. A smooth-incidence argument would discard the phenomenon.

This does not yet supply an invariant controlling those singularities
in higher degree. Therefore asking Pro merely to exclude n=4 would be
case elimination, not the transferable breakthrough the user requested.
No such prompt was sent. Nothing here excludes a main common cover.

## 2. The selected laboratory now has two proved outcomes

The actual genus-two/F625 corank-one pair is defined in
[critical quartics](../Theorems/Thm_genus_two_active_critical_quartics.md).
Its higher obstruction is NO LONGER OPEN:
[explicit_genus_two_witt_obstruction](../Theorems/Thm_explicit_genus_two_witt_obstruction.md)
proves epsilon!=0 by an exact residue, with the original nonsplit twist
and jet extension retained. Source supplied, locally replayed, medium
audit PASS.

The next experiment is also complete:
[etale_p_witt_obstruction](../Theorems/Thm_etale_p_witt_obstruction.md)
gives the general deck-module survival criterion and proves all six
cyclic5 covers remove this epsilon. Their repaired source lifts cannot
extend the original map to C2. Exact computations and a fresh medium
geometric audit PASS. Do not duplicate these proofs here.

These are mechanism tests, not a new endpoint pivot or common-cover
realization. They refute both universal one-endpoint lifting and
universal persistence of its failure through etale covers. The actual
two-leg descent problem remains.

## 3. A reusable residue formula retained from the experiment

With z=u^2/v, eta=du/v, tangent frame eta^-1 and F monic of degree5,
H1(T_C)=k((z))/(k[u,v]+z^2 k[[z]]) has basis z^-3,z^-1,z.
Put a4=F_4,a3=F_3 and phi=(u^2+c1u+c0)eta^2. The three Serre weights are

    (-2a3-2a4 c1-2c0, -2c1, -2).

Indeed w=1/u=z^2+a4z^4+(a4^2+a3)z^6+..., hence
u=z^-2-a4-a3z^2+..., eta=-z dw, u^2 eta=z du and
u eta=-z dw/w. Take the three residues. Reduce the actual cocycle
modulo affine coboundaries FIRST; do not substitute a raw truncation.

The earlier handwritten inversion mistakenly retained an a4^2 term.
Exact generic-series checks corrected it before any obstruction claim.
The small pair's only automorphism is the hyperelliptic involution,
acting trivially on quadratics, so symmetry does not force the residue
to vanish. Its actual nonzero value is now established.

## Current work

See CYCLIC_P_OBSTRUCTION_PLAYGROUND.md for the completed cover mechanism.
The theta request RETURNED SUCCESS and is integrated as the audited
genus_two_active_theta. The all-abelian defect-node theorem is also now
audited and canonical. Do not send the solved properness question again.
The rank-one request RETURNED without a verdict. The next-Witt function
request is now running. Independently,
[defect_preserving_etale_descent](../Theorems/Thm_defect_preserving_etale_descent.md)
has passed its focused audit, including the effective bound: the small
bad-double experiment led to an ALL-DEGREE exclusion of Galois Y-leg
active sources with defect1 for the SAME main pair. It descends the
full f-canonical tower to a genus3 intermediate, then counts partners;
it does not lift the further map to Y. This is exactly the transferable
kind of payoff the playground was intended to produce.

The next boundary is a bounded-genus carrier of higher or non-Galois
defects. Equal defect alone cannot extend the argument to5-divisible
covers, where actual cokernel pullback can vanish. Main endpoints,
A18 and backup-only source comparisons remain unchanged and paused.

# Arithmetic and Abel torsion of the small backup

[Statement](../../Theorems/curve_arithmetic/backup_curve_arithmetic.md).

## 1. Arithmetic

The squarefree degree-five model has unique infinity O, pole semigroup
⟨2,5⟩ and div(du/v)=2O. Its Hasse–Witt determinant is3(alpha+1)^4≠0.
The six double-zero differential lines are precisely the Weierstrass
lines. The [earlier Cartier matrix](../jacobians/torsion/family_singleton_root_exclusion.md)
exclude all six from Cartier eigenlines. They hold at every smooth
parameter and require no degree-avoidance bound here.

The [preparation certificate](../../../litt3-computation-data/legacy_workspace_computations/backup_genus_two_preparation.json)
counts118 and15926 points over F125 and F15625. Newton identities give
the displayed irreducible P. Apply
[Howe–Zhu, Theorem6](https://arxiv.org/html/math/0002205v1#S4)
with q=125, a=−8, b=182. The four nonsimple cases require a=0
or a² in{q+b,2b,3b−3q}; here a²=64 and the latter values are
307,364,171. Thus the ordinary Jacobian is absolutely simple.
The ordinary converse in their
[Proposition3(2)](https://arxiv.org/html/math/0002205v1#S3)
gives Q(pi^n)=Q(pi) for every n. Tate's theorem therefore gives
geometric End⁰=Q(pi). Rosati sends pi to125/pi, and
theta=pi+125/pi satisfies theta²−8theta−68=0. Its fixed field
is Q(sqrt21), which contains no square root of5.
The original [generator](../../scripts/genus_two/backup_genus_two_prepare.sage)
retains the point counts and irreducibility check. Its obsolete
root-ratio routine is removed; the original receipt keeps its evidence.
The new proof needs only the cited theorem and four integer comparisons.

## 2. Automorphisms and moduli orbit

The [affine branch-family theorem](prime_field_branch_family.md)
applies at t=alpha. Its degree over either F5 or F25 is3, coprime
to20; hence Aut(B)=C2 and both moduli Frobenius orbits have length3.

## 3. A small Frobenius congruence controls all{2,3}-torsion

All branch points are F125-rational and v₂P(1)=v₂P(−1)=4=2g.
The [hyperelliptic two-unit criterion](../jacobians/torsion/reduced_divisor_rigidity.md#4-hyperelliptic-two-primary-descent)
therefore makes every two-primary W1 point a two-class. The six
Weierstrass points give exactly those classes.

On T₃J, division of T^24−1 by the monic P gives the short congruence

    T^24−1 ≡18(1+T³) mod(P,27).

Thus pi^24−I=9U, where U is integral and U mod3=2(I+pi)^3.
Since P(−1)=16816 is prime to3, U is a3-adic unit. On T₂J,
pi²−I=(pi−I)(pi+I) is4 times a unit.
[Boxall–Grant's order law](../jacobians/torsion/reduced_divisor_rigidity.md#3-published-torsion-order-law-and-rationality)
with τ=pi² and b=12 gives ker(pi^24−I)∩J[2^∞]=J[16].
In particular pi^24 fixes J[3] and J[4].

Apply the mixed-prime pencil theorem to the hyperelliptic map with
r=1 and N=24. Every{2,3}-primary W1 point is rational over F_(125^24),
and the two primary kernel bounds give order dividing16·9=144. The argument
uses the original effective class, without projecting it inside W1.

The retained order24 and36 Hasse-jet certificates express a power of
F as a combination of original maximal minors. The
[polynomial jet criterion](../jacobians/torsion/superelliptic_single_point_torsion_test.md)
therefore excludes all nonbranch W1 points killed by either order.
In particular W1[9] is{0}; the Frobenius bound now excludes all
three-primary W1 points. These two identities also replace the older
separate9/12 computations and their repeated-support translations.

The [bounded assembly checker](../../scripts/genus_two/audit_backup_cored_small_packet.py)
checks the displayed congruence and both original-minor identities.
The [original assembly audit](../../Research/audits/BACKUP_CORED_COMPLETION_AUDIT_2026_09_11.md)
retains the earlier, larger calculation's provenance. The Frobenius
congruence replaces its long rational inverse; no companion-matrix
model of the actual Tate module is assumed.

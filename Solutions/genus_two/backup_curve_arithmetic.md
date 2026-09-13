# Arithmetic and Abel torsion of the small backup

[Statement](../../Theorems/genus_two/backup_curve_arithmetic.md).

## 1. Arithmetic

The squarefree degree-five model has unique infinity O, pole semigroup
⟨2,5⟩ and div(du/v)=2O. Its Hasse–Witt determinant is3(alpha+1)^4≠0.
The six double-zero differential lines are precisely the Weierstrass
lines. The [family eigenline identities](../arithmetic/family_small_torsion_specialization.md)
exclude all six from Cartier eigenlines. They hold at every smooth
parameter and require no degree-avoidance bound here.

The [preparation certificate](../../Research/computations/backup_genus_two_preparation.json)
counts118 and15926 points over F125 and F15625. Newton identities give
the displayed P. Its exact factorization is irreducible. The root-ratio
resultant Res_U(P(U),P(zU)), apart from a nonzero scalar, factors as

    (z−1)^4
    ·(z^4+(12/5)z³+(48374/15625)z²+(12/5)z+1)
    ·(z^4+(68/125)z³−(2/5)z²+(68/125)z+1)^2.

The two quartics are irreducible over Q and nonintegral monic, hence
not cyclotomic. No distinct Frobenius eigenvalues have root-of-unity
ratio. Consequently P's eigenvalue powers remain distinct and conjugate
over every finite extension: the Jacobian stays simple. Tate's theorem
identifies its geometric rational endomorphisms with the unchanged
centralizer Q(pi), since every geometric endomorphism is defined over
some finite extension. Rosati sends pi to125/pi. For theta=pi+125/pi,

    theta²−8theta−68=0,

so the fixed field is Q(sqrt21), which contains no square root of5.
The original [generator](../../scripts/genus_two/backup_genus_two_prepare.sage)
checks the counts and factorization; these are retained exact inputs.

## 2. Automorphisms and moduli orbit

The [affine branch-family theorem](prime_field_branch_family.md)
applies at t=alpha. Its degree over either F5 or F25 is3, coprime
to20; hence Aut(B)=C2 and both moduli Frobenius orbits have length3.

## 3. A small Frobenius congruence controls all{2,3}-torsion

All branch points are F125-rational and v₂P(1)=v₂P(−1)=4=2g.
The [hyperelliptic two-unit criterion](../arithmetic/low_pencil_torsion_rigidity.md#4-hyperelliptic-two-primary-descent)
therefore makes every two-primary W1 point a two-class. The six
Weierstrass points give exactly those classes.

On T₃J, division of T^24−1 by the monic P gives the short congruence

    T^24−1 ≡18(1+T³) mod(P,27).

Thus pi^24−I=9U, where U is integral and U mod3=2(I+pi)^3.
Since P(−1)=16816 is prime to3, U is a3-adic unit. On T₂J,
pi²−I=(pi−I)(pi+I) is4 times a unit; the
[power formula](../arithmetic/low_pencil_torsion_rigidity.md) makes pi^24−I
equal16 times a unit. In particular pi^24 fixes J[3] and J[4].

Apply the mixed-prime pencil theorem to the hyperelliptic map with
r=1 and N=24. Every{2,3}-primary W1 point is rational over F_(125^24),
and the two displayed units bound its order by16·9=144. The argument
uses the original effective class, without projecting it inside W1.

The retained order24 and36 Hasse-jet certificates express a power of
F as a combination of original maximal minors. The
[polynomial jet criterion](../arithmetic/superelliptic_single_point_torsion_test.md)
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

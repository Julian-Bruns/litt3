# Proof: disjoint stable-factor ranks

## Frobenius pushforward

[Sun, *Direct images of bundles under Frobenius morphism*, Theorem2.2](https://arxiv.org/pdf/math/0611360#page=5)
proves that F_*W is stable when W is stable and g>=2. Sun uses relative
Frobenius; over the algebraically closed field, absolute Frobenius
factors through it and the scheme isomorphism induced by the field
Frobenius. This transport preserves ranks, degrees and stability.

Riemann–Roch gives

    mu(F_*W)=(mu(W)+(p−1)(g−1))/p.

Since F_* is exact, it carries a stable-factor filtration of a
semistable bundle of slope g−1 to another such filtration. After e
iterations every factor has rank divisible by p^e. Twisting by a
degree-zero line bundle preserves stability, slope and factor ranks.
Thus the two bundles in either Hom space of(1) have no common stable
factor: their factor ranks are respectively below p and at least p.
A nonzero morphism between semistable bundles of the same slope would
give a common simple factor. Both Hom spaces vanish.

Finite étale pullback preserves semistability and multiplies degrees
and g−1 by the covering degree. Pull back the original stable-factor
filtration and refine its semistable factors. Their ranks remain below p,
so the same argument applies on the cover.

## Defect bundles and their joint image

[Joshi, *Stability and locally exact differentials on a curve*,
Theorem1.1](https://comptes-rendus.academie-sciences.fr/mathematique/item/10.1016/j.crma.2004.02.019.pdf#page=2)
proves that B_{1,C} is stable of rank p−1 and slope g−1.
The [tangent-bundle theorem](../../Theorems/projective_connections/tangent_bundle_cyclic_refinements.md)
gives stable V_r of rank2 and semistable E_r of rank4, both of slope
g−1 in characteristic5. These satisfy the criterion, including the
case where E_r splits into two stable rank-two factors.

Normalization pushforward is fully faithful on torsion-free sheaves:
locally, for R⊂S⊂K with S the finite normalization, an R-linear map
between torsion-free S-modules extends to a K-linear map, hence commutes
with S. Closed-immersion pushforward is also fully faithful. Factor a
through the normalization of its integral image; absolute Frobenius
commutes with a. The asserted Hom spaces on A0 are consequently the
corresponding Hom spaces on D.

A zero operator is nilpotent and represents zero in the Cartier-crystal
quotient: see [Baudin, *Generic vanishing theory in positive characteristic*,
v2, Definition2.1.5](https://arxiv.org/html/2507.00771v2).
This quotient statement supplies no vanishing of ordinary cohomology.

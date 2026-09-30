# Proof: the three graphs impose a trace budget

[Statement](../../Theorems/quotient_geometry/cubic_packet_map_rigidity.md).

## The eigenspace inequality

Since X/gamma is rational, the norm identity gives
1+zeta+zeta^2=0 on J(X), where zeta=gamma^*. Its Rosati adjoint
is zeta^2. On the X-isotypic part of J(T), K is central, and the
three rational projectors for sigma are orthogonal and self-adjoint.
Write v_i for the corresponding components of h^*, and
a_i=v_i^dagger v_i in K. Then a_i are self-adjoint and
\[
a_0+a_1+a_2=M,\qquad
u=h_*\sigma^*h^*=a_0+\zeta a_1+\zeta^2a_2.
\tag{4}
\]
For every self-adjoint a in K, invariance of trace under Rosati and
commutativity give
\[
\operatorname{Tr}(\zeta a)=\operatorname{Tr}(\zeta^2a)
=-\tfrac12\operatorname{Tr}(a).
\tag{5}
\]
All traces here are on the full 2g-dimensional rational H1 of J(X).

Suppose none of the equalities h sigma=gamma^j h holds. The reduced
joint image Gamma of (h,h sigma) in X times X is then distinct from
all three graphs. If c is the degree from T to its normalization,
the product-surface correspondence intersection formula gives, after
reindexing j if necessary,
\[
0\le\Gamma\cdot\operatorname{Graph}(\gamma^j)
=\frac{2M-\operatorname{Tr}(\zeta^j u)}{c}.
\tag{6}
\]
The inequality holds even for a singular joint image and ramified h:
these are distinct effective integral divisors on a smooth surface.
The formula is the bilinear version of the
[joint-image intersection calculation](../jacobians/isogeny_sieves/etale_rosati_factorization.md).
In particular no curve-map saturation is being inferred just from
the character decomposition.

Let s_i=Tr(a_i)/(2M). Equations(4)--(5) give
\[
\sum_i s_i=g,\qquad
\operatorname{Tr}(\zeta^{-i}u)=M(3s_i-g).
\]
Equation(6) bounds every s_i above by (g+2)/3; summing the other
two bounds gives s_i>=(g-4)/3. In genus g>4 a missing component
would have s_i=0, a contradiction. This proves(1)--(2). Rosati
positivity also gives s_i>=0 independently.

One can read the contradiction without introducing the masses:
if one eigenspace is missing, one of the three traces equals -gM.
Their sum is zero, so the other two sum to gM. Distinct graph
intersections bound their sum by 4M, impossible for g>4.

## Only two Jacobian copies fit above a cyclic cubic cover of X

Now let pi:T->X be cyclic etale of degree three. Then g(T)=25.
The trivial deck packet is pi^*J(X), of dimension nine. The only
nontrivial rational packet has dimension
(g(X)-1)[Q(zeta_3):Q]=16, by the
[actual-cover packet formula](../jacobians/isogeny_sieves/etale_endomorphism_packets.md).
It contains at most one copy of the simple nine-dimensional J(X).

Therefore the entire X-isotypic part has multiplicity at most two.
Its original copy has eigenvalue one. A possible new copy has
eigenvalue zeta or zeta^2, since its K-multiplicity is one and
the invariant packet was already exhausted. At least one of the
three eigenspaces is missing.

Apply(1) to any nonconstant separable v:T->X. Riemann--Hurwitz
gives deg(v)<=3. If v sigma=v, it descends through pi, and the
resulting separable self-map of X is an automorphism.

## A nontrivial cubic return would permute the whole branch set

Suppose instead v sigma=gamma^j v with j nonzero. Quotienting
gives an actual separable map a:X->P1 with
\[
xv=a\pi,\qquad \deg a=\deg v\le3.
\]
The trigonal genus-nine X has no map of degree one or two to P1,
and its degree-three pencil is unique: two distinct degree-three
fields would give genus at most four by Castelnuovo--Severi.
Hence deg(v)=3 and a=phi x for some phi in PGL2(k). Equality in
Riemann--Hurwitz now also makes v etale.

The two embedded X-fields generate k(T): their compositum properly
contains the pi-field, whose index is the prime three. Thus T is
the normalization of the actual fiber product of x:X->P1 and
phi x:X->P1.

Let B be the eleven-point UNWEIGHTED branch set of x. If a point
of B were outside phi(B), its preimages under phi x would be
unramified, and base change of the tamely ramified cubic x would
ramify pi there. Thus B is contained in phi(B), and equality of
cardinalities gives phi(B)=B. The finite certificate below gives
phi=1. But the normalization of X times_(x,P1,x) X is the disjoint
union of the three graphs of gamma^j. It cannot be the connected
degree-three cover T. This excludes the nontrivial return.

This step deliberately uses the unweighted branch-set computation.
Aut(X)=C3 alone would not exclude a Mobius map moving infinity and
changing the distribution of the Kummer exponents.

## Complete finite branch-set check

Use the defining F25 codes of P from the fixed pair. The
[Sage source](../../scripts/arithmetic/fixed_x_branch_stabilizer.py)
finds all ten distinct roots in F_(5^8), and appends infinity.
Every geometric projective stabilizer is determined by the images
of one ordered triple. Its images are among these eleven points,
so ALL 11*10*9=990 candidates already have coefficients in F_(5^8).
The exact check retains only the identity. Of the 989 failures,
986 fail at the fourth point and three at the fifth point.

The [receipt](../../../litt3-computation-data/abelian_rigidity_20260922/branch_stabilizer.json)
contains the field modulus, the embedding of a with a^2=a+3,
all roots, rejection counts and the surviving matrix. It proves
the full unweighted stabilizer is trivial, not just its rational
subgroup over F25.

Finally every automorphism of T descends by(3), so its quotient
by the original deck C3 embeds in Aut(X)=C3. Its order is three
or nine. A free quotient subgroup has order dividing g(T)-1=24,
hence order one or three. The latter quotient has genus nine.
This gives the asserted Galois-quotient genera, without asserting
that a non-Galois quotient comes from an automorphism subgroup.

# Proof: finite projective quotients and normalized determinant powers

[Statement](../../Theorems/shared_tensors/common_finite_coefficients.md) · [Independent consolidation review](../../Research/audits/COMMON_GRASSMANNIAN_QUOTIENT_RIGIDITY_AUDIT_2026_10_03.md).
The argument retains the given vector-bundle isomorphism on the
actual source. No simultaneous Galois closure is introduced.

## The additional all-slope no-clump consequence

Retain the quotient rigidity proved below, and assume $p$ is odd,
there is no clump and $p\nmid g(C)-1$ at one endpoint. The actual
image $I$ of a nonzero compatible morphism from a common strongly
semistable $E$ to $B$ is common strongly semistable, of the slope of
$E$. Its saturation in $B$ is compatible on both endpoints, since
étale pullback commutes with saturation. The determinant defect is
a common effective divisor pair and hence must vanish in the absence
of a clump. Thus $I$ is already saturated.

The [common Cartier subbundle theorem](../../Theorems/cartier_and_spin/common_cartier_subbundles.md)
then says $I=B$: there is no proper nonzero common saturated subbundle
when $p\nmid g(C)-1$ at an endpoint. But $B_C$ is not strongly
semistable. Its first Frobenius adjunction is a quotient
$F_C^*B_C\twoheadrightarrow\omega_C$, whose slope is $2(g(C)-1)$,
strictly less than the slope $p(g(C)-1)$ of $F_C^*B_C$ for odd
$p\ge3$. This contradiction proves the all-slope vanishing.

The higher quotients have their canonical common filtrations whose
successive factors are Frobenius pushforwards of $B$ on the appropriate
twists. Adjunction reduces a compatible map from $E$ to such a factor
to a compatible map from a Frobenius pullback of $E$ to $B$.
That pullback remains common strongly semistable; the preceding
vanishing applies at every slope and twist. Induction through the
filtration proves the assertion for $B^{[e]}$. All comparison maps
are those of the actual span, with scalar Frobenius retained.

## Common image lines come from the slope-rigidity foundation

The [common quotient-rigidity theorem](../deformations/pointed_bundle_instability.md#2-common-strongly-semistable-quotients-preserve-slope)
applies to every compatible locally free quotient and saturated
subbundle of a strongly semistable common bundle, at any slope.
Its proof uses the Grassmannian finite quotient on the ORIGINAL
endpoints; no simultaneous Galois closure is presumed.

A compatible map $J\to L$, with $J$ strongly semistable of
degree zero, has an actual image line $T$ of degree zero.
Its zeros therefore form an actual common effective divisor pair
of degree $\deg L_C$. The line $T$ is torsion over
$\overline{\mathbf F}_p$. If $J$ is already finite-etale-trivial,
a connected finite etale trivialization makes its quotient map
a constant matrix, so $T$ is the corresponding finite character
quotient. No Frobenius factor remains in the divisor degree.

## The genus-two numerical consequence

For a coreless span, a nonzero common effective divisor is supported
on its unique finite physical component, and its multiplicity is
constant on that component. Thus if its reduced image on $Y$ has
$r$ points, then $r\mid\deg L_Y$. The established
[genus-two clump theorem](genus_two_clump_connection_reduction.md)
gives $r\equiv-1\pmod p$, with the additional singleton option
only when $p=5$.
For $L_Y=\omega_Y$ its degree is two. No divisor of two is
$-1$ modulo $p\ge5$; the only surviving case is the characteristic-five
singleton. Both selected endpoints exclude that case.

Finally a compatible map from strongly semistable degree-zero
coefficients on the twisted curves to $F_*\omega$ is, by Frobenius
adjunction, a compatible map from their Frobenius pullbacks to
$\omega$. The coefficients remain strongly semistable of degree
zero. The result just proved kills the adjoint map. The canonical
injection $B\hookrightarrow F_*\omega$ gives the second vanishing.
This proves the arbitrary-rank assertion and identifies exactly
which compatibility is needed.

## Morphism images and their determinant defects

For a general compatible morphism, its actual image in a vector
bundle is torsion-free, hence locally free on each smooth curve.
The source surjects onto that image. Images and saturations
commute with the two étale pullbacks, so quotient rigidity retains compatibility. If the target $H$ is strongly
semistable, the actual image $I$ therefore has slope $\mu(E)$,
and its saturation $J$ has slope $\mu(H)$ by the subbundle result.
The determinant of $I\hookrightarrow J$ gives the stated common
divisor, with degree $r(\mu(H)-\mu(E))$. Its degree is positive
exactly when these slopes differ. No root of a determinant or
choice of a spin line was used.

## The rank-$p-1$ integrality test

Suppose $E\to B$ is a nonzero compatible map and denote its
actual image by $I$, of rank $r$ with $1\le r\le p-1$.
The preceding result gives that $I$ is strongly semistable and
has slope $\mu(E)$ on each endpoint. Compose with the canonical
injection $B\hookrightarrow F_*\omega$ and use relative Frobenius
adjunction. This gives a nonzero compatible map
\[
F^*I\longrightarrow\omega.
\]
Its actual image is a line bundle $T$. Quotient rigidity on the
original, untwisted span gives
\[
\deg T=p\mu(I),\qquad \deg T\le\deg\omega.
\]
In particular $p\mu(I)$ is an integer. Also $r\mu(I)=\deg I$
is an integer. Since $1\le r<p$, the denominator of $\mu(I)$
divides both $p$ and $r$, and is therefore one. This proves
the integral-slope assertion and its bound. In genus two and
characteristic five it leaves $\mu(E_Y)\le0$. The zero-slope
case is excluded for the selected pairs by the preceding
canonical-line and singleton-clump argument. Thus the remaining
slope is at most $-1$.

This last argument uses the rank of the IMAGE, not the potentially
unbounded rank of $E$. It uses the actual image before saturation,
so the adjunction cannot silently discard its zero divisor.

Finally the nested Frobenius subalgebras give a filtration of
$B^{[e]}$ whose successive quotients are iterated Frobenius
pushforwards of the first bundle $B$, with their relative twists.
For any strongly semistable common $E$ of nonnegative slope,
adjunction identifies a compatible map $E\to F_*^iB$ with a
map $F^{i*}E\to B$. The latter vanishes by the result just proved.
An induction through the filtration therefore gives
$\operatorname{Hom}_{\rm common}(E,B^{[e]})=0$ for every $e$.
This uses exact images and adjunction, without splitting that
filtration.

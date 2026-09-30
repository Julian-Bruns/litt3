# Proof: finite projective quotients and normalized determinant powers

[Statement](../../Theorems/shared_tensors/common_finite_coefficients.md).
The argument retains the given vector-bundle isomorphism on the
actual source. No simultaneous Galois closure is introduced.

## First reduce to finite étale coefficients

A strongly semistable degree-zero bundle over $\overline{\mathbf F}_p$
becomes finite-étale-trivial after some Frobenius pullback. One can
see this by descending it to a finite field: boundedness gives only
finitely many degree-zero semistable bundles of its rank over that
field, so the Frobenius sequence is eventually periodic. A periodic
bundle is étale-trivial by Lange--Stuhler. This is the boundedness
argument in [Subramanian, Theorem3.2](https://arxiv.org/pdf/math/0611212);
the periodic trivialization theorem is stated in
[Biswas--Ducrohet, Theorem1.1](https://comptes-rendus.academie-sciences.fr/mathematique/item/10.1016/j.crma.2007.10.010.pdf).

Choose one exponent $a$ working for both endpoints. Pull back the
entire compatible pair of maps by the $a$th absolute Frobenius.
This operation commutes with the two actual maps and is faithfully
flat on the smooth curves, so it retains nonvanishing. It replaces
$L_Y$ by $L_Y^{\otimes p^a}$. Absolute Frobenius here is only the
functorial pullback of bundles; it does not identify distinct
relative Frobenius twists as $k$-curves.

It remains to prove the assertion when both coefficient bundles
are finite-étale-trivial. Denote them by $J_X,J_Y$ again.

## A common finite matrix group

Morphisms between finite-étale-trivial bundles on a proper connected
curve are morphisms of their finite local systems. Indeed, after a
common connected finite étale trivialization, a bundle morphism is
a matrix of global regular functions, hence a constant matrix.

Fix fibers above one geometric point of $Z$ and use the specified
isomorphism to identify them with a vector space $V$. The two finite
monodromy images $A_X,A_Y\subset\mathrm{GL}(V)$ then have compatible
restrictions to $\pi_1(Z)$. Their finitely many matrix entries lie
in one finite field. Consequently
\[
\Gamma=\langle A_X,A_Y\rangle\subset\mathrm{GL}_r(\mathbf F_q)
\]
is finite. This use of $\overline{\mathbf F}_p$ is essential.

Trivialize $J_X$ on a connected finite étale cover $X'\to X$.
The nonzero map to $L_X$ gives a rational map
$\phi_X:X'\dashrightarrow\mathbf P(V^\vee)$. Its value records
the proportionality class of the associated local sections of $L_X$.
The map extends on the smooth curve. It is $A_X$-equivariant.
There is a finite geometric quotient
\[
\pi:\mathbf P(V^\vee)\longrightarrow\mathbf P(V^\vee)/\Gamma.
\]
For a finite group this construction works also when $p$ divides
its order: cover projective space by invariant affine opens and
take the integral invariant-ring quotients. Averaging is unnecessary.

The composition $\pi\phi_X$ descends to $X$. The corresponding
construction on $Y$ descends to $Y$, and the two rational maps
agree on $Z$. Compatibility can be checked after a common finite
étale trivialization on $Z$, where their row vectors agree up to
the scalar specifying the line-bundle identification.

If their common image had dimension one, its function field would
embed into both $k(X)$ and $k(Y)$ inside $k(Z)$. Corelessness rules
this out. Thus both quotient maps are constant. Since $\pi$ is
finite, $\phi_X$ and $\phi_Y$ are constant as well.

## A common character line and its zero divisor

On the connected trivializing cover, constancy says that the map
$V\otimes\mathcal O\to L$ has a fixed codimension-one kernel in
$V$. This kernel is preserved by endpoint monodromy. It therefore
descends to a flat subbundle and gives a finite-étale character
quotient $J_X\twoheadrightarrow T_X$, with a nonzero map
$T_X\to L_X$. The same construction gives $T_Y$. The kernels,
quotients, and maps agree on $Z$, because they are extracted from
the given compatible maps themselves.

Each $T$ has degree zero. The zero divisors of these line maps
satisfy
\[
f^*D_X=g^*D_Y,\qquad \deg D_Y=\deg L_Y>0.
\]
For the original strongly semistable coefficients, first take the
actual image $I_Y\subset L_Y$, a line bundle on the smooth curve.
Flatness identifies the image after the $a$th Frobenius pullback
with $I_Y^{\otimes p^a}$. The finite-coefficient argument just
proved makes that image degree zero. Hence $\deg I_Y=0$ already.
The same applies on $X$. Images commute with the two étale
pullbacks, so these original image lines and their zero divisors
are compatible. This removes the Frobenius factor from the degree.
The image lines are torsion because every degree-zero line bundle
over $\overline{\mathbf F}_p$ is defined over a finite field.

Notice that we did not assume the refined span
$X'\leftarrow Z'\to Y'$ remained coreless: the core was constructed
on the ORIGINAL endpoints by their common finite projective quotient.

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

## Locally free quotients of arbitrary slope

Let $E$ have rank $N$ and let $E\twoheadrightarrow I$ be a
compatible locally free quotient of rank $r$. This notation
denotes the given quotient on EACH endpoint and the specified
identification on the actual source. Form
\[
J=(\bigwedge^r E)^{\otimes N}\otimes(\det E)^{-r},\qquad
L=(\det I)^{\otimes N}\otimes(\det E)^{-r}.
\]
Taking determinants of the quotient and then its $N$th tensor
power gives a compatible SURJECTION $J\twoheadrightarrow L$.
Strong semistability is preserved by exterior and tensor powers
and by line twists; see the Ramanan--Ramanathan input in
[Subramanian, Section2](https://arxiv.org/pdf/math/0611212).
Consequently $J$ is strongly semistable of degree zero, while
\[
\deg L=N\deg I-r\deg E
       =Nr\bigl(\mu(I)-\mu(E)\bigr)\ge0.
\]
The inequality also follows directly from semistability of $E$.
If the degree were positive, the degree-zero result already proved
would make the actual image of $J\to L$ a degree-zero line. But
the map is surjective. Hence $\deg L=0$ and $\mu(I)=\mu(E)$.
Applying every Frobenius pullback to the quotient now proves that
$I$ is strongly semistable: it is a quotient of a semistable bundle
with the same slope. Applying this argument to the dual proves
the assertion about compatible saturated subbundles.

For a general compatible morphism, its actual image in a vector
bundle is torsion-free, hence locally free on each smooth curve.
The source surjects onto that image. Images and saturations
commute with the two étale pullbacks, so all the preceding
constructions retain compatibility. If the target $H$ is strongly
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

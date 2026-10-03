# Proof: corestrict the extension and normalize its boundary

[Statement](../../Theorems/deformations/prime_to_five_bt_extension_descent.md).
All Ext groups are in abelian fppf sheaves. Retain the actual
BT$_N$ group $A$ and $H=A[p]$.

## The exact boundary criterion

For $e:0\to H\xrightarrow{i}B\xrightarrow{\pi}A\to0$ and
$a\in A[p]$, an fppf-local lift $b$ gives
\[
\partial(e)(a)=pb\in H.
\tag{2}
\]
This is independent of the lift because $pH=0$, additive in
$e$ and functorial. An actual marked BT$_{N+1}$ with quotient
map $[p]:B\to A$ has boundary $\operatorname{id}_H$.

Conversely assume this boundary is the identity. The middle sheaf
is an $H$-torsor over the finite locally free $A$, hence is
representable and finite locally free. If $pb=0$, then
$\pi(b)\in A[p]$ and the boundary gives $\pi(b)=0$. Thus
$B[p]=i(H)$. Multiplication by $p$ factors through an injective
$\beta:A\to B$ with $\pi\beta=[p]_A$ and $\beta|_H=i$.
Therefore
\[
p^N B=\beta(p^{N-1}A)=\beta(H)=i(H)=B[p].
\tag{3}
\]
Also $p^{N+1}B=0$. The exactness of
$B\xrightarrow{p^N}B\xrightarrow{p}B$ is precisely flatness
over $\mathbf Z/p^{N+1}$ as an fpqc module sheaf. Since $N+1\ge2$,
this and finite local freeness are the truncated BT criterion in
[Illusie, Definition1.1](https://www.imo.universite-paris-saclay.fr/~luc.illusie/Illusie-Chicago-2023-1.pdf#page=1).
It is stated for an arbitrary prime. Its lower truncation is
$B[p^N]=pB=\beta(A)$, providing the specified marking.

## Corestriction retains the exact boundary

Finite etale direct image of abelian sheaves is exact: locally
on a splitting etale cover it is a finite product. Push the
supplied extension $e_D$ forward, pull back its quotient along
the diagonal $A\to q_*q^*A$, and push out its kernel along
the sum $q_*q^*H\to H$. Naturality and additivity of (2) give
\[
\partial\operatorname{cor}_q(e_D)=d\operatorname{id}_H.
\tag{4}
\]
Choose an integer $a$ with $ad\equiv1\bmod p$. The Baer multiple
$a\operatorname{cor}_q(e_D)$ has boundary the identity, so the
first part realizes it as an actual marked BT$_{N+1}$ on $C$.

For odd $p$ in height two and dimension one, the discrepancy
from a supplied compatible determinant target is a character
in $1+p^N\mathbf F_p$. Squaring is invertible on this group.
Its inverse square character twist is trivial at the preceding
level and corrects the next determinant. This step presupposes
a compatible determinant target; it does not change the marked $A$.

## The characteristic-five application and the single-cover reduction

The comparison in [common BT1 realization](common_admissible_bt1.md)
identifies $f^*H_X$ with $g^*H_Y$ tensored by an order-four
etale character. Its Teichmuller $\mathbf Z_5$-lift gives a full
extension of $f^*H_X$. Apply (4) with $q=f$, $p=5$, $N=1$.
Corestriction does not preserve the specified upper extension.

For the general reduction, take the connected Galois closure
$W\to C$ of the SINGLE cover, of group $\Gamma$, and a Sylow
$p$-subgroup $P$. A subgroup series factors $W\to W/P$ into
cyclic degree-$p$ covers. If existence descends through each such
step, it descends to $W/P$. The residual degree $[\Gamma:P]$
is prime to $p$, so (4) descends it to $C$. This supplies no
simultaneous Galois envelope of a two-leg span.

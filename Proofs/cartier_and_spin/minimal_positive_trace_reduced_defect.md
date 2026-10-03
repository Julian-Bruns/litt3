# Proof: transverse-plane collision excludes repeated section defects

Version1,2 October2026. [Focused independent root review](../../Research/audits/MINIMAL_POSITIVE_TRACE_REDUCED_DEFECT_AUDIT_2026_10_02.md) PASS.
[Statement](../../Theorems/cartier_and_spin/minimal_positive_trace_reduced_defect.md).
This is a purely geometric argument on the actual same-source span.

Use the exact integral identity
$I+P_X=U$ from
[the first positive-trace proof](actual_first_trace_positive_rank_three_exclusion.md).
Thus $J+K=H$. The same proof supplies the local facts
$I=U$ at every ordinary finite point and
$\tau P_X\subset I$ at every finite cubic branch, whose original
saturation defect has length one. Infinity is treated by counting its
actual sheet representatives, not by imposing a local inclusion there.

Take a connected Galois closure $q:T\to Y$ of the ONE genus-two leg,
of degree $8d$, with its conjugate actual maps $h_i:T\to X$ of degree
$d$. Let $P_1,\ldots,P_N$ be the distinct conjugate positive planes.
They form a transitive deck orbit and each has $8d/N$ raw sheet
representatives. They have degree $7d$ and are saturated in $q^*K$,
because $q^*K/P_i$ embeds in the torsion-free $q^*B_Y/P_i$.

Join two distinct vertices when their generic planes are transverse.
The resulting graph is deck invariant, hence regular, of valency
$\delta$ and edge count $T_0=N\delta/2$. It is nonempty. To see this,
suppose every pair meets. The planes are Lagrangian in the generic
four-dimensional Cartier fiber. Choose two distinct planes meeting
in a line $L$; their sum is $L^\perp$. Any third plane meeting both
either contains $L$ or is spanned by its two distinct intersection
lines, hence lies in $L^\perp$. Every Lagrangian plane inside this
three-space contains its radical $L$. All the planes would therefore
span at most $L^\perp$, contradicting the rank-four trace.

For every graph edge, the determinant of the two planes in $q^*K$
is nonzero, with zero divisor of degree
\[
16d-7d-7d=2d.
\]
The sum of these divisors over all edges is deck invariant. Its
multiplicity is therefore the same at all $8d$ points of any
$q$-fiber. In particular at any point at most $T_0/4$ edge pairs
fail to be transverse in the fiber. This is the decisive budget;
it is computed in $q^*K$, not in the larger Cartier lattice.

Let $C=J\cap K$. Then $K/C\simeq H/J$. Suppose one local elementary
exponent at $Q\in Y$ is $a\ge2$. In a Smith basis of $K$ over the
local DVR, a selected coordinate of every section of $C$ lies in
$\tau^aR$. Pull this basis to $t\in q^{-1}(Q)$.

Remove a distinct plane only if ALL its raw representatives send $t$
to $O$. At most $d$ raw labels do so: the deck action identifies their
count with $|h_0^{-1}(O)\cap q^{-1}(Q)|$, bounded by $d$. Hence at
most $N/8$ distinct planes are removed. Every surviving plane has a
non-infinity representative. At an ordinary finite point it lies in
$C$; at a cubic branch its multiple $\tau P_i$ lies in $C$. Since
$a\ge2$, in both cases its selected coordinate vanishes modulo
$\tau$. Thus all surviving plane fibers lie in one hyperplane of
$(q^*K)_t$.

Removing $k\le N/8$ vertices covers at most $k\delta\le T_0/4$
edges of the regular graph. At least $3T_0/4$ edges consequently have
both endpoints surviving. Their plane fibers lie in one hyperplane
and cannot be transverse, contradicting the upper budget $T_0/4$.
Here $T_0>0$ is essential and was proved above.

Every elementary exponent is at most one. After etale local splitting,
the complete trace map is the sum of the actual sheet maps. The proof
uses this identity without dividing by a covering degree, so it also
applies to degrees divisible by five. Duplicate raw representatives
were used only for the infinity count, never as graph vertices or
as pairs with identically zero determinant.

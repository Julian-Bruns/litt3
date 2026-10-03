# Low-rank Frobenius instability and the characteristic-five Cartier exception

Version3,3 October2026. Let $k$ be algebraically closed of
characteristic $p\ge5$ and let $X\xleftarrow fZ\xrightarrow gY$
be an ACTUAL finite etale span of smooth proper connected
hyperbolic curves with no clump. All common bundles and
connections retain their specified comparison on this SAME source
and on every relative or coefficient twist.

## The projective detector in arbitrary genus

Let $E$ be common and semistable on both endpoints.
If it is not strongly semistable, the original span has a
common regular dormant projective connection whenever
\[
\operatorname{rk}E\in\{2,3\},\quad p\ge5,
\qquad\text{or}\qquad
\operatorname{rk}E=4,\quad p\ge7.
\]
Thus in the no-common-oper branch all common semistable bundles
of ranks at most three are strongly semistable for every
$p\ge5$, and those of ranks at most four are so for $p\ge7$.

Rank-two instability always forces $2\mid\deg E_C$ on each
endpoint. Rank-three instability forces $3\mid\deg E_C$
whenever $3(g(C)-1)\le p$, in particular on a genus-two endpoint.
No unrestricted arbitrary-genus degree divisibility is claimed
for ranks three or four.

The mechanism is intrinsic. A full rank-$n$ oper gives a scalar
projective connection when $n(n^2-1)$ is invertible. Its
Schwarzian coefficient is $1/2,2,5$ in ranks two, three, four.
Horizontal stops give smaller actual opers; the rank-four
two-by-two HN case gives either a two-block oper or a genuine
horizontal rank-two subquotient.

In the full rank-three oper case at $p=5$, adjunction also gives
an ACTUAL injection $E\hookrightarrow F_*N$, with rank-two
locally free quotient whose canonical Frobenius connection is
a complementary dormant projective oper.

## The conditional Cartier boundary at every prime

After an ACTUAL source refinement of degree at most two,
endpoint theta characteristics can have a common identification.
On its first twist,
\[
B\vartheta^{-1},\qquad B=F_*\mathcal O/\mathcal O,
\]
is a common stable bundle of rank $p-1$ and degree zero,
whose first Frobenius pullback is unstable.
No clump and no common projective connection persist under
this refinement. This is a conditional example, not existence
of a no-oper span or a complete rank threshold for every prime.

## Exact characteristic-five/genus-two classification

For the remaining assertions retain $k=\overline{\mathbf F}_5$
and $g(Y)=2$. If there is no common regular projective connection,
a common semistable rank-four bundle satisfies
\[
E\text{ not strongly semistable}
\quad\Longleftrightarrow\quad F^*E\text{ unstable}
\quad\Longleftrightarrow\quad E=B\otimes L
\]
for an ACTUAL common line $L$. Such bundles are common-simple.
No twist $B\otimes L$ has a common connection; hence there is
no delayed instability in ranks at most four.
In this branch $4\nmid\deg E_Y$ forces strong semistability.

A common semistable rank-three degree-zero bundle fails strong
semistability if and only if a common dormant projective oper
exists. Its actual adjoint bundle $\operatorname{End}^0(Q)$
is such an example; no common spin line is required.

Write $e=1$ or $2$ for the generator of degrees in the
[actual common Picard group](../shared_tensors/saturated_divisor_relations.md).
A non-strongly-semistable degree-zero rank-four bundle in the
no-oper branch exists exactly when $e=1$, equivalently when
there is a common degree-one line on $Y$.
Allowing either oper branch, the least possible rank $m$ of
a common semistable degree-zero bundle which is not strongly
semistable is exactly:

| Common regular projective oper | $e=1$ | $e=2$ |
| --- | --- | --- |
| Exists | $m=2$ | $m=3$ |
| Does not exist | $m=4$ | $m=5$ |

The rank-five example is the ACTUAL common $F_*\omega^{-2}$.
The table uses the original comparison before a theta refinement.
It does not decide which row or column occurs for an unknown span.

The detector does not supply a small common coefficient from
an arbitrary span. The Cartier exception and minimum-rank table
retain their characteristic-five/genus-two scope; they are not
automatically extended by the general detector.
[Proof](../../Proofs/cartier_and_spin/low_rank_common_frobenius_instability.md).

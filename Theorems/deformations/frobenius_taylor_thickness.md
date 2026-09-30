# Frobenius height controls integral Taylor transport

Let $A$ be a complete mixed-characteristic DVR with uniformizer $\pi$,
$p=u\pi^e$, and $p>2$. Its coefficient Frobenius preserves the valuation.
On a smooth formal relative curve, let $\mathcal H$ be a locally free
integral crystal with a horizontal Frobenius $F$. Assume
\[
F(\varphi^*\mathcal H)\subset\mathcal H,
\qquad \pi^a\mathcal H\subset F(\varphi^*\mathcal H),
\qquad 0\le a\le e.
\]
The same conclusion holds for a finite cycle of coefficient components
and $p$-Frobenius maps between them, if the bound $a\le e$ holds
for every map in that cycle. In an integral local frame and
an étale coordinate $z$, write its rational Taylor transport as
$T(z,t)=\sum_{j\ge0}T_j(z)t^j$. Then
\[
v_\pi(T_j)\ge-a\lfloor\log_pj\rfloor\quad(j\ge1).
\tag{1}
\]
Consequently, if $n\ge1$ and $(p-1)n>a$, transport between maps
congruent modulo $\pi^n$ is integral, converges, and is the identity
modulo $\pi^n$. Modulo $\pi^{n+1}$ only its linear connection term
survives. The integral transports satisfy the actual Taylor cocycle
and commute with finite étale pullback.

Suppose now that the reduced curve is smooth proper of genus at least
two and the rank is two. An actual oper line in the evaluation over
the entire constant curve $C_{A/\pi^n}$, with $n\le e$ and
$(p-1)n>a$, determines a unique marked smooth proper lift of that
curve-line pair over $A$, for this FIXED coefficient crystal. This
lifting construction retains both maps of a compatible finite
bi-étale span. Rational compatibility and one endpoint oper lattice
with the displayed Frobenius height already suffice, by stable-lattice
descent.

In particular an oper supplied to precision $\pi^a$, with $1\le a\le e$,
always suffices. There is no restriction on $a/e$. No divided powers
on $(\pi^a)$ and no dormancy assumption are required here. A connection
without the displayed Frobenius bound does not satisfy this stronger
criterion merely because it has an oper reduction.

There is a sharper componentwise statement. Index a cycle by
$i\in\mathbf Z/f\mathbf Z$, let $F_i$ map component $i-1$ to $i$,
and suppose its height bound is $0\le a_i\le e$. Define
\[
S_i(r)=\sum_{h=0}^{r-1}a_{i-h},\qquad S_i(0)=0,
\qquad \tau_i=\max_{1\le r\le f}\frac{S_i(r)}{p^r-1}.
\tag{2}
\]
Then the actual component Taylor series satisfies
\[
v_\pi(T_{i,j})\ge-S_i(\lfloor\log_pj\rfloor).
\tag{3}
\]
All the integral transport and rank-two lifting assertions above hold
for component $i$ whenever $n>\tau_i$. Only the oper on that component
is needed; the other components need not be opers. The bound uses
every actual constituent Frobenius map, not just their composite.

In particular, if the last $s$ incoming maps before component $i$
are integral isomorphisms, then
$\tau_i\le e/(p^{s+1}-1)$. An actual residue oper on this component
therefore lifts whenever $e<p^{s+1}-1$. For $p=5$, one incoming
isomorphism permits $e\le23$, two permit $e\le123$.
This does not construct the residue oper or the incoming isomorphisms.

There is also a statement using only an actual $q=p^s$ Frobenius
map on one component, with integral matrix and inverse of height
$a\le e$. Put
\[
b_s(j)=\begin{cases}0&1\le j<p,\\
1+\lfloor\log_q(j/p)\rfloor&j\ge p.
\end{cases}
\]
Then $v_\pi(T_j)\ge-a b_s(j)$. The same oper-lifting criterion
$(p-1)n>a$ follows, provided the whole initial oper line is given.
For $s=1$ this is(1). For $s>1$ the first possible denominator
still occurs at degree $p$, not degree $q$. The proof supplies an
integral rank-two local $q$-Frobenius crystal with
$v_\pi(T_p)=-a$ for every $1\le a\le e$. Thus a small height for
the composite alone does not give higher Cartier descent, an oper
line, or the stronger threshold $(q-1)n>a$.

Version3,20 September2026. The composite-Frobenius estimate and its
sharp first-denominator example separate it from the ordered
componentwise bound. Author proof by the coefficient recurrence;
the logarithmic estimate agrees with the integral-connection case of
Kedlaya--Tuitman, Lemma2.5. No numerical certificate is involved.
[Proof](../../Proofs/deformations/frobenius_taylor_thickness.md).

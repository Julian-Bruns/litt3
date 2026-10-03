# Proof of weighted power-trace integrality detection

The [statement](../../Theorems/cartier_and_spin/trace_power_integrality_detection.md)
is elementary local algebra. No numerical certificate is used.

## Maximal poles, Vandermonde separation and Newton identities

Suppose a pole exists and use the largest pole order $M>0$ from the
statement. For every maximal-pole branch write
\[
u_i=\kappa_i\pi^{-M}+\text{terms of greater valuation},
\qquad \kappa_i\in\kappa^\times.
\]
Let $c_1,\ldots,c_s$ be the distinct residues of its $a_i$, with $s\le d$,
and let $I_c$ be the indices with residue $c$ and pole order exactly $M$.
For each $k=1,\ldots,r$, the order $-kM$ coefficient of the integral
weighted traces gives
\[
\sum_c c^j\sum_{i\in I_c}\kappa_i^k=0,
\qquad 0\le j\le d-1.
\]
Branches of smaller pole order contribute nothing at this order, because
every $a_i$ is integral. Taking the first $s$ rows gives a square
Vandermonde matrix on distinct residues, whose determinant is nonzero.
Hence each individual group has power sums
$\sum_{i\in I_c}\kappa_i^k=0$ for $1\le k\le r$.

Every nonempty group has size $m\le r<p$. Newton identities through
degree $m$ are valid with invertible divisors $1,\ldots,m$ in $\kappa$.
They force all elementary symmetric functions of its $\kappa_i$ to be
zero. The monic polynomial having these nonzero roots would therefore
be $Z^m$, a contradiction. Thus there was no pole.

For the necessity of a cohort bound below $p$, take $R=\kappa[[\pi]]$
in characteristic $p$, $n=p$, $a_i=c\in R$ for every $i$, and
$u_i=\pi^{-1}$ for every $i$. Then
$\operatorname{Tr}(a^j u^k)=p c^j\pi^{-k}=0$ for all $j,k$, while all
$u_i$ are nonintegral. This is a counterexample to a general trace-only
criterion without the cohort restriction, not an admissible source.

## Reciprocal traces at degree at most twice the characteristic

Assume the reciprocal hypotheses. If any $u_i$ has a pole, its cohort of
largest pole order has at least $p$ members. Indeed, if it had fewer,
the leading coefficients of the regular traces of $u^k$ would give zero
power sums through its size, and the same Newton argument as above would
force those nonzero leading coefficients to vanish.

The unit norm implies $\sum_i\operatorname{ord}(u_i)=0$, so a pole requires
a zero. Applying the same argument to $u^{-1}$ shows that the cohort of
largest zero order of $u$ also has at least $p$ members. The two cohorts
are disjoint. Thus they cannot occur if $n<2p$. If $n=2p$, both cohorts
have exactly $p$ members and exhaust every branch. In particular every
pole has one common order $M$ and every zero has one common order $N$.
The unit norm gives $pM=pN$ as an equality of integer valuations, hence
$M=N$.

In each cohort the first $p-1$ power sums of the leading coefficients
vanish. Newton identities imply that its monic root polynomial has form
$Z^p-c$. In residue characteristic $p$, all its roots therefore coincide;
this conclusion does not require the residue field to be perfect, since
the roots under consideration already belong to that field.

In $e_p(u)$ the product of the $p$ pole branches is the unique term of
valuation $-pM$. Every other product of $p$ branches includes a zero branch
and has greater valuation. The leading product is nonzero, so no
cancellation is possible and $e_p(u)$ has exact pole order $pM$. Its
regularity excludes the nonunit case. Conversely, unit tuples have all
these traces, their norm, and every elementary symmetric coefficient
regular. This completes the reciprocal assertion.

## Newton carries in arbitrary degree

Put $P_j=\sum_i u_i^j$ and $e_0=1$. Newton's integral polynomial
identity is
\[
k e_k=\sum_{j=1}^k(-1)^{j-1}e_{k-j}P_j.
\]
Through $p-1$ all divisors $k$ are units in $R$, so the forward low
traces give regular $e_1,\ldots,e_{p-1}$. The reciprocal traces similarly
give regular $e_j(u^{-1})$ for $j<p$. Since
$e_{n-j}(u)=e_n(u)e_j(u^{-1})$ and the norm $e_n$ is a unit, all the
outer coefficients $e_{n-p+1},\ldots,e_{n-1}$ are regular as well.

Induct jointly on $k\le N=n-p$. Assume all earlier $e_j,P_j$ are regular.
If $p\nmid k$, the required $P_k$ is regular and division by the unit
$k$ in Newton's identity gives regular $e_k$. If $p\mid k$, the
coefficient $e_k$ is a supplied carry. Solving the same identity for
$P_k$, whose coefficient is $(-1)^{k-1}$, gives regular $P_k$ without
any division by $k$. This closes the induction. It works in mixed
characteristic as well as characteristic $p$.

All coefficients of $\prod_i(Z-u_i)$ are now regular. Every $u_i\in K$
is integral over $R$ and hence belongs to $R$, since a DVR is integrally
closed. The unit norm makes the sum of their nonnegative valuations
zero, so each belongs to $R^\times$. Conversely, a unit tuple has every
power trace, reciprocal trace and elementary coefficient regular.
When $n=2p+r$ the missing coefficient interval is precisely
$e_p,\ldots,e_{p+r}$; the sole carry is $e_p$ and all other indices in
the interval are units modulo $p$. This proves the specialized list.

Here are exact sharpness examples over $R=k[[\pi]]$, with $k$
algebraically closed of characteristic $p$. To omit $e_p$, take $p$
copies of $\pi^{-1}$, $p$ copies of $\pi$, and $r$ copies of $1$.
The norm is one and every forward and reciprocal power trace is the
regular constant $r$. The unique product of the $p$ pole branches makes
$e_p$ have pole order $p$.

For $1\le i\le r$, put $q=p+i$ and take the tuple consisting of
\[
(\zeta\pi^{-p})_{\zeta^q=1},\qquad
p\text{ copies of }\pi^q,\qquad r-i\text{ copies of }1.
\]
There are $q+p+r-i=2p+r$ entries and the norm is a nonzero constant.
Since $q$ is prime to $p$, all its roots of unity are distinct. Their
$j$th power sum is zero unless $q\mid j$, and then it is $q$.
The $p$ equal zero branches contribute zero to every power trace in
characteristic $p$. Hence all low forward and reciprocal traces are
regular. Among the additional exponents $p+1,\ldots,p+r$, the only
multiple of $q$ is $q$ itself, since they are less than $2p<2q$.
All extra traces except $P_q$ are regular; $P_q$ has exact pole order
$pq$. The characteristic polynomial is
\[
(Z^q-\pi^{-pq})(Z^p-\pi^{pq})(Z-1)^{r-i}.
\]
Its coefficient $e_p$ is, up to sign, $\pi^{pq}$ and is regular:
the first possibly nonregular coefficient has index $q>p$, and the
unit factor has degree $r-i<p$. This is a counterexample when the
single trace $P_{p+i}$ is omitted while all other specified data are
retained. These tuples are local algebra counterexamples, not actual
admissible sources.

## Why the cubic model supplies the cohort bounds

In the cubic model, $\phi(w_i)$ is a unit: if it vanished modulo $\pi$,
the equality $F(w_i)=0$ would contradict the unit $\tau$. Also
\[
F'=\phi D.
\]
Since $F$ is separable, each $D(w_i)$ is nonzero over $K$. Poles of
$u_i=U(w_i)/D(w_i)$ can occur only over roots of $\overline D$, so their
$w_i$ have at most three distinct residues.

If $m$ source branches reduce to one such residue $c$, then $c$ has
multiplicity $m$ in $\overline F$. The multiplicity in its derivative is
at least $m-1$, and is at least $m$ if $5\mid m$. Since $\overline\phi(c)$
is nonzero and $\overline D$ is a nonzero polynomial of degree at most
three, it follows that $m\le4$. These bounds apply in particular to the
subset of maximal-pole branches. The general theorem applies with
$d=3,r=4$ once the $k=1$ traces are known to be integral.

Those first-power traces are automatic. The monic power-basis trace
formula gives
\[
\operatorname{Tr}(w^j U(w)/D(w))
=v^{-1}[T^9]\bigl(T^j\phi U\bmod(F/v)\bigr).
\]
For completeness, for any separable monic polynomial $P$ of degree ten,
interpolation of a polynomial of degree less than ten shows that its
coefficient of $T^9$ equals $\sum_i g(w_i)/P'(w_i)$. Applying this to
$gP'\bmod P$ proves the stated trace formula. Multiplication by the monic derivative
$(F/v)'=\phi D/v$ cancels $D$ in the trace-dual formula. Monic polynomial
division preserves integral coefficients, and $v$ is a unit. Thus the
display is integral for $j=0,1,2$. Tests for powers two through four now
give integrality of all $u_i$ by the general theorem. The converse is
immediate because both $w$ and $u$ are integral.

## Conductor interpretation and boundaries

Set $P=F/v$ and $Q_i=P/(T-w_i)$. The conductor of $B=R[T]/P$ in its
normalization $R^{10}$ consists of tuples $(P'(w_i)a_i)_i$ with $a_i\in R$.
To prove this, a normalized tuple $z$ lies in the conductor exactly when
every coordinate tuple $z_i e_i$ lies in $B$. Its interpolating polynomial
is $z_iQ_i/P'(w_i)$. Since $Q_i$ is monic, its coefficients are integral
exactly when $z_i/P'(w_i)\in R$. This proves the asserted conductor
formula, or equivalently $\mathfrak c=\sum_i RQ_i$ in $B$.

The tuple represented by $U$ is $(u_iD(w_i))_i$. Since
$P'(w_i)=\phi(w_i)D(w_i)/v$ and $v,\phi(w_i)$ are units, it lies in the
conductor exactly when every $u_i$ is integral. This establishes the
claimed linear interpretation.

The derivative multiplicity argument fails when $\overline D=0$; then
$\overline F$ can be a polynomial in $T^5$, permitting fivefold cohorts.
The argument that $\phi(w_i)$ is a unit fails at $\tau=0$, and monic
integrality can fail at $v=0$. The theorem asserts nothing at those
boundaries. In an actual admissible source they require the endpoint,
fractional conductor, and other local lattices separately.

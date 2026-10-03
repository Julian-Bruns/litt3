# Contact bounds and canonical quotients for shared tensors

Version2,3 October2026. The original uniform contact bound retains
its independent audits. Later stratified counting and quotient
conclusions are consolidated here, with focused author review.

Let $k$ be algebraically closed of characteristic $p>0$.
Let $X,Y$ be smooth projective connected curves of genus at least
two, with nonzero regular canonical tensors $s_X,s_Y$ of the same
weight $d\ge1$. Consider a nonempty finite REDUCED union of distinct
joint images whose smooth normalizations $Z_i$ retain two actual
finite etale maps $f_i:Z_i\to X$, $g_i:Z_i\to Y$ satisfying
$f_i^*s_X=g_i^*s_Y$. Put
\[
A=\sum_i\deg f_i,\quad B=\sum_i\deg g_i,\quad
T=\sum_i(g(Z_i)-1)=A(g(X)-1)=B(g(Y)-1).
\]
Let $\mathcal E$ be the common set of positive zero multiplicities.
For $e\in\mathcal E$, let $u_e,v_e$ count the zeros of order e on
X,Y and let $r_e$ be the prime-to-p part of $e+d$.

## One contact inequality for every weight and stratum

If $p\mid d$ and $p\nmid e$ for some stratum, then
\[
B\le r_eu_e,\qquad A\le r_ev_e.
\tag{1}
\]
Otherwise, when $p\nmid d$, let $m_e\ge2$ be least with
$e+dm_e=0\bmod p$; when p divides both d and e, put $m_e=2$.
Thus $2\le m_e\le p+1$. Define
\[
K=\sum_{e\in\mathcal E}\left(1+\frac{m_e-1}{r_e}\right)-2.
\]
Then
\[
KAB\le2T+\sum_e m_eAu_e.
\tag{2}
\]
If $K>0$,
\[
B\le\frac{2(g(X)-1)+\sum_e m_eu_e}{K},\qquad
A\le\frac{2(g(Y)-1)+\sum_e m_ev_e}{K}.
\tag{3}
\]
In particular two distinct positive zero multiplicities always
give a degree bound, in every characteristic and at every weight.
The reduced-union bound includes contacts BETWEEN image components.

## The original uniform and simple-zero bounds

If $\operatorname{div}(s_X)=eD_X$,
$\operatorname{div}(s_Y)=eD_Y$ with both D reduced and
$p\nmid d(e+d)$, put $n=e+d$ and let $m\ge2$ be least with
$e+dm=0\bmod p$. Equation(2) becomes
\[
\frac{m-1-n}{2n}AB\le(1+md/e)T.
\]
If $m>n+1$, this gives
\[
B\le\frac{2(g(X)-1)n(e+md)}{e(m-1-n)},\qquad
A\le\frac{2(g(Y)-1)n(e+md)}{e(m-1-n)}.
\]
A single jointly minimal actual span is the one-component case.

For $p\ge5$, a shared one-form with simple zeros has
\[
B\le\frac{4p(g(X)-1)}{p-4},\qquad
A\le\frac{4p(g(Y)-1)}{p-4}.
\]
If an actual effective orbifold atlas $C\to S$ pulls back a
rational coarse one-form to a regular simple-zero form, its degree
is at most $4p(g(C)-1)/(p-4)$. No Jacobian, ordinary, tame-inertia
or prime-to-p degree hypothesis is required.

## The whole preserving relation has one quotient

For a fixed pair $(C,s)$ satisfying (1) or $K>0$, ALL exact
s-preserving self-images form a finite groupoid, with canonical
smooth proper effective quotient $S_s$ and actual finite etale atlas
$C\to S_s$. Its total atlas degree obeys the same bound with X=Y=C.
An actual tensor-preserving span between endpoint pairs satisfying
the criterion identifies their exact quotients and descended tensors.

Line preservation adds the finite cyclic prime-to-p multiplier
group $G=\operatorname{Aut}(S_s,k\beta)$ of the descended tensor.
Its multiplier character is injective and its quotient is
$S_{[s]}=[S_s/G]$. The line quotient is unchanged under connected
finite etale endpoint refinements, scalars and all positive powers.
More precisely $S_{s^a}=[S_s/G[a]]$ for every $a\ge1$; this asserts
finiteness of the power relation, not invariance of the numerical
bound under powers.

The criterion is conditional on ACTUAL tensor equality. It does
not produce a shared tensor or canonical marking on an arbitrary
unmarked common cover. The general contact budget can be nonpositive
for uniform zeros; the separate ramified-root theorem remains needed.

[Proof](../../Proofs/shared_tensors/contact_degree_bound.md).

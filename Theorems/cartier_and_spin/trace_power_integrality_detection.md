# Detecting integrality by weighted power traces

Version3, 1 October2026. Let $R$ be a DVR with uniformizer $\pi$,
fraction field $K$, and residue field $\kappa$ of characteristic $p>0$.
Let $a=(a_i)\in R^n$ and $u=(u_i)\in K^n$ in the split étale algebra
$K^n$, with trace $\operatorname{Tr}(z)=\sum_i z_i$.
Choose integers $d\ge1$ and $1\le r<p$.

If any $u_i$ has a pole, put $M=\max_i(-\operatorname{ord}(u_i))>0$.
Assume the indices with pole order exactly $M$ have at most $d$ distinct
residues $\overline a_i$, and that at most $r$ such indices share any one
residue. If
\[
\operatorname{Tr}(a^j u^k)\in R
\qquad(0\le j\le d-1,\ 1\le k\le r),
\]
then $u\in R^n$. The conditional hypothesis on maximal poles is vacuous
when there are no poles. No assumption is made on the other residue
groups or on the total degree $n$.

The bound $r<p$ is necessary in general. In characteristic $p$, a cohort
of $p$ equal pole values with the same $a$ has all weighted power traces
zero while its values are nonintegral.

## Reciprocal traces at the characteristic boundary

Let $u\in(K^\times)^n$, with $n\le2p$, and suppose
\[
\operatorname{Nm}(u)\in R^\times,\qquad
\operatorname{Tr}(u^k),\operatorname{Tr}(u^{-k})\in R
\quad(1\le k\le p-1).
\]
If $n<2p$, then $u\in(R^\times)^n$. If $n=2p$, either $u$ is a unit
tuple or it consists of exactly $p$ poles of one order $M>0$ and exactly
$p$ zeros of that same order. In the latter case the leading coefficients
within each cohort are equal, and the elementary symmetric coefficient
$e_p(u)$ has exact pole order $pM$. Thus the additional condition
$e_p(u)\in R$ forces a unit tuple also when $n=2p$.

This identifies a characteristic-$p$ datum that ordinary traces can miss.
It does not assert that $e_p(u)$ is regular in any particular global
source problem.

## All characteristic carries in arbitrary degree

Let $n\ge p$, $u\in(K^\times)^n$, and put $N=n-p$. Assume a unit
norm and regular forward and reciprocal power traces through $p-1$.
In addition assume
\[
e_{kp}(u)\in R\quad(1\le kp\le N),\qquad
\operatorname{Tr}(u^j)\in R\quad(p\le j\le N,\ p\nmid j).
\]
Then every $u_i$ is a unit. These conditions are also necessary for a
unit tuple. This criterion works for a DVR of residue characteristic
$p$, including mixed characteristic; it does not require a Frobenius
identity in its fraction field.

In particular, if $n=2p+r$ with $0\le r<p$, the only additional inputs
are
\[
e_p(u)\in R,\qquad
\operatorname{Tr}(u^{p+i})\in R\quad(1\le i\le r).
\]
Each listed extra trace is individually indispensable in general, even
when all the others and $e_p$ are retained. The carry $e_p$ is also
indispensable. Split equal-characteristic counterexamples prove these
sharpness assertions. For $n=11,p=5$, the extra inputs are exactly
$e_5(u)$ and $\operatorname{Tr}(u^6)$.

These are integrality criteria, not global pole bounds or assertions
that a particular source supplies the missing carry coefficients.

## Integral cubic critical model in characteristic five

Let $R$ have characteristic five, and suppose a degree-ten polynomial
splits over $R$ as
\[
F=v\prod_{i=1}^{10}(T-w_i)
=v\phi^2+\phi S+\tau,
\qquad \phi=T^5+q,\quad D=S',
\]
where $v,\tau\in R^\times$, $q\in R$, $S\in R[T]$ has degree at most
four, and the nonzero reduction $\overline D$ has degree at most three.
Assume $F$ is separable over $K$. For any $U\in R[T]$ of degree less
than ten set $u_i=U(w_i)/D(w_i)$. Then
\[
\operatorname{Tr}(w^j u^k)\in R
\qquad(0\le j\le2,\ 2\le k\le4)
\quad\Longleftrightarrow\quad u\in R^{10}.
\]
No distinctness of the critical roots or slopes is needed. In particular,
this includes repeated roots of $\overline D$. The leading coefficient
of $D$ need not be a unit; only $\overline D\ne0$ is required.

Writing $B=R[T]/(F/v)\subset R^{10}$ and $\mathfrak c$ for its conductor
in $R^{10}$, the equivalent integrality condition is $U\bmod(F/v)\in
\mathfrak c$. Thus the tests detect the actual linear conductor lattice
on this integral unit open. They do not establish any global source
exclusion.

For the actual degree-ten admissible source, this corollary applies on
finite disks where the finite coordinate is integral, $v,t$ are units,
and $D\bmod\pi\ne0$, since $\tau=t^3$. Selected endpoints, nonintegral
coordinate charts above zeros of $v$, and disks with $D\bmod\pi=0$
remain separate boundaries. Fivefold clusters at those boundaries are
not excluded by this lemma.

[Proof](../../Proofs/cartier_and_spin/trace_power_integrality_detection.md).

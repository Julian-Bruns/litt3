# Proof: finite transport reduces to a shared power

[Statement](../../Theorems/shared_tensors/finite_tensor_transport.md).
All coefficients and descent data below belong to the two actual
maps. No simultaneous Galois closure is used.

## 1. Homogeneous spectral equations

Write $A$ for the common canonical ring. By
[canonical intersection](matched_section_rings.md), either $A=k$
or $A=k[s]$; in the latter case the primitive weight $d$ is prime
to $p$. A common monic spectral equation of degree $N$ has the
form
\[
B(T)=T^N+a_1T^{N-1}+\cdots+a_N,\qquad a_j\in A_{bj}.
\]
The positive-weight coefficients vanish if $A=k$. That equation
cannot have a nonzero root, so a multisection containing $\beta\ne0$
forces $A=k[s]$.

Put $h=\gcd(d,b)$ and $r=d/h$. A coefficient $a_j$ can be
nonzero only when $r\mid j$. In that case
$a_j=c_j s^{bj/d}$, with $c_j\in k$. If $N=qr+t$, $0\le t<r$,
divide $B(\beta)=0$ by $\beta^t s^{qb/h}$. The nonzero rational
function
\[
u=\beta^r/s^{b/h}\in k(Z)^\times
\]
satisfies a monic polynomial over $k$. Since $k$ is algebraically
closed, $u\in k^\times$. This proves the displayed identity. Since
$p\nmid d$, the exponent $r$ is prime to $p$.

Conversely, a shared $\beta^r$ with $p\nmid r$ defines the common
spectral equation $T^r-\beta^r=0$. It is finite with regular monic
coefficients, and generically reduced. This proves the equivalence.

If \(\operatorname{div}\beta=bD\) with \(D\) reduced, then
\(\operatorname{div}(\beta^r)=brD\). Since the shared tensor
\(\beta^r=f^*s_X=g^*s_Y\) has weight \(br\) and both maps are étale,
its endpoint divisors are \(brD_X,brD_Y\) with reduced \(D_X,D_Y\)
and \(f^*D_X=g^*D_Y=D\). In characteristic at least five,
the [canonical marked-quotient theorem](../quotient_geometry/canonical_marked_quotient.md)
then gives a core, contrary to the hypothesis.

The same calculation applies to any nonzero geometric generic root
$\gamma$ of $B$, inside an algebraic closure of $k(Z)$. It gives
$\gamma^r=c' s^{b/h}$. Hence $(\gamma/\beta)^r=c'/c\in k^\times$,
and $\gamma/\beta\in k$. The zero root, if present, is rational as
well. Thus the entire generic multisection splits on $Z$.

## 2. Differences in an affine torsor

Let $M$ be a common finite generically reduced multisection of a
torsor under $\omega^b$. Form the nonzero differences of ordered
pairs of its geometric generic branches, retaining each distinct
difference once. This set is independent of a local origin in the
torsor and is stable under each endpoint's generic descent.

Its monic root polynomial therefore descends on both endpoints.
Its coefficients are regular: locally every branch of $M$ is
integral over the regular local base ring, so every difference and
every elementary symmetric function of the retained roots is
integral. A coefficient in the endpoint function field that is
integral over its local discrete valuation ring belongs to that
ring. The transition law is exactly that for $\omega^{bj}$.
This constructs a common finite tensor multisection without imposing
any tameness condition on its degree.

If $P,Q\in M$ are global distinct sections, the difference
$\beta=Q-P$ is a nonzero global branch. Section1 makes every
difference a constant multiple of $\beta$. In particular every
branch of $M$ is $P+c_j\beta$. Three noncollinear sections are
therefore impossible. If an iterative reduced transport closure is
bounded in degree, its generic sets stabilize; the same argument
applies to that finite common closure.
The reduced-divisor corollary applies to \(\beta=Q-P\) as well.

# Frobenius recursion for the connecting class

**Status: exact comparison calculation, 2026-09-05. No new exclusion.**

Let \(S=X\times Y\), let \(H=\mathcal O_S(\Gamma)\) with defining
section \(F\), and suppose \(t=\tau^n\) descends to a unit of
\(M^n|_\Gamma\). Put \(L=M^n\). With local lifts \(s_i\) of \(t\)
and the convention

\[
 \delta_n=\left[(s_j-s_i)/F\right]\in H^1(S,LH^{-1}),
\]

the lifts \(s_i^p\) of \(t^p\) give the exact identity

\[
 \boxed{\delta_{pn}=F^{p-1}\operatorname{Fr}(\delta_n).}
\]

Here the twists are

\[
 H^1(LH^{-1})\xrightarrow{\operatorname{Fr}}
 H^1(L^pH^{-p})\xrightarrow{\cdot F^{p-1}}H^1(L^pH^{-1}),
\]

and Frobenius is \(p\)-semilinear over \(k\). There is no extra sign.
Iteration gives
\(\delta_{p^a n}=F^{p^a-1}\operatorname{Fr}^a(\delta_n)\).
The same identities hold for the inverse unit and \(M^{-n}\).
They start from an exponent that descends; no descent of
\(\tau^{n/p}\) is assumed. Rescaling \(F\) changes both sides
consistently. Independently normalized units give the identity
projectively.

If \(E_n\) is the projective coefficient field on \(Y\) and \(E_F\)
is the incidence coefficient field, expansion of the formula yields

\[
 E_{pn}\subset E_F E_n^p.
\]

Thus the coefficients need not all be \(p\)-th powers: the factor
\(F^{p-1}\) can supply separating coordinates. In the actual canonical
setup and strict degree range, file 106 gives the stronger equality
\(E_n=E_F\) for every admissible exponent, so field invariance along
\(n,pn,p^2n,\ldots\) is already a consequence of that result.

## Exact diagonal countermodel

As a formal test of the positive-line-bundle setup, take the diagonal
\(F=x-y\) in \(\mathbf P^1_x\times\mathbf P^1_y\), with
\(P_n=Q_n=\mathcal O(n)\). Both projections of its normalization are
isomorphisms. Up to a common scalar, its inverse-unit connecting class is

\[
 \delta_n=\sum_{j=1}^n y^{j-1}[x^{-j}]
 \in H^1(\mathcal O(-n-1))\otimes H^0(\mathcal O(n-1)).
\]

In characteristic five, exact polynomial multiplication gives

\[
 (x-y)^4\operatorname{Fr}(\delta_2)
 =\sum_{j=1}^{10}y^{j-1}[x^{-j}]=\delta_{10}.
\]

The two coefficient maps are the degree-one and degree-nine Veronese
maps, both separable with field \(k(y)\). The coordinate \(y\) comes
from \(F^4\). This disproves the inference that powering the unit
forces a purely inseparable coefficient map. It is not a model for the
fixed genus-\((9,25)\) canonical problem.

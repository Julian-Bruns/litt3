# Proof: canonical rings and divisors on a cored quotient

[Statement](../../Theorems/quotient_geometry/cored_ring_and_marking_spectrum.md).

## 1. Invariant divisors give the shared ring

The [cored bridge](cored_orbifold_bridge.md) gives an actual simultaneous
étale Galois refinement \(W\to Z\). Put \(A=\operatorname{Gal}(W/X)\),
\(B_0=\operatorname{Gal}(W/Y)\), \(G=\langle A,B_0\rangle\),
\(\mathcal S=[W/G]\), and \(\pi:W\to B=W/G\).
Étale descent identifies the endpoint section spaces with the
\(A\)- and \(B_0\)-invariants. Their intersection is the \(G\)-invariants,
compatibly with multiplication.

Use the notation \(n=|G|\), \(R=\sum_P\delta_P[P]\), and
\(K_W=\pi^*K_B+R\) of
[Köck–Tait, *Faithfulness of Actions on Riemann–Roch Spaces*,
Lemma2.1 and Corollary2.4](https://doi.org/10.4153/CJM-2014-015-2)
(their curves \(X,Y\) are \(W,B\) here). Lemma2.1 states, for every
\(G\)-invariant divisor \(D\),
\[
 \pi_*^G\mathcal O_W(D)
   =\mathcal O_B\!\left(\left\lfloor\frac{\pi_*D}{n}\right\rfloor\right).
\]
Apply it to \(D=mK_W\). The paper identifies
\(\mathcal O_W(mK_W)\simeq\Omega_W^{\otimes m}\) as \(G\)-sheaves,
so this gives the stated ring. These are subsheaf equalities in the
rational function field, hence preserve products. Corollary2.4 gives
the dimension formula. Neither result requires tame ramification.

## 2. Compatible reduced divisors

A compatible pair pulls back to one reduced divisor on \(W\), invariant
under both deck groups and hence under \(G\). Its naturally linearized
ideal descends along \(W\to\mathcal S\) to a reduced effective Cartier
divisor. Conversely, such a divisor pulls back to a compatible pair;
faithfully flat descent makes these operations inverse.

A reduced divisor on \(\mathcal S\) consists of \(a\ge0\) ordinary points
and a subset of its exceptional residual gerbes. Their respective
degrees are \(1\) and \(1/e_i\); enough ordinary points exist over the
algebraically closed field. Pullback to \(X\) multiplies degree by
\(n_X\). This proves the marking spectrum, the canonical-size criterion,
and the smallest positive degree \(1/\max(1,e_i)\).

## 3. Zero shared one-forms

Put \(D_1=\lfloor\pi_*R/n\rfloor\). Since it is effective, vanishing
of \(H^0(B,\Omega_B(D_1))\) forces \(B=\mathbf P^1\) and
\(\deg D_1\le1\). In characteristic \(p\ge3\), a wild inertia group has
\(\delta\ge(e-1)+(|I_1|-1)>e\). Thus there is at most one wild point,
with \(1<\delta/e<2\).

Set \(h=2g(X)-2\). The atlas Hurwitz formula is
\[
 h/n_X=-2+\sum_i\delta_i/e_i.
\]
In the tame case its smallest positive value is \(1/42\): order the
three branch indices to obtain \((2,3,7)\); four points give minimum
\(1/6\) (four indices2 give zero), and five or more give at least \(1/2\).

With one wild point, put \(c=\delta-e\) and let \(m_1,\ldots,m_t\)
be the tame orders. Then
\[
 h/n_X=t-1+c/e-\sum_j1/m_j.
\]
Positivity forces \(t\ge1\). For \(t\ge3\) the right side exceeds
\(1/2\); for \(t=2\) outside \((2,2)\) it exceeds \(1/6\).
In the \((2,2)\) case, \(h=(n_X/e)c\), so \(c\mid h\), while
\(c=\sum_{i\ge1}(|I_i|-1)-1\equiv-1\pmod{p-1}\).

For a jointly minimal source, \(Z=W/(A\cap B_0)\), so
\(\deg(Z/Y)=[B_0:A\cap B_0]\le[G:A]=n_X\).
This transfers each atlas bound to that source degree.

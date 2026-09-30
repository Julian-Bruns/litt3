# Proof: exact ratio coordinates and exclusion of all cubic cusps

[Statement](../../Theorems/cartier_and_spin/degree140_linear_cubic_cusp_exclusion.md).
This is a scoped integration of the partial moving-ratio reply.
The [full report](../../../litt3-computation-data/quartic_complete_partial_replies_20260927/extracted/linear/REPORT.md)
retains the source reconstruction and all earlier evidence. Its full
square-locus decision remains open. The user has since stopped the Pro
continuation and authorized local algorithm work, recorded separately.

## The ratio change is an isomorphism on the entire original open

Use the incoming base25 encoding over K. Ascending rows are
\[
\begin{aligned}
a_0&=(350365,93449),&d&=(47171,357608),\\
b&=(90885,339126,362701,194731,371097,144818),\\
c&=(56518,278019,104390,351083,235630,246647,217983),\\
e&=(0,324104,260238,219737,136154,199269,
240524,27757,108951,319279).
\end{aligned}
\]
Exact coefficient division gives Psi=d psi and
\[
\psi=e/q+cH+qbH^2+q^2a_0H^3,\qquad F_6=\psi/(qd).
\]
With q=w^3, h=wH, put u=qH and s=F6/h^3. Then
f(u)=(a0-sd)u^3+bu^2+cu+e=0. Conversely H=u/q and
\[
\psi=sdu^3/q,\qquad \Psi=sd^2u^3/q,\qquad F_6=su^3/q^2.
\]
The old open inverts H,q,mu,Psi and q-e1,q-p0,q-q0, where
e1=10149,p0=118020,q0=64426 and d=357608(q-p0).
It is therefore isomorphic to
\[
K[q,s,\mu,1/(qs\mu d(q)(q-e_1)(q-q_0))][u,u^{-1}]/(f(u)).
\]
These formulas use only already specified units. They are inverse
ring maps over arbitrary coefficient rings, not only on geometric
points. Adjoining w with w^3=q is etale and recovers the same
original source, h=u/w^2 and lambda=w mu. All70 square equations
are transported unchanged.

## Four monic charts retain both coefficient boundaries

The supplied exact Bezout identity ub*b+uc*c=1 has
\[
u_b=(322147,332458,311415,35409,235254,115011),\quad
u_c=(383626,183665,347542,169054,100559).
\]
Thus the homogenized cubic is nonzero on every fiber. Evaluate
at tau=0,1,2,3. The invertible four-point Vandermonde matrix and
this identity give sum beta_tau(q)f(tau)=1, checked coefficientwise.
On D(f(tau)) put z=V/(U-tau V). Writing a=a0-sd, the equation is
\[
a+(3a\tau+b)z+f'(\tau)z^2+f(\tau)z^3=0.
\]
Divide only by the unit f(tau) to obtain a monic cubic. These four
opens cover the whole base. The original finite nonzero-u locus
is exactly z(1+tau z)!=0, with u=tau+1/z. This proves the stated
finite-flat projective cover and exact source open, also at degree
drops and nonreduced points. It does not assert that either a or e
is a global unit.

## All triple-root ratios and their infinitesimal fibers

Coefficientwise computation gives
\[
C=c^2-3be=(375887,61969,120100,319268,316878,42015,131041,
344618,17272,253241,28972,368439,192911,239943,130588).
\]
It is squarefree and coprime to b,c,e,d, all old q exclusions,
and a0*c-2b^2. All denominators below are therefore units modulo C.
Since s=(a0+b/u+c/u^2+e/u^3)/d,
\[
\frac{ds}{du}=-\frac{bu^2+2cu+3e}{du^4}.
\]
The critical quadratic has a repeated root precisely at C=0.
Its source coordinate and value are u_c=-c/b and
s_c=(a0*c-2b^2)/(dc), and exact reduction gives
f(U)=(2b^2/c)(U-u_c)^3. Conversely a finite nonzero triple root
has these values; the a=0 branch cannot have f'=f''=0 because
b,c do not vanish together. Thus the full inverse image is
\[
B[U]/((U-u_c)^3),\qquad B=K[q]/(C_{\rm monic}),\quad\dim_K B=14.
\]
All original open factors are units there. The eight irreducible
factors of C_monic have degrees1,1,1,1,1,2,3,4. Their product,
modular-power irreducibility tests and CRT idempotents are retained
and independently regenerated. In particular these are all geometric
ratio points, not just K-valued samples.

The discriminant of the cubic, considered as a quadratic in s,
satisfies D1^2-4D0D2=d^2C^3. Depressing the reciprocal cubic gives
z_new^3+p(q)z_new+nu(q,s), where p=-C/(3e^2) and nu_s=-d/e.
At every root of C both relevant derivatives are units, so the
branch curve has an ordinary cusp. Its normalization has function
field K(q,sqrt(C)), a genus-six hyperelliptic curve. These are
coordinate geometry statements, not witnesses of a square residual.

## The actual two square tails exclude the entire cusp stratum

In each of the eight coefficient fields, the verifier reconstructs
the original barred source, its fixed-degree resultant, and the
cubic norm. All divisions by q^5 t^5 v have zero remainder.
The resulting model is (qd)^36 times the actual residual, an old
unit square. It has x-degree140 and scale-degree at most6, with
the prescribed nonzero leading coefficient. Thus its normalized
square tails are those of the actual source.

Let Ahat(T)=T^140 S_model(T^-1). The coefficients T71,T72 of
Ahat^63 at reciprocal degrees71,72 are necessary square equations.
They have actual scale degrees53,54 in every factor field. Exact
multiplier polynomials satisfy
\[
b_{71}(\mu)T_{71}(\mu)+b_{72}(\mu)T_{72}(\mu)=1.
\]
The C++ construction and a separate Python polynomial multiplication
both verify these identities. They hold over all geometric scales,
not just scales in the coefficient fields; no leading tail factor
is inverted. CRT combines them over B.

In the full length42 ratio algebra put delta=U-u_c, delta^3=0.
Lift the same multipliers and write their combination as1+W.
Its reduction modulo delta is1, so W^3=0. Multiplication by
1-W+W^2 gives1 in the full actual square ideal. This proves
emptiness including all cusp nilpotents and after the allowed
localizations. It also proves the cover D(f') union D(f'') of
the remaining square scheme; the two remaining opens are undecided.

## Verification receipt

All36 essential outputs of resolution/src/verify_resolution.py
were regenerated and matched, with every mathematical datum retained.
The unmodified wrapper initially rejected the stored Python3.13.5
version string on local Python3.14.7. A separate replay copy adds
only the metadata key `python` to the existing timing-field ignore
set; no arithmetic, source input, assertion or certificate changes.
The original archive and source copies remain byte-identical.
The original manifest passed, and the one-line portability change
is separately recorded.

See [the integration audit](../../Research/audits/QUARTIC_COMPLETE_PARTIALS_2026_09_27.md)
for exact commands and hashes. Source copies are under
[the retained source tree](../../scripts/arithmetic/pro_quartic_complete_partials_20260927/linear/).
The fourteen-ratio result does not exclude any whole additional q
fiber, since other H-values at the same q remain allowed.

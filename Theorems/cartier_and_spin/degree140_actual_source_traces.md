# Actual-source critical traces and endpoint cancellation

Version1,30 September2026. Use the primitive constant degree140 family,
its original ratio chart and normalized critical double cover C->X from
[the normalized trace criterion](degree140_normalized_critical_trace.md).
Write
\[
F_\ell=\ell\phi^2+\phi S+t^3,\qquad
\phi=W^5+\overline Q,\qquad S=aW^3+bW^2+cW+e,
\]
where a=g2,b=g3,c=g4 are the regular source coefficients. On S'=0 put
\[
\Lambda=-(\phi S+t^3)/\phi^2,\quad
\eta=(3b-aW)/2,\quad \eta^2=b^2+2ac,
\quad \omega_0=dx/(3y^2),\quad \omega_0(\delta_0)=1.
\]
The last notation means that delta0 is the derivation dual to omega0.
Differentiating Lambda with W fixed gives its induced derivative on C.

For every affine regular multiplier f on X of pole order at most p at O,
the following field traces to k(Lambda) are polynomials. Every nonzero
scale defining an actual everywhere-etale degree-ten source annihilates
all three:

| Trace | Degree bound |
| --- | --- |
| T_f=Tr(f delta0Lambda) | max(2,floor((21+p)/4),floor((24+p)/7)) |
| Q_f=Tr(f delta0Lambda/phi) | max(5,floor((1+p)/4),floor((17+p)/7)) |
| U_f=Tr(f delta0Lambda/eta) | max(2,floor((5+p)/4),floor((8+p)/7)) |

Actual splitting forces delta0Lambda to vanish at each geometric point
of the actual scale fibre. For U_f the assertion is about the paired
residue trace: its summands need not be regular at critical collisions.
In particular U_1,U_x,U_(x^2) are quadratic necessary equations.

T_1 has exact degree five with leading coefficient
<333905>w h^-12, a unit on the original chart. T_x has exact degree six:
if Lambda=c0 z^-4+O(z^-3) at O4 in the standard parameter x=z^-3,
then [ell^6]T_x=c0^-5. The other infinity has Lambda pole seven.

Endpoint multiplication gives V_j=U_(t*x^j), j=0,1,2, of degrees at
most3,4,5. In H=hw,q=w^3,ell=w*mu their leading coefficients are
\[
[\ell^3]V_0=(\langle363030\rangle H+\langle156117\rangle)w^8/H^7,
\quad [\ell^4]V_1=\langle274269\rangle w^{10}/H^9,
\quad [\ell^5]V_2=\langle252884\rangle w^{12}/H^{12}.
\]
Every coefficient of w*V_j(w*mu) lies in
K[H^+-1,q^+-1,Psi^-1], with no moving endpoint-content denominator.
Their constant finite-endpoint correction is
\[
C_j=2\operatorname{Tr}_{K[x]/(t)/K}
\left(x^j t'(x)U_0(x)G_2^{(2)}(x)/P(x)\right),
\qquad U_0=(Q-L_0^5)/t^3.
\]
Here G2^(2) is the y^2 coefficient in the supplied G2; K[x]/t is fixed
etale and P is a unit there. All positive-scale corrections vanish.
For t*x^i*y^k, replace x^j G2^(2) by x^i G2^(2-k), 0<=k<=2.

This calculus supplies the necessary equations used in the
[complete constant-family exclusion](degree140_constant_actual_etale_exclusion.md)
and transfers with an extra v factor to
[the root-nine family](root9_actual_divided_traces.md). It does not
characterize the larger entirely-ramified or abstract square locus,
and supplies no unmarked common-cover solution.

[Proof](../../Proofs/cartier_and_spin/degree140_actual_source_traces.md).

# Global cubic, quartic and quintic actual-scale equations

Version1,30 September2026. Retain the primitive degree140 family and
the actual-source hypotheses of the
[quadratic divided-trace theorem](degree140_inverse_discriminant_quadratic_traces.md).
Write t=A/([13](x-alpha)), H=hw, q=w^3 and ell=w*mu, with the same
original chart units H,q,Psi. Define
\[
V_j(\ell)=\operatorname{Tr}_{k(C)/k(\Lambda)}
       (t x^j\delta_0\Lambda/\eta),\qquad j=0,1,2.
\]
Every actual nonzero etale scale is a common zero of V_0,V_1,V_2.
Their degrees are at most3,4,5, respectively. The leading coefficients,
in the prescribed field coding, are
\[
[\ell^3]V_0=(\langle363030\rangle H+\langle156117\rangle)w^8/H^7,
\quad [\ell^4]V_1=\langle274269\rangle w^{10}/H^9,
\quad [\ell^5]V_2=\langle252884\rangle w^{12}/H^{12}.
\]
Thus V_1 is uniformly monic after multiplying by a chart unit; V_0
is monic away from the one explicit H-line in its displayed coefficient.
No point of that line is omitted from the three-equation system.

Each coefficient of w*V_j(w*mu) belongs to
K[H^+-1,q^+-1,Psi^-1]. In particular there is NO moving endpoint-content
denominator. A short-coordinate infinity residue formula and the following
constant correction compute the full equations:
\[
C_j=2\operatorname{Tr}_{K[x]/(t)/K}
 \left(x^j t'(x)U_0(x)G_2^{(2)}(x)/P(x)\right),
\quad U_0=(Q-L_0^5)/t^3.
\]
Here G_2^{(2)} is the coefficient of y^2 in the supplied G_2. All positive
scale coefficients have zero endpoint correction. The fixed algebra K[x]/t
is etale and P is a fixed unit in it.

The complete global equations have been constructed in a proved finite
interpolation box. This is not a claim that their common locus is empty,
nor an actual common-cover construction.

[Proof](../../Proofs/cartier_and_spin/degree140_divided_endpoint_traces.md).

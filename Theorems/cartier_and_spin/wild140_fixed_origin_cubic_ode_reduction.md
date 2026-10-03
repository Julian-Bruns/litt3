# Wild140: the five fixed-origin cubic cases reduce to one explicit family

Version1, 3 October2026. Scoped necessary reduction; [independent whole review PASS](../../Research/audits/WILD140_ORDINARY_FOUR_PAIR_AUDIT_2026_10_03.md).

Retain BOTH actual finite étale endpoint maps from the SAME source and the full ACTUAL ordinary canonical degree140 carrier hypotheses of the [ordinary wild140 theorem](canonical_wild_degree_140_ordinary_spin_reduction.md). Let the distinguished point P be one of the five fixed Weierstrass points of Yₜ: infinity or z=0,1,2,3. Assume that the actual weight-seven generator has a cubic even part.

After a projective change of coordinate over F₅, the curve has the same family equation with a transformed parameter t′ and P at infinity. In w=z+1 it has equation y²=w⁵+qw⁴−w−q, q=−(t′+1)≠0. Normalize the odd part of F to be monic and let a be its nonzero cubic even coefficient. Then necessarily a²=q, and the further normalization w=a²X,y=a⁵Y,F=a⁷F₀ gives
\[
\Psi=X^5+X^4+LX+L=(X+1)(X^4+L),\quad
L=-q^{-4}\ne0,-1,\qquad F_0=X^3-L+YX.
\]
This family passes the entire Cartier gate C(F₀³dX/Y)=0 and has seven simple zeros. Its exact norm is
\[
N=-X^7+2LX^3-LX^2+L^2,\qquad
\operatorname{Res}(N,N')=2L^{10}(L+1)^2.
\]
Define
\[
G_0=4X^9+3X^8+4LX^4+4L^2X^2
 +Y(3X^6+4LX^3+3L^2).
\]
Then dG₀=F₀³dX/Y, and the actual weight-twenty generator has the form G=cG₀+K₀+K₅X⁵+K₁₀X¹⁰, with c,K₁₀≠0. At the seven zeros of F₀ put D=X⁵+2LX+L. The necessary SAME-base completion condition reduces, after scaling c to one, to
\[
(2D^2+a_0+b_0X^5+d_0X^{10})^2\equiv\lambda D^5\pmod N,
\quad\lambda\ne0,\quad d_0\ne3.
\]
The seven explicit remainder equations are a remaining gate. No choice solving them or actual carrier existence is asserted; neither the five-origin cubic case nor the common-cover problem is excluded by this theorem.

[Proof](../../Proofs/cartier_and_spin/wild140_fixed_origin_cubic_ode_reduction.md).

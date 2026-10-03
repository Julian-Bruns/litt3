# Proof: the common completion refinement of exceptional wild140

Version1, 3 October2026. [Independent whole review PASS](../../Research/audits/WILD140_EXCEPTIONAL_COMMON_COMPLETION_REFINEMENT_AUDIT_2026_10_03.md). The [statement](../../Theorems/cartier_and_spin/wild140_exceptional_common_completion_refinement.md) explicitly retains both actual maps and explicitly assumes the same-base completion equality. Nothing below substitutes local group type for that equality.

For its actual-carrier provenance, the [weak completed-extension invariant](../../Theorems/quotient_geometry/weak_local_completed_extension_invariant.md) gives 𝓘=−(yF′)⁵/((2c)⁵G²) at each wild zero when β=G⁷/F²⁰. Identifying the completions through the actual common source makes these scalars equal. The algebraic refinement below starts with precisely this necessary equality.

All integers in this proof are interpreted in characteristic five. Put V=v² and d=V−s. If d=0, the point w=0,y=−v is a zero of F of order five: Φ−s=w⁴(w+q), while y−v is a unit there. This contradicts the reduced seven-point wild fiber. Therefore d≠0. The zeros consist of w=0,y=±√s and the five simple roots of
\[
P_5(w)=w^5+qw^4-d,\qquad y=-v.
\]
At the latter points, yF'=2qw⁴. At the former points, yF'=s±v√s.

Direct differentiation gives every primitive of the required pole bound in the form
\[
G=c\left[4w^9+2qw^8+(4s+2V)w^4
+yv\left(3w^4+\frac{3w^5}{q}+\frac{3(V+s)}q\right)\right]
+K_0+K_5w^5+K_{10}w^{10}.
\]
Indeed d(yC)/σ=ΦC′+Φ′C/2. The difference of two primitives is a fifth power. Its fifth root has pole at most4P and is consequently a polynomial in w of degree at most two, since P is Weierstrass of genus two. This proves the stated completeness of the three correction terms; it does not assume that an odd primitive has degree at most four.

Reducing G at y=−v modulo P₅ gives R∈𝒱, where
\[
\mathcal V=\langle 1,w^4,w^3-qw^2+q^2w\rangle,
\quad R=aw^4+b(w^3-qw^2+q^2w)+e,
\]
and
\[
\begin{aligned}
a&=c(3q^5+V)-qK_5+(q^6-2qd)K_{10},\\
b&=qd(3c+qK_{10}),\\
e&=K_0+c(2q^4d+4V^2/q)+dK_5+(d^2-q^5d)K_{10}.
\end{aligned}
\]
Also the remainder of w¹⁰ belongs to 𝒱 and is
\[
W_{10}=(q^6-2qd)w^4+q^2d(w^3-qw^2+q^2w)+d^2-q^5d.
\]

We need the following exact interpolation fact: any three of the five evaluations of 𝒱 on P₅ are linearly independent. The following short conic proof is due to the independent root derivation. Scale w=qx and set D=d/q⁵≠0 and H=x³−x²+x. The five evaluation points (1,x⁴,H), at roots of P=x⁵+x⁴−D, lie on the conic
\[
Q=X_0^2-D^{-1}X_0X_1-X_0X_2+D^{-1}X_1^2=0.
\]
Indeed the polynomial identity x⁸−x⁴−DH+D=(x³−x²+x−1)P proves this. The symmetric matrix of Q has determinant D⁻¹ in characteristic five, so the conic is nonsingular. The five points are distinct: equal x⁴ gives equal x⁵ from P, and hence equal x because Frobenius is injective. A line intersects a nonsingular conic in at most two distinct points. Consequently no three evaluations are linearly dependent. Scaling back only changes the basis by nonzero factors.

Write the completion equality as G²=λ(yF′)⁵ with λ≠0. Choose C with C²=λ(2q)⁵. At the five roots of P₅ it says R=±Cw¹⁰. At least three signs agree. Therefore R−CW₁₀ or R+CW₁₀ vanishes at three roots. That polynomial belongs to 𝒱, so the interpolation fact makes it identically zero. Changing the sign of C if necessary gives R=CW₁₀. Comparing b,a,e, in that order, yields
\[
K_{10}=C-3c/q,\qquad K_5=c(2V-s)/q,\qquad
K_0=2c(V^2+Vs+s^2)/q.
\]

At w=0 the two G-values are K₀±B, where B=3c√s v(V+s)/q. Equality of the two completion constants implies
\[
(K_0+B)^2(s-v\sqrt{s})^5
-(K_0-B)^2(s+v\sqrt{s})^5=0.
\]
Since c,q,s,v are nonzero, substitution of K₀ and division by the nonzero factors gives, for x=V/s,
\[
4x^6+2x^5+x+3=(x-1)^5(4x+2)=0.
\]
The reduced fiber already excluded x=1. Thus x=2, proving v²=2s and the displayed K₀,K₅. At x=2, the pair constants are λ=3c²/(q²s): use (1+r)³=2 for r²=2, and neither 1±r vanishes. Consequently C²=λ(2q)⁵=c²q³/s. There are precisely two choices for each nonzero v and C over the algebraically closed field. These are necessary normalized pairs; the proof constructs no source or actual carrier.

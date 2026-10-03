# Proof: derivative-root cancellation and highest norm coefficients

Version1,3 October2026. [Statement](../../Theorems/cartier_and_spin/canonical_degree_forty_two_differential_shape_reduction.md). [Independent whole-case review PASS](../../Research/audits/BACKUP42_WHOLE_REPAIRED_EXCLUSION_AUDIT_2026_10_03.md). All functions belong to the ACTUAL Y field; no endpoint map is changed.

Use the accepted identities H²=αF⁷+βG³ and ∂(FG)=cH. Their differentiated consequence is ∂(GH)=αcF⁶. At every one of the SIX simple zeros of F, D=∂F is a unit and
\[
G=D^2/(\beta c^2),\qquad H=D^3/(\beta c^3),\qquad GH=D^5/(\beta^2c^5).
\]
These evaluations hold also at Weierstrass zeros, since σ is a unit there and F itself is a local parameter. The difference GH−D⁵/(β²c⁵) has zero constant term and its derivative has order SIX at such a point. Its terms of local degrees1,2,3,4 therefore vanish. It is divisible by F⁵ at every zero. Consequently
\[
R_0=\frac{GH-D^5/(\beta^2c^5)}{\alpha cF^5}
\]
has no pole away P and satisfies ∂R₀=F. Since F has pole SIX, D has exact pole NINE and GH has pole at most35, R₀ has exact pole FIFTEEN. The leading coefficient of y w⁵ is2/(αβ²c⁶): D has leading term3yw² and F has leading termw³. This recovers the accepted Frobenius normal form with the SPECIFIC choice J=β⁻²⁄⁵c⁻¹D, rather than an arbitrary element of L(9P).

The pole-fifteen space and ∂R₀=U+ay imply R₀=aw+yB₅ after subtracting a fifth power. Indeed the even primitive part has derivative a and its remaining constant and w⁵ terms are fifth powers. Write B₅=Σbᵢwⁱ. Equating coefficients of degrees8,7,6,5 in
\[
U=\Phi B_5'+\Phi'B_5/2
\]
gives b₄=2qb₅,b₃=q²b₅,b₂=0,b₁=2λb₅; the degree-four equation then vanishes identically. This yields
\[
B_5=b_5(w^5+2qw^4+q^2w^3+2\lambda w)+b_0
\]
and the displayed even part U. The exact leading coefficient above gives b₅=2/(αβ²c⁶)≠0. Normalizing the cubic coefficient of U to one and eliminating b₀ gives the stated moving/fixed forms.

Next E=(D²−βc²G)/F is regular away P. To obtain its value at an F-zero, differentiate (∂(FG))²=c²αF⁷+c²βG³ there. Substituting βc²G=D² gives
\[
2G\partial D+D\partial G=0,\qquad E=-\partial D.
\]
Hence Z=(E+∂D)/F is again regular away P. Its pole is at most SIX, so Z=A₃+ky. We have exactly
\[
g:=\beta c^2G=D^2+F\partial D-F^2Z.
\]
Write F=w³+bw²+dw+e+ay. The pole bound G≤14 deletes the cubic coefficient of A₃, gives k=a, and fixes its quadratic coefficient to q−2a². Vanishing of the next odd pole FIFTEEN term requires2a(q+a²)=0, so a²=4q. Thus Z=3qw²+mw+n+ay.

These coefficient comparisons can be checked directly with ∂F=yU′+aΦ′/2 and ∂²F=ΦU″+Φ′U′/2+ayΦ″/2. Put
\[
L=b^2+2d+bq+4q^2.
\]
The leading even w⁷ and odd y w⁴ coefficients of g are L−m and −a(L+2m). Their contribution to the leading odd y w⁷ term of Fg is−3am. Applying ∂ gives the unique pole TWENTY-TWO term4am w¹¹ in h:=βc³H. Since H has pole at most21, m=0.

Let t be the coefficient of y w⁸ in h. For m=0 its even w¹⁰ coefficient is a(t+n). Explicitly, if M is the even w⁶ coefficient of g and J its odd y w³ coefficient divided by a, then
\[
t=4[M+(b+q)L],\qquad
[w^{10}]h=a[M+J-bL],\qquad
J-3M+qL=n.
\]
The last identity is a direct coefficient subtraction; none of these leading coefficients depends on λ or s. Thus the stated even coefficient is a(t+n).

Write τ=αβ²c⁶≠0. The actual relation is h²=g³+τF⁷. Its highest even w²¹ coefficient gives τ=t²−L³. Its highest odd y w¹⁸ coefficient gives
\[
2a(t+n)t=2aL^3+2a\tau=2at^2,
\]
so nt=0. In the ordinary and order-three profiles H has exact odd pole TWENTY-ONE; hence t≠0 and n=0. In the order-two profile H has pole NINETEEN, so both t and a(t+n) vanish, again forcing n=0. This proves Z=3qw²+ay and the full differential shape in the statement. No Gröbner computation or coefficient census enters the proof.

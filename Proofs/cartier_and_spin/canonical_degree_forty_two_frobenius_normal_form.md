# Proof: removal of invisible principal parts and integration in characteristic five

Version1. [Statement](../../Theorems/cartier_and_spin/canonical_degree_forty_two_frobenius_normal_form.md). Exact argument passed [independent review](../../Research/audits/CANONICAL_DEGREE_FORTY_TWO_FROBENIUS_NORMAL_FORM_AUDIT_2026_10_03.md). Use the accepted [ordinary degree42 identities](canonical_septic_triangle_ordinary_spin_reduction.md) and [order-two/three cone identities](canonical_degree_forty_two_small_cone_reduction.md). Every function remains in the ACTUAL Y field; no common-source replacement is made.

From H²=αF7+βG³ and d(FG)=cHσ, direct differentiation in characteristic five gives
\[
dH=H\,dF/F+4\beta cG^2\sigma/F,
\qquad d(GH)=\alpha cF^6\sigma.
\]
Consequently
\[
R=GH/(\alpha cF^5)\quad\text{satisfies}\quad dR=F\sigma.
\]
Let D be the SIX distinct zero points of F. At every point of D, G,H are units and R has exact pole FIVE. Since dR is regular there, the Laurent principal part of R contains only its fifth-order term: all lower negative exponents would differentiate nontrivially. At P its pole is at most FIVE for the ordinary profile and at most THREE for either cone profile.

Choose fifth roots of the six leading principal coefficients in local parameters at D. Riemann–Roch makes the principal-part map
\[
H^0(O_Y(D+3P))\longrightarrow\bigoplus_{Q\in D}\mathfrak m_Q^{-1}/O_{Y,Q}
\]
surjective: deg(D+3P)=9 gives dimension8, its kernel H0(O_Y(3P)) has dimension2, and the target has dimension6. Equivalently H1(O_Y(3P))=0 because3>2g−2. Thus some R1 with simple poles at D and pole at most3P has exactly those principal coefficients. Then R−R1⁵ is regular away from P and has pole at most15P. Its derivative is still Fσ.

The full pole-fifteen space on a Weierstrass genus-two curve is A7(z)+yB5(z). If d(A7+yB5)=Fσ=(U3/y+v)dz, independence of1,y over k(z) gives A7'=v. Hence A7=vz+a z5+b. Subtracting the fifth power a z5+b preserves the derivative and pole bound and can be absorbed into R1⁵. We may therefore choose
\[
R_0=vz+yB_5,\qquad dR_0=F\sigma,
\qquad U_3=\Phi B_5'+\Phi'B_5/2.
\]
After multiplying by αcF5 and absorbing the constant fifth root, put J=(αc)¹⁄⁵FR1. This is regular at D because F has simple zeros and R1 has at most simple poles. It has no other finite pole, and its pole at P is at most6+3=9. Thus
\[
J\in H^0(O_Y(9P)),\qquad GH=\alpha cF^5R_0+J^5.
\]

Write w=FG and Z=GH. Since dR0=Fσ,
\[
dw=cZ\,dR_0/w,\qquad
d(w^2)=2cZ\,dR_0
=d(\alpha c^2F^5R_0^2+2cJ^5R_0).
\]
The kernel of the derivation on the smooth curve field k(Y) over its perfect constant field is k(Y)⁵. Therefore
\[
w^2=\alpha c^2F^5R_0^2+2cJ^5R_0+K^5
\]
for some K∈k(Y). Every term on the right before K5 is regular away from P. Its pole is at most60P: F5R0² has pole at most30+30=60, J5R0 at most45+15=60, and w² has smaller pole. Hence K has no finite pole and has pole at most12P.

Finally the original generator relation gives
\[
Z^2=\alpha F^5w^2+\beta G^5.
\]
Substituting the two integrated identities cancels the R0 terms and yields βG5=J10−αF5K5. Taking the unique fifth root gives
\[
G=\beta^{-1/5}(J^2-\alpha^{1/5}FK).
\]
The stated full section spaces J=A4+yB2 and K=A6+yB3 follow directly from their Weierstrass pole bounds. This is a necessary normal form only; its equations have not been shown empty on BACKUP and do not construct the original common source.

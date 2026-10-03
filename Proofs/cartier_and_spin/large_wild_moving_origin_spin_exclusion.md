# Proof: a scalar Cartier incompatibility excludes every moving-pencil member

Version1,3 October2026. [Statement](../../Theorems/cartier_and_spin/large_wild_moving_origin_spin_exclusion.md). Independent root review PASS: [report](../../Research/audits/LARGE_WILD_MOVING_ORIGIN_EXCLUSION_AUDIT_2026_10_03.md). Work entirely on the actual Y; both endpoint maps stay on the same T. Use the accepted leading/fourth Hermitian packet, the small Cartier obstruction and the selected-origin inventory. No computation or global Hermitian-field assumption enters.

## The bounded primitive and the actual leading/fourth jets

Put ε=h−a²≠0 and F=w(y+a). Direct differentiation gives
\[
D=dF/\sigma=w^5+3qw^4+h+ay.
\]
The bounded primitive of F³σ has the full form
\[
H_0=4w^9+2qw^8+4(h+3a^2)w^4
+\frac{3a}{q}(y^3+a^2y)+\ell_0+\ell_1^5w^5.
\]
Indeed its derivative is F³σ, and its pole is at most18P. Its only invisible fifth-power ambiguity is L(3P)⁵, namely the two displayed affine-polynomial terms. Write α=4c/λ⁵≠0.

The actual packet supplies R∈L(41P) with C(RF³σ)=0. At each simple F-zero, its expansion in t=F has constant term αD⁵, coefficients ONE,TWO,THREE zero, and fourth coefficient r4 with r4⁵=2cH0D⁵. Therefore
\[
R=\alpha D^5+F^4V,\qquad V\in L(22P).
\]
This follows from the divisor of F and the jet conditions, not from a formal local substitution. Write V=C11(w)+yD8(w), with the indicated degree bounds.

The seven simple finite F-zeros consist of the two points above w=0 and the five points y=−a above the roots of Ψ=Φ−a²=w⁵+qw⁴+ε. The latter roots are distinct and nonzero, since Ψ′=4qw³ and ε≠0. At them D=2qw⁴ and
\[
V^5=2cH_0D^5.
\]

## The five one-sheet values force a sparse remainder

On those five points, substituting y=−a and w⁵=−qw⁴−ε gives
\[
H_0=3qw^8+a^2w^4+4a^4/q+\ell_0+\ell_1^5w^5.
\]
Since w⁸=q⁻²(w¹⁰+2εw⁵+ε²) and w⁴=−(w⁵+ε)/q, the fifth root of this value is a quadratic polynomial Aw²+Bw+C. All fifth roots are unique over k. Thus, for γ⁵=2c, the values of V are those of 2γq w⁴(Aw²+Bw+C). Reduction modulo Ψ again has only degrees FOUR,ONE,ZERO, because both w⁵ and w⁶ reduce to combinations of w⁴,w,ONE.

Let Vb=v4w⁴+v1w+v0 denote this remainder. At y=−a the value of V is C11−aD8; the five distinct Ψ-roots therefore imply
\[
C_{11}-aD_8=V_b+\Psi U,\qquad \deg U\le6.
\]
The other two F-zero conditions remain present, but will not be needed.

## Both pole bounds give a smaller normal form for V

The preceding identity first gives V=Vb+ΨU+(y+a)D8. Write R=A20+yB18, which is its exact L(41P) decomposition. In the odd polynomial B18, the only potentially high-degree term is w⁴Φ²(D8−aU); every other odd term has degree≤13. Hence deg(D8−aU)≤4. Put Z=D8−aU. Then
\[
V=V_b+(\Phi+ay)U+(y+a)Z,\qquad\deg U\le6,\quad\deg Z\le4.
\]
For completeness, direct expansion of R gives its even part
\[
A_{20}=\alpha(w^5+3qw^4+h)^5
+w^4(\Phi^2+a^2\Phi+a^4)V_b+w^4\Phi^3U+a^5w^4Z,
\]
and its odd polynomial
\[
B_{18}=\alpha a^5\Phi^2+4aw^4(\Phi+a^2)V_b
+a^5w^4U+w^4\Phi^2Z.
\]
These identities verify the claimed cancellation and degree argument even when a=0.

The terms involving Vb and Z in A20 have degree≤18. Comparing powers TWENTY-FIVE through TWENTY-ONE against the bound degA20≤20 therefore yields, with uj=[U]wj,
\[
u_6=-\alpha,\quad u_5=3q\alpha,\quad u_4=4q^2\alpha,
\quad u_3=0,\quad u_2=3h\alpha.
\]
Here the needed leading part of Φ³ is w¹⁵+3qw¹⁴+3q²w¹³+q³w¹²+3hw¹⁰, and the fifth power of w⁵+3qw⁴+h has no powers TWENTY-ONE through TWENTY-FOUR.

## Two Cartier coefficients leave a nonzero scalar

The actual Cartier-zero condition is equivalently
\[
\Omega=\frac{C(RF^3\sigma)}{F}=C(F^2V\sigma)=0,
\]
because C(F³σ)=0 and the αD⁵ term exits Cartier. Split Ω into its polynomial-σ and polynomial-dw sectors, and denote their constant coefficients by ω0 and η0 respectively. Cartier keeps coefficient w⁴dw and takes its fifth root; also C(Tσ)=C(TΦ²dw)/y.

Using F²=w²(Φ+a²+2ay) and the displayed normal form for V, the even and odd coefficient polynomials of F²V, after removing w², are respectively
\[
(\Phi+a^2)V_b+(\Phi^2+3a^2\Phi)U+(3a\Phi+a^3)Z,
\]
\[
2aV_b+(3a\Phi+a^3)U+(\Phi+3a^2)Z.
\]
Since Φ has no powers ONE,TWO,THREE and Vb has no power TWO, the coefficient w² calculations are especially simple. With z2=[Z]w² they give
\[
\omega_0^5=h^3(h+3a^2)u_2+a h^2(a^2+3h)z_2,
\qquad
\eta_0^5=a(a^2+3h)u_2+(h+3a^2)z_2.
\]
Substitute u2=3hα and eliminate z2. The exact identity
\[
h(h+3a^2)^2-a^2(a^2+3h)^2=(h-a^2)^3
\]
gives
\[
(h+3a^2)\omega_0^5-a h^2(a^2+3h)\eta_0^5
=3\alpha h^3(h-a^2)^3\ne0.
\]
Thus Ω cannot vanish, contrary to the actual packet. This treats all admissible a uniformly, without requiring a nonzero even part or dividing by h+3a².

The accepted actual étale cubic reduction transfers the same contradiction from degree21000 to degree7000 inside the given T. The conclusion excludes the entire moving-origin large-wild branch and retains the original maps; it does not exclude the remaining fixed-origin forms.

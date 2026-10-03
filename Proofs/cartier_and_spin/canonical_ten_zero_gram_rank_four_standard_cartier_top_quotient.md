# Proof: the three top p-basis directions and their saturated positive plane

Version1, 3 October2026. [Independent focused audit PASS](../../Research/audits/OCT03_RANK_FOUR_STANDARD_CARTIER_TOP_QUOTIENT_AUDIT.md). Mathematical scope is unchanged by canonical metadata integration.

## Generic Cartier top space

Put A=c⁻³,D=d⁵,F=f⁵,K₀=k(Γ)⁵. The accepted fixed primitive gives
\[
d^2=A+Bf^2+Cf^4,
\quad B=TWO bc^2D,
\quad C=-c^7D^2-Ah/F.
\]
The ω² twist ofF₄ evaluates, up to the retained nonzero common factorκ⁻¹, to
\[
(U/d+V+Xd+Rd^2+Wd^3)df,
\qquad U,V,X,R,W\in k(\Gamma).
\]
The exact p-basis tables for d⁻¹,d,d³ are those of the rankTWO and rankTHREE gates. CartierZERO is the vanishing of the f⁴ coefficient. As before write W=ΣW_i f^i overK₀. The D⁷ andD⁶ coefficients force W₃=W₀=ZERO. The next TWO coefficients give
\[
X_2=THREE A W_2,
\qquad X_4=TWO A W_4.
\]
Indeed the D⁵ terms are THREE c¹⁸F²W₂−c²¹F²X₂, and the D⁴ terms are THREE bc¹³F²W₄+bc¹⁶F²X₄. No other terms have these degrees after the first TWO eliminations.

Every triple W₁,W₂,W₄ is realizable by a rational kernel element. Choose X₂,X₄ as above and set the other X_i toZERO. The remaining Cartier output has only powers D⁻¹,ONE,D,D²,D³. These FIVE powers are spanned by the available U,V,R outputs: U₄m₀ has nonzero D⁻¹ coefficient A²; U₂m₂ is the nonzero constant FOUR bc⁻¹; R₂B is TWO bc²D; U₃m₁ has nonzero leading coefficient bc⁹FD²; U₁m₃ has nonzero leading coefficient c¹⁴FD³. The lower powers can be removed in decreasing order. Thus
\[
W\in\langle f,f^2,f^4\rangle_{K_0}
\]
is precisely the allowed generic last coefficient. There are NINE independent Cartier output directions D⁻¹,ONE,D,…,D⁷, because D has ACTUAL degreeTEN overK₀. Their rank isNINE, so the kernel of the rankTWENTY-FIVE domain has rankSIXTEEN.

The raw last-power quotient has nonzero constant coefficient (df)²/f², by the accepted trace functionalℓ₅ and Tr(d⁸)=constant·f⁻⁴. The top image therefore has saturation P as stated. The factors κ do not change any saturation or generic span.

## Exact local saturation ofP andQ

Both subspaces are native because their displayed rational generators are native. At an ordinary finite nonzero f-value, df is a frame and f is a local parameter up to translation. The ratio of the TWO Q coefficients is f³, whose first derivative is nonzero. Thus Q has wedge orderZERO. Multiplying the P coefficients by the unitf gives ONE,f,f³. At f=a≠ZERO their first THREE Taylor coefficient vectors are independent: the quadratic coefficient of f³ is THREE a≠ZERO. Thus P also has wedge orderZERO. There are no other ordinary contributions.

At tame f=ZERO, choose f=t² after extracting the unit square, possible in characteristicFIVE. The respective orders of t₂,(df)²,f²(df)² are ZERO,TWO,SIX. With t₁=t⁵, dividing the last generator by t₁ gives leading residueONE; the other residues areZERO,TWO. The TWO-dimensional Q and THREE-dimensional P bases are saturated, and their original rational wedges have orderONE.

At a weak wild point choose the exact fixed-f Artin–Schreier parameter
\[
f=\lambda(t^{-5}-t^{-1}),\quad df=\lambda t^{-2}dt,
\quad t_1=t^5,\quad\lambda\in k^\times.
\]
The argument establishing this parameter withf fixed is in the rankTWO gate. Write α=t₂,β₀=(df)²,β₂=f²(df)². In the local free basis t^j(dt)² ofF_*ω², ZERO≤j≤FOUR, the coefficient vectors are
\[
\alpha=\frac\lambda{ONE-t_1^4}
(t_1,ONE,t_1^3,t_1^2,t_1),
\]
\[
\beta_0=\lambda^2( ZERO,t_1^{-1},ZERO,ZERO,ZERO),
\quad
\beta_2=\lambda^4(-TWO t_1^{-2},t_1^{-3},ZERO,ZERO,t_1^{-2}).
\]
All vectors are interpreted over the completed fifth-power coefficient ring; when read on the relative twist their constant coefficients carry the corresponding fixed scalar twist.

Put q₂=t₁²(β₂−λ³t₁⁻³α) and p₀=β₀−λt₁⁻¹α. These are integral. Modulo t₁, α has leading vectorλe₁, q₂ has leading vectorTWO λ⁴e₀, and p₀ has leading vector−λ²(e₀+e₄). These THREE vectors are independent. Thus (α,q₂) and (α,q₂,p₀) are saturated bases ofQ andP respectively. Their rational wedges have order−TWO at every wild point. Therefore
\[
\deg Q=\deg P=N/TWO-TWO N/FIVE=N/TEN=\deg\omega_\Gamma.
\]
Native Picard identifies both genuine determinants withω_Γ₁. The primitive global sectionα gives the native O subline ofQ. Its quotient isω_Γ₁. Since Q is saturated in the ambient pushforward it is saturated inP; their rankONE quotient has genuine native determinantO and is thereforeO.

A strict ordinary HN destabilizer ofQ would be native by uniqueness. Its lineω_Γ₁^a would have a≥ONE, since μ(Q)=degω/TWO. Its inclusion inF_{Γ*}ω² would by Frobenius adjunction give ω^(FIVE a)→ω², impossible by degree. Hence Q is ordinarily semistable. This makes no ordinary-stability claim onΓ.

## Frobenius evaluation and the actual source top surjection

Frobenius evaluation F_Γ*Q→ω² is nonzero and surjective. Away from the wild orbitα is already a unit ofω². At a wild point the evaluated q₂ is
\[
t^{10}\beta_2-\lambda^3t^{-5}\alpha
=\lambda^4\left(t^{-4}-TWO+t^4-
\frac{t^{-4}}{ONE-t^4}\right)(dt)^2,
\]
whose constant coefficient is−THREE λ⁴≠ZERO. Thus there is no defect. Its kernel has genuine native determinantω⁵ω⁻²=ω³ and rankONE, proving the stated exact sequence.

The calibrated original adjoint source S=V(M^(1))² maps toP, because it is in the STANDARD kernel. Since P/Q=O and S is an ordinary direct sum of a positive line, its map toP/Q isZERO. Its top map therefore lands inQ. It is nonzero: otherwise naturality of Frobenius adjunction would give zero last-power quotient for the original row, contradicting integral full generation ofM⁶F₄.

Its saturation cannot have rankONE. Such a saturation would be nativeω^a, of degree at mostdegω/TWO by Q semistability and hence a≤ZERO; the actual rankONE image is a quotient ofS of positive slope at leastdegω/FOUR, a contradiction. Hence its rank isTWO and its saturation isQ. Tensoring the actual image by(M^(1))⁻² makes it globally generated, so the invariant determinant defect has degree at most degQ−TWO deg(M^(1))²=degω/TWO. The least invariant orbit has degreeN/FIVE=TWO degω. The defect isZERO. This gives the literal integral original surjection S→Q, without using irreducibility or a dimension bound.

## Descent toY and the embedded differential plane

The actual Hurwitz identity and retained canonical comparison give
\[
\omega_T=\phi^*\omega_\Gamma\otimes q^*O_Y(P_0)
=\phi^*\omega_\Gamma^2,
\qquad\phi^*\omega_\Gamma=q^*O_Y(P_0)
\]
with the inherited genuine native actions. PullingQ byφ^(1) and descending through the free q^(1)-torsor gives Q_Y, the O subline, quotientO(P₀^(1)), and the actual source A_V→Q_Y. Its degree isONE. Semistability ofQ is preserved by the separableφ^(1); a destabilizer downstairs would pull back to one upstairs. Hence Q_Y is semistable, and rankTWO degreeONE makes it stable. Pullback and faithful descent of the Frobenius evaluation give the integral exact sequence with kernelO_Y(THREE P₀).

The adjoint map Q_Y→F_{Y*}ω_Y is generically injective. In the actual endpoint coordinates its generic evaluated space, up to the fixed nonzero common constant c²/κ, is
\[
\langle z\eta,f^3z\eta\rangle_{k(Y)^5},
\qquad\eta=dz/w,
\]
because df/(fd)=c²zη and the quotient of the two Q generators isf³. These TWO forms are independent overk(Y)⁵, sincef is a separating p-basis. This image is saturated. At wild and tame pointsφ is unramified and the previous pushforward saturation bases retain their independent residues. At every other point the first form is a unit; the ratiof³ has contactONE, except at the unique degreeTEN ramification pointP₀ wheref−h has contactTWO. Both contacts are less thanFIVE, so the pushforward germ pair remains primitive. There is no image defect.

## Ordinary Cartier onQ_Y is surjective

Here only zero/nonzero and divisors are needed, so the coefficient identities can be recorded before their fixed fifth-root scalar identification. Write H(z)=h z⁵+c z⁴−ONE=w². Since η=w⁴dz/w⁵, Cartier is obtained from the coefficient of z⁴ over the fifth-power field. The two generic forms satisfy
\[
C_Y(z\eta)=c^{2/5}z_1\eta_1,
\quad
C_Y(f^3z\eta)=c^{2/5}\frac{b^{1/5}w_1+TWO}{z_1^2}\eta_1.
\]
In literal relative notation, the constants and z₁,w₁,η₁ are transported by the fixed coefficient twist; these formulas equivalently assert that the two pre-root coefficients relative toη₁ are c²z⁵ and c²(bw⁵+TWO)/z¹⁰. They introduce no new scalar-line calibration.

For verification, (w+b)⁶=w⁶+bw⁵+FOUR bw+TWO. Multiplying by w⁴, dividing by w⁵ and by z¹⁴ gives
\[
f^3z\eta=z^{-14}
\left(w^5+FOUR b+(b+TWO/w^5)H(z)^2\right)dz.
\]
Only c²z⁸ inH² contributes to the z⁴ residue after multiplication by z⁻¹⁴, giving the second formula. The first follows by multiplyingH² byz; its only relevant term is c²z⁹.

The first Cartier output is a regular nonzero canonical section with precisely the TWO wild zeros z₁=ZERO. Thus surjectivity only needs checking at those points. Let w₀=±TWO be the value ofw at z=ZERO. At either wild point choose the previous weak parameter, and put ζ=lim(z/t). The exact leading identity forf gives ζ⁵=(w₀+b)²/λ. Apply Cartier to the saturated generator q₂. After raising the output coefficient relative toη₁ to its FIFTH power, its nonzero common scalar apart, the constant term is
\[
c^2\left((bw_0+TWO)\zeta^{-10}
-\lambda^3\zeta^5\right)
=\frac{c^2\lambda^2}{(w_0+b)^4}
\left(bw_0+TWO-(w_0+b)^6\right).
\]
Now (w₀+b)⁶=ONE, because w₀²=FOUR,b²=THREE, and (w₀+b)⁵=w₀+FOUR b. The remaining bracket is bw₀+ONE, which cannot vanish: (bw₀)²=TWO≠ONE. Hence the Cartier output ofq₂ is a unit at BOTH wild points. Everywhere else the first output is a unit. This proves integral surjectivity C_Y:Q_Y→ω_Y₁. Its kernel is the rankONE line detQ_Y⊗ω_Y₁⁻¹=O_Y₁(−P₀^(1)), as stated.

This fixed positive quotient of the actual source is not embedded inB_Y, and its map need not factor through the original K. Those are separate original-source compatibility questions. The rankFOUR zero-Gram case remains open.

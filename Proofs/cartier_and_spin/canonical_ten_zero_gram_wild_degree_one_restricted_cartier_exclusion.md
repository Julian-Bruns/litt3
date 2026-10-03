# Proof: complete native Hom lattices and a formal-adjoint Cartier contradiction

Version1, 3 October2026. [Fresh whole static audit](../../Research/audits/OCT03_ZERO_TOP_WILD_DEGREE_ONE_RESTRICTED_CARTIER_EXCLUSION_AUDIT.md): mathematical PASS allTWELVE checks, no repair. One literal display typo was corrected. Scope and canonical inputs are in the [statement](../../Theorems/cartier_and_spin/canonical_ten_zero_gram_wild_degree_one_restricted_cartier_exclusion.md). The argument retains both original finite étale maps on the SAME T and the actual standard-Cartier comparison. No numerical computation is needed.

## The wild integral modification has nonnegative ordinary minimum slope

Suppose I_r has a negative last HN quotientQ. Native HN uniqueness and Picard integrality givedegQ≤−δ. Its kernelU⊂I_r⊂H hasdegU≥TWOδ and rank at mostFOUR. The accepted native subbundle bounds onH force rankU=FOUR, degU=TWOδ andU=B_Γ: saturation cannot add a nonzero invariant divisor while staying within the same maximum degree. ButB_Γ has wild fiber⟨e₀,e₁,e₂,e₃⟩, andℓ(e₀)=r≠ZERO, soB_Γ is not contained inI_r. This is a contradiction. Thusμ_min(I_r)≥ZERO; no geometric nefness or strong semistability is asserted.

## Exact wild and tame frames for W_r

Put ε=t_right−t_left temporarily at a wild point and abbreviatet=t_left. The pulled modification condition onV=F*H is that the e₄ coefficient plusr times thee₀ coefficient be divisible byt⁵. On the canonical evaluation kernelV₁ it gives the integral basis
\[
w_j=\epsilon^jdt_{\rm right}
-\frac{r(-t)^j}{ONE+rt^4}\epsilon^4dt_{\rm right}\quad(j=ONE,TWO,THREE),
\qquad w_4=t^5\epsilon^4dt_{\rm right}.
\]
The denominator is a unit. This is the actual lengthFIVE pullback of the lengthONE modification onΓ₁. At every tame or ordinary point,W_r=V₁ integrally.

Let a native rational functional onW_r toO have valuesL_i(f) on(δf)^i df_right, i=ONE,…,FOUR, withδf=f_right−f_left. Because these frames are invariant, L_i∈k(f). At finite ordinary points the frames are regular bases, so eachL_i has no pole there. ThusL_i are Laurent polynomials, with possible poles only atf=ZERO.

At wild usef=λ(t⁻⁵−t⁻¹). Moduloε⁵,
\[
\delta f=\lambda t^{-2}\epsilon(ONE+\epsilon/t)^{-1},
\qquad df_{\rm right}=\lambda(t+\epsilon)^{-2}dt_{\rm right}.
\]
Writinga_j for the values onε^jdt_right gives the exact triangular formulas
\[
\begin{aligned}
a_1&=t^4\lambda^{-2}L_1+THREE t^5\lambda^{-3}L_2+t^6\lambda^{-4}L_3,\\
a_2&=t^6\lambda^{-3}L_2+FOUR t^7\lambda^{-4}L_3,\\
a_3&=t^8\lambda^{-4}L_3,\\
a_4&=t^{TEN}\lambda^{-5}L_4.
\end{aligned}
\]
Regularity meansa_j−r(−t)^j a₄/(ONE+rt⁴) regular forj=ONE,TWO,THREE andt⁵a₄ regular.

At tame takef=v² exactly. Ifb_j are the values on(v_right−v_left)^j dv_right, the inverse diagonal change gives
\[
\begin{aligned}
b_1&=FOUR v^{-2}L_1+TWO v^{-4}L_2,\\
b_2&=TWO v^{-3}L_2+THREE v^{-5}L_3,\\
b_3&=v^{-4}L_3,\\
b_4&=THREE v^{-5}L_4.
\end{aligned}
\]
These follow by expandingε_t=THREEδf/v+THREE(δf)²/v³+(δf)³/v⁵ anddv_right/df_right=THREEv⁻¹(ONE+TWOδf/v²+(δf)²/v⁴). Their integral regularity is used below, not merely the leading diagonal valuations.

## The two complete native Hom spaces

For targetO, tame regularity first requiresL₄ divisible byf³ andL₃ byf². ThenL₂ is divisible byf with its f coefficient equal to the f² coefficient ofL₃; L₁ has no negative exponent, and its constant isTWO times that f coefficient ofL₂. Wild regularity ofw₄ forcesdegL₄≤THREE, soL₄=A f³. Regularity ofw₃ forcesdegL₃≤TWO, henceL₃=B f²; no larger-degree leading term can be canceled by its a₄ contribution. SimilarlydegL₂≤ONE anddegL₁≤ONE. ThusL₂=B f andL₁=E f+TWO B.

At wild the negative-order terms ofw₃ are(B+rA)λ⁻²t⁻²; those ofw₂ cancel under the same condition. Those ofw₁ then leave exactlyEλ⁻¹t⁻¹. ConsequentlyB=−rA andE=ZERO. Conversely these conditions cancel all negative orders in the exact formulas; the tame conditions already ensure regularity there. This provesHom_native(W_r,O)=kα_r with the four values in the statement, including existence and completeness.

For targetω², multiply the tame formulas by(df/dv)²=FOURv² and the wild formulas by(df/dt)²=λ²t⁻⁴. Tame regularity requiresL₄ divisible byf²,L₃ byf, L₂ regular with constant equal to the f coefficient ofL₃, andL₁ allowed a sole f⁻¹ term with coefficientTWO times that constant. Wild regularity then forcesL₄=A f²,L₃=B f,L₂=B,L₁=E+TWO B/f, withB=−rA and E arbitrary. The negative leading terms inw₃,w₂,w₁ are canceled exactly as above; there are no additional poles. Hence
\[
(L_1,L_2,L_3,L_4)
=E(ONE,ZERO,ZERO,ZERO)+A(-TWO r/f,-r,-rf,f^2).
\]
The second term is preciselyt₂α_r in the targetω² frame(df)², proving the second exact Hom formula. All scalar coefficientsA,E are constants in k, not arbitrary rational functions. This distinction is essential below.

## Correct normalization of the last native quotient

Use d=s/(κdf) and retain the common nonzero evaluation factorκ⁻¹. The unitω² basis(df)² and global quadraticO basis(df)²d² evaluate to d⁻¹df andd df. The normalized cubic quotientF₃/F₂=ω⁻¹ has raw cubic zero divisorW, with multipliert₂=(df)²/f. Thus its raw rational vectord³ maps to a nonzero constant times(df)⁻¹/f. After tensoring byω², the raw third vector maps to a nonzero constant timesdf/f. A last-quotient lift of the frame df must therefore multiply that raw third vector by a nonzero constant timesf.

The family shear changes its evaluated differential by a scalar multiple of the natural last quotientdf. Consequently, in any original allowed constant normalization, the third evaluated direction with last quotientdf has coefficientζ f d²−ϑ, ζ≠ZERO,ϑ∈k. This agrees with the accepted shear identity; the raw value d²−τ/f is not a normalized last-quotient lift.

## An actual restricted lift would give a differential operator

Supposeι_r:I_r→H lifted toZ_τ. The minimum-slope bound andμ_max(N₃)<ZERO make an ordinary lift unique; any G-conjugate is another lift of the same equivariant inclusion, so that lift is native without averaging. Frobenius adjunction givesΦ:F*I_r→J_τ with last quotient equal to canonical evaluation. Its restriction toW_r lands inω²⊕O. By the exact Hom spaces it is
\[
\psi=e\gamma+a_0t_2\alpha_r\quad\text{to }\omega^2,
\qquad q\alpha_r\quad\text{to }O,
\qquad e,a_0,q\in k.
\]
Generically F*I_r=V. On the invariant diagonal basis(δf)^jdf_right, the evaluated differential coefficients are
\[
\begin{aligned}
A_0&=u/d+v d+\zeta f d^2-\vartheta,\qquad u,v\in k(f),\\
A_j&=(e\delta_{j,ONE}+a_0L_j/f)/d+qL_jd,
\quad j=ONE,\ldots,FOUR.
\end{aligned}
\]
All maps and parameters here derive from the specified lift; no arbitrary source is substituted. The commonκ⁻¹ factor preserves CartierZERO.

For a rational inputφ(f)df, Taylor expansion gives the evaluated operatorΣA_j∂_f^jφ/j!. Cartier kills exact derivatives. Repeated integration by parts therefore gives
\[
C_T\!\left(\sum_j A_j\,\partial_f^j\phi/j!\;df\right)
=C_T\!\left(\left[\sum_j(-ONE)^j\partial_f^jA_j/j!\right]\phi\,df\right).
\]
Becausef is the actual p-basis onT, testingφ=ONE,f,…,f⁴ makes its Cartier pairing nondegenerate overk(T)⁵. The assumed standard-CartierZERO lift forces the bracket to be ZERO in the actual fieldk(T).

## Sparse formal adjoints and the actual primitive coefficient table

ForR=ΣR_i f^i, ZERO≤i≤FOUR, with fifth-power constantsR_i, define
\[
S_L(R)=\sum_{j=ONE}^{FOUR}(-ONE)^j\partial_f^j(L_jR)/j!,
\qquad S_{L/f}(R)=\sum_{j=ONE}^{FOUR}(-ONE)^j\partial_f^j(L_jR/f)/j!.
\]
Direct differentiation of the four monomials gives
\[
S_L(R)=(TWO r+ONE)R_1+THREE r R_4 f^3,
\qquad
S_{L/f}(R)=-TWO rR_0/f^2+(TWO r+ONE)R_2.
\]
Hence the required bracket identity is
\[
\zeta f d^2-\vartheta+u/d+v d
-e\partial_f(d^{-1})+a_0S_{L/f}(d^{-1})+qS_L(d)=ZERO.
\]

Put a=c⁻³,h=c−ONE,D=d⁵,F₀=f⁵. The accepted actual rankTWO Cartier table, usingb²=THREE, simplifies to
\[
\begin{array}{c|l}
i&m_i\text{ in }d^{-1}=\sum m_i f^i\\\hline
ZERO&a^2D^{-1}\\
ONE&bc^9F_0D^2+bh/c\\
TWO&FOUR b/c\\
THREE&c^{14}F_0D^3+TWO c^4hD+a^2h^2/(F_0D)\\
FOUR&THREE a^2h/(F_0D).
\end{array}
\]
For d=Σp_i f^i the needed coefficients are
\[
p_1=TWO bc^6F_0D^2+THREE bc^{-4}h,
\qquad p_4=THREE cD+TWO a^3h/(F_0D),
\]
andp₂ has highestD-power−c²¹F₀²D⁵, nonzero. This follows immediately fromp₂=(THREEa²B+C³F₀²)/D in the accepted table.

D has degreeTEN overk(Γ)⁵. Sincek(T)⁵/k(Γ)⁵ is separable andk(Γ)/k(Γ)⁵ is purely inseparable, adjoiningf does not lower this degree. Equivalently the table expressesd in k(Γ)(D), so D also has degreeTEN overk(Γ). ThusD⁻¹,ONE,D,D²,D³,D⁴,D⁵ are independent overk(Γ), and the following comparisons, whose coefficients lie in k(f), are valid.

## Four forced coefficients leave an impossible nonconstant term

TheD⁵ coefficient appears only invd, forcingv=ZERO. TheD³ coefficient then appears only inu/d−e∂_f(d⁻¹), forcingu=THREEe/f. Combining these two terms now yields
\[
u/d-e\partial_f(d^{-1})
=e\,(THREE m_0/f+TWO m_1+m_2f-m_4f^3).
\]
Comparison ofD² andD respectively gives
\[
c^3e+(TWO r+ONE)q=\zeta bc,
\qquad rq=TWO\zeta bc.
\]
Because r≠ZERO, these imply
\[
q=TWO\zeta bc/r,
\qquad e=TWO\zeta b(r-ONE)/(c^2r).
\]
Finally the coefficient ofD⁰ is a rational function whose only nonconstant polynomial term is
\[
\left(\zeta a+FOUR be/c\right)f
=\frac{\zeta}{c^3r}\,f.
\]
All its other terms are constants in k: fromζfd² they are−ζah; from−ϑ a constant; from the e combination they areTWOebh/c; froma₀S they areFOURa₀(TWO r+ONE)b/c; and fromqS they areTHREEq(TWO r+ONE)bc⁻⁴h. TheD⁻¹ terms do not enter this comparison. Sinceζ,c,r are nonzero andf is nonconstant, theD⁰ coefficient cannot vanish. This contradicts the required Cartier identity.

There is therefore no restricted lift for anyr∈k× or finiteτ. No normalized-image ramification argument or trace-preservation assertion is used. Combining the all-dimensional degree-one source factorization with this exclusion and the already audited tame exclusion leaves only the higher-degreeB_Γ andH images, whose original C′ pullback classes remain open.

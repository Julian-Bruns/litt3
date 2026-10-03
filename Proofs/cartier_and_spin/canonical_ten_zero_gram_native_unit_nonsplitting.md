# Proof: the top native dual coefficient prevents splitting the unit

Version1, 3 October2026. [Independent bounded audit](../../Research/audits/OCT03_NATIVE_UNIT_NONSPLITTING_AUDIT.md): mathematical PASS allSEVEN tasks. The functionals use the positive explicit-b convention from the affine-family theorem. The only executed calculation is an exact polynomial recurrence overFIVE checking the displayed degreeSEVEN and degreeNINE coefficients; no search or computational certificate is needed. In the local coefficient calculation below, the scalar family parameter is denotedτ whilet denotes the wild uniformizer.

## Weighted finite-flat duality and annihilators

Put E=φ_*O_T and ω=ω_Γ. The actual different section s is a section of φ*ω, using the retained genuine identity ω_T=φ*ω². Finite-flat duality makes
\[
E\otimes E\longrightarrow\omega^{-1},
\qquad (b,c)\longmapsto\operatorname{Tr}_\varphi(bc/s)
\]
a perfect genuine native pairing on E. This is the usual inverse-different trace duality, with its specified actual different generator; thus E*=Eω. The accepted ordinary traces vanish for powersZERO throughSEVEN and Tr(ONE/s)=ZERO. The saturated annihilators are therefore
\[
F_2^\perp=F_6,
\qquad F_4^\perp=F_4.
\]
Indeed the indicated power spaces are generically orthogonal by these traces, their ranks are the required complementary ranks, and saturation identifies them with the integral annihilators. Hence
\[
F_2^*=(E/F_6)\omega.
\]
Write J₄(τ) for the finite family member. The native quotient F₄→O is ℓ₇+τℓ₅, with kernel J₄(τ). Under the same perfect pairing its dual line in (E/F₄)ω is
\[
y_\tau=[f^3d^7df+\tau f^2d^5df].
\]
It is a subbundle because the quotient map is surjective. If A_τ=J₄(τ)^⊥⊂E, then A_τ/F₄ is this line untwisted byω, and
\[
J_4(\tau)^*=(E/A_\tau)\omega.
\]
All identities are for the genuine native action; an original source row acquires this action after its paired M⁻⁶ untwist.

## Coefficient conventions and the exact recurrence

At a wild point use the common regular frame dt, and write df=t⁻²u(t)dt, with u a unit. Set a=s/dt and Q(X)=X²−A(t)X+B(t), where A=a₊+a₋ and B=a₊a₋. The regular saturated basis of E is
\[
e_{2r+e}=t^{-r}Q(a)^r a^e,
\quad ZERO\le2r+e\le NINE.
\]
The supplied values give A(ZERO)≠ZERO, B(ZERO)≠ZERO and A(ZERO)²=THREE B(ZERO). Also d=t²u⁻¹a. Thus d^l df contributes the scalar t^(2l−TWO)u^(ONE−l) times a^l dt. The highest e_l coefficient has order TWO l+floor(l/TWO)−TWO.

Write X^n=U_n(Q)X+V_n(Q), with U₁=ONE,V₁=ZERO and recurrence U_(n+ONE)=A U_n+V_n, V_(n+ONE)=(Q−B)U_n. In characteristicFIVE the required terms are
\[
X^7=Q^3X+THREE A Q^3+(A^2-THREE B)Q^2X+\text{terms of power degree at mostFOUR},
\]
where other Q² constant terms also have power degreeFOUR, and
\[
X^9=Q^4X+FOUR A Q^4+B Q^3X+FOUR AB Q^3
+\text{terms of power degree at mostFIVE}.
\]
The second expansion is exact in its displayed topFOUR terms. These formulas follow directly from the recurrence and were also checked by a standard-library sparse polynomial calculation overFIVE, PASS.

## Native maps on F₂

A native rational section of (E/F₆)ω has a unique expression
\[
\bigl(A_7(f)d^7+A_8(f)d^8+A_9(f)d^9\bigr)df\pmod{F_6\omega}.
\]
At all finite ordinary f-values its coefficients have no poles, since the ordinary power basis is integral and saturated. At f=ZERO, the tame integral basis t^l d^l and df=t·unit·dt require A_l to be polynomial and divisible by f^floor(l/TWO). Thus A₇ is divisible by f³, A₈ and A₉ by f⁴.

At the wild point, the highest coefficient of d⁹df has orderTWENTY. Since f has order−FIVE, degA₉≤FOUR, so A₉=γf⁴. Its e₈ coefficient is regular, of orderZERO. The e₈ coefficient of A₈d⁸df has highest orderEIGHTEEN−FIVE degA₈, so degA₈≤THREE; tame divisibility then forces A₈=ZERO. The e₇ coefficient of A₉d⁹df has orderNINETEEN−TWENTY=−ONE and residue proportional to γB(ZERO). No A₇ can cancel it: its highest e₇ order isFIFTEEN−FIVE degA₇, which is a multiple ofFIVE, and if negative its leading order is at most−FIVE. It follows first that degA₇≤THREE and then that γ=ZERO. We are left with A₇=εf³, whose e₇ coefficient is regular. Thus the native section space is one-dimensional, represented by f³d⁷df.

The corresponding functional is ℓ₇(b)=f³Tr(bd⁶). It kills the unit since Tr(d⁶)=ZERO. A native retraction of O⊂F₂ would not kill the unit; none exists.

## Native maps on J₄(τ)

In the quotient (E/A_τ)ω use the rational gauge A₇=ZERO, subtracting the generic multiple of y_τ. Every native rational section then has a unique expression
\[
\bigl(A_5(f)d^5+A_6(f)d^6+A_8(f)d^8+A_9(f)d^9\bigr)df.
\]
This is an integral quotient basis at all ordinary finite values. At f=ZERO, y_τ has a unit coefficient in the regular degreeSEVEN direction; its degreeFIVE coefficient is also regular. Therefore eliminating degreeSEVEN leaves the regular basis with degreesFIVE,SIX,EIGHT,NINE. The coefficient bounds are consequently unchanged: A₅,A₆,A₈,A₉ are polynomials divisible respectively by f²,f³,f⁴,f⁴.

At the wild point, y_τ has a unit e₇ coefficient and its e₆/e₇ coefficient ratio is exactlyTHREE A(t). The added τf²d⁵df has no e₆ or e₇ coefficient. It is therefore legitimate to eliminate e₇ in the saturated quotient. As above the e₉ condition gives A₉=γf⁴; its e₈ contribution is regular, and tame divisibility with the e₈ bound forces A₈=ZERO.

The only dangerous e₆ coefficient of γf⁴d⁹df, after elimination of e₇, is precisely
\[
\gamma f^4t^{19}u^{-8}
\bigl(FOUR AB-THREE A\cdot B\bigr)
=\gamma f^4t^{19}u^{-8}AB.
\]
It has order−ONE and nonzero leading coefficient if γ≠ZERO. The e₆ top coefficient of A₆d⁶df has orderTHIRTEEN−FIVE degA₆. Since tame divisibility requires degA₆≥THREE if nonzero, this is at most−TWO; it cannot cancel an order−ONE pole. It follows that A₆=ZERO and then γ=ZERO. Only A₅ remains, and its e₅ condition gives degA₅≤TWO; hence A₅=εf². This is the image of the already regular native section f²d⁵df, and is nonzero in the quotient because it is generically independent of y_τ. Thus the native dual-section space is one-dimensional.

Its functional is the restriction of ℓ₅ to J₄(τ). That functional kills the unit because Tr(d⁴)=ZERO. Again a native retraction of the unit would be nonzero there, so the native unit extension has no splitting for ANY finite τ. The argument requires no ordinary uniqueness of a splitting, averaging, or unsupported ordinary stability.

## The actual lifted image and relation scope

The accepted confinement places the actual rankTWO projected image at M⁶Q₁, and the actual rankTHREE image at M⁶I₃(τ). The actual lifted image H projects onto that image integrally. If its rank equalled the projected rank, this projection would be an isomorphism and, after M⁻⁶, would supply the forbidden native unit splitting. Hence its rank is respectivelyTHREE orFOUR and its saturation is respectively M⁶F₂ or M⁶J₄(τ).

Global generation of the raw H bounds its invariant torsion defect by the degree of the saturation. These two degrees are N/EIGHT and N/TEN, respectively; both are smaller than the least nonempty invariant orbit degree N/FIVE. Thus the defects vanish and H globally generates the full claimed lift.

For the rankTHREE projected case, the accepted affine-family determinant argument now applies only to the rankFOUR lift: its actual dimensionEIGHT relation R has rankFOUR, detR=M⁻²⁴ω² and detR·M⁴⁰=ω⁴. The native fifth-root degree obstruction makes R nonhorizontal and supplies the nonzero original image and first jet. For the rankTWO projected case, R has rankFIVE, detR=M⁻¹⁸ω and detR·M⁵⁰=ω⁵. Its potential fifth root has native degree degω. We do not infer horizontality or nonhorizontality in this remaining case.

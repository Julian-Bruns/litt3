# Proof: the two native dual sections and the original rank-three relation

Version1, 3 October2026. [Independent bounded audit](../../Research/audits/OCT03_RANK_THREE_NATIVE_FAMILY_AUDIT.md): mathematical PASS all SEVEN tasks. The literal source and relative-Frobenius clarifications are applied. No computational certificates are needed.

The supplied perfect ω⁻¹-valued pairing on Q₄=F₈/O, where ω=ω_Γ, makes Q₂=F₄/O a maximal isotropic subbundle. Consequently
\[
Q_2^*\simeq(F_8/F_4)\otimes\omega.
\]
We compute its genuine native global sections in the fixed endpoint frame. The quotient Γ/G=P¹ has wild value f=∞ and tame value f=ZERO. The native invariant rational canonical differential df has order−TWO at every wild point and orderONE at every tame point. There are no other zeros or poles: this follows from weak C₅ breakONE, where f has local form A(t⁻⁵−t⁻¹), and tame indexTWO, where f is a unit times t². Its divisor is the tame orbit minusTWO times the wild orbit, with the correct degreeN/TEN.

Since the ordinary power flag is saturated outside the wild orbit, every G-invariant rational section for the genuine native action on (F₈/F₄)ω has a unique generic expression
\[
\Bigl(\sum_{l=5}^8 A_l(f)d^l\Bigr)df\pmod{F_4\omega},
\qquad d=s/df,
\]
with A_l in k(f). At an ordinary finite f-value, the power basis is an integral basis moduloF₄ in a nonvanishing canonical frame, so each coefficient has no pole. At f=ZERO, the regular canonical frame is dt, df is t times a unit, and d is t⁻¹ times a unit-valued primitive different coefficient. The integral power basis is therefore t^l d^l. Regularity requires
\[
2\operatorname{ord}_{f=0}A_l+1-l\ge0.
\]
Thus A_l are polynomials, divisible by f^ceil((l−ONE)/TWO).

## Exact regularity at the weak wild orbit

In a common regular dt frame put a=s/dt, so d=t²u(t)⁻¹a for a regular unit u, and df=t⁻²u(t)dt. Use the established saturated polynomial basis
\[
e_{2r+e}=t^{-r}Q(a)^r a^e,
\qquad Q(X)=(X-a_+(t))(X-a_-(t)),\quad e\in\{0,1\}.
\]
The class of a^l in its highest e_l quotient has coefficient t^floor(l/TWO). Thus the top coefficient of d^l df in e_l has order
\[
2l+\lfloor l/2\rfloor-2.
\]
The FOUR orders for l=FIVE,SIX,SEVEN,EIGHT are TEN,THIRTEEN,FIFTEEN,EIGHTEEN. A polynomial of f-degree m has order−FIVE m at this wild point.

The highest l=EIGHT coefficient therefore requires degA₈≤THREE, but tame divisibility requires f⁴, so A₈=ZERO. The l=SEVEN coefficient requires degA₇≤THREE and tame divisibility f³, so A₇=γf³. Its e₆ coefficient is regular, and its only potentially irregular lower coefficient moduloF₄ is e₅. This latter coefficient is regular as well, for the exact following reason.

Put A=a₊(t)+a₋(t) and B=a₊(t)a₋(t), so X²=Q+A X−B. Polynomial recurrence in characteristicFIVE gives the coefficient of Q²X in X⁷ as A²−THREE B; its coefficient of Q³ is THREE A. The known wild ratio r=a₊(ZERO)/a₋(ZERO), with r+r⁻¹=ONE, gives A(ZERO)²=THREE B(ZERO). Thus A²−THREE B has order at leastONE. The e₅ coefficient of f³d⁷df has naive orderFOURTEEN−FIFTEEN=−ONE, and this vanishing makes it regular. The e₆ and e₇ coefficients already have orderZERO or higher.

Since the A₇ contribution is regular, the e₆ top condition requires degA₆≤TWO, incompatible with divisibility f³. Hence A₆=ZERO. Then the e₅ condition requires degA₅≤TWO and divisibility f², so A₅=εf². Both resulting sections are regular also at the tame and ordinary points. We have proved the exact native section space
\[
H^0\bigl((F_8/F_4)\omega\bigr)^G
=k\,[f^2d^5df]\oplus k\,[f^3d^7df].
\]
The two classes are generically independent. No finite-field search or unrecorded higher-jet parity is used; the one needed vanishing is the explicit quadratic root-sum identity.

## Pairing and the actual affine family

Weighted pairing with these TWO sections gives respectively ℓ₅(b)=f²Tr(bd⁴) andℓ₇(b)=f³Tr(bd⁶), because s=d df. The native polynomial has only powers TEN,FIVE,TWO,ZERO. Newton sums give Tr(d^j)=ZERO for ZERO≤j≤SEVEN, Tr(d⁸)≠ZERO, and Tr(d⁹)=Tr(d¹⁰)=ZERO. Hence on the generic power classes ONE,d,d²,d³,d⁴, ℓ₅ is nonzero only on d⁴, whileℓ₇ is nonzero only on d². The integral ℓ₅ is therefore the canonical F₄/F₃ quotient. Its restriction to Q₁=F₂/O is ZERO. The integral restriction ℓ₇|Q₁ is a nonzero scalar multiple of Q₁→O, hence surjective. This identifies the maps without treating raw d² or d⁴ as saturated generators at the wild point.

The rankTHREE actual image has, by power confinement, an integral genuine native quotient Q₂→O. Its map is a nonzero combination of these TWO. If it were ℓ₅ alone, its kernel F₃/O would contain Q₁=F₂/O, and its scalar quotient by M⁶Q₁ would be M⁶ω⁻¹, of negative degree−N/FORTY. A globally generated actual image cannot have that quotient. Thus the ℓ₇ coefficient is nonzero, and normalization gives ℓ₇+tℓ₅. Its restriction to Q₁ is still surjective, so its full map is surjective for every finite t.

In the explicit endpoint polynomial Tr(d⁸)=C f⁻⁴ for a fixed nonzero C. Therefore the relation on coefficients C₂,C₄ of a generic element is f C₂+tC₄=ZERO. Since t₂=f⁻¹(df)², the kernel is exactly the generic span[s],[s³],[s⁴−t t₂s²]. Taking its actual saturation supplies the integral kernel; determinantω⁻² follows from the exact quotient Q₂→O.

## Semistability of this kernel

Put I₀=ker(ℓ₇+tℓ₅), of rankTHREE and degree−TWO d with d=degω. A strict Harder–Narasimhan destabilizer is uniquely preserved by the genuine native G-action. If it has rankONE, the native integer degree lattice and μ(I₀)=−TWO d/THREE require degree at leastZERO; this contradicts its inclusion in the semistable Q₄ of slope−d/TWO. If it has rankTWO, its determinant degree must be at least−d, while Q₄ semistability gives degree at most−d. It is therefore the unique native rankTWO equality-slope Q₁. But ℓ₇+tℓ₅ is surjective on Q₁, so Q₁ is not contained in I₀. Both possible destabilizers are excluded. Thus I₀ is ordinarily semistable; the stated scalar slope follows by adding degM⁶=THREE d/FOUR.

## Original lifts and Cartier nonhorizontality

Let J₄(t) be the native preimage of I₀ in E°. The actual original lifted image H projects onto M⁶I₀ as sheaves. If its rank isTHREE, this is an isomorphism and supplies a paired native splitting of the unit extension after untwisting by M⁶. Its determinant is M¹⁸ω⁻². If its rank isFOUR, H has torsion quotient in M⁶J₄(t), whose degree is FOUR·THREE N/FORTY−TWO N/TEN=N/TEN. Its global generation bounds the invariant determinant defect by N/TEN<N/FIVE, so the defect isZERO. Thus H=M⁶J₄(t) and detH=M²⁴ω⁻².

For the Cartier conclusions retain the SAME original horizontal rankTHREE surjection a:W₈O_T→F_T*K₀, its original evaluation λ:F_T*K₀→L⁶ whose adjoint row is represented by this Γ lift, and the paired calibration onΓ^(1) inverse to (M^(1))², with F_Γ*(M^(1))²=M¹⁰. Let R=ker(W₈OΓ→H), of rank k=EIGHT−rankH. A horizontal R would Cartier-descend to R₁ onΓ^(1). That paired original calibration makes R₁⊗(M^(1))² genuinely native. Its determinant has relative-Frobenius pull
\[
F_\Gamma^*\det\bigl(R_1\otimes(M^{(1)})^2\bigr)=\det R\,M^{10k}=
\begin{cases}
\omega^6,&\operatorname{rk}H=3,\ k=5,\\
\omega^4,&\operatorname{rk}H=4,\ k=4.
\end{cases}
\]
Here the original determinantONE normalization and M¹⁶=ω² are retained. Neither SIX degω/FIVE norFOUR degω/FIVE lies in the native line-degree lattice degω·Z onΓ^(1). Hence R is nonhorizontal in either alternative. The same derivative-of-relations argument as in the eight-source Cartier theorem gives a(φ*R)≠ZERO and j₁λ(a(φ*R))≠ZERO. This uses the WHOLE actual Γ relation kernel and source horizontality, not Γ-linear independence of the constant module.

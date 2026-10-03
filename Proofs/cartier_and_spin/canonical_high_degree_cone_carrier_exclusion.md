# Proof: cone pole ledgers and the same complete Cartier gates

Version1. [Statement](../../Theorems/cartier_and_spin/canonical_high_degree_cone_carrier_exclusion.md). Whole-cone argument passed [independent review](../../Research/audits/CANONICAL_HIGH_DEGREE_CONE_CARRIER_AUDIT_2026_10_03.md). Reuse the accepted actual carrier-level mixed-fiber and primitive-even obstructions in [the character carrier theorem](actual_spin_carrier_character_reduction.md), the [ordinary degree18 Cartier proof](canonical_nonic_triangle_ordinary_spin_exclusion.md), and [ordinary degree24 Cartier proof](canonical_octavic_triangle_ordinary_spin_exclusion.md). Their complete BACKUP gates and proper specialization bounds are reused without computation. Every function is on the ACTUAL endpoint; no auxiliary cover replaces either original map.

## Local pole and coefficient ledgers

The canonical stack Hurwitz identity still gives K_Y∼2P, hence P is Weierstrass. Let t be the distinguished faithful stabilizer order. The actual mixed fiber gives κ=t(2+u), u≥1. Therefore t=2 or3 when κ=18; t=2,3 or8 when κ=24. Order9 cannot occur for18.

The genuine canonical weights are(1,2,8) for18 and(1,2,7) for24. At an order-t cone an invariant weight-j generator has target local order r_j=(-j mod t), reduced to0≤r_j<t. Its normalized genuine Y function has exact pole j−2r_j at P, because the actual spin map has index TWO there and the canonical different section has simple zero. The generator divisors at the other cones are unchanged. Consequently:

|κ|t|pole F|pole G|pole H|
|---|---|---|---|---|
|18|2|6|8|7|
|18|3|6|6|9|
|24|2|6|8|13|
|24|3|6|6|15|
|24|8|2|8|13|

Here F,G,H have weights6,8,9 for18 and6,8,15 for24.

At a ramified Γ fiber there are t actual quadratic ramified factors. Each quadratic has linear and constant coefficients in the target maximal ideal. In their product, every contribution to the coefficient of degree ℓ uses at least t−floor(ℓ/2) such vanishing coefficients, when positive; multiplication by the unramified factors cannot decrease this lower bound. Thus
\[
\operatorname{ord}_{\Gamma}(e_{\kappa-\ell})\ge\max(0,t-\lfloor\ell/2\rfloor).
\]
For every odd weight below κ, its invariant space has coarse degree ZERO, and any nonzero coefficient has exactly its forced cone order r_j. A required larger order therefore forces that coefficient identically zero.

For κ24,t8 the odd weights15,21,23 have forced orders1,3,1 and required orders at least4,7,8. All odd coefficients vanish, giving the forbidden primitive even polynomial. This excludes t8 directly. In each t2 case eκ−1 vanishes; in each t3 case both eκ−1 and eκ−3 vanish. These facts will be compatible with the parity conclusions below.

## A regular differential must vanish at P

For18 the same actual generator identity is
\[
G^3=F(\alpha F^3+\beta H^2),\qquad\alpha\beta\ne0,
\qquad \nu=(F\,dG-3G\,dF)/(FH).
\]
Its regularity at finite points and nonzero property are exactly as in the ordinary proof: F has divisor3D−6P for the TWO distinct order-nine points, G has order ONE at D, H is a unit there; at H=0 the differentiated identity removes the apparent denominator. The function G/F³ has exact pole EIGHT at D, proving ν≠0. If t3, the numerator has pole at most13 and FH pole15, so ν vanishes at least twice at P. If t2, its leading pole15 cancels because8−3·6=−10=0; FH has pole13, leaving at most a SIMPLE pole at P. This is its only possible pole, so the residue theorem removes it. Hence ν is regular also when t2.

For24 adjoin the ACTUAL connected étale double cover u²=F and put W=H/u. Connectedness follows from the Weierstrass gap THREE: a square root of F would have sole pole3P. The cover has two points over P. As in the ordinary proof,
\[
W^2=\alpha u^8+\beta G^3,\qquad
\nu=(G\,du-u\,dG)/W
\]
is nonzero and regular at finite points and invariant under the cover involution, hence descends to Y. For t3, poles u,G,W are3,6,12, so the numerator pole at most10 makes ν vanish at least twice over P. For t2, these poles are3,8,10; the leading numerator pole12 cancels because8−3=0, leaving at most a simple pole. The descended differential therefore has P as its sole possible simple pole, and the residue theorem removes it.

On the same separating Kummer elliptic map used in the ordinary proofs, supersingularity gives
\[
C(F\nu)=0
\]
on the ORIGINAL Y. This identity does not assume ν proportional to σ. For18 the pullback is ξν with ξ6=F; for24 it is−ξν with ξ³=u, again ξ6=F. In both cases ξ25=ξF4 gives the displayed identity.

Write σ=dz/y with double zero at P. Any regular differential is aσ+bzσ. If b≠0, since F has exact pole6, Fν has exact pole SIX at P. Its Laurent coefficient of t^-6dt is nonzero and its Cartier image has exact pole TWO, because−6≡−1 modulo five. No lower pole contributes to that same Cartier pole. This contradicts C(Fν)=0. Therefore
\[
\nu=c\sigma,\qquad c\ne0,\qquad C(F\sigma)=0.
\]

## Noninvariant F is excluded by the accepted complete gates

For18, F still has divisor3D−6P, with D the two distinct order-nine fiber points. Noninvariant F corresponds to a nonzero THREE-torsion Abel class D−K_Y. The accepted complete80-class BACKUP cubic norm gate at all six origins excludes C(Fσ)=0. Its proper torsion-incidence bound at most38118276 excludes MAIN. The invariant class is treated below.

For24 with t2 or3, F still has divisor2D−6P for the three distinct order-eight fiber points. Noninvariant F has the same exact finite branch-partition normal form. The accepted SIXTY nonzero BACKUP determinants at six origins and ten partitions exclude C(Fσ)=0. Their at most2880-parameter bound excludes MAIN. No new parameter family or check is required.

## Invariant F in degree18

The exact divisor3D forces F=(z−r)³, where D is a nonbranch hyperelliptic pair. Shift r to zero. Since G has a simple zero at each D point, write G=z(U+v y). For t2 its remaining pole-six space has degU=3 and scalar v; for t3 the remaining pole-four space is already polynomial, so v=0. The identity ν=cσ gives
\[
cH=y(zU'-3U)+v(z\Phi'/2-3\Phi).
\]
When t2, a nonzero v creates an even polynomial of exact degree FIVE and pole TEN, contradicting H's pole SEVEN. Thus v=0 in both cases. F,G and every even characteristic coefficient are invariant, while H is anti-invariant with exact odd pole. For t2, the only possible odd terms are H,FH,GH, whose multipliers have distinct pole orders0,6,8; moreover e17=0 by the local coefficient ledger. For t3, that ledger already gives e15=e17=0, leaving only the H term, so no independence of F and G of equal pole order is needed. Hyperelliptic parity forces every remaining odd coefficient zero, giving the excluded primitive even polynomial.

## Invariant F in degree24

The exact even-zero divisor of the invariant cubic F has precisely the two types from the ordinary proof, after rescaling:
\[
\text{I: }F=E_3,\quad \Phi=E_3J_2;
\qquad
\text{II: }F=E_1(z-a)^2,\quad\Phi=E_1J_4.
\]
E,J are squarefree with disjoint roots; a is nonbranch and distinct from the root of E1. In type I the three zero points are distinct Weierstrass points; in type II they are one Weierstrass point and a nonbranch hyperelliptic pair.

Write G=V+yZ. For t3 its pole SIX gives degV=3 and scalar Z. For t2 its pole EIGHT initially gives degV=4 and degZ≤1. The actual norm is a linear combination F4,G3. At the distinguished order-two cone its exact pole is20. Both basis functions have leading pole24, while a nonzero linear term in Z makes G³'s odd part have pole23; this cannot cancel with invariant F4. Thus Z is scalar also for t2. Write it as v. If v=0, parity closes immediately.

Assume v≠0. On the same étale double cover and with r²=E, s²=J, y=rs, the exact ν=cσ identities are as in the ordinary proof. In type I put u=r and W=rA+sB. Then
\[
cA=-vE_3J_2'/2,\qquad
cB=E_3'V/2-E_3V'.
\]
A has exact degree4. For t2, H=uW=E3 A+yB would therefore have an uncancellable even polynomial of degree7 and pole14: its other even term is absent. This contradicts H's exact pole13. For t3, V has degree3 and B exact degree5 because H has exact odd pole15. The coefficient of y in W² is2AB of degree9; in αu8+βG³ it is β(3vV²+v³Φ), of degree at most6. Contradiction.

In type II put u=(z−a)r and W=rA+sB. Then
\[
cA=vE_1[J_4-(z-a)J_4'/2],\qquad
cB=E_1V+(z-a)V/2-E_1(z-a)V'.
\]
A has exact degree5. For t2, H=uW=E1(z−a)A+(z−a)yB has an uncancellable even polynomial of degree7 and pole14, contradicting H's pole13. For t3, B has exact degree4 because H has exact odd pole15, and2AB again has degree9 while the corresponding coefficient in βG³ has degree at most6. Contradiction.

Thus v=0 in every invariant-F case. All even coefficient functions lie in k(z). For t2, characteristic evaluation has the form A(F,G)+H Q(F,G)=0 with multiplier support1,F,G of distinct pole orders0,6,8; moreover e23=0 by the local coefficient ledger. For t3, that ledger gives e21=e23=0, leaving only the H term. H has exact odd pole and cannot lie in k(z), so parity forces every remaining odd coefficient zero in either case. This contradicts the primitive-even-polynomial obstruction and closes all canonical degree18 and24 distinguished-cone cases on BOTH selected endpoints.

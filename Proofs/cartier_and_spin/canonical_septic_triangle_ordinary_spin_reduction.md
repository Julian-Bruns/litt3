# Proof: norm cancellation and the six actual cone-zero values

Version1. [Statement](../../Theorems/cartier_and_spin/canonical_septic_triangle_ordinary_spin_reduction.md). Scoped argument passed [independent review](../../Research/audits/CANONICAL_SEPTIC_TRIANGLE_ORDINARY_SPIN_REDUCTION_AUDIT_2026_10_03.md). Reuse the accepted [ordinary high-degree Weierstrass reduction](tame_high_degree_ordinary_spin_exclusion.md), actual [different primitivity](tame_spin_different_primitivity.md), and primitive-even-polynomial obstruction. All functions below belong to the ACTUAL selected endpoint, and both original maps remain on the same source.

## Exact generators and the regular differential

The canonical weights(1,2,6) on signature(2,3,7) give actual generators
\[
F=t_6/s^6,\qquad G=t_{14}/s^{14},\qquad H=t_{21}/s^{21}.
\]
Their sole poles at the Weierstrass point P have exact orders6,14,21. Their zero divisors are respectively the SIX distinct order-seven fiber points, FOURTEEN distinct order-three fiber points, and TWENTY-ONE distinct order-two fiber points. These divisors are disjoint. The invariant N42 space has basis t6⁷,t14³ and dimension TWO. The different forced cone zeros give
\[
H^2=\alpha F^7+\beta G^3,\qquad\alpha\beta\ne0.
\]
The actual norm coefficient is K=C F7+D G3, with CD≠0 and exact sole pole40 at P. Its zero is ordinary, unlike either basis cone zero. These C,D need not equal α,β.

In characteristic five define
\[
\nu=(F\,dG-4G\,dF)/H=d(FG)/H.
\]
At H=0, differentiating the generator identity yields
\[
3\beta G^2(F\,dG-4G\,dF)=2H(F\,dH-H\,dF),
\]
so ν is regular there. At F=0 or G=0, H is a unit; elsewhere no finite denominator vanishes. At P the numerator's leading pole21 cancels because14−4·6=−10=0. The denominator has pole21, so ν vanishes at least ONCE. It is nonzero: FG has simple zeros at the F and G fibers, so cannot be a fifth power. A nonzero canonical form on genus two which vanishes at the Weierstrass point has divisor2P. Hence
\[
\nu=c\sigma,\qquad c\ne0,\qquad\sigma=dz/y.
\]

For completeness the Cartier gate follows on the actual separating Kummer extension ξ6=F. Put x=G/ξ14, zE=H/ξ21. Then zE²=α+βx³ and
\[
dx/z_E=\xi\nu.
\]
Indeed14/6=4 in characteristic five. The invariant differential on this elliptic curve has Cartier zero: the polynomial(α+βx³)² has degrees0,3,6 and no degree4 modulo five. Pullback and ξ25=ξF4 give C(Fσ)=0 on the ORIGINAL Y, exactly as in the accepted canonical degree18/24 arguments. No common-source replacement is inferred from this auxiliary extension.

## Invariant F is impossible

Assume F∈k(z). Its exact pole6 and six distinct simple zeros give F=U3(z), degU3=3, with THREE distinct finite nonbranch roots. Write the full pole-fourteen generator as
\[
G=A_7(z)+y B_4(z),\qquad\deg A_7=7,\quad\deg B_4\le4.
\]
If degB4=4, the odd part of D G³ has exact pole41: its leading polynomial multiplying y is3D A7²B4 of degree18; the additional term DΦB4³ has degree17. Since C F7 is invariant, this cannot cancel in the norm K of pole40. Therefore degB≤3.

The differential identity gives the FULL expression
\[
cH=y(F A_7)' +\Phi(FB)' +\tfrac12\Phi'FB.
\]
Since deg(FA7)=10, its derivative has degree at most8 in characteristic five. The exact odd pole21 of H forces (FA7)' to have degree EXACTLY8. If degB=3, FB has degree6, so Φ(FB)' has exact degree10; Φ'FB has degree at most9 because the leading derivative of the monic degree-five Φ vanishes. Thus the even part of H has exact degree10. The odd part of H² then has polynomial coefficient of degree18 multiplying y, hence pole41. But the odd part of βG³ has degree at most17 multiplying y, hence pole at most39, while αF7 is invariant. This contradicts the generator identity. Consequently degB≤2.

Let r be any of the THREE distinct roots of F. At either actual point over r, F' and y are units and G,H are units. Evaluation of the differential formula gives cH=yF'G. The generator identity gives H²=βG³. Division by G² therefore yields
\[
c^2\beta G=\Phi(r)F'(r)^2.
\]
The right side is the SAME on the two hyperelliptic sheets. Thus G has the same value on both sheets, forcing B(r)=0. Three distinct roots force the degree-at-most-two B to vanish identically. Therefore G∈k(z).

Every even characteristic coefficient below42 is now a polynomial in F,G, and the norm is also invariant. The odd terms have the form H Q(F,G), with Q supported on1,F,F²,F³,G,FG. Their pole orders0,6,12,18,14,20 are pairwise distinct. H has exact odd pole21 and lies outside k(z). Characteristic evaluation gives A(F,G)+H Q(F,G)=0. If Q≠0 this puts H in k(z), impossible; if Q=0, distinct pole orders force every odd coefficient to vanish. The resulting primitive even polynomial is forbidden by the accepted different-primitivity and minus/tangent obstruction. This completes the invariant-F exclusion on BOTH endpoints.

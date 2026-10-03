# Proof: an actual double-cover differential and the exact family Cartier kernel

Version1. [Statement](../../Theorems/cartier_and_spin/canonical_degree_one_twenty_wild_cartier_reduction.md). Necessary reduction passed [independent review](../../Research/audits/CANONICAL_DEGREE_ONE_TWENTY_WILD_CARTIER_AUDIT_2026_10_03.md). Both original endpoint maps remain onT. The existing exact partition and invariant-gate certificate is reused without a replay.

## The actual quotient generators and differential

The accepted actual two-point quotient Picard presentation gives
\[
40D_w=6D_t=U_0,\qquad K=7D_w-D_t.
\]
Arbitrary invariant generators of weights6,23,40 have zero divisors2Dw,Dw+Dt,2Dt. Their normalized Y functions F,H,G can be scaled so that
\[
H^2=FG,\qquad\beta=G^3/F^{20}=H^6/F^{23}.
\]
The distinguished inertia t is ONE, SIX or FORTY. In the first two cases,
\[
\operatorname{div}F=2D_3-6P,
\]
with D3 the complete wild fiber of THREE distinct points. In the distinguished-wild case,
\[
\operatorname{div}F=2Q-2P,
\]
whereQ is the unique unramified wild-fiber point. The pole triples(H,F,G) are respectively(23,6,40),(21,6,36),(21,2,40); their exact values follow from the target cone generator zeros and index-two pullback atP.

In every case F is nonsquare: a root would have sole pole THREE or ONE at the Weierstrass pointP, both gaps. Its even divisor therefore gives the ACTUAL connected étale double cover Y' with U²=F. PutV=H/U, so V²=G andβ=V⁶/U⁴⁰. Characteristic five gives
\[
d\beta=V^5\,dV/U^{40}.
\]
At an unramified wild point ofY', U has order ONE andV is a unit. The actual different47 gives ord(dβ)=47−80=−33, so dV has order SEVEN. At the two points overP, dV has pole19 in the ordinary and tame cases, and pole5 in the wild case. These follow from the different tower: ord(dβ) is1,11 or95−160=−65, respectively. At other tame points V has a simple zero and dβ order FIVE, so dV is a unit. Thus exact divisor comparison gives
\[
dV=cU^7\sigma_P,\qquad c\ne0.
\]
Using U⁷=U⁵F and Cartier exactness proves C(FσP)=0. IfP were distinguished-wild, FσP would be a nonzero REGULAR differential with divisor2Q, contradicting ordinarity ofY. Therefore only ordinary and tame positions remain and divF=2D3−6P.

## Noninvariant and squarefree invariant norms are excluded

In a Weierstrass model y²=Φ(z), divσP=2P, write F=A3+by. Ifb≠0, its even zero divisor has no Weierstrass support, and its hyperelliptic norm is a square. The accepted branch partition argument yields
\[
\Phi=E_2E_3,\quad
A_3=(aE_2+b'E_3)/2,\quad ab'\ne0.
\]
The gate forces dependence of C(E2σP),C(E3σP). The accepted complete SIXTY BACKUP partition determinants and their MAIN2880 transfer in the [degree24 proof](canonical_octavic_triangle_ordinary_spin_exclusion.md) exclude it on BOTH endpoints.

ThusF is a cubic polynomial. Its THREE distinct order-two zero points have just TWO possibilities: F=E3, the product of three distinct Weierstrass branch factors; or F=(z−w)(z−a)², wherew is a branch root anda is nonbranch. The first is impossible because the same nonzero partition determinant makes its E3 column individually nonzero. Only the second remains.

## Other origins have finite support at most3600

The retained [exact invariant gate certificate](../../../litt3-computation-data/oct03_n24_cartier_gate/backup_cartier_gate.json) gives two quadratic equations ina for every origin and branch rootw. For the FIVE origins infinity,0,1,2,3, every BACKUP polynomial gcd is constant. These equations have no common projective root at infinity either: their a² coefficients represent C((z−w)σP), a nonzero REGULAR form, whose Cartier image is nonzero by BACKUP ordinarity. Hence every homogeneous quadratic resultant is nonzero atα.

For MAIN, monic hyperelliptic branch roots are rational functions oft. At a finite origin their common denominator has degree at most FOUR. The Cartier equations are the FOURTH and NINTH coefficients of
\[
(z-w)(z-a)^2\Phi(z)^2.
\]
The first has homogeneous branch/a degree NINE and the second FOUR. Clearing the common denominator to the ninth power gives parameter degree at most36 for every coefficient of the two quadratics ina. Their quadratic resultant has parameter degree at most144. There are25 choices of the five origins andfive branch roots, so their F5-stable support has at most25·144=3600 geometric parameters. The selected MAIN degree exceeds3600. Thus the same FIVE origins are excluded on MAIN as on BACKUP, and necessarilyP=t.

The infinity check here is essential: no affine-gcd argument is used to discard roots escaping to infinity under specialization.

## The moving-origin gate has genuine generic survivors

ForP=t put s=1+t,z=1/(u−t), yP=y z³. Direct expansion gives
\[
\Phi_P=z-sz^2+s^2z^3-s^3z^4+(s^4-1)z^5.
\]
Its square has successive coefficients at degrees2 through10
\[
1,-2s,3s^2,s^3,-2,s^5+2s,3s^6-2s^2,-2s^7+2s^3,(s^4-1)^2.
\]
For anyw, the FOURTH and NINTH coefficients after multiplication by(z−w)(z+1/s)² are ZERO. This proves the necessary gate identically, rather than just at the BACKUP parameter.

For ordinaryY, the Cartier map on polynomial multiples ofσP of degree at mostTHREE has rank TWO: its regular subspace spanned byσP,zσP already maps injectively. Its target has only the two indicated numerator coefficients. The kernel is therefore two-dimensional, and the two independent polynomials(z+1/s)² andz(z+1/s)² just found form its basis. Any surviving monic cubic equals(z−w)(z+1/s)². Its simple root must be one of the FIVE branch roots in the theorem, while its double root corresponds to the original coordinateu=t−s=4, a nonbranch point on the selected smooth curve. Hence precisely the five asserted shapes remain.

No endpoint contradiction follows from this weaker gate. In particular the moving origin does NOT lie in a finite exceptional parameter set. The original X maps, actual source and stronger differential identity remain available for further work.

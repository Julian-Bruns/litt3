# Proof: the first nonzero flag stage detects the marked extension

Version1, 3 October2026. [Statement](../../Theorems/cartier_and_spin/canonical_ten_gram_four_degree_one_marked_quotient.md); [independent four-point static review: PASS](../../Research/audits/OCT03_GRAM_FOUR_DEGREE_ONE_MARKED_QUOTIENT_STATIC_REVIEW.md). No computation is needed.

## An exact degree-zero quotient test for the rank-two extension

Let V be the stated extension and T a degree-zero line. A nonzero map V→T which kills the kernel O(−P) factors through O. A degree-zero line admits a nonzero section only when it is trivial, so this gives T=O.

Otherwise the restriction O(−P)→T is nonzero. Its section of T(P), of degree one, determines a unique effective point S and T=O(S−P). If S=P the class is already trivial; the original quotient V→O proves its existence, without requiring the prescribed kernel restriction to lift.

Suppose S≠P. Then T is nontrivial and H0(T)=0. The prescribed kernel map lifts to V→T exactly when pushing out the extension along O(−P)→T kills its class in H1(T). If κ is its Serre-dual functional on H0(ω(P)), this says that κ kills the image of the exact dual multiplication map
\[
H^0(\omega T^{-1})=H^0(\omega(P-S))
\hookrightarrow H^0(\omega(P)).
\tag{1}
\]
The left side has dimension one. Indeed Riemann–Roch gives h0−h1=1 and h1=h0(O(S−P))=0. Since P is Weierstrass on a genus-two curve, H0(ω(P))=H0(ω); the image in (1) is the canonical differential line vanishing at S. The nonzero κ has kernel exactly kη0. Thus (1) is killed precisely when η0 vanishes at S, namely S=R+ or R−.

Conversely the original quotient V→O exists, and the two marked quotient maps V→O(R±−P) exist by this same pushout test, or by the accepted [wild marking theorem](canonical_ten_power_quotient_wild_marking.md). This proves the rank-two Hom classification. The classes O(R±−P) are nontrivial because R±≠P and a principal divisor R±−P would give a degree-one map from a genus-two curve to P1.

## Apply the test to the original full power flag

Descend the genuinely equivariant bundle φ*F6 along the SAME free G-torsor q and call it U6. The native integral flag descends exactly to
\[
U_0=O_Y\subset U_2\subset U_4\subset U_6,
\qquad U_{2r}/U_{2r-2}\simeq V\quad(r=1,2,3),
\tag{2}
\]
where V is the pulled marked extension above. This uses the settled identification of the three successive native quotients and faithfully flat descent. It does not split the flag or descend either original endpoint map.

The [original quotient splitting proof](canonical_ten_gram_four_original_kernel_quotient_splitting.md) supplies the integral surjection
\[
\Phi:\omega_Y\otimes U_6\twoheadrightarrow E/B.
\]
It is surjective because its composition with the original row surjection is the original integral source map modulo B. Its restriction to ωY⊗U0 is exactly the distinguished ωY summand of E/B. Therefore projecting onto H/B and removing ωY gives an integral nonzero map
\[
\beta:U_6\twoheadrightarrow T_0,
\qquad\beta|U_0=0.
\tag{3}
\]
Take the least r for which β|U2r is nonzero. Its restriction kills U2r−2, so (2) gives a nonzero map V→T0. Since degB=1, deg(H/B)=2 and T0 has degree zero. The rank-two test proves the three-class restriction.

## Keep the determinant and Frobenius marking exact

From 0→H→E→ωY→0,
\[
\det H=F_Y^*(\det K)\otimes\omega_Y^{-1}.
\]
Since H/B is a line, removing B and then ωY gives the asserted formula
\[
T_0=F_Y^*(\det K)\otimes B^{-1}\otimes\omega_Y^{-2}.
\]
On the accepted constant and surviving linear saturated charts, B=O(P) and ωY=O(2P), so T0=F_Y*(detK)⊗O(−5P). Relative Frobenius sends O_Y1(P^(1)) to O_Y(5P), giving the stated exact determinant condition. This is a necessary condition on the ORIGINAL detK, not an identification of a root selected after Frobenius pullback. In particular T0=O allows a nontrivial relative-Frobenius-kernel discrepancy.

Finally R++R− is canonical and linearly equivalent to 2P, so the two marked nontrivial classes are inverse. No torsion or effectivity conclusion beyond the displayed statements follows. The full actual horizontal source compatibility and the original common-cover problem remain unresolved.

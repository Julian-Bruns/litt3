# Proof: three vanishing remainder jets from full Hermitian normality

Version1,3 October2026. [Statement](../../Theorems/cartier_and_spin/large_wild_hermitian_remainder_jet_constraints.md). Passed [root's independent review](../../Research/audits/LARGE_WILD_HERMITIAN_REMAINDER_JET_AUDIT_2026_10_03.md). Use the accepted [actual large-wild reduction](large_wild_spin_frobenius_and_cubic_reduction.md) and [the full Hermitian local normal form](../quotient_geometry/local_actions/hermitian_local_normality.md). No second-tier primitive or computation is needed. Both original finite étale maps stay on the SAME T throughout.

## The three additional Hermitian coefficient identities

Fix an unramified wild point R≠P. The actual completion of Y over the SAME coarse β-field is the Galois completion of Γ, because q and the carrier are étale here. Put t=F and f=β⁻¹=t¹⁰⁰⁰G⁻⁷. The preceding reduction proves that G is a unit with all Taylor coefficients of orders1,…,119 zero, its coefficients G120 and G144 are nonzero, and J has gap1,…,23.

For the Hermitian action with tame complement EIGHT, use the local coordinates zH=x/y and w=1/x. Its quotient is
\[
w+z_H^4w^5=z_H^5,\qquad
F_8(z_H)=\frac{w^{200}}{(1-w^{24})^8}.
\]
Writing w=zH⁵h(zH²⁴) gives h+vh⁵=1. All intrinsic increments are therefore multiples of24; to order1149 the quotient is exactly
\[
F_8(z_H)=z_H^{1000}+3z_H^{1120}+3z_H^{1144}+O(z_H^{1150}).
\]
Indeed the numerator's first correction has increment600, the denominator square begins at240, and w²⁴=zH¹²⁰(1+zH²⁴+O(zH⁴⁸)).

Full local normality supplies an actual right equivalence f=aF8(φ(t)), with a≠0 and φ(t)=λt u(t), u(0)=1. Any target tail begins at order2000 and is immaterial to these coefficients. Put S(t)=u(t)⁻¹. The leading term's first possible correction is at increment125. For k=2,3,4 it contributes nothing to order1120+5k. The1120-term has coefficients S_k⁵ at increments5k, since u¹¹²⁰=(u²²⁴)⁵ and u²²⁴ agrees with u⁻¹ to degree24. The1144-term has coefficients S_k at increments k≤4, since u¹¹⁴⁴ agrees with u⁻¹ through degree4. There are no overlaps from the other two terms at these six positions. Consequently
\[
\frac{c_{1120+5k}}{c_{1120}}=
\left(\frac{c_{1144+k}}{c_{1144}}\right)^5,
\qquad k=2,3,4.
\]
This assertion deliberately omits k=1 and5, where the leading term and the other supported term can overlap.

Since G has gap1,…,119, nonlinear terms of G⁻⁷ begin at increment240. For all increments120,…,149 its coefficient is therefore3G(R)⁻⁸ times the corresponding coefficient of G. The three identities become
\[
\frac{G_{130}}{G_{120}}=\left(\frac{G_{146}}{G_{144}}\right)^5,
\quad \frac{G_{135}}{G_{120}}=\left(\frac{G_{147}}{G_{144}}\right)^5,
\quad \frac{G_{140}}{G_{120}}=\left(\frac{G_{148}}{G_{144}}\right)^5.
\]

## Differential exactness and the vanishing jets

Use the statement's f_i,r_i, and write J_j for the coefficient of t^j in J. Exactness of dH0=t³σ makes its t⁴dt coefficient zero, since the derivative of t⁵ vanishes. Thus f1=0. Exactness of dJ=t²³\(\mathcal R\)σ similarly makes its t²⁴dt coefficient zero. Since f0≠0, this yields r1=0 before any extra Hermitian equation is used.

From dG=ct¹⁴³σ one obtains
\[
G_{144}=4cf_0,\quad G_{146}=cf_2,
\quad G_{147}=3cf_3,\quad G_{148}=2cf_4.
\]
The remainder decomposition gives G120=J24⁵, G130=J26⁵, G135=J27⁵, and G140=cH0(R)+J28⁵. Exactness of dJ and the already vanishing linear coefficients give
\[
J_{24}=4r_0f_0,\quad
J_{26}=r_0f_2+r_2f_0,\quad
J_{27}=3(r_0f_3+r_3f_0).
\]
The first two Hermitian identities, taking unique fifth roots, say J26=4J24 f2/f0 and J27=2J24 f3/f0. These right sides are r0f2 and3r0f3 in characteristic FIVE, so r2=r3=0. It now follows that
\[
J_{28}=2(r_0f_4+r_4f_0).
\]
The last Hermitian identity yields cH0(R)+J28⁵=(3J24 f4/f0)⁵=(2r0f4)⁵. Cancelling the common fifth-power term proves exactly
\[
cH_0(R)+(2r_4f_0)^5=0.
\]
The nonzero r0 follows from J24≠0, already forced by the first nonzero Hermitian correction. No nonvanishing of r4 or H0(R) is assumed.

## The third global differential ratio

At each finite F-zero the vanishing r1,r2,r3 makes d\(\mathcal R\) vanish to order at leastTHREE. There are no other finite poles of \(\mathcal R\), and σ has no zeros away from P. Hence \(\mathcal T\)=d\(\mathcal R\)/(F³σ) is regular off P.

The previous accepted bounds are \(\mathcal R\)∈L(41P) ordinarily/tamely and L(87P) in the distinguished-wild case. Their derivatives have poles at most42P and88P. The denominator F³σ has pole19P or13P respectively, giving \(\mathcal T\)∈L(23P) or L(75P). This includes every distinguished position and does not apply the unramified-point local normality at P.

Locally \(\mathcal T(R)\)=4r4/f0. The coefficient identity says r4⁵=2cH0(R)/f0⁵. Therefore
\[
\mathcal T(R)^5 f_0^{10}=3cH_0(R),
\]
as claimed. This is an evaluation identity at the actual wild fiber, not an identity of rational functions on Y. A change of bounded primitive by a fifth power changes the fourth remainder coefficient compatibly; the vanishing first three coefficients remains valid. Neither the jet constraints nor this small differential packet supplies a large-wild exclusion.

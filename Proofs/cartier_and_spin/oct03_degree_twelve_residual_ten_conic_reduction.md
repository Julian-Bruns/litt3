# Proof: common infinity forces a critical conic fiber and two singular branches

Version1, 3 October 2026. [Independent whole audit PASS](../../Research/audits/OCT03_DEGREE_TWELVE_RESIDUAL_TEN_CONIC_AUDIT_2026_10_03.md). See the [statement](../../Theorems/cartier_and_spin/oct03_degree_twelve_residual_ten_conic_reduction.md). The input overlap reduction passed its [separate audit](../../Research/audits/OCT03_RESIDUAL_TEN_OVERLAP_EXTENSION_AUDIT_2026_10_03.md); no numerical certificate is replayed.

The actual R/Q leg is étale, gR=2gQ−1, deg(t:R→P1)=2, E=B′/R has degree10 andg(E)=193. Its two source projections to X remain finite étale. The unique pi-uniform fiber has degree5 and contains precisely the two common infinity points of C0.

## The third local tensor coefficient applies directly to index one

Put X_i=x_i+1 and d=[23], so q0(x_i)=X_i²+d. Translating x by one leaves the x9 coefficient p9=[22] unchanged in P, since the degree10 translation contribution is10=0. The fixed coarse tensor is
\[
T(X)(dX)^3,\qquad T(X)=X^{-4}(1+A/X+O(X^{-2})),\quad A=-2p_9\ne0.
\]
At a common infinity point of C0, each actual étale X-map gives X_i=l_i u^{-3}+m_i u^{-2}+n_i u^{-1}+k_i+O(u). The tensor is regular and nonzero there. Its leading coefficient is3/l_i. Since the two actual pulled tensors are globally proportional, rho=l2/l1 is the SAME constant at both common infinity points.

The first two local coefficients give m2=rho m1 and n2=rho n1. The third coefficient, computed directly as in the accepted common-triple jet proof, gives
\[
X_2-\rho X_1\text{ regular},\qquad
(X_2-\rho X_1)(P)=(\rho-1)A.
\]
This calculation uses only the actual triple x-poles, not the cubic-root index-three field hypothesis. If rho≠1, the identity
\[
q_0(x_2)-\rho^2q_0(x_1)
=2\rho X_1(X_2-\rho X_1)+(X_2-\rho X_1)^2+d(1-\rho^2)
\]
has exact pole order3 in its numerator, while q0(x1) has pole6. Hence z³−rho² and z−z(P) have EXACT order3. But at the sole common uniform e5 fiber, z has order5 or10, according as Q/z is unramified or ramified. Therefore rho=1 and the common z-value satisfies z³=1.

In E the two R/Q lifts of the common Q-point consequently lie above t-values satisfying t6=1. Each E/R fiber consists of exactly two points, each of index5. The original common x-leading ratio is1 at all four E-points. On one R-lift both map to the SAME conic infinity section D+, and on the other lift both map to D−; the free t→−t involution exchanges these sections.

## Exact ruled-surface blowup ledger

Use the resolved conic over R from [the quadratic conic construction](../../Research/notes/oct03_ten_hour/split_conic_quadratic_base_extension.md):
\[
U^2-V^2=d(t^6-1)W^2,\quad U=X_2W,\quad V=t^3X_1W.
\]
Its disjoint infinity sections D± have self-intersection−6, and K_S=−(D_++D_-)+pi*omegaR. It has an actual birational image C of E because E=k(t,x1,x2). Its degree over R is10.

The conic can be contracted to the ruled surface with fiber coordinate a=(U−V)/W, a section of A³ for A=t*O(1), degA2. Indeed b=(U+V)/W satisfies ab=d(t6−1). Its zero section has self-intersection+6 and infinity section D− has self-intersection−6. At a zero of t6−1 of multiplicity m=1 or2 the graph ab=s^m is resolved by m successive ordinary blowups at the zero section: in the first chart a=s a1 it becomes a1b=s^(m−1), and continue. Thus the full smooth conic resolution is this ruled surface blown up at a total12 points, counting infinitely near centers, all along the proper zero section. This also handles the A1 fibers when R/t has index2.

Let F be the ruled fiber class and E_i the TOTAL transform classes of those twelve exceptional divisors. They are orthogonal, E_i²=−1. If D denotes the ruled negative section, then D²=−6 and D.F=1, while the two proper conic infinity sections have classes
\[
D_-=D,\qquad D_+=D+6F-\sum_{i=1}^{12}E_i.
\]
The curve C meets each original infinity section only at common infinities. Every common point has normal boundary order3, coming from 1/x_i, and residual infinity points are affine in the twisted conic chart. Since sigma exchanges D± and the four E-common points occur two on each section,
\[
C.D_-=C.D_+=6.
\]
Therefore, numerically,
\[
C=10D+66F-\sum a_iE_i,\quad
\sum a_i=60,\quad C^2=720-\sum a_i^2,
\]
where a_i=C.E_i are nonnegative blowup multiplicities.

At either special common R-fiber, ALL degree10 of C over R is supported at one point of one infinity section. If it is the section that was contracted, every one of the m successive blowups over that fiber has a_i=10: the last end component meets C with degree10, the intervening components have intersection zero, so the successive total-transform intersections coincide. If instead C lies on the negative-section end, its m multiplicities a_i are zero. In our two special fibers sigma swaps D+ and D−, so ONE special fiber contributes m entries10 and the OTHER contributes m entries0. This orientation must be retained: both fibers do NOT contribute10 in the same chosen ruled contraction.

The ramification index m of R/t is the same on both lifts, and equals the Q/z index (one or two), because R/Q is étale.

For m1, the twelve entries include one10 and one0. The remaining ten sum50; Cauchy gives sum a_i²≥100+10*25=350. Thus C²≤370.

For m2, they include two10 and two0. The remaining eight sum40; hence sum a_i²≥200+8*25=400 and C²≤320.

## Two common branches contribute at least forty-six delta

At each special R-value, both normalized E-points map to the SAME smooth surface point on its infinity section. In local surface coordinates (s,v) with s a parameter on R and v normal to the infinity section, each branch has orders(5,3). Its delta is at least(5−1)(3−1)/2=4. The two branches have intersection multiplicity at least15: after taking the tame cubic root of v, each has equation with weighted initial term s³−c v5, weights5 and3, so substitution into the other branch has order at least15. The union thus has local delta at least4+4+15=23. The two distinct special R-values give total delta at least46.

Adjunction gives K_S.C=−12+10(2gR−2)=20gR−32. Therefore
\[
p_a(C)\le\frac{C^2+20gR-32}2+1,
\qquad g(E)=193\le p_a(C)-46.
\]
For m1, C²≤370 gives193≤124+10gR. Hence gR≥7, which excludes gR1 and5, leaving onlygR9.

For m2, C²≤320 gives193≤99+10gR. Since gR≤9, its right side is at most189, a contradiction. Thus the common Q-point is unramified for Q/z.

Conclusion: only(gQ,j)=(5,1) remains, with its sole uniform5 branch point ordinary under the hyperelliptic map Q→P1_z and z³=1 there. This is a further necessary reduction, not an existence assertion or common-cover solution.



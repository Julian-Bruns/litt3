# Proof: all common branches in the resolved cubic-base conic

Version1, 3 October2026. [Fresh independent seven-check major whole review PASS](../../Research/audits/OCT03_THREE_TEN_BLOCKS_PHASE_ONE_FULL_COMMON_CONIC_MAJOR_WHOLE_AUDIT_2026_10_03.md), with no correction. See the [statement](../../Theorems/cartier_and_spin/canonical_ten_three_blocks_exact_phase_full_common_conic_exclusion.md).

The original common-infinity bounds, exact global leading ratioρ=κ³, all-phase tame whole ledger and full-fiber consequence of the finite index-four exclusion are accepted inputs. This proof checks a NEW geometric implication. Its resolved-conic construction generalizes the already audited [quadratic-base conic ledger](../../Research/notes/oct03_ten_hour/split_conic_quadratic_base_extension.md) and [corrected overlap blowup calculation](oct03_degree_twelve_residual_ten_conic_reduction.md); their numerical certificates are not replayed.

## 1. Actual source and conic image

Let c=5h and d=15+5h, with h2or3. The actual étale double E=C0(t), t²=z has genus16d+1. Both composed maps E→C0→X are finite étale of degree2d, while both original maps remain on their SAME original source. The actual field R⊂k(E) contains t, [R:k(t)]=3 and [k(E):R]=10. Since the original k(C0)=k(x1,x2,z),
\[
k(E)=k(t,x_1,x_2)=k(R,x_1,x_2).
\]
Thus the actual conic image over R is birational to E; no simultaneous endpoint Galois closure is assumed.

Put L=t_R*O(1), degL3. In the lines convention, the conic bundle is
\[
U^2-V^2=d_0(t^6-1)W^2,
\]
inside P(O_R⊕L³⊕L³), where on E the rational coordinates are U/W=B and V/W=t³A. Residual infinity points are affine in the appropriate twisted chart: at a zero of t the factor t³ cancels A's triple pole, and at a pole the opposite chart cancels B's triple pole. At common infinity t is a unit, both coordinates have triple poles, and the image meets an infinity section with normal order THREE. Properness supplies the morphism to the conic and its smooth resolution S. The birational image C⊂S has normalization E and degree TEN over R.

Write D∞=D++D− for the two disjoint proper infinity sections. The common leading ratio isρ=1. Over t³=1 a common point lies on D+, and over t³=−1 it lies on D−; the free involution t→−t exchanges these. There are2c common E-points, c on EACH section, all with normal order three. No other E-point meets these sections. Therefore
\[
C\cdot D_+=C\cdot D_-=3c,
\qquad K_S=-D_\infty+p^*\omega_R.
\]

## 2. Eighteen blowup centers and the numerical class

Contract the conic to the ruled surface with coordinate a=(U−V)/W; b=(U+V)/W satisfies ab=d0(t⁶−1). Its negative section, denoted B0, has self-intersection−9, and its zero section has self-intersection+9. Let f be the ruled fiber class. Over a root of t⁶−1 of multiplicity m, the graph is ab=s^m times a unit. It is resolved by m successive ordinary blowups at the zero section: in the first chart a=sa1 the equation becomes a1b=s^(m−1), and one continues. Here m≤3 because R/t has degree three, prime to characteristic five. This construction includes the A1/A2 rational double points when m2or3.

The zero divisor of t⁶−1 has degree18. Consequently S is the ruled surface blown up at EIGHTEEN centers, counting infinitely near centers; these are not presumed to be eighteen distinct base fibers. For the TOTAL transform exceptional classes Ei,
\[
B_0^2=-9,\quad B_0\cdot f=1,\quad E_i^2=-1,\quad E_i\cdot E_j=0\ (i\ne j),
\]
and
\[
D_-=B_0,\qquad D_+=B_0+9f-\sum_{i=1}^{18}E_i.
\]
These classes give K_S=−D∞+p*ωR directly from the ruled canonical divisor and ordinary blowup formula. The two infinity sections are distinct from their SUM D∞ and from the total-transform exceptional classes.

The image C is horizontal of degree ten. Put ai=C·Ei≥0; these are the blowup multiplicities. Using C·D±=3c yields
\[
C\equiv10B_0+(3c+90)f-\sum_{i=1}^{18}a_iE_i,
\qquad \sum_{i=1}^{18}a_i=90,
\]
and hence
\[
C^2=900+60c-\sum a_i^2,
\qquad K_S\cdot C=20g(R)-20-6c.
\]

## 3. Full common fibers force the correct ten/zero allocation

At each full common Q-point, Q/z has index two and π has profile2^5. Since its z-value is a unit, R/Q is étale there. There are TWO distinct lifts on R, with opposite t-values. At each lift E/R has FIVE points, each of index TWO, and ALL degree ten of the conic fiber is supported at its single infinity-section point. One R-lift lies on D+, the other on D−. Also R/t has index m=2 at each lift.

For a chain of m blowups, the end component adjacent to D+ is the last exceptional component Em. If the complete C-fiber is on that end, C·Em=10 and its intersections with all preceding components Ei−Ei+1 are zero. Thus EACH total-transform multiplicity in that chain is10. If the complete fiber lies on the D− end instead, its intersections with every exceptional component are zero and EACH multiplicity is0. This retains the orientation: the two lifts do not both contribute tens.

Each full common Q-value therefore supplies TWO entries10 and TWO entries0 among the eighteen ai. For h full values there are2h tens,2h zeroes and18−4h remaining nonnegative entries with sum90−20h=5(18−4h). Cauchy's inequality gives
\[
\sum a_i^2\ge200h+25(18-4h)=450+100h,
\qquad C^2\le450+200h.
\]
In particular C²≤850 for h2 and C²≤1050 for h3. No assumption on any other finite conic fiber was used.

## 4. Five distinct common branches give delta at least sixty-five

Each of the2h lifted common fibers contains FIVE distinct normalization points mapping to the SAME smooth surface point on its infinity section. The points give distinct image branches because E is the normalization of C. In local coordinates(s,v), with s a parameter on R and v normal to that section, EVERY branch has exact orders
\[
\operatorname{ord}(s)=2,\qquad\operatorname{ord}(v)=3.
\]
The first order is actual E/R ramification; the second is the actual triple endpoint pole. It requires no formal leading-coefficient equality beyond the already fixed section and no descended endpoint map.

Each branch has delta at least one. For two distinct branches, normalize s=u², permissible because two is invertible. Their local degree-two Weierstrass equations have weighted initial form v²−c²s³, with weights2and3, and all remaining terms have higher weighted order. Substituting the other branch therefore has order at least SIX. Thus their intersection multiplicity is at least six; cancellation of leading coefficients can only raise it. The delta formula for a union of branches gives at EACH common surface point
\[
\delta\ge5\cdot1+\binom52\cdot6=65.
\]
The2h points lie over distinct R-values, so their contributions are disjoint and the TOTAL normalization defect is at least130h. Other defects are nonnegative and need not be evaluated.

Adjunction and normalization now give
\[
g(E)\le1+\frac{C^2+K_S\cdot C}{2}-130h
\le216-45h+10g(R).
\]
For h2, g(E)=401 implies401≤126+10g(R), hence g(R)≥28. For h3, g(E)=481 implies481≤81+10g(R), hence g(R)≥40.

## 5. The actual tame ledger gives an incompatible genus bound

Let a be the number of σ-fixed points on R. Every zero/pole of z on C0 has source order exactly two. Therefore Q/z above0and∞ has only indices one or two. R=Q(t),t²=z is ramified precisely at the index-one Q-points there, and a is their count. At EACH such Q-point, π has uniform index two, giving one uniform-quadratic π-value. The h full common values are additional, at unit z, disjoint from these a values.

The accepted whole π-ledger has8d single-fold values and N uniform-quadratic values. Riemann–Hurwitz for the actual π gives
\[
N=8d/5+4-4g(Q),\qquad N\ge a+h.
\]
The actual double R/Q has
\[
g(R)=2g(Q)-1+a/2.
\]
Combining these equations eliminates a and yields
\[
g(R)\le4d/5+1-h/2=13+7h/2.
\]
Thus h2 gives g(R)≤20, contradicting28, and h3 gives the integral bound g(R)≤23, contradicting40.

## 6. Scope and preserved evidence

This excludes BOTH remaining phase-one degrees25and30 of the actual three-ten-block packet. The finite companions and third Q/z profiles are unrestricted in this proof. The independent centered and six-q-point norm results remain useful fixed-curve arithmetic and retain their original evidence; none is a dependency of the conic contradiction. Both original maps remain finite étale on their SAME original source throughout. Neither the conic image nor R/Q is offered as a replacement endpoint source. Other phases and extraction of the retained packet from arbitrary covers remain unresolved.

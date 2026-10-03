# Proof: three calibrated fibers and the extremal divisor

Version1,3 October2026. Whole scoped review PASS; see the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_one_triple_infinity_degree_bound.md). This is a conceptual actual-source restriction, with no numerical gate. [Independent audit](../../Research/audits/ACTUAL_Q0_TENSOR_ONE_TRIPLE_INFINITY_AUDIT_2026_10_03.md).

## Degree bound on the actual coarse field

Use the accepted cubic coarse reduction. Its B has index ONE or THREE over Bx=k(x1,x2). There are u=d−THREE shared simple infinity poles Qj and two distinct triple poles R1,R2. The q0 cube identity gives div(z)=TWO R1−TWO R2, so z:B→P¹ has degree TWO. If R1=R2, z would be constant. Then B=Bx(z)=Bx and the q0 quadratic relation makes [Bx:k(x1)] at most TWO. Moreover the accepted identity t/z∈Bx makes t∈Bx, so the ORIGINAL joint X-field is C0=Bx(y1), with y2=ty1. Its degree over either X-field is at most TWO, contrary to d≥THREE with one triple pole. Thus the displayed degree-TWO map is genuine.

Exact leading calibration at EVERY shared simple pole gives z(Qj)³=ρ², with the SAME nonzero ρ. There are only THREE possible z-coordinates, each with at most TWO points in its fiber. Hence u≤SIX, and d=u+THREE≤NINE. This uses exact tensor equality, not just local groups.

Center both original coordinates identically, retaining q0=xi²+D, D≠ZERO, and the nonzero fixed coefficient P9. The exact first jet gives the SAME finite part ξ0 for ξ=x2−ρx1 at all Qj. It makes their z-ramification status uniform, with all Weierstrass if ρ=ONE and all ordinary otherwise.

## Ordinary higher genus is impossible

At d=SIX,u=THREE the complete [one-triple high-genus proof](actual_q0_tensor_degree_six_one_triple_high_genus_exclusion.md) already excludes g(B)≥THREE in ALL repeated/distinct coordinate positions. Its separate proof B=Bx at that degree is retained.

For u≥FOUR, all Qj must be ordinary: a degree-TWO branch fiber has only ONE point, so the THREE available coordinate values cannot support FOUR Weierstrass points. Let J be the product of their distinct coordinate factors, with q=deg J=TWO or THREE. Suppose g(B)≥THREE and write Y²=Φ(z), with R1 at ZERO and R2 at infinity. The exact polar bounds are
\[
x_1=A_1/(zJ)+bY/(z^2J),\qquad x_2=A_2/J+cY/J,
\]
with deg Ai≤q+ONE and deg b,c≤q+ONE−g. At an ordinary coordinate occupied by two conjugate poles, comparison of BOTH calibrated leading residues gives z²c=ρb. At a coordinate occupied by only one pole, cancellation of the other sheet gives the SAME identity at that coordinate. These statements retain both coordinate occupancy patterns.

Both odd polynomials are nonzero by the actual odd-order triple poles at their respective Weierstrass Ri; pure even functions of z cannot supply them. The ordinary pole argument also retains all local boundaries: at a single coordinate the canceled opposite sheet forces BOTH odd residues nonzero, while at a paired coordinate the SAME nonzero calibrated ratios on both sheets exclude a pure-even map against a pure-odd map, whose ratios have opposite signs. If both odd terms vanished, xi would lie in k(z) and [B:Bx] would be even, contrary to its accepted index ONE or THREE. A zero even part is not asserted to make a map constant.

When q=TWO, the degree bound makes b,c constants at g=THREE and kills them for higher g. The two coordinate values a,d would obey a²c=d²c=ρb as well as a³=d³=ρ². Hence a=d, impossible. When q=THREE, deg b,c≤ONE and J=z³−ρ². The polynomial z²c−ρb vanishes at ALL THREE roots, so c=kz,b=kρ with k≠ZERO. Absorb k into Y. The odd q0 identity gives A1=zL,A2=ρL, and the SAME finite-part function is ξ=Y/z².

Since u≥FOUR among THREE degree-TWO fibers, at least one coordinate has TWO conjugate ordinary poles. Their Y values are nonzero and opposite. Their ξ values are therefore opposite and nonzero, contradicting the common ξ0. This excludes every g(B)≥THREE possibility without assuming B=Bx in degree NINE.

## The remaining Weierstrass boundary at degree six

At u=THREE with all Qj Weierstrass, their coordinates are precisely the roots of J=z³−ONE. R1,R2 are also Weierstrass, so g(B)≥TWO. The entire Weierstrass argument in the cited degree-SIX proof uses only that lower bound: Φ=zJH with H nonconstant and disjoint from J. The even parts have only degree-TWO poles at R1,R2, so they are A/z and B with A,B linear. Its exact q0 identities either give H(zc²−b²)=DJ² in the pure-odd boundary or (h²H−J)M=DJ² with M=μJ in the nonzero-even boundary. Both contradict H being disjoint from J and the nonzero odd poles there. The intermediate cases with exactly one zero even part or proportional A,B are excluded directly by the same pole calibration. Thus degree-SIX all-Weierstrass positions are excluded even at genus TWO. This extends the already written calculation's scope, rather than extrapolating a Sidon count.

Consequently every d≥SIX survivor in this sector has only ordinary shared poles and g(B)≤TWO.

## Degree nine forces the rational double cover

Here u=SIX fills ALL THREE degree-TWO z-fibers over z³=ρ². Put J=z³−ρ². The regular finite-part function ξ takes the SAME value ξ0 at all SIX points. Its only poles are R1,R2, each of order at most THREE.

If ξ were constant, then x2=ρx1+ξ0. The ORIGINAL jointly minimal field k(C0)=k(X1)k(X2) would then be k(x1)(y1,y2), of degree at most NINE over k(x1) and hence at most THREE over k(X1). This contradicts d=NINE. This original-field argument does not assume that z descends to Bx.

Thus ξ−ξ0 is nonconstant. Its SIX distinct zeros and pole degree at most SIX force the EXACT divisors
\[
\operatorname{div}(\xi-\xi_0)=\sum_jQ_j-3R_1-3R_2,\qquad
\operatorname{div}(J)=\sum_jQ_j-6R_2.
\]
For f=(ξ−ξ0)/J, div f=THREE R2−THREE R1. Therefore $f^2/z^{-3}$ has divisor ZERO and is a nonzero constant c; equivalently $f^2=c z^{-3}$. It follows that (fz²)²=cz. Over the algebraically closed field this puts √z in B. Since [B:k(z)]=TWO, B=k(√z) is rational. No original source map is replaced by this auxiliary rational quotient.

This proof establishes only the stated bounded restriction. The later [whole one-triple theorem](actual_q0_tensor_one_triple_infinity_exclusion.md) deletes degrees SIX through NINE separately. Multiple-triple-pole and cubic-index-ONE alternatives remain outside these conclusions.

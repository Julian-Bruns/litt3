# Proof: the full degree-twenty extension has no conductor pole fiber

Version1, 3 October2026. [Theorem](../../Theorems/cartier_and_spin/canonical_twenty_split_full_cubic_vertical_infinity_exclusion.md). Fresh independent whole argument review PASS; canonical presentation review pending. No computation is used.

## 1. The exact global extension belongs to the original source

Retain BOTH actual finite étale degree20 maps from the SAME C₀, their actual cubics and all split identities in the statement. The accepted [conic construction](canonical_ten_split_tensor_conic_bundle_exclusion.md) makes C₀ the normalization of the prime Cartier image C⊂S. C avoids the two boundary sections. Actual étaleness and div(t)=H₁−H₂ make every t-pole simple and give x₂ exact pole3 there.

Suppose ENTIRE ρ divides a. The accepted [full-factor boundary](canonical_split_full_cubic_extension_degree_twenty_boundary.md) and [paired cubics](canonical_split_paired_cubic_adjoint_counterterms.md) supply
\[
C\sim10L,\quad R\sim4L,\quad
h=a/ρ\in H⁰(S,O_S(3D+10F_\infty)),\quad h|C₀=y₂,
\]
\[
\mathcal Dh=Gρ,\qquad h³-P(u-1)=γ₂GQ,
\quad G\in k^\times,\quad γ₂\ne0,
\tag{1}
\]
where Q defines the ACTUAL prime C and Dt=v,Du=0,Dv=−3dt⁵. Its individual error is zero. The OTHER actual cubic and its possible error ε₁∈H⁰(2L) remain retained. Assume for contradiction that F∞ is a component of R.

## 2. Global polynomial form and its first infinity coefficients

The complement of D∪F∞ is the smooth affine surface with ring k[t,u,v]/(v²−u²+d(t⁶−1)). The full h is regular there. Its unique reduced polynomial form is
\[
h=\sum_{i=0}^{3}A_i(t)u^i+
v\sum_{i=0}^{2}B_i(t)u^i,
\]
\[
\deg A_i\le10-3i,\qquad\deg B_i\le7-3i.
\tag{2}
\]
Here is the pole verification. At the two boundaries v∼u and v∼−u. If the maximal degree m in u,v exceeds3, the leading coefficients are A_m+B_{m−1} and A_m−B_{m−1}. Pole bound3 at BOTH boundaries forces both to vanish; descending eliminates every degree m>3. At infinity set s=t⁻¹,U=s³u,V=s³v. A highest weighted term restricts to a reduced expression A(U)+VB(U) on U²−V²=d. Since V is quadratic irrational over k(U), this expression cannot vanish identically unless A=B=0. The pole bound10 consequently forces the individual weights in(2). There is no unproved leading cancellation.

Put H=s¹⁰h and write
\[
H=H₀+sH₁+s²H₂+s³H₃+\cdots.
\tag{3}
\]
On the fixed rational infinity conic U²−V²=d, H₀,H₁ have boundary pole bounds3,3, whereas H₂,H₃ have bounds2,2. Indeed a term of coefficient index j in(3) has weight10−j; for j=2,3 its u,v degree is at most2. In particular
\[
H₃=A₀+A₁U+A₂U²+V(B₀+B₁U)
\tag{4}
\]
with constant coefficients. These five functions form the full Laurent space with bounds2,2. The conic relation U²−V²=d(1−s⁶) introduces no correction up through s³.

## 3. A conductor infinity fiber forces a nonzero constant

The scaled field s²𝒟 is regular at infinity. The derivative of s⁻¹⁰ has coefficient10=0, so the infinity restriction of s¹²𝒟h is δH₀, where
\[
δ=-3Uz\partial_z,\quad z=U+V,\quad
U=(z+d/z)/2,\quad V=(z-d/z)/2.
\]
The positive F∞ factor of R and(1) give δH₀=0. Its kernel on the rational conic is k(z⁵), and a fifth-power Laurent function with boundary pole bounds3,3 is constant. Thus H₀=c.

The constant is nonzero. If it were zero, the infinity restriction of the actual cut(1) would be−U¹⁰ and C would contain the auxiliary U=0 points. But every actual infinity branch has s as uniformizer and U=s³(x₂+1) a unit by actual x₂ pole3. These auxiliary points are excluded by the ACTUAL source.

The fixed shifted polynomial has coefficient p₉=[22]≠0:
\[
P(U-1)=U^{10}+p₉U^9+\cdots.
\]
Multiplying the exact cut(1) by s³⁰, its regular local defining function at infinity, up to a nonzero constant, is
\[
\mathcal F=H³-U^{10}-p₉s³U^9+O(s^6).
\tag{5}
\]
Choose a≠0 with a¹⁰=c³. Then
\[
\mathcal F|_{s=0}=c³-U^{10}=(a²-U²)^5.
\tag{6}
\]

## 4. Actual branch multiplicities kill the first two coefficients

If a²≠d, set b²=a²−d, b≠0. Equation(6) has four points U=±a,V=±b, each of fiber intersection multiplicity5. U is a local fiber parameter at each. If a²=d, there are instead two points U=±a,V=0, each of intersection multiplicity10. V is a local parameter there, and U∓a has exact order2.

Every normalization point over infinity is an actual simple t-pole. The order of s on each branch is1, so every branch is smooth and transverse to the fiber. C₀ is the normalization of the prime C, hence these intersection multiplicities are exactly branch counts. The four-point germs have five branches and local multiplicity5 each. The two-point germs have ten branches and local multiplicity10 each. No upper bound on branch count has been inferred from cubic tangent phases.

For a local defining function of multiplicity m in regular coordinates(s,z), its coefficient of sʲ has z-order at least m−j when j<m. In(5) the s coefficient is3c²H₁. Its total zero order is at least16 in the four-point case or18 in the two-point case, against total polar degree at most6. Therefore H₁=0 on the rational conic. The s² coefficient is now3c²H₂. Its total zero order is at least12 or16, against total polar degree at most4. Thus H₂=0.

Each H_j has a unique reduced polynomial representation with v degree≤1. An identically zero H₁ or H₂ is therefore zero in that representation, so it creates no hidden s³ correction. The s³ coefficient is exactly
\[
3c²H₃-p₉U^9.
\tag{7}
\]
It has order at least2 at all four ordinary points, or at least7 at both V=0 points.

## 5. Values and first derivatives cannot match

Put K=p₉/(3c²)≠0 and use(4). In the four-point case the values H₃=KU⁹ at both V signs, for each U sign, force B₀+B₁a=B₀−B₁a=0. Hence B₀=B₁=0. The two remaining values give
\[
A₁=Ka^8,\qquad A₀=-A₂a².
\tag{8}
\]
The order-two matching also gives first U derivatives because U is a local parameter. Since9=4 in characteristic5,
\[
A₁+2A₂a=4Ka^8,\qquad A₁-2A₂a=4Ka^8.
\tag{9}
\]
Subtracting gives A₂=0, then A₁=4Ka⁸, contradicting(8). The difference3Ka⁸ is nonzero.

In the two-point case V is the parameter and U=±a+O(V²), with nonzero quadratic coefficient because U²=d+V² and a≠0. The order-seven matching forces the V coefficient of V(B₀+B₁U) to vanish at BOTH U signs, again giving B₀=B₁=0. The constant and V² coefficients then impose precisely the values and first-U-derivative equalities(8)–(9). Their contradiction is unchanged. This treats the ramified U-coordinate case in V coordinates.

Both configurations contradict p₉≠0. Hence F∞ is absent from R under a full a factor.

## 6. The actual first-leg swap and exact scope

For a full b factor, use the ACTUAL endpoint swap τ=t⁻¹,u₁=v/t³,v₁=u/t³. Its conic is u₁²−v₁²=d(τ⁶−1) and its pole fiber is the original F₀. The accepted full-factor proof gives the exact frame transport Ωτ=−t⁻²Ωt and rational adjoint factor t¹⁸ up to scalar. It preserves the SAME effective conductor divisor and full individual-factor condition. The first actual endpoint still has the same shifted p₉≠0 and simple infinity poles by actual étaleness. Applying Sections1–5 in these swapped actual coordinates excludes F₀⊂R.

The fully extending single-leg degree-twenty sector with its pole fiber absent remains open. The proof does not imply a full factor for the other cubic or vanishing of its possible error. No simultaneous-factor exclusion is claimed: the first polynomial's infinity restriction is the ENTIRE P(V−1), not merely V¹⁰. BOTH original actual finite étale endpoint maps remain on their SAME source, and the original unmarked common-cover problem remains unsolved.

[Fresh whole argument audit](../../Research/notes/oct03_ten_hour/split_twenty_full_extension_vertical_infinity_audit.md). [Research note, including the exact first-leg compatibility and rejected simultaneous-factor shortcut](../../Research/notes/oct03_ten_hour/split_twenty_full_extension_actual_geometry.md).


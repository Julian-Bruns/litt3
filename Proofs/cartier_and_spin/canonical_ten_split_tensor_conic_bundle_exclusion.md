# Proof: the actual joint curve on a six-fiber conic bundle

Version1, 3 October2026. [Independent whole review PASS](../../Research/notes/oct03_ten_hour/split_integral_spin_aux.md), including the common-infinity strengthening. See the [statement](../../Theorems/cartier_and_spin/canonical_ten_split_tensor_conic_bundle_exclusion.md). Both actual étale maps remain on C₀; the original source T and its other endpoint map remain retained inputs.

Write ξᵢ=xᵢ+ONE, so q₀(xᵢ)=ξᵢ²+d. The exact actual-map identity is
\[
ξ₂^2-t^6ξ₁^2=d(t^6-1).
\]
It places the actual field in a fixed smooth projective conic bundle π:S→P¹_t. The two affine base charts have equations
\[
u^2-v^2=d(t^6-1)w^2,
\qquad U^2-V^2=d(1-s^6)W^2,
\]
where s=t⁻¹, [U:V:W]=[s³u:s³v:w] on the overlap. This gluing is the projective compactification of two copies of the line bundle O(THREE) over P¹ with their common homogenizing coordinate. The image of C₀ is given on the first chart by [u:v:w]=[ξ₂:t³ξ₁:ONE], and on the second by [U:V:W]=[t⁻³ξ₂:ξ₁:ONE].

## 1. Surface geometry

There are SIX singular conic fibers, over t⁶=ONE. Their parameters are distinct since SIX is nonzero in characteristicFIVE. At the conic node u=v=ZERO,w=ONE, the t-derivative of the defining equation is a unit. Thus the TOTAL surface is smooth there. At w=ZERO at least one u or v derivative is nonzero, and all other points are also smooth. The infinity base fiber is smooth by its second equation. Hence S is a smooth projective surface.

Let D₊ and D₋ be its two disjoint sections w=ZERO,u=±v, and let F be the numerical fiber class. Set D=D₊+D₋. We have
\[
D₊^2=D₋^2=-THREE,\qquad D₊D₋=ZERO,
\qquad D F=TWO,\qquad F^2=ZERO.
\]
For the section self-intersection, near D₊ the fiber-normal coordinate is h=w/u; on the other base chart it becomes W/U=t³h. This is the transition of its normal line O(−THREE). The same calculation applies to D₋.

The canonical class is
\[
K_S=-D-TWO F.
\]
One can check this without any projective-bundle sign convention. On the affine conic write A=u+v,B=u−v, so AB=d(t⁶−ONE). The rational two-form Ω=dt∧dA/A has a simple pole at each of D₊,D₋. At a singular conic fiber, dt is a unit multiple of B dA+A dB, so Ω is a regular nonzero multiple of dB∧dA, including at the node. There is no vertical divisor there. On the second base chart A∞=s³A, and
\[
Ω=-s^{-2}ds\wedge dA_\infty/A_\infty.
\]
Thus its only additional divisor is minusTWO times the infinity base fiber, proving the displayed canonical class.

The class L=D+THREE F satisfies
\[
L^2=SIX>ZERO.
\]

## 2. The actual image and its boundary intersections

Let J=min(H₁,H₂), Dᵢ=Hᵢ−J and n=r−c. The nonconstant t-map has degree n. Away from H₁∪H₂, the displayed projective coordinates are regular. At D₁ the zero of t is simple and ξ₁ has pole orderTHREE, so t³ξ₁ is regular and ξ₂ is finite. At D₂ use the second base chart: t⁻³ξ₂ is regular and ξ₁ is finite. The morphism therefore avoids D at both kinds of noncommon infinity point.

At a point of J, t is a unit and BOTH ξᵢ have poles of exact orderTHREE. Clearing that common pole extends the projective morphism. Its w-coordinate then has exact zero orderTHREE, while u and v are units. The leading exact relation gives u=±v on w=ZERO. Since D₊ and D₋ are disjoint, the pulled boundary divisor is precisely
\[
f^*D=THREE J.
\]
This proves that the rational map extends everywhere to a morphism f:C₀→S.

Let C=f(C₀) be the integral image. The image function field is k(t,ξ₁,ξ₂), which is k(C₀) by the ACTUAL field-generation hypothesis. Thus f is birational onto C and C₀ is its normalization. In particular
\[
C F=n,\qquad C D=THREE c,
\qquad C L=THREE r,\qquad K_S C=-TWO r-c.
\]
The boundary computation uses pullback to the normalization and remains valid if the image has several branches at one surface point.

## 3. Hodge index and genus

On a smooth projective surface the intersection pairing is negative semidefinite on the orthogonal complement of any numerical class of positive square. Apply it to L. Since L²=SIX and C L=THREE r,
\[
C^2\le \frac{(C L)^2}{L^2}=\frac32r^2.
\]
Adjunction for the integral Cartier divisor C and the normalization inequality give
\[
g(C₀)\le p_a(C)
=ONE+\frac{C^2+K_S C}{TWO}
\le ONE+\frac34r^2-r-\frac12c.
\]
On the other hand, either actual étale map C₀→X gives g(C₀)=EIGHT r+ONE. Combining the two bounds yields
\[
ZERO\le \frac34r(r-TWELVE)-\frac12c.
\]
This is impossible for ONE≤r≤ELEVEN.

For the specified split degreeTEN bridge, c=ZERO and the actual field equality follows immediately from k(C₀)=k(x₁,x₂,z), z=t², t∈k(C₀). The upper bound is SIXTY-SIX and the required genus is EIGHTY-ONE. This contradiction closes that entire split configuration. No ramification cancellation on Γ and no square root of its canonical bundle is used.

## 4. Exact boundary of the new argument

At r=TWELVE the inequality forces c=ZERO and all inequalities to be equality. It then requires a smooth image C numerically equivalent to SIX L; this numerical configuration alone is not excluded. For larger r the genus bound alone need not contradict étaleness. The actual cubic-indexTHREE alternative and nonsplit square-root cases are outside this proof. Therefore this result is a scoped geometric closure, not an all-degree tensor recognition or original unmarked common-cover solution.

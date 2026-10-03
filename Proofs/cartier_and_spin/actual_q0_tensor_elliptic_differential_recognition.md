# Proof: all-degree q0-tensor recognition with the elliptic differential line

Version1,3 October2026. [Independent whole-scope review PASS](../../Research/audits/Q0_ROOT_STABILIZER_AND_PETRI_RECOGNITION_AUDIT_2026_10_03.md). The source construction is [the actual exact-root bridge](actual_q0_tensor_exact_root_self_span.md). Fixed-X automorphisms and q0 are settled inputs. The new critical-value algebra below is a bounded exact computation, not a replay of the fixed-X arithmetic or a correspondence search.

## 1. Exact critical-value gate for R0

Use a²=a+3 over F25, encoding c+5d as c+da. The ascending coefficients of P and q0 are
\[
P=(11,22,18,5,19,20,15,16,9,22,1),
\qquad q0=(24,2,1).
\]
The new [tiny source](../../scripts/genus_two/oct03_q0_critical_value_gate.py) performs direct univariate extended gcds and eight modular multiplications. It proves
\[
\gcd(P′,P″)=\gcd(P′,P)=\gcd(P′,q0)=1.
\]
Thus P′ has eight distinct roots, all outside Pq0=0. In the reduced algebra A=F25[x]/(P′), the EIGHT columns1,R0,…,R0⁷ have determinant THREE. After extension to the algebraic closure this algebra is k⁸ and R0 acts by its eight critical values. The determinant is their Vandermonde determinant up to the invertible coefficient-to-evaluation matrix. Therefore those values are all distinct. They are finite and nonzero by the two other gcds.

All three Bezout identities are guarded by direct multiplication. The [small exact receipt](../../../litt3-computation-data/oct03_q0_critical_value_gate/critical_algebra.json) contains the Bezout coefficients, the representative of R0 in A, the complete8×8 power matrix, and its nonzero determinant. No factorization, resultant, Gröbner calculation or large finite search is used.

The derivative is R0′=−q0⁵P′/P². At each q0 root the local index is FIVE and the different is FIVE, since P′ is a unit there. At each P′ root the local index is TWO and the different is ONE; its value is shared with no other critical point. The P-roots are simple poles, hence unramified on the x-line. At x=∞ one has R0=1−P9/x+O(x^-2), with P9=22≠0, so infinity is also unramified. These contributions total2·5+8=18=2·10−2, and there are no other branch points. In particular each of the eight critical values has x-fiber profile(2,1⁸).

## 2. Indecomposability and S10 monodromy

The degree-ten separating rational map cannot decompose nontrivially. By Lüroth, its only possible factor degrees are2 and5, in either order.

If its inner factor had degree FIVE and its outer factor degree TWO, the zero fiber of the outer map would have two distinct simple points: an outer index TWO would be incompatible with the original odd index FIVE. Each of those points would have a single preimage under the degree-five inner map, with index FIVE. Each contributes different at least FIVE, contradicting Hurwitz's total different EIGHT for a separating degree-five map P1→P1.

If the inner factor had degree TWO and the outer factor degree FIVE, every singleton simple critical value of the composite would have to come from one of the TWO ramification points of the inner map. Indeed outer ramification with index TWO would give either two ramified preimages of index TWO or one of index FOUR; larger outer indices cannot give the profile(2,1⁸). Consequently such a composite has at most TWO singleton simple critical values, whereas R0 has EIGHT. This excludes the other factor order.

Its transitive degree-ten monodromy is therefore primitive, and one singleton simple branch supplies a transposition. The graph of all conjugates of that transposition has monodromy-invariant connected components. Primitivity forces the graph to be connected; its edge transpositions generate S10. Thus the geometric monodromy is exactly S10. This argument allows the monodromy order to be divisible by FIVE.

## 3. The elliptic differential gives the original-field core

On X′,
\[
\frac{η^3}{λ^3}=\frac{q0^{10}}{P^2}=R0^2.
\]
The constructed lifts already have proportional η. The additional proportionality of λ therefore gives R0(x1)=cR0(x2) for a constant c∈k×. Both functions lie in the ORIGINAL fields on S; no auxiliary-field equality is substituted.

The scalar is ONE. The map X→B through R0 has index THREE at the original infinity point over the finite value ONE. Its other index-three points are exactly the ten P-root points over B=∞. At finite ordinary points its possible indices are ONE, TWO and FIVE, as Section1 proves. Choose a source point above the first original infinity. Étaleness of h1 gives index THREE for R0(x1). The equality R0(x1)=cR0(x2), together with étaleness of h2, forces the second target point also to have index THREE over a finite value. It must therefore be its original infinity, where R0=1. Hence c=1.

## 4. Every different-coordinate component is ramified

Consider the actual image of S in X×B X and its smooth normalization C. Both projections C→X are finite étale: they are intermediate maps in the original étale towers S→C→X, and the local different formula has nonnegative terms. The two original maps and their source S are retained.

The x-line fiber product has exactly the diagonal and ONE off-diagonal component, because S10 is two-transitive. Suppose the two x-functions differ. Then C maps onto that off-diagonal component. Choose any singleton simple critical value and a point there having first x-coordinate an ordinary unramified sheet and second x-coordinate the ramified sheet. Choose the first sheet finite and outside the P-roots; even if the critical value is ONE, several such sheets exist. This point belongs to the off-diagonal component, whose normalization has index TWO over its first x-line at that point: it is the local fiber product of an unramified branch with a tame quadratic branch.

The first X→x-line map is unramified at the selected ordinary finite x-point. Every point of C above the chosen off-diagonal point thus has index divisible by TWO over its first X-target, by ramification transitivity. Surjectivity supplies such points. This contradicts the étaleness of C→X. Consequently the x-functions are equal. The y-functions then differ by a constant cube root of unity, giving h2=γh1.

This recognizes the ORIGINAL X-fields at every degree under the stated λ-line hypothesis, including when the actual elliptic joint field has higher genus. The proof does not establish that hypothesis from η alone. The exact-root source still ramifies over S and over any original Y-leg; it was used only to state and transport the extra differential marking.

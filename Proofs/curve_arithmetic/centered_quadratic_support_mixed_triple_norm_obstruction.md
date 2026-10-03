# Proof: incompatible Frobenius periods in the mixed third norm

Version1, 3 October2026. [Fresh independent four-check whole static review PASS](../../Research/audits/OCT03_MIXED_CENTER_QUADRATIC_ZERO_THIRD_NORM_FROBENIUS_WHOLE_AUDIT_2026_10_03.md), with no correction. See the [statement](../../Theorems/curve_arithmetic/centered_quadratic_support_mixed_triple_norm_obstruction.md).

## 1. All six quadratic-zero points are F625-rational

Use β²=β+3, d0=3−β, d0²=2 and d0⁵=−d0. The centered polynomial p has ascending coefficients[8,3,21,23,22,12,22,21,1,22,1], with [a+5b]=a+bβ. Its exact remainder modulo q=U²+d0 is
\[
p(U)\equiv d_0+2-(1+d_0)U\pmod q.
\]
This is the fixed coefficient identity already used in the accepted critical-point arguments; no polynomial calculation is replayed.

Let α²=−d0. Then α⁴=2, α⁸=−1, and α²⁴=−1, so α²⁵=−α and α⁶²⁵=α. The two roots±α belong to F625. They are nonzero. Put c=d0+2 and l=1+d0. Their p-values have product
\[
p(\alpha)p(-\alpha)=c^2+d_0l^2=2d_0\ne0.
\]
Indeed c²=1+4d0 and l²=3+2d0, giving c²+d0l²=2d0. Since all coefficients lie in F25 and α²⁵=−α,
\[
p(\alpha)^{26}=2d_0,\qquad
p(\alpha)^{208}=(2d_0)^8=1.
\]
The multiplicative group F625× has order624; an element is a cube exactly when its208th power is one. Thus p(α) and p(−α) are cubes in F625. All cube roots of unity are already in F25, so ALL three y-values at EACH root±α are in F625. These six points are ordinary and are fixed individually by625-Frobenius.

## 2. Six times a centered Abel class has exact Frobenius period three

Put p0=p(0)=3+β and ζ=p0⁸=3+3β, a nontrivial cube root of unity. Choose y0³=p0 and centered points Ti=(0,ζ^i y0). The endpoint deck σ(U,y)=(U,ζy) fixes O and rotates Ti. Let F be25-Frobenius on geometric Jacobian points. Since y0²⁵=y0p0⁸,
\[
F[T_i-O]=\sigma[T_i-O],\qquad
(1+\sigma+\sigma^2)[T_i-O]=0.
\]
The second relation is the principal divisor of U. It implies the same relations on every integer multiple of v=[Ti−O].

The settled [fixed-pair real Frobenius polynomial](fixed_pair_arithmetic.md),
\[
Q(V)=V^9-2V^8-254V^7+457V^6+21826V^5-29834V^4
-703917V^3+354810V^2+6210225V+6613875,
\]
has characteristic polynomial T⁹Q(T+25/T). Frobenius is bijective on geometric points, so cancellation of F⁹ gives on the centered cyclic module
\[
Q(F+25F^{-1})=Q(\sigma+25\sigma^2)=Q(-25-24\sigma)=0.
\]
Modulo two the displayed integer polynomial Q is V⁹+V⁶+V³+V+1, and −25−24s≡1. Hence
\[
Q(-25-24s)=1+2R(s)
\]
for an integer polynomial R. This equality says that every centered-module element killed by two is zero: if2x=0 and Q(-25−24σ)x=0, then x+2R(σ)x=x=0.

Now suppose w=6v were fixed by F², which is625-Frobenius. On this module F²=σ², so σ²w=w. Multiplying by σ gives σw=w. The principal-divisor relation then yields3w=0, or18v=0. The element x=9v is killed by two, so the preceding Frobenius identity forces9v=0.

But L(9O)=span{1,U,U²,U³}, by the fixed pole semigroup⟨3,10⟩. A function of divisor9Ti−9O would be a polynomial of degree three in U. Any nonconstant polynomial vanishing at Ti also vanishes at the OTHER two points over U=0; it cannot have Ti as its sole zero. This contradiction proves that6v is not F²-fixed. Since F³w=σ³w=w, its Frobenius orbit has exactly three elements. No point-count, torsion-order calculation or numerical certificate is used here.

## 3. The mixed divisor and the actual single-fold fiber

For E=2T+E_q as in the statement, put D_q=[E_q−8O]. Section1 gives F²D_q=D_q. If3E~30O, then
\[
6[T-O]+3D_q=0.
\]
Its right side would make6[T−O] fixed by F², contrary to §2. This excludes EVERY repeated q-zero support in the mixed divisor.

For the conditional source application, retain BOTH actual degree25 finite étale maps h1,h2:C0→X and the actual π:C0→Q degree10, with Q/z degree3, phaseκ³=1 and two full common critical fibers. At the remaining critical γ, assume Q/z has fiber3R and π above R has one fold. There is one source point P of z-index SIX and eight points Pj of index THREE. The accepted [three/six classification](../../Theorems/cartier_and_spin/finite_exact_phase_critical_three_six_classification.md) makes h2(P) a centered T and every h2(Pj) a q-zero point. Since the source divisor is
\[
\operatorname{div}_{C_0}(z-\gamma)=6P+3\sum_{j=1}^8P_j-2D_2,
\]
its ACTUAL endpoint norm along h2 has divisor3E−30O, where E=2T+Σh2(Pj). All D2 points map to O, and degD2=15. This contradicts the mixed divisor obstruction. The other original étale leg remains on the same C0; no map is descended to Q and no source replacement is made.

The [centered norm obstruction](centered_sixfold_norm_obstruction.md) separately removes the uniform-quadratic third fiber. Thus the third3R branch, when present, must have π unramified and ten q-zero endpoint images. The third Q/z profiles1+1+1 or2+1, the ten-q-zero norm itself, and the global companion conditions have not been excluded by this proof.

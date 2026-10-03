# Proof: the finite companions supply exactly the missing conic poles

Version1, 3 October2026. [Fresh independent eight-check whole review PASS](../../Research/audits/OCT03_THREE_TEN_BLOCKS_DEGREE_THIRTY_COMPANION_PARITY_WHOLE_AUDIT_2026_10_03.md), with no required mathematical corrections and two wording clarifications applied. See the [statement](../../Theorems/cartier_and_spin/canonical_ten_three_blocks_degree_thirty_companion_parity.md). The discovery and formal surviving local models are preserved in the [research note](../../Research/notes/oct03_ten_hour/three_ten_blocks_higher_overlap.md).

## Actual fields and full-fiber norm calibration

All maps and functions stay on their original sources. The accepted [small residual reduction](canonical_ten_nonsplit_small_residual_all_degree_block_reduction.md) produces the actual σ-stable R⊂B′∩Γ, Q=Rσ and whole degree-ten S10 map π:C0→Q, with Q/z of degree three. In the specified d30 ratio-one case, div(z)=2D1−2D2, degD_i15, and all fifteen common infinity points form THREE full quadratic π-fibers. Each has source z-index four and lies over a critical value α_i³1. Thus Q/z has fiber 2A_i+B_i, with B_i unramified over the z-line, and
\[
\operatorname{div}_{C_0}(z^3-1)
=4J+\sum_{i=1}^3\pi^*B_i-6D_2.
\]
The finite term is essential and has degree thirty.

The accepted [full-fiber norm calibration](../shared_tensors/common_infinity_norm_pole_gap.md) applies separately to each critical fiber and to BOTH actual endpoint maps. For h2, Norm(z−α_i) has only pole O of exact order30−20=10. For h1, use Norm((z−α_i)/z); its poles are on D1 and give the same exact order ten. Their finite zero divisors are respectively (h2)_*π*B_i and(h1)_*π*B_i, both of degree ten. These actual fiber classes are 10O. The settled two-torsion and low-pole fixed-X obstructions eliminate uniform indices2,5,10 at B_i, leaving an unramified fiber or the unique single fold. No vanishing of a Picard family and no Hom vanishing is needed.

Since L_X(10O)=〈1,x,x²,x³,y〉, each norm has form a y+g(x), deg g≤3, with a≠0: a polynomial in x alone has pole at most nine. After division by a, express the cubics in the centered variable as G_i and H_i. The norm of y+G_i(U) along X→P1_U is p(U)+G_i(U)³. Consequently the roots of F_i=p+G_i³, with their multiplicities, are EXACTLY the centered-x pushforward of the actual degree-ten endpoint zero divisor. The same holds for K_i. Pushforward of point cycles over an algebraically closed field does not multiply by the trigonal ramification index.

At every source point of π*B_i, the actual identity gives B²=A². The two weighted centered-square pushforwards therefore agree. Taking the monic quadratic norms gives
\[
F_i(U)F_i(-U)=K_i(U)K_i(-U).
\]
At U0 a root of multiplicity r contributes U^(2r) to this displayed identity; it still has weight r in the square-coordinate divisor. This convention avoids double-counting the fold at a center.

## Exact factor swaps

Fix one i, let S=gcd(F,K) monic and write F=SC,K=SD. Both F,K are monic of degree ten, so degC=degD=m. For a monic polynomial E define E*=(-1)^degE E(−U). The quadratic-norm identity cancels SS* and gives CC*=DD*. Since gcd(C,D)=1, C divides D*. Their equal degrees and monicity give D=C*. Therefore gcd(C,C*)=1. This proves all factor-swap assertions, including repeated roots. If U divided C, it would divide C* too; hence every centered root is part of S.

## Exhaustive finite companion types

The source z-index k at a companion point equals its π-weight and is one or two, because B_i is unramified over the z-line. Étaleness of the endpoint maps makes an ordinary centered coordinate an actual source parameter. At a trigonal branch, its variation has order three.

There are no companion q-zero points. At a diagonal q-zero, let u=A−a and w=B−A, where a²=−d0 and p(a)≠0. The q-ratio has limit one, so B′(0)=1. The original cubed theta relation forces leading phase one. Writing ordw=n>1 gives k=n−1 from q(B)−q(A)=2Aw+w². Comparison of the leading u^(n−1) terms gives n≡4 mod5. Thus k≡3 mod5 and cannot be one or two. At an anti-diagonal q-zero, the q-ratio instead gives B′(0)=−1; the cubed theta relation requires p(a)²+p(−a)²0. The fixed remainder p(U)=d0+2−(1+d0)U modulo q gives
\[
p(a)^2+p(-a)^2=2(d_0+2)=3\beta\ne0.
\]
This is impossible.

At a noncenter ordinary diagonal with q-unit, choose u=A−a and w=B−A. If k2, then ordw2 and B′=1+cu+⋯ with c≠0. The cubed theta equation, however, has right side1+O(u²), since both p(B)/p(A)−1 and z24−1 have order at least two. Its nonzero linear derivative term is a contradiction. Therefore such a diagonal point is unramified, with weight one. It may have a nontrivial cube-root derivative slope at k1; this case is retained.

At a center A=B=0, p0 and q0 are units. Both centered coordinates have order one. The cubed theta equation gives their leading slope λ³1. If λ1, B−A has order at least two and q(B)−q(A) has order at least three, incompatible with k≤2. Therefore λ is a nontrivial cube root, k2, and the point is the companion's unique fold. Its denominator A+B has order one because λ≠−1.

Both endpoints cannot be trigonal branches: at a diagonal branch the q-difference has order at least three, and the accepted fixed branch roots have no opposite centered pair. The latter fact is recorded with an exact three-coordinate hand check in the [all-phase critical-value proof](finite_uniform_wild_critical_value_exclusion.md); no numerical replay is used here. If exactly one endpoint is a trigonal branch, its opposite ordinary endpoint has q-variation of order one, while the branch variation has order three. Thus it is noncenter anti-diagonal, q is a unit, and k1. Ordinary noncenter anti-diagonal points of weight one or two remain. These cases exhaust π*B_i.

Write D,A_w,F_c for the counts in the statement. The total π-weight of the three companions is thirty, so
\[
D+A_w+2F_c=30.
\]
At most one fold per companion implies F_c≤3.

## Exact global conic pole divisor and parity

Define on the SAME C0
\[
F_0=\frac{B-A}{z^3-1}=\frac{A^2+d_0}{A+B},\qquad
H_0=F_0-A=\frac{d_0-AB}{A+B}.
\]
Direct use of the q-identity gives H0²+d0=z³F0². The original common-infinity leading ratio is ONE, so H0 has exact pole order three at each of the fifteen points of J. At D1,D2 it is regular: one centered coordinate has a triple pole while the other is finite, and the numerator/denominator quotient has finite limit. At a finite point with z³≠1, the first expression for F0 proves regularity. Thus any other pole is in a companion fiber.

At a noncenter diagonal companion point A+B has nonzero value, so H0 is regular. At a noncenter anti-diagonal point, q(A) and B−A are units. The identity
\[
(B-A)(B+A)=(z^3-1)q(A)
\]
makes ord(A+B)=k. The numerator has value q(A)≠0, so the pole order of H0 is its π-weight k. At a center, A+B has a simple zero and the numerator has nonzero value d0; the pole order is ONE. Therefore
\[
\deg(H_0)=45+A_w+F_c.
\]
This exhausts the poles, including possible q-zero cancellation away from the critical fibers. The common poles make H0 nonconstant.

Since divz is even, div(H0²+d0) is even. Choose a∈k with a²=−d0; a≠0. The zero supports of H0−a and H0+a are disjoint, and every zero multiplicity of either is even. Their common zero degree equals the pole degree of H0, even if H0 is inseparable. Hence degH0 is even and
\[
A_w+F_c\equiv1\pmod2.
\]
Together with the weight count, this also gives D+F_c odd.

## Polynomial form and centered cubic constraints

For a nonzero unordered pair{a,−a}, let r,s be its multiplicities in F_i, and r′,s′ those in K_i. Their sums agree. Let a_+,a_- be the actual total π-weights transported from a to−a and from−a to a by the SAME source points. Then
\[
a_+-a_-=r-r',\qquad
a_++a_-\equiv r-r'\pmod2.
\]
The contribution of this unordered pair to degC_i is |r−r′|, because S_i removes the common multiplicities at both roots and r+s=r′+s′. Summing over all nonzero pairs gives A_w≡Σm_i mod2. Centered roots contribute nothing to m_i. Thus Σm_i+F_c is odd.

A center is a single folded source point with π-weight two. There is no other center in that companion, since all centers would be folds. Its centered-x pushforward polynomial therefore has root U0 of EXACT order two. For F=p+G³ this gives F0=F′0=0 and G0≠0, hence the two cubic conditions in the statement. Its second Hasse derivative is nonzero by the exact root multiplicity, although no explicit second-derivative formula is needed here.

The resulting parity eliminates the all-unramified triple of trivial identities F_i=K_i, and the all-anti noncenter triple, whose total anti weight is thirty. It leaves odd mixed swaps or centered folds. A single unramified all-diagonal companion has genuine formal local models with nontrivial cubic derivative phases, as explained in the research note; it is not ruled out by finite-wild exclusions. Neither local models nor the remaining polynomial alternatives are asserted to globalize. The original common-cover problem remains unresolved.

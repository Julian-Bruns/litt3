# Proof: the original third jet makes common boundary graphs agree to order three

Version2, 3 October2026. [Fresh independent six-check major changed-scope review PASS](../../Research/audits/OCT03_THREE_TEN_BLOCKS_OTHER_PHASE_SHARED_CUBIC_CONIC_MAJOR_AUDIT_2026_10_03.md), with no correction. The negative-phase refinement has [fresh independent four-check extension review PASS](../../Research/audits/OCT03_NEGATIVE_PHASE_THREE_BLOCK_NODE_VARIANCE_STATIC_EXTENSION_AUDIT_2026_10_03.md).  The negative-degree35 finite-companion refinement has [fresh independent four-check review PASS](../../Research/audits/OCT03_NEGATIVE_PHASE_THIRTY_FIVE_OPPOSITE_COMPANIONS_STATIC_EXTENSION_AUDIT_2026_10_03.md). See the [statement](../../Theorems/cartier_and_spin/canonical_ten_three_blocks_other_phase_shared_cubic_conic_bound.md).

The original full-block fields, all-phase tame ledger, common globalρ and source-index-three statement are accepted. The ruled resolution and general class calculation are the same ACTUAL geometry as in [the phase-one conic proof, §§1–2](canonical_ten_three_blocks_exact_phase_full_common_conic_exclusion.md). This proof checks the NEW other-phase branches and their shared cubic coefficient; the stronger full-fiber allocation of that proof is not imported.

## 1. The original conic and its general numerical bound

Use ORIGINAL A=x1+1 and B=x2+1. Then
\[
B^2-t^6A^2=d_0(t^6-1)
\]
holds for ANYρ. Scaling A byρ would change this equation and is not done. The actual E=C0(t) has genus16d+1, two actual étale composed X-legs, k(E)=k(t,x1,x2) and degree ten over R. Its conic image C is birational to E and its normalization is E.

On the smooth resolution over R, t has degree three. The ruled negative section B0 has self-intersection−9; resolving ab=d0(t⁶−1) uses eighteen TOTAL blowup centers counted with multiplicity. The infinity sections are D−=B0 and D+=B0+9f−ΣEi, where f is the fiber and Ei are total-transform classes, Ei²−1 and Ei·Ej0 fori≠j. Every common point has normal order three, and the two t-signs put exactly c E-points on each section regardless ofρ. Thus C·D±=3c. Residual infinity points remain affine in the twisted charts.

As in the phase-one calculation, with ai=C·Ei≥0,
\[
C\equiv10B_0+(3c+90)f-\sum a_iE_i,\quad\sum a_i=90,
\]
and
\[
C^2=900+60c-\sum a_i^2\le450+60c,
\qquad K_S\cdot C=20g(R)-20-6c.
\]
The inequality uses only Cauchy, Σai²≥90²/18=450. No allocation of blowups at any common value is required, including whenρ=−1 puts those values at conic nodes.

## 2. The common branches are smooth over R

The accepted original infinity jet gives source z-index EXACTLY three whenρ≠1. At a common point, the original individual infinity sections exclude the nonuniform π-fold, and the uniform ramified π-indices2,5,10 cannot divide three. Hence the common point is π-unramified and Q/z has index three. This does NOT presume that the rest of that π-fiber is unramified; a folded finite point remains allowed wherever not separately excluded.

Since Q/z has total degree three, each contributing common z-value has only ONE Q-point. Its two R-lifts are unramified over Q, because z is a unit. On each lift the ki common E-points give distinct image branches at its single infinity-section point. Every common branch is unramified over R and has boundary order three: in local coordinates(s,v), s is an R-parameter and v=1/A is a regular normal coordinate, so the orders are(1,3). The branch is therefore a smooth graph v=fi(s). The two t-lifts lie over different R-values; all such common surface points are distinct.

## 3. Their cubic graph coefficient is the SAME

The accepted original third tensor coefficient, explicitly extracted with its unrestricted LOCAL scope in [the low-quotient-genus proof](canonical_ten_residual_twenty_low_quotient_genus_exclusion.md), gives
\[
\Delta=B-\rho A\text{ regular},\qquad
\Delta(P)=a_0(\rho-1),\qquad a_0=-2p_9\ne0.
\]
This identity uses the two original étale X-legs, triple poles and fixed monic p9, not a quotient-genus bound or an index-three field assumption. The sameρ and a0 apply to EVERY common point.

Let e0=z³−ρ² be the SAME pullback function on R. The exact quadratic identity, with v=1/A, is
\[
e_0=\frac{2\rho\Delta v+
\bigl(\Delta^2+d_0(1-\rho^2)\bigr)v^2}{1+d_0v^2}.
\]
At a common branch, v has order three and Δ−a0(ρ−1) has order at least one. All constantsρ,a0,ρ−1 are nonzero. Therefore
\[
v-\frac{e_0}{2\rho a_0(\rho-1)}
\text{ has order at least FOUR.}
\]
Because the branch is unramified over R, its actual source uniformizer differs from s by a unit. Each graph fi(s) agrees with the identical R-function e0/[2ρa0(ρ−1)] through its cubic term. Two DISTINCT graphs therefore have intersection multiplicity ords(fi−fj)≥4. No fifth-order agreement is presumed: the next coefficient can differ.

Each common branch itself is smooth. The normalization defect at a lifted surface point is at least4·binomial(ki,2). Summing over both lifts of all three common values gives
\[
\delta_{\rm common}\ge4\sum_i k_i(k_i-1).
\]
There is no extra assumption on other finite fibers or singularities; their defects are nonnegative.

## 4. Genus inequality and the remaining degrees

Adjunction and normalization give
\[
16d+1=g(E)\le216+27c+10g(R)-4\sum_i k_i(k_i-1).
\]
The accepted ACTUAL whole-field Hurwitz bound, valid in every phase, is g(R)≤4d/5+1. It also follows from the tame π-ledger N=8d/5+4−4g(Q), N≥a for the a fixed R/Q points, and g(R)=2g(Q)−1+a/2. This use retains the actual quotient and both original endpoint maps.

Substituting d=c+15 gives
\[
4\sum_i k_i(k_i-1)\le105+19c.
\]
For d45,c30 every ki=10, so its left side1080 exceeds675. For d40,c25 the minimal sum is attained at the balanced partition(9,8,8), where Σki(ki−1)=184; its left side736 exceeds580. Hence both degrees are excluded.

For d35,c20 the sum must be at most121. A largest part at least ten gives minimum130 at(10,5,5); a largest part nine gives minimum122 at(9,6,5). With largest part eight, (8,8,4) gives124 and is excluded, while(8,7,5),(8,6,6) give118and116. With largest part seven only(7,7,6) is possible, giving114. Thus precisely those three sorted partitions remain under this necessary bound.

For d30,c15, any part ten gives minimum98 at(10,3,2), whose left side392 exceeds390. Thus every part is at most nine. For d25,c10, (10,0,0) gives left side360 exceeding295 and is excluded. No deletion of the other degree25/30 partitions is claimed.

The independently accepted all-phase divisibility5|d and previous common-degree/genus reductions leave only d25,30,35 in theρ≠1 three-ten-block sector after this proof. They remain unresolved. Both original maps stay finite étale on their SAME source, and the conic/quotient curves are auxiliary geometric images rather than substituted endpoint sources.

## 5. The negative phase forces an additional node variance

Specialize toρ=−1. Only the node allocation penalty below is new; §§1–4 and their six-check major audit remain the Version1 inputs. The registered Version1 [statement snapshot](../../Research/history/three_blocks_other_phase_conic_bound_version1_statement.md) and [proof snapshot](../../Research/history/three_blocks_other_phase_conic_bound_version1_proof.md) preserve its mathematical body; its original audit evidence is retained.

### Partial ends

Specialize ONLY toρ=κ³=−1. The common critical z-values satisfy z³=1. At every contributing value, the previously established source index three and common π-unramifiedness force Q/z index three. Thus its two R-lifts have R/t index THREE. Each lifts to a conic node resolved by a chain of THREE blowups, with total-transform multiplicities a1,a2,a3. One lift contains ki common smooth branches on D+, the other the same ki on D−. Their actual base orders are one; the normal boundary order is three. Finite points elsewhere in the π-fiber remain permitted and are not classified here.

On the D+ lift the last end component E3 meets C with at least ki. The intermediate strict components are E1−E2 and E2−E3 and have nonnegative intersections with the horizontal irreducible C. Hence
\[
a_1\ge a_2\ge a_3\ge k_i.
\]
On the D− lift, the negative end component has class f−E1 and its intersection with C is10−a1≥ki. The same intermediate inequalities then give
\[
10-k_i\ge a_1\ge a_2\ge a_3\ge0.
\]
These are LOWER/UPPER bounds on each of the three entries, not a presumption that the complete π-fiber is supported at infinity or that paired entries sum to ten. Distinct contributing z-values use disjoint chains, six entries each. If ki=0 no bound is imposed.

### Refined inequality

The total conic ledger has eighteen entries, Σai90. Consequently
\[
\sum a_i^2=450+\sum(a_i-5)^2
\ge450+6\sum_i(k_i-5)_+^2,
\]
where x+=max(x,0). Indeed each contributing ki>5 supplies three entries at least ki and three at most10−ki, each at distance at least ki−5 from five. Every remaining square is nonnegative. This uses no paired-entry equality and remains valid if some of the three common values are absent.

The accepted smooth common graphs share their cubic term, so their total defect is at least4Σki(ki−1). Repeating only the changed quadratic penalty in the accepted adjunction calculation gives
\[
16d+1\le216+27c+10g(R)
-4\sum_i k_i(k_i-1)-3\sum_i(k_i-5)_+^2.
\]
The actual whole-field genus bound gR≤4d/5+1 therefore yields
\[
4\sum_i k_i(k_i-1)+3\sum_i(k_i-5)_+^2\le105+19c.
\]
No contact order five is asserted.

### The exact degree-thirty-five boundary

The accepted general bound leaves only(8,7,5),(8,6,6),(7,7,6) at d35,c20. Their refined left sides are respectively
\[
472+39=511,\quad464+33=497,\quad456+27=483,
\]
while the right side is485. The first two partitions are excluded. Only(7,7,6) remains atρ=−1.

For that last partition, the eighteen baseline entries are, at each common value, three copies of ki and three copies of10−ki. Their sum is90 and squared sum is504. The conic class therefore has C²≤1596, K.C=20gR−140 and
\[
g(E)=561\le273+10gR.
\]
The accepted upper bound is29, so gR=29 is forced. The fixed-point count a of R/Q is2,4or6, with gR=2gQ−1+a/2. Integrality gives a4 and gQ14. The whole tame count then has N=8d/5+4−4gQ=4=a: there are no additional uniform-quadratic π-values at unit z. A nonuniform finite fold is still retained.

In fact the squared sum MUST be exactly504. Any change from the baseline raises a high entry at least six or lowers a low entry at most four. Since the total sum stays90, a nonzero change requires at least one unit increase and one unit decrease. Their minimum squared cost is
\[
(2\cdot6+1)+(-2\cdot4+1)=6.
\]
It would lower the arithmetic genus by at least three, incompatible with the normalization genus561 and the minimum common defect456. Thus every high chain is constant ki and every low chain constant10−ki, C²=1596 and pa(C)=1019. The TOTAL normalization defect is EXACTLY458; common branches account for at least456, leaving at most TWO beyond that minimum.

The intermediate component intersections are zero. Each common end's degree ki is filled by its ki unramified common branches; all remaining degree10−ki in that fiber is on the opposite end. This statement is about the actual conic image and does not assert an endpoint map on R.


### Remaining small degrees and scope

At d25,c10 the largest part nine gives partition(9,1,0), refined left side288+48=336>295, while a part ten was already excluded. Thus every ki≤8 atρ=−1. At d30,c15, a largest part nine can only remain as(9,3,3): the other sorted possibilities(9,5,1),(9,4,2),(9,6,0) already exceed the refined inequality or its accepted precursor. This is a necessary list, not an actual-source decision.

The last degree35 profile is not excluded: ordinary finite conic self-intersections with different endpoint cubic phases may contribute the residual defect two. The original conic forgets the endpoint y-values; equality of conic coordinates need not mean equality of fixed endpoint points or force contact five. No sign-cover endpoint descent, simultaneous Galois closure, extra Cartier trace or field equality from formal contact is imported. The current target is this narrow actual negative-phase boundary and the other nontrivial phases at degrees25/30/35.

## 6. The remaining opposite-end companions are distinct unramified P-root pairs

This further necessary consequence uses only the exact negative-degree35 ledger in §5 and the original endpoint comparisons. Its [fresh four-check static extension audit](../../Research/audits/OCT03_NEGATIVE_PHASE_THIRTY_FIVE_OPPOSITE_COMPANIONS_STATIC_EXTENSION_AUDIT_2026_10_03.md) reports PASS without correction.

At either R-lift of a common value, the three blowup multiplicities are constant. Every internal strict component has zero intersection with the horizontal conic image C. The ki common branches fill one end; the remaining10−ki branches lie on the opposite end. Since the common phase is rho=−1 and t^6=1, that opposite affine line is B=A, where A=x1+1 and B=x2+1 are the ORIGINAL centered functions. Its intersections with the internal chain and its own infinity section are unavailable to these remaining branches.

In particular none of these opposite-end branches can map to the original affine node A=B=0. The strict opposite end maps isomorphically to the corresponding affine line away from the node. Its unique point over that node is its intersection with the adjacent internal component. A horizontal curve passing through that point would have positive intersection with the internal component, contrary to the exact zero intersection. This argument uses the smooth resolved surface; it does not discard a centered endpoint merely from a conic picture.

Let a=A(P)=B(P) be any remaining finite endpoint value. Thus a is nonzero. Write p(U)=P(U−1), d0=[23], q(U)=U^2+d0. The actual R/t-index is3. The whole tame degree-ten ledger allows the branch index e(E/R) to be1 or2 here, since all uniform quadratic values are the four special values counted by a=N=4. The source index of z−z0 is k=3e. The original conic gives the exact identity
\[
(B-A)(B+A)=(z^3-1)q(A).
\]

If p(a) is nonzero, the first actual étale endpoint makes A−a a uniformizer. Since B+A is a unit, B−A has order k+v, with v=ord q(A) equal0or1. This order is at least3. Hence dB/dA has residue1 and p(B)/p(A) has residue1. Cubing the ORIGINAL differential comparison gives
\[
\left(\frac{dB}{dA}\right)^3
=\frac{p(B)^2}{\kappa^3z^{24}p(A)^2}.
\]
Here kappa^3=−1 and z0^3=1, so its residues would give1=−1. Therefore p(a)=0. Both endpoint images are the SAME finite trigonal branch point, since their centered values are equal.

The settled fixed-root input makes a and q(a) units at every such p-root. Using the first étale branch parameter y1, A−a has exact order3. If e=2, then B−A has exact order6. Consequently p(B)/p(A) and dB/dA again have residue1, contradicting the same cubed comparison. Thus e=1 for EVERY remaining opposite-end companion: the whole fiber at this critical value is unramified over R, including its finite points.

When e=1, let lambda be the ratio of the leading coefficients of B−a and A−a. Both derivatives and the p-ratio have residue lambda. The cubed comparison yields lambda^3=−lambda^2; both original étale legs make lambda nonzero, so lambda=−1. Therefore B−A starts with−2(A−a). The conic identity now gives
\[
A-a=-\frac{q(a)}{4a}(z^3-1)+O(s^4),
\]
where s is the SAME uniformizer on the actual R-base. Thus two finite companion branches over that R-point and with the same p-root a have identical cubic terms and intersection multiplicity at least4. They are smooth graphs because e=1. Their defect contribution alone would exceed the global residual budget458−456=2. Hence the10−ki companion roots are DISTINCT within each critical fiber.

The necessary finite companion sets therefore have sizes3,3,4, consist of distinct roots of the fixed p, and have no fold. The two opposite t-lifts give the same set because the actual étale double fixes A,B. No constraint equating the sets at different critical values is inferred. The three sets can overlap across different R-fibers, and the residual defect two can still be supported elsewhere. There is no actual-source exclusion, higher contact claim, endpoint map on R or replacement of either original endpoint leg.

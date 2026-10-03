# Proof: the degree-fifteen vertical conductor contradicts the actual cubic residue

Version1, 3 October2026. [Independent whole canonical audit PASS](../../Research/notes/oct03_ten_hour/split_fifteen_vertical_canonical_whole_audit.md), with no required corrections. This proof assembles the independently audited boundary-section and finite-section arguments, spells out their actual-source input, and keeps the exact residue before passing to any auxiliary infinity equation. No computation or settled certificate replay is used.

## 1. The actual source, adjoint and integral surface identity

Assume the theorem's TWO actual degree-fifteen finite étale maps exist. Their smooth source has genus121. The actual functions u=x₂+1 and v=t³(x₁+1) satisfy u²−v²=d(t⁶−1). The [accepted smooth conic construction](canonical_ten_split_tensor_conic_bundle_exclusion.md) has disjoint boundary sections D±, six reducible fibers, K_S=−D−2F, and L=D+3F with L²=6. Its integral image C has normalization C₀ because the actual joint field is k(t,x₁,x₂). It satisfies
\[
CF=15,\quad CD_\pm=0,\quad CL=45,\quad K_SC=-30.
\]
The reduced infinity divisor of the second actual map is exactly the fifteen simple poles of t.

In the six-fiber blowup basis B=D₋,F,Eᵢ, one has D₊=B+3F−ΣEᵢ and
\[
C=15B+45F-\sum a_iE_i,\qquad\sum a_i=45.
\]
The integer minimum Σaᵢ²=339 gives C²≤336 and hence δ=p_a(C)−121≤33. This bound is not used to replace the actual source by an arbitrary divisor.

The actual θ₂ and normalization duality produce a section σ of O_C(C−D−18F) whose normalized zero divisor is EXACTLY the conductor divisor Δ. Indeed θ₂ is a nowhere-zero section of ω_C₀(−16F), whereas the dualizing sheaf of the Cartier image adds precisely Δ. The two unchanged surface vanishings
\[
H¹(-D-18F)=H¹(-D-8F)=0
\]
follow from Riemann–Roch and Serre duality: h⁰ is zero because the fiber degree is negative, while χ=h² is respectively17 and7, since the dual spaces are H⁰(16F) and H⁰(6F). Thus σ extends to S. Its intersection with either boundary is−15, forcing5D as a fixed divisor. Removing it gives an effective actual residual
\[
R=C-6L,\qquad RF=3,\quad RD_\pm=0,
\]
with section ρ whose pullback is Δ.

The actual differential θ₂y₂ has divisor at least6F on C₀. Normalization duality therefore puts the product σy₂ in O_C(C−D−8F); this does not assume y₂ descends to the singular image. The second vanishing extends it. Its boundary intersections are−5, forcing2D, and removing those factors gives a section a of3D+10F+R with actual restriction a=ρy₂. All boundary factors are units on C₀ because C avoids D.

Use the rational representative
\[
R_{\rm polar}=2D_++D_-+3F_\infty-\sum(a_i-8)E_i.
\]
The generic conic pole bounds of ρ,a,Q are respectively(2,1),(5,4),(8,7), where Q defines the actual C and its two boundary orders are exact. The accepted actual adjoint/residue construction, as in the [audited degree-fourteen proof](canonical_fourteen_split_disjoint_cubic_adjoint_normal_form.md), gives
\[
\mathcal DQ=\lambda a²/\rho\quad\text{on }C,
\qquad\lambda\in k^\times,
\]
with 𝒟(t)=v,𝒟(u)=0,𝒟(v)=−3dt⁵. The constant is global: the residue section and θ₂/ρ have identical normalized divisors, so their ratio is a global unit. Compatible rational R frames multiply Q,ρ,a by the same function; their derivative adds a Q-multiple to this equality.

The actual cubic yields N=a³−P(u−1)ρ³=QW globally. Its numerator poles are bounded by(16,13), so W has bound(8,6). At either generic boundary, 𝒟(u)=0 and its base coefficient has at most a simple pole; the Wronskian ρ𝒟a−a𝒟ρ has the same bound(8,6). Differentiating N=QW and using the exact residue on C gives W=(3/λ)(ρ𝒟a−a𝒟ρ) there. Both sections have total generic polar degree at most14. Since C has fifteen reduced generic points, their difference is identically zero. We have the WHOLE surface identity
\[
a³-P(u-1)\rho³=cQ(\rho\mathcal Da-a\mathcal D\rho),
\qquad c=3/\lambda\ne0.
\tag{1}
\]
This is a consequence of the actual source, not a source-free classification of curves on S.

## 2. Infinity frames and the actual branch-contact lemma

Put s=t⁻¹,U=s³u,V=s³v. Then U²−V²=d(1−s⁶). The balanced R frame gives weights3,13,21 for ρ,a,Q. Write their local rational representatives ρ₀=s³ρ,a₀=s¹³a,Q₀=s²¹Q, and P∞=s³⁰P(s⁻³U−1). The derivation Δvec=s²𝒟 has
\[
\Delta_{\rm vec}(s)=-sV,\quad
\Delta_{\rm vec}(U)=-3UV,\quad
\Delta_{\rm vec}(V)=-3(U²+ds⁶).
\]
The frame term in the Wronskian has coefficient13−3=10, zero in characteristic5. Thus(1) becomes exactly
\[
a₀³-P_\infty\rho₀³
=cQ₀(\rho₀\Delta_{\rm vec}a₀-a₀\Delta_{\rm vec}\rho₀).
\tag{2}
\]
At F∞ use z=U+V, U₀=(z+d/z)/2,V₀=(z−d/z)/2. At fixed z,
\[
\Delta_{\rm vec}=-sV₀\partial_s+\delta+O(s⁶),
\quad\delta=-3U₀z\partial_z,\quad
P_\infty=U₀^{10}+O(s³).
\tag{3}
\]
These bounds are exact enough for the first two base coefficients: the moving-conic corrections start at s⁶, and a degree-nine coefficient of P, if present, starts at s³.

Every actual infinity branch has s as a parameter and U a unit: this follows from the actual x₂ pole order three and simple t poles. The original θ₁ identity imposes
\[
\frac{V'}{y₁²}=\kappa\frac{-3U+sU'}{H²},\qquad H=s^{10}y₂\text{ a unit}.
\tag{4}
\]
The [audited two-map infinity lemma](canonical_fourteen_split_disjoint_cubic_adjoint_normal_form.md) applies independently of degree. For completeness, when y₁ is a unit, choosing its and H's actual cubic phases makes(4) a regular ODE in s,V. Three phase ratios give at most three initial slopes. Equal initial slope gives the same regular ODE, and recursion divides only by1,2,3,4 to make projected jets equal through degree four. If y₁=0, w=y₁ is a parameter on X and V−V₀ is a unit times w³. The regular ODE for w permits simultaneous cubic scaling of w,H; after phase normalization its w jets agree through degree four, making projected contact at least seven. Consequently two DISTINCT image branches have intersection multiplicity
\[
I=1\quad\text{or}\quad I\ge5,
\tag{5}
\]
and at most three tangent directions occur at an image point. No uniqueness beyond the fourth jet is assumed.

## 3. A vertical infinity component has multiplicity at most three

Suppose R contains F∞. Its zero intersections with D± force both boundary sections as components, because otherwise all effective intersections with the missing boundary would be nonnegative and F∞ would contribute positively. Since RF=3, write
\[
R=D+H+V_{\rm vert},
\]
where H is a degree-one section, possibly a boundary section, and V_vert is effective vertical. An irreducible degree-one horizontal curve is a smooth section, since its finite degree-one morphism to the normal base is an isomorphism. The boundary budgets are3−HD± if H is nonboundary, and(6,3) or(3,6) if H is a boundary. Hence the exact F∞ multiplicity k is1,2 or3.

At actual infinity branches away from H∞ the conductor order is EXACTLY k. At a finite H∞ with b actual branches and positive contacts hᵢ=I(branchᵢ,H), their orders are k+hᵢ. A smooth-branch plane-curve conductor exponent is the sum of its pairwise intersections. Writing the branches and H as formal graphs gives Iᵢⱼ≥min(hᵢ,hⱼ). For m=min hᵢ, this yields
\[
(b-2)m\le k.
\tag{6}
\]

If k=3, there can be no cluster outside H∞. A pair would require contact3, a triple two contacts summing to3, and four branches four distinct tangents; each violates(5) or its tangent bound. Larger clusters already contribute at least4. If H∞ is finite all fifteen branches there violate(6); if it is a boundary no actual branch meets it. Thus k=3 is impossible.

If k=1 and H∞ is finite, the outside clusters are transverse pairs and(6) gives b≤3. Equation(2) forces a₀ to have a factor s, exactly one because its actual ratio to ρ₀ is a unit on outside branches. After common stripping the leading ratio has δh=0 and poles≤4 at both boundaries and≤1 at H∞. It is a fifth power, so these pole bounds make it constant. Its actual cubic at outside images gives h³=U₀¹⁰, admitting at most four conic points. Yet15−b≥12 branches require at least six pair images. If H∞ is a boundary, all fifteen branches would instead partition into pairs, impossible. Thus k=1 is excluded.

For k=2 and finite H∞, outside clusters are ordinary transverse triples. Equation(6) gives b≤4, and15−b is divisible by3, so b=0 or3. In the latter case m≤2, and a minimum-contact branch has conductor2+m equal to3 or4. Neither is a sum of two allowed contacts from(5). Thus b=0: H∞ is outside C∞ and there are five ordinary triple images. When H∞ is a boundary the same five-triple conclusion holds directly. In either case ordF∞(a₀) is1 or2; a larger order would contradict the actual unit ratio on infinity branches.

## 4. Boundary H∞: unequal orders and common stripping

First let H∞ be the boundary D₊, exchanging the signs if needed. If ρ₀=s²ρ₂ and a₀=sa₁, put f=a₁/ρ₂ at infinity and q=Q₀|∞. Here ρ₂|∞ is a nonzero constant: its residual zero divisor is2D₊+D₋, matching the balanced polar representative. Equation(2) gives
\[
f³=cq(\delta f+V₀f),
\]
and q has exact poles8 and7. At D₊ use w=z⁻¹, where δ is a unit times∂w. Since δ(U₀²)=−V₀U₀², the operator is U₀²δ(f/U₀²). If b=ord(f) and b+2 is not divisible by5, its order is b−1, requiring2b=−9, impossible. Otherwise let j be the first Laurent exponent of f/U₀² not divisible by5. The operator order j−3 cannot be2 modulo5, whereas the equation requires8+3b≡2 modulo5. If no such j exists the operator is zero. Thus unequal orders are impossible at a boundary H∞.

We can strip the common s² factor and put h=a₂/ρ₂. Equation(2) becomes
\[
\Delta_{\rm vec}h=c^{-1}s²(\rho₂/Q₀)(h³-P_\infty).
\tag{7}
\]
Its leading h₀ is a fifth power, with boundary pole bounds5 and4. A constant accounts for at most four image points; hence h₀=(A+Bz)⁵, B≠0, and it has exact pole5 at D₊.

If H is nonboundary, its intersection with D₊ is exactly one: the double F∞ consumes two of its budget three. Near that intersection its equation is w=bs+O(s²), b≠0. The uniform pole divisor of h is4D₊+4D₋+H, so
\[
h(s,w)=A(s,w)/(w⁴(w-bs+O(s²))),\qquad A(0,0)\ne0.
\]
Its first coefficient h₁ has a nonzero pole6 at D₊, pole≤4 at D₋, and no finite poles. But the s coefficient in(7) is(δ−V₀)h₁=0. Since δ(U₀³)=V₀U₀³, its solutions are h₁=U₀³g⁵. Those pole bounds forbid any pole of g, including at finite zeros of U₀, so g is constant. Then h₁ has poles≤3, a contradiction.

If H=D₊ itself, each h coefficient has fixed boundary pole bounds5 and4. The s² coefficient in(7) is
\[
(\delta-2V₀)h₂=c^{-1}(\rho₂|_\infty/q)(h₀³-U₀^{10}).
\]
Its left side has pole≤6 at D₊. The right side has exact pole15−8=7 because h₀³ has pole15, U₀¹⁰ only10, and ρ₂ is constant. This is again impossible. This excludes every boundary-H case.

## 5. Finite H∞: the exact residue survives common-factor division

Let H∞ have finite coordinate p. If a₀ has order2, common stripping again gives a fifth-power leading ratio with boundary poles≤4 and one possible finite pole≤1. It is constant and cannot account for five triple images. Thus only
\[
\rho₀=s²\rho₂,\quad a₀=sa₁,
\quad H_\infty\notin C_\infty
\]
remains. In the balanced frame, ρ₂|∞ is proportional to z−p. The leading f=a₁/ρ₂ has boundary poles≤4 and a pole≤1 at p, while q has five distinct triple roots, all with U₀ a unit. Equation(2) reads
\[
f³=c\frac{q}{z-p}(\delta f+V₀f).
\tag{8}
\]

Retain the EXACT actual residue, before differentiating only this auxiliary equation. Multiplying it by ρ gives a regular expression in compatible bundles and its Cartier divisibility by C:
\[
\rho\mathcal DQ-\lambda a²=QB.
\]
The weights3,13,21 give t⁻²³𝒟Q=ΔvecQ₀+21VQ₀. Hence locally near the finite actual infinity points,
\[
\rho₀(\Delta_{\rm vec}Q₀+21VQ₀)-\lambda a₀²=Q₀B₀.
\]
The left side contains s². Since Q₀ has no F∞ factor, the quotient B₀ contains s² as well. Divide it and restrict to infinity. Terms multiplying q remain irrelevant, and the resulting regular divisibility is
\[
\rho₂\delta q-\lambda a₁²\equiv0\pmod q.
\tag{9}
\]
This uses the actual Cartier equation and actual residue; arbitrary solutions of(8) need not satisfy it.

At each triple root, ρ₂ and δ are units. Equation(8) makes f vanish. If its order n is not divisible by5, it gives3n=3+n−1, hence n=1. If n is divisible by5, the degree≤9 pole bound permits only n=5, since four other roots already contribute four. But δq has exact order2 whereas a₁² has order10, contradicting divisibility by the triple root in(9). Therefore f has FIVE SIMPLE zeros at the five actual triple images.

## 6. The remaining rational derivative has no possible zero divisor

Put g=f/U₀². Equation(8) gives
\[
g'=C\frac{(z-p)f³}{qU₀³z},\qquad C\ne0.
\tag{10}
\]
At a boundary let b=ord(f). Because δ is a unit derivation there, U₀² has pole2 and q/(z−p) pole7, either b+2 is not divisible by5 and(8) forces b=−4, or b+2 is divisible by5 and b∈{−2,3,8,...}. A boundary zero of order≥3 is impossible by the total divisor degree: the other boundary and p could supply at most five poles against at least eight zeros. Thus the two boundary poles have orders TWO or FOUR.

At any additional ordinary point outside q,p and U₀=0, a zero would have order divisible by5, otherwise its derivative order contradicts(8). Such a fifth-order zero plus the five known zeros exceeds the maximum nine poles. At ordinary p a zero also fails the order equation unless divisible by5, again exceeding the budget. At an auxiliary point U₀=0, δU₀=−3V₀U₀ and the leading coefficient of δf+V₀f is V₀(1−3n); a zero is possible only with n≡2 modulo5. The budget leaves order2.

If p itself has U₀=0, a unit or simple pole of f violates(8), with orders0 versus−1 or−3 versus−2. Its only possible zero is order2. Together with five simple q zeros and an optional order2 zero at the other auxiliary point, this gives an odd total zero order, against even boundary pole order and no pole at p. Thus p is not auxiliary.

Let ε be the number of order-two auxiliary zeros of f. There are exactly5+2ε zeros. Parity forces a simple pole at p, and degree equality gives precisely these three cases: ε=2 with boundary poles(4,4); ε=0 with(2,2); or ε=1 with(4,2) or(2,4). Since(10) is a rational derivative, every residue must vanish. Each case contradicts that requirement.

If ε=2, then g'=C(z²+d)³/(z³(z−p)²). Its residue at0 is proportional to3d²(d/p²+1); vanishing forces p²=−d, already excluded.

If ε=0, then g'=Cz³/((z−p)²(z²+d)³). The residue at p forces p²=d. Scale d=p=1, allowing a sign change in z. For r²=−1 put A=z³/((z−1)²(z+r)³). The triple-pole residue at r is A''(r)/2, and
\[
A''(r)/A(r)=1/(r(r-1)²)=3\ne0.
\]

If ε=1, scale its auxiliary zero to w=1 and put b=p/r, where r²=−d and b≠0,±1. For boundary poles(4,2),
\[
g'=Cw³(w-1)³/((w-b)²(w+1)³).
\]
Zero residues at b and−1 require3b²+b+2=0 and4(b+1)²+2(b+1)+1=0. The latter is b²=2, and the former then gives b=2, a contradiction. For poles(2,4),
\[
g'=C(w-1)³/(w³(w-b)²(w+1)³).
\]
Zero residues at0 and b require b²+b+1=0 and2b²+b+3=0. Subtracting twice the first forces b=1, which fails the first equation. Exchanging the auxiliary signs changes nothing. All cases are impossible.

Thus the last finite-H vertical remainder is excluded. Together with Sections3–4, this proves F∞ is absent from the actual conductor-adjoint R.

## 7. Scope and independent evidence

The [boundary-H audit](../../Research/notes/oct03_ten_hour/split_fifteen_vertical_boundary_audit.md) independently checked the vertical conductor reductions, unequal-order boundary argument and both base coefficients. The [finite-H audit](../../Research/notes/oct03_ten_hour/split_fifteen_vertical_finite_residue_audit.md) independently checked the exact residue division, exhaustive zero/pole list and all residue contradictions. Their [original partial note](../../Research/notes/oct03_ten_hour/split_fifteen_vertical_adjoint_partial.md) retains a useful nonempty leading model with an order-five zero; the [finite-H argument](../../Research/notes/oct03_ten_hour/split_fifteen_vertical_finite_residue_exclusion.md) shows precisely why that model fails the actual residue gate. This proof remains frozen for a further fresh whole canonical audit.

Only the vertical sector is excluded. Degree-fifteen disjoint-infinity sources with R not containing F∞, common-infinity and nonsplit comparisons have separate remaining analysis. Both original actual endpoint legs stay on their common source, and no unmarked common-cover conclusion is claimed.

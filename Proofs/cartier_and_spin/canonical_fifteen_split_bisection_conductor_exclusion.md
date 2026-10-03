# Proof: no boundary-disjoint bisection-plus-section conductor in degree fifteen

Version1, 3 October2026. Fresh independent [whole or canonical scope/fidelity audit](../../Research/audits/CANONICAL_FIFTEEN_SPLIT_BISECTION_CONDUCTOR_EXCLUSION_AUDIT_2026_10_03.md): **PASS**, no mathematical correction. Original component evidence and audited input hashes are preserved. No numerical replay at integration.

## 1. Actual paired cubics and the conductor configuration

Keep BOTH actual finite étale degree-fifteen maps from the SAME smooth projective C₀ to X, their actual cubics, the original canonical identity θ₁=κt¹⁶θ₂, the actual split joint field k(C₀)=k(t,x₁,x₂), and disjoint reduced infinity divisors. The accepted actual conic image is integral with normalization C₀ and CF=15,CD±=0. Its exact effective conductor-adjoint R=C−6L has RF=3,RD±=0, and ν*R=Δ.

Suppose
\[
R=H+Z,\qquad HF=2,\quad ZF=1,\quad HD=ZD=0,
\tag{1}
\]
with H integral and Z a section. Since neither is a boundary and RD±=0, there is no vertical component: any vertical prime on the conic surface meets at least one boundary. A degree-one integral component over the rational base is a smooth section, since its proper finite birational map to the normal base is an isomorphism. The accepted constant-q₀ component theorem excludes the four sections u=α₂,v=α₁t³ with αᵢ²=−d.

The SAME conductor section ρ supplies actual sections a,b of 3D+10F∞+R. Their restrictions are a=ρy₂ and b=t¹⁰ρy₁ on C₀. Since the paired error bundle C−8L has fiber degree15−16<0, both global errors are zero. The whole identities are
\[
a³-P(u-1)\rho³=\gamma₂Q(\rho\mathcal Da-a\mathcal D\rho),
\tag{2}
\]
\[
b³-t^{30}P(v/t³-1)\rho³
=\gamma₁Q(\rho Eb-bE\rho),
\tag{3}
\]
where Q defines the actual C, γᵢ≠0, and
\[
\mathcal Dt=v,\quad\mathcal Du=0,\quad\mathcal Dv=-3dt⁵;
\qquad Et=-tu,\quad Eu=-3(u²+d),\quad Ev=-3uv.
\]
The coefficient t³⁰P(v/t³−1) in(3) is regular at F₀, as expansion of the degree-ten polynomial has only nonnegative powers of t.

The accepted full single-cubic theorem says that the ENTIRE ρ factor divides neither a nor b. Its actual auxiliary-point obstruction forces R to contain both points on BOTH end fibers:
\[
F₀:\ (t,v,u)=(0,0,\pm c),\qquad
F∞:\ (s,U,V)=(0,0,\pm c),\quad c²=-d,
\tag{4}
\]
where s=t⁻¹,U=s³u,V=s³v. The actual C avoids all four points: pole-three x₁ and simple zeros of t make v a unit on C₀ over F₀, and pole-three x₂ with simple poles of t make U a unit over F∞. Thus Q is a unit there.

The actual endpoint swap uses τ=t⁻¹,u₁=v/t³,v₁=u/t³, giving the same conic equation. Its frame comparison Ωτ=−t⁻²Ωt and original θ₁=κt¹⁶θ₂ transport the adjoint representative by a scalar times t¹⁸, preserving the SAME effective R and full-factor condition. Every swapped argument below uses these two original maps, not an added map on H or Z.

Avoidance of D gives degree at most six for u and v/t³ on the normalization of H. These functions are nonconstant in the PRESENT configuration: Z covers at most one forced auxiliary point of F₀, so H meets another. If u were constant, its auxiliary value would satisfy u²=−d, making v²=−dt⁶ split H into two sections. The swapped argument excludes constant v/t³. Arbitrary constant-u conic bisections away from the q₀ roots are not being excluded by this assertion.

In the F₃ blowup basis,
\[
H=2B+6F-\sum c_iE_i,\qquad0\le c_i\le2,\quad\sum c_i=6,
\qquad p_a(H)=5-\tfrac12\sum c_i²\le2.
\tag{5}
\]
The bounds on cᵢ are its nonnegative intersections with both components of each reducible fiber. They include all singular and locally reducible germs of the integral H.

## 2. Exact parity at an isolated auxiliary point

Suppose a|H is generically nonzero and an auxiliary point p∈H∩F₀ is absent from Z. Then ρ is a unit times a prime local equation w of H, and Q is a unit at p. Restrict(2) to H and cancel a in k(H). This gives the intrinsic regular-section square identity
\[
(a|H)²=-\gamma₂(Q|H)(\mathcal D\rho|H).
\tag{6}
\]
Therefore on EACH normalized branch the finite valuation of 𝒟w must be even. If that derivative vanishes identically, the same identity already contradicts a|H≠0. Derivatives of common-frame units vanish on restriction to ρ=0, so the parity test is independent of that frame.

When HF₀ has intersection one at p, H is a smooth unramified graph v=f(t). Directly,
\[
\mathcal D(v-f(t))|H=-3dt⁵-f'f.
\tag{7}
\]
Leading orders one and two of f give odd derivative orders one and three. Order at least four leaves the odd t⁵ term. Leading order three also gives odd order five unless f=ct³+O(t⁴),c²=−d. This cancellation makes u−u(p) vanish to order at least seven, contradicting its degree at most six. Thus an isolated simple auxiliary point forces a|H=0.

If all intersection HF₀=2 lies at p and H is smooth ramified, it has equation t=g(v),g(v)=βv²+O(v³),β≠0. Its normal derivative v+3dt⁵g'(v) has exact order one, again impossible.

For the remaining singular cases let τ be a branch parameter, and let c_branch be its conductor valuation in the plane germ H. Normalization duality gives
\[
w_v|\widetilde H=\varepsilon\tau^{c_{branch}}t',\qquad
\mathcal Dw|\widetilde H=-\varepsilon\tau^{c_{branch}}u u',
\tag{8}
\]
with ε a unit. The first formula compares the plane dualizing generator dt/w_v with dτ; it applies on each branch of a reducible completed germ as well. The second follows from differentiating w and the conic identity uu'=vv'+3dt⁵t'. Here t'≠0, since its leading base index is one or two, prime to five.

For a singular unibranch germ, ord(t)=2 and ord(v)≥2. Its conductor valuation is even. Orders ord(v)≥4 would give at least eight zeros of u−u(p), beyond its degree. Orders two and three give exact zero orders four and six, whose derivatives have orders three and five. Equation(8) then has odd order, contrary to(6). This includes a leading v term proportional to t and assumes no Puiseux normal form.

For a two-branch germ, both branches have base index one and are smooth graphs. The global degree-six bound leaves v orders (1,1),(1,2), or(2,1). Two order-two branches already contribute eight zeros of the same u value; an order-three branch contributes at least six, or at least seven after the cancellation in(7), and any order at least four contributes six. If I is their pair intersection, each branch conductor valuation is I. Thus(8) has order I+2ord(v)−1, and(6) forces I odd. Since pₐ(H)≤2, one has I≤2. Hence I=1: the sole escape is an ORDINARY node with two unramified branches, having u−u(p) orders two or four and total at most six.

The same complete statement applies to b at F∞ under the actual swap. In particular a nonzero restriction on H can have isolated auxiliary total intersection two only at the stated ordinary node.

## 3. Two nonzero H restrictions contradict the field of H

Suppose a|H and b|H are both nonzero. If H meets both auxiliary F₀ points, one is simple and absent from Z, already impossible. If H meets one auxiliary point simply and has its other fiber point ordinary, Z must meet the other auxiliary point, again leaving the simple H point isolated. Thus H meets just one auxiliary value with total intersection two, and Z meets the opposite value. Section2 makes the H point an ordinary node. The swapped argument gives the same conclusion at F∞.

Write p₀,q₀ for the normalized branches at zero and p∞,q∞ for those at infinity. All four are unramified over the base. The two infinity auxiliary branches cancel at least one order each from the potential pole-three u, so deg u≤4. At zero, u−u₀ vanishes to order at least two on each branch, hence has at least four zeros. Equality follows throughout:
\[
\operatorname{div}(u-u₀)=2(p₀+q₀)-2(p∞+q∞)=2\operatorname{div}(t).
\]
Thus u=u₀+βt² with β≠0. The swapped argument gives v/t³=v∞+γt⁻², so v=v∞t³+γt. Since the actual image coordinates generate k(H)=k(t,u,v), these identities make its field k(t), contradicting HF=2. At least one extension therefore contains H as a global Cartier factor.

## 4. Exactly one H factor contradicts the other whole cubic

Suppose H divides a but not b. Since full ρ divisibility is excluded, a|Z≠0. A nonconstant boundary-disjoint section through an auxiliary F₀ point has v with exact leading order one. Indeed u,v are polynomials of degree≤3; a leading v order at least two forces u−u₀ to have order at least four, beyond that degree, unless u is constant and the section is an excluded constant-q₀ section. Its directional normal derivative therefore has exact order one. If H were absent from that auxiliary point, restriction of(2) to Z would make a square have odd valuation. Thus Z cannot be an isolated auxiliary contributor at F₀. H must cover BOTH auxiliary F₀ points simply. Because b|H≠0, at F∞ it has the isolated ordinary node of Section2, and Z has the opposite auxiliary value.

Set w=u+v and A(t)=Norm_{k(H)/k(t)}w. Both w and u−v are regular for finite t, and their product is d(t⁶−1). Consequently
\[
A(t)=k\prod_{i=1}^6(t-t_i)^{c_i},\quad t_i^6=1,
\quad0\le c_i\le2,\quad\sum c_i=6.
\tag{9}
\]
The exponents measure intersections with one component of each reducible fiber. They agree with the blowdown convention in(5) or its complement 2−cᵢ; that complement has the same sum and square sum, so the genus calculation is unchanged.

The two F₀ auxiliary values give A(0)=d. The common infinity V value c gives leading coefficient −d. Comparing constant and leading coefficients, using the product −1 of all six roots of t⁶−1, gives
\[
\prod_{c_i=2}t_i=\prod_{c_i=0}t_i.
\tag{10}
\]
The infinity node requires pₐ(H)≥1. At pₐ=1 exactly one cᵢ is two and one is zero; equation(10) would identify two DISTINCT roots. Hence pₐ=2, every cᵢ=1, and the full Pic(S) class is H=L. Thus A=−d(t⁶−1).

Let w' be the quadratic conjugate and T=w+w'. Then w'=A/w and d(t⁶−1)/w=−w'. Therefore
\[
u=(w-w')/2,\qquad v=(w+w')/2=T/2\in k(t).
\tag{11}
\]
This conjugate identity, rather than trace alone, justifies the claimed rational v. The trace T is polynomial of degree≤3, with T(0)=0 and leading term2ct³. The infinity node makes u² have degree at most four. The degree-five coefficient of T²+4d(t⁶−1) removes the t² term, leaving the necessary form
\[
H:\quad v=ct³+\ell t,\qquad c²=-d,\quad\ell\ne0,
\tag{12}
\]
with u²=2cℓt⁴+ℓ²t²−d. The case ℓ=0 splits into excluded constant-q₀ sections. A finite repeated root of this even quartic makes it a square and also splits H, so it does not add an integral exceptional case.

Use the OTHER whole identity(3). For the prime local equation F_H=v−ct³−ℓt, direct substitution gives
\[
EF_H|H=-3uv+(3ct²+\ell)tu=-2\ell tu.
\tag{13}
\]
At EACH distinct auxiliary H point of F₀, t is a parameter and u is a unit, so this has exact order one. The section Z misses at least one of those two points. At that point Q is a unit and ρ is a unit times F_H. Restricting(3) to H and cancelling its generically nonzero b gives b²=−γ₁QEρ, an impossible odd valuation. The actual swap excludes the opposite allocation H|b,H∤a.

It follows that H divides BOTH a and b in every hypothetical configuration(1).

## 5. Both H factors contradict the exact infinity critical ledger

Full-factor exclusion makes both restrictions on Z nonzero. The same section parity test now forces H to cover both auxiliary points on BOTH end fibers, each simply. The third intersection R∩F∞ is Z∩F∞.

Use two accepted actual-source consequences of the [nonvertical critical ledger](../../Research/notes/oct03_ten_hour/split_fifteen_nonvertical_critical_normal_form.md), stated with its [independent audit](../../Research/notes/oct03_ten_hour/split_fifteen_nonvertical_critical_audit.md):

1. The rational infinity ratio h∞=a∞/ρ∞ has no finite or auxiliary pole. At a double auxiliary zero of ρ∞ it is a unit. A possible simple auxiliary pole would leave eight ordinary critical orders, whereas each such order must be divisible by five under the whole cubic and original exact residue.
2. If the extra third R∩F∞ point is ordinary, its smooth global R component divides a. This is the audited unused-cubic-factor/Darboux argument using the actual normalization conductor and exact original residue.

If Z∩F∞ were ordinary, consequence2 would force Z|a, together with H|a giving the excluded ENTIRE factor. Thus Z meets an auxiliary point p of F∞ already met simply by H. Likewise Z is auxiliary at F₀, since an ordinary zero-fiber point would force Z|b after the actual swap.

A nonconstant D-disjoint section auxiliary at both ends has
\[
u_Z=u₀+\beta t²,\qquad v_Z=ct³+\gamma t,\qquad\beta\gamma\ne0.
\tag{14}
\]
Polynomial coefficient comparison proves this; β=0 or γ=0 are the excluded constant-q₀ sections. A prime local equation in the infinity chart is f_Z=U−βs−u₀s³. With Δ=s²𝒟,
\[
\Delta s=-sV,\quad\Delta U=-3UV,\quad\Delta V=-3(U²+ds⁶),
\qquad\Delta f_Z|Z=-2\beta sV.
\tag{15}
\]
The last derivative has EXACT order one at p, since β and V(p) are nonzero.

Choose a regular common R frame near p, and prime local equations f_H,f_Z. Since H|a, compatible representatives have
\[
\rho₀=\varepsilon f_Hf_Z,\qquad a₀=f_H\alpha,
\tag{16}
\]
with ε a unit and α regular. The relative infinity weight of a and ρ is ten, whose derivative is ZERO in characteristic five. The scaled whole identity is therefore a genuine regular identity
\[
a₀³-P_\infty\rho₀³=\gamma₂Q₀(\rho₀\Delta a₀-a₀\Delta\rho₀).
\tag{17}
\]
Restrict to Z and cancel its generically nonzero a₀. This gives a₀²=−γ₂Q₀Δρ₀. Here Q₀ is a unit by actual avoidance of the auxiliary point. If I=I_p(H,Z)≥1, valuation on the smooth Z gives
\[
2I+2\operatorname{ord}_p(\alpha|Z)=I+1.
\tag{18}
\]
Hence I=1 and α is a unit. Because H meets F∞ simply, a∞ has exact zero order one on F∞ at p. The conductor section ρ∞ has zero order two, one from each of H,Z. Thus a∞/ρ∞ has a SIMPLE AUXILIARY POLE, contradicting consequence1 of the audited exact critical ledger. This is the final contradiction.

## Scope and provenance

The proof treats every allocation along H: neither extension contains H, exactly one contains H, and both contain H. The complete source argument passed its [fresh bounded whole audit](../../Research/notes/oct03_ten_hour/split_fifteen_bisection_whole_audit.md) on source SHA256 `39d4b253377255370f72c808501fc2681b2732f28602f8a9ca6808f03da72a19`; that receipt has SHA256 `e9ec40b4bced1f2c1994ab28a31c1c5a2cc6d2269692f82962503bb906c44aa2`. This canonical version spells out the quadratic conjugate identity from the audit and preserves its corrected constant-coordinate scope. Its fresh canonical presentation audit is required before registration.

The exact square identities come from BOTH actual cubics and their shared conductor section. Every endpoint swap uses the SAME original maps, canonical identity and split joint field. Auxiliary H,Z are never asserted to carry original endpoint legs. Boundary-containing and other conductor configurations remain outside this theorem, which does not solve the unmarked common-cover problem.

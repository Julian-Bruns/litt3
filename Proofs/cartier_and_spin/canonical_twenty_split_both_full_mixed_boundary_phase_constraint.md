# Proof: actual polar modes, the exact infinity trace and the sole fixed cubic/quadratic gate

Version1, 3 October2026. Fresh independent [whole mathematical/application review PASS](../../Research/notes/oct03_ten_hour/split_twenty_both_full_boundary_polar_modes_audit.md), no mathematical corrections; canonical extraction fidelity review pending. No computation is replayed. The [statement](../../Theorems/cartier_and_spin/canonical_twenty_split_both_full_mixed_boundary_phase_constraint.md) retains BOTH actual finite étale endpoint maps and BOTH entire original conductor factors on their SAME C₀/T.

## 1. Original whole identities force the two polar modes

The [both-full paired linear theorem](canonical_twenty_split_both_full_paired_linear_normal_form.md) supplies genuine h=a/ρ,g=b/ρ in3D+10F∞, LINEAR C∼10L,R∼4L, nonzero scalarG₂ with Dh=G₂ρ, and
\[
Eg=-κDh,\quad g³-h³=P₁-P₂,
\quad P₂=P(u-1),\quad P₁=t³⁰P(v/t³-1).
\tag{1}
\]
These are the original whole cubic identities with the SAME defining Q and calibrated constants, rather than arbitrary polynomial conditions.

At a generic boundary v/u→σ=±1, the complete bounded polynomial basis gives hσ,gσ of degree at most1 in t. Write P(X−1)=ΣpⱼXʲ. The pole-ten term cancels because v¹⁰−u¹⁰=(v²−u²)⁵ is independent of u. The next coefficient in(1) is exactly
\[
g_\sigma³-h_\sigma³=p₉(σt³-1),\quad p₉=2+4𝔞\ne0.
\tag{2}
\]
All lower original terms have boundary pole at most8. The whole shifted original P₁ has been retained.

For linear polynomials at+b,ct+e, vanishing of the mixed coefficients of their cube difference gives a²b=c²e and ab²=ce². If all four coefficients are nonzero these force a/c=b/e with cube1, so the entire difference is zero. A zero coefficient, together with nonzero constant and cubic terms, instead forces complementary monomials: a pure t term and a nonzero constant. Neither polynomial can itself be zero, since one linear cube cannot have both nonzero endpoint coefficients and no mixed terms. Thus each boundary has exactly one of
\[
\mathrm I:\ h_\sigma=\alpha_\sigma t,\ g_\sigma=\beta_\sigma,
\qquad \mathrm{II}:\ h_\sigma=\alpha_\sigma,\ g_\sigma=\beta_\sigma t,
\quad\alpha_\sigma\beta_\sigma\ne0.
\tag{3}
\]
The leading pole-four coefficient of Eg+κDh is gσ−tgσ'+σκhσ'. In mode I this gives βσ=−σκασ. Equation(2) gives ασ³=−σp₉ andβσ³=−p₉, whence κ³=−1. Mode II imposes no phase relation.

## 2. The exact infinity trace of the complete linear normal form

Set s=t⁻¹,U=s³u,V=s³v. On F∞, U²−V²=d. In the complete27-dimensional potential space of the accepted paired normal form write
\[
s⁸w=W₀(U,V)+sW₁(U,V)+O(s²),
\quad Wᵢ\in\operatorname{span}\{1,U,U²,V,UV\}.
\]
The two coefficients are independent top-weight data. The scaled fieldsΔ=s²D,Ξ=s²E have
\[
Δs=-sV,\quad ΔU=-3UV,\quad ΔV=-3(U²+ds⁶),
\]
\[
Ξs=U,\quad ΞU=-3ds⁵,\quad ΞV=0.
\]
The accepted normal form is H=κh=−(E−2u)w+Aq+Bt¹⁰+Ktv(v²−d),g=Dw+C+Jqt⁴−Ku(v²−d),q=u²+d. Its exact trace is
\[
κh∞=-UW₁+B+KV³,
\]
\[
g∞=-3U(V\partial_U+U\partial_V)W₀+3VW₀+JU².
\tag{4}
\]
The apparent s⁻¹ term of the first expression cancels because8+2=10=0. The second uses8=3. The K term of g has weight9 and disappears from its weight-ten trace. On W₀=1,U,U²,V,UV the potential expression gives3V,0,−3U²V,−3d,−3U³. Hence
\[
g∞\in\operatorname{span}\{1,V,U²,U³,U²V\},
\tag{5}
\]
while h∞ has the complete seven-dimensional conic space with pole bound3 at both boundaries. The original cubic difference gives
\[
g∞³-h∞³=F(V),\quad F(V)=P(V-1)-(V²+d)⁵.
\tag{6}
\]
For the fixed original P,d, F has degree9 with F₉=p₉≠0 and F₈=1. It is not replaced by a monomial or a constant.

## 3. Matching modes reduce to one fixed cubic/quadratic problem

If mode II occurs at BOTH boundaries, the leading hσ is constant in t. Its weight-ten cubic polar coefficient at infinity vanishes on both sides, so h∞ has pole bound2 at both boundary points. Write
\[
h∞=A(V)+UB(V),\quad\deg A\le2,\quad\deg B\le1,
\]
\[
g∞=C(V)+cU(V²+d),\quad\deg C\le3,
\]
using(5). Put q=V²+d. The U coefficient in(6) is
\[
cq(3C²+c²q³)=B(3A²+qB²).
\tag{7}
\]
Its right degree is at most5. If c≠0, write C=C₃V³+C₂V²+C₁V+C₀. Comparing degrees8,7,6 gives
\[
3C₃²+c²=0,\quad C₂=0,\quad C₁=-dC₃,\quad C₃\ne0.
\]
The last equality uses6=1 in characteristic5. The polynomial part of g∞³ is C³+3c²Cq³; with C₂=0 it has NO V⁸ coefficient. The polynomial part of h∞³ is A³+3AqB², of degree at most6. This contradicts F₈=1. Therefore c=0.

Now h∞³∈k(V). The conic extension k(V,U)/k(V) has degree2 since q has simple roots and is not a square. The base contains cube roots of unity, so a nontrivial cube root has degree3, which cannot divide2. Thus h∞∈k(V),B=0 and necessarily
\[
F=C³-A³,\quad\deg C=3,\quad\deg A\le2.
\tag{8}
\]
If mode I occurs at BOTH boundaries, g∞ has pole bound2 at both points. Its restricted space(5) then makes it a polynomial in V of degree≤2. The same quadratic-extension argument makes h∞ a polynomial of degree3. This yields F=C_{≤2}³−A₃³, which is exactly(8) after replacing C by−A₃ and A by−C_{≤2}. Both matching-mode cases therefore require the SAME fixed gate. No mixed-mode conclusion is used in these reductions.

## 4. Complete algebraic-closure gate and exact sole-run certificate

Write fᵢ for the fixed coefficients of F. Every prospective C in(8) has
\[
C=α(V³+pV²+qV+r),\quad α³=f₉,
\quad p=f₈/(3f₉),\quad q=f₇/(3f₉)-p².
\]
Only r remains arbitrary over the FULL algebraic closure. Cubic phases ofα are not lost because onlyα³ enters
\[
G_r=f₉(V³+pV²+qV+r)³-F=\sum_{i=0}^{6}G_i(r)V^i.
\]
Set L=G₆,S=G₅,T=2G₄L+S². On L≠0 a prospective quadratic cube has normalized coefficients s=2S/L,t=T/L²; its four remaining coefficient constraints are EXACTLY
\[
G₃L²-3S³-2ST=0,\quad G₂L³-3T²-2S²T=0,
\]
\[
G₁L⁴-ST²=0,\quad G₀L⁵-T³=0.
\tag{9}
\]
They are also sufficient there, since a cube root of L exists over k. The denominator-zero branch must be checked separately.

The [sole execution receipt](../../Research/notes/oct03_ten_hour/split_twenty_boundary_cubic_quadratic_gcd_run_receipt.md) preserves the root-inspected fixed source, exact output and all asserted checks. Its one authorized run used one process/thread, an external15s bound, exit0 in0.06465587485581636s wall time, and immediately released core2. No replay or coefficient enumeration is performed here.

Using 𝔞²=𝔞+3 and the code[5A+B]=B+A𝔞, its saved exact ascending GF25[r] arrays are
\[
p=[18],\quad q=[3],\quad L=[1,11],\quad S=[1,2],\quad T=[10,23,7].
\]
The four equations in(9), in order, are
\[
[3,12,0,2,1],\quad[3,19,20,11,21,1],
\]
\[
[5,1,24,10,21,23,24],\quad[15,13,7,1,13,19,16,0,2].
\]
Their recorded Bézout coefficient arrays are
\[
[10,22,19,14,11,12,3,7],\quad[14,11,11,14,11,7,23],\quad[15],\quad[].
\]
The sole source's executed reconstruction assertion verifies their linear combination equals1. Their gcd is[1], with no L factor removed; the saturated gcd remains1. This unit-ideal certificate excludes a common root over ANY field extension, not merely GF25-rational points.

The unique L=0 value is r=[12]. The saved exact residual G is[7,21,16,21,20,20], of degree5, so it cannot be a nonzero polynomial cube: its positive degree is not divisible3. The exceptional branch is excluded too. Thus(8) is empty over the FULL algebraic closure.

Exact provenance, independently inspected in the [whole application audit](../../Research/notes/oct03_ten_hour/split_twenty_both_full_boundary_polar_modes_audit.md): [source](../../scripts/oct03_split_twenty_boundary_cubic_quadratic_gcd.py) SHA256 `01b86573724ad8f11e0674f63cca2a6d62ea47b117592661e64ae314aeb2465f`; [external exact output](../../../litt3-computation-data/oct03_ten_hour/split_twenty_boundary_cubic_quadratic_gcd_20261003.json) SHA256 `c7b68899f15c4a38dd054a0ebba1be7e92c663828a11810439ce38ceadaa7da5`; [external run receipt](../../../litt3-computation-data/oct03_ten_hour/split_twenty_boundary_cubic_quadratic_gcd_20261003.run_receipt.json) SHA256 `e6b03999e34d6ef68276a464cf03fe369cd05f1691fe89559ca50359e4a276f2`. The raw source snapshot, stdout and empty stderr remain external as linked by the human receipt. The fresh audit statically inspected formulas, algorithms and recorded fields; it performed no arithmetic replay.

## 5. Actual mixed-mode conclusion and genuine boundary multiplicities

Sections3–4 exclude mode II at BOTH boundaries for everyκ, and also mode I at BOTH. By the exhaustive original polar alternatives(3), ONLY the MIXED pattern remains. Its mode I boundary forcesκ³=−1 by Section1.

At the constant-h boundary, Dh has pole at most3 instead of its allowed4. Since Dh=G₂ρ withG₂≠0, the genuine sectionρ of4D+12F∞ vanishes along that boundary. At the linear-h boundary, its pole-four coefficient isσασ≠0, soρ is a unit there. Hence EXACTLY ONE distinct D boundary occurs in R, with positive multiplicity UNSPECIFIED; the other has multiplicity zero. This does not assert that the positive multiplicity is exactly1.

This closes only the matching-mode alternatives under BOTH entire original factors. Ifκ³≠−1, that BOTH-full sector is impossible. A retained phaseκ³=1 can be used only if independently proved for the actual packet. The mixedκ³=−1 case, single-full packets and general degree20 sources remain undecided. The two actual étale maps, original cubics, faithful joint field and exact conductor remain on the SAME C₀/T. No arbitrary polynomial pair supplies a source or an auxiliary endpoint leg, and no unmarked common-cover solution follows.

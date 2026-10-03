# Proof: three actual conductor sections violate paired critical-point parity

Version1, 3 October2026. Fresh independent [whole or canonical scope/fidelity audit](../../Research/audits/CANONICAL_FIFTEEN_SPLIT_THREE_SECTION_CONDUCTOR_EXCLUSION_AUDIT_2026_10_03.md): **PASS**, no mathematical correction. Original component evidence and audited input hashes are preserved. No numerical replay at integration.

## 1. Both actual cubics and the exact conductor

The [actual conic construction](canonical_ten_split_tensor_conic_bundle_exclusion.md) uses BOTH actual degree-fifteen finite étale X-maps on their SAME C₀, the exact joint field, q₀ identity, disjoint reduced infinity divisors and θ₁=κt¹⁶θ₂. It makes C₀ the normalization of the integral conic image C. On the smooth conic surface,
\[
u²-v²=d(t⁶-1),\qquad u=x₂+1,\quad v=t³(x₁+1),
\]
with boundary D=D₊+D₋, L=D+3F and actual effective conductor-adjoint R=C−6L, RF=3,RD±=0. Its section ρ has EXACT normalization pullback Δ, the conductor divisor.

The [paired actual adjoint construction](canonical_split_paired_cubic_adjoint_counterterms.md) gives a,b with actual restrictions ρy₂,t¹⁰ρy₁. Degree fifteen makes both integral errors vanish. In compatible regular finite frames its second-leg whole identity is
\[
a³-P(u-1)ρ³=γ₂Q(ρ\mathcal Da-a\mathcal Dρ),\quad γ₂\ne0,
\tag{1}
\]
where Q defines C and
\[
\mathcal Dt=v,\quad \mathcal Du=0,\quad \mathcal Dv=-3dt⁵.
\tag{2}
\]
The first-leg whole identity gives the SAME form after the ACTUAL endpoint swap s=t⁻¹,u₁=v/t³,v₁=u/t³. It transports the SAME conductor section, not an independently chosen adjoint. Indeed Ω_s=−t⁻²Ω_t, and the original spin identity changes the rational adjoint by a nonzero constant times t¹⁸. These are precisely the line-bundle transport factors. At the nonzero finite points used below they are local units.

Assume R is the sum of three distinct sections disjoint from D. The actual auxiliary obstruction forces R to meet both auxiliary points at EACH endpoint fiber. The [independently checked three-section factor ledger](../../Research/notes/oct03_ten_hour/split_fifteen_three_section_auxiliary_factor_ledger.md) gives the following explicit reduction. Its local whole-cubic lemma says that two nonconstant sections at the same auxiliary zero-fiber point both divide a; the swapped statement holds for b at infinity. A single nonconstant section at an auxiliary point also divides the appropriate extension by its odd normal-derivative order. Thus an endpoint profile2+1 forces the forbidden full ρ factor, excluded by the [full single-cubic theorem](canonical_fifteen_split_full_cubic_extension_exclusion.md). The only profiles are1+1+ordinary at both ends.

The ordinary-adjoint factor lemma forces the component at an ordinary infinity point into a and the component at an ordinary zero point into b. If the sets of two auxiliary components at the two ends agreed, their common ordinary component would again give both forbidden full factors. Hence the two auxiliary sets overlap in precisely one section. Relabel the sections so that Z₀ is auxiliary at both ends, Z₁ auxiliary only at zero, and Z₂ auxiliary only at infinity. The necessary factors and nonvanishing are
\[
Z₀+Z₁\mid a,\qquad Z₀+Z₂\mid b,
\qquad a|Z₂\ne0,\quad b|Z₁\ne0.
\tag{3}
\]
The [constant-q₀ conductor theorem](canonical_fifteen_split_constant_q0_conductor_exclusion.md) excludes the four constant sections. No derivative-square cancellation is made on a component where its extension vanishes identically.

## 2. Exact conductor parity at a simple normal zero

Let Z be a smooth multiplicity-one component of R, p a finite interior point on no other component, and assume a|Z is generically nonzero. Restrict(1) to Z and cancel a in its function field:
\[
(a|Z)²=-γ₂(Q|Z)(\mathcal Dρ|Z).
\tag{4}
\]
Take a PRIME local equation z of Z and write ρ=εz in a regular frame. Frame derivative terms contain z, so Dρ|Z=εDz|Z. If Dz|Z has exact order1 at p, (4) implies Iₚ(C,Z)+1 is even.

In fact Iₚ(C,Z) is even. It is zero if p∉C. Otherwise exact ν*R=Δ and the absence of other local R components give
\[
Iₚ(C,Z)=\sum_{P\mapsto p}\operatorname{ord}_P(ν^*z)
=\deg(Δ|_{ν^{-1}(p)})=2δₚ(C).
\tag{5}
\]
The last equality is the local conductor-degree identity for a reduced Gorenstein plane curve, valid for any number of normalization branches. Thus (4) contradicts a simple normal-derivative zero. Such a zero MUST lie on another R component. The actual first cubic gives the swapped version for b, with the same (5).

This statement concerns a PRIME normal equation. For example v−v_Z(t) contains the mirror u=−u_Z(t) at a zero of u_Z. Its extra apparent derivative zeros are not used.

## 3. Complete geometric forms with general endpoint signs

Choose δ²=−d. The nonconstant auxiliary-both sections are
\[
u=ε₀δ(1+2α²t²),\qquad
v=ε_∞δ(t³+2αt),\qquad α³=1,
\quad ε₀,ε_∞\in\{1,-1\}.
\tag{6}
\]
Set τ=αt and rename τ as t. Its cube and sixth power are unchanged, so neither x₁ nor x₂ changes; the SAME fixed P remains on both actual legs. The q₀ and spin identities persist with nonzero constant rescaling. Thus α=1. No endpoint-coordinate sign flip is made.

Set u₀=−ε₀δ,w₀=−ε∞δ,η=w₀/u₀∈{1,−1}. The opposite auxiliary values give
\[
Z₁:\quad u=u₀\bigl(1+(b²/2)t²+χb³t³\bigr),\quad
v=u₀\bigl(bt+χb²t²+(b³/2)t³\bigr),
\quad b⁶=1,\quad χ²=3,
\tag{7}
\]
and
\[
Z₂:\quad u=w₀\bigl(at²+βa²t+a³/2\bigr),\quad
v=w₀\bigl(t³+(a²/2)t+βa³\bigr),
\quad a⁶=1,\quad β²=3.
\tag{8}
\]
These are complete forms, not a bounded numerical classification. For a section auxiliary at zero, write u=u₀(1+At²+Bt³),v=u₀(Ct+Et²+Gt³). Polynomiality follows from disjointness from D and degree≤3 at infinity. The conic gives A=C²/2,B=CE,E(AC−G)=0. The E=0 branch is auxiliary at both ends. Auxiliary ONLY at zero therefore has E≠0,G=C³/2,E²=3C⁴,C⁶=1, giving(7). The actual coordinate swap gives(8). The auxiliary-both branch similarly gives(6), with constant sections already excluded.

## 4. The true critical point on Z₂ cannot lie on Z₀

The u-polynomial in(8) has its unique critical point at
\[
t₂=-βa/2=2βa.
\]
Direct substitution in characteristic five gives
\[
t₂²=2a²,\quad t₂⁶=3,\quad
u₂(t₂)=w₀a³,\quad v₂(t₂)=w₀βa³.
\tag{9}
\]
Both u and v are units. The point is interior, at nonzero finite base parameter, and its fiber is not one of the six reducible fibers. Since v is a unit, (t,u) are regular surface coordinates and z=u−u₂(t) is a PRIME equation of Z₂. Then
\[
\mathcal Dz|Z₂=-u₂'(t)v₂(t)
\]
has exact order1 at t₂, because u₂′ is linear of nonzero slope and v₂(t₂) is a unit.

If Z₀ passed through this point, equality of its u coordinate −u₀(1−a²) with w₀a³ would force
\[
a²=1+ηa³.
\]
The right side is0 or2, since a³,η∈{1,−1}. The first is impossible for a≠0. The second contradicts (a²)³=a⁶=1, since2³=3. Thus Z₀ misses the point. By(3) and the source parity lemma, Z₁ MUST pass through it.

## 5. That crossing fixes incompatible cubic signs

Put p=ab,r=p³∈{1,−1},h=χ/β∈{1,−1},s=a³∈{1,−1}. Equality of BOTH coordinates at t₂, using(7)–(9), is
\[
1+p²+2hr=ηs,
\qquad 2p+2hp²+2r=ηs.
\tag{10}
\]
For h=1, subtraction gives p²+2p−1=0. This yields p³=p−2p²=3, contradicting p³=±1.

For h=−1, subtraction gives
\[
p³-2p²-2p+1=(p+1)³=0.
\]
Hence p=−1,r=−1, and(10) gives ηs=−1. The necessary conditions are therefore
\[
χ=-β,\qquad ab=-1,\qquad a³=-η,\qquad b³=η.
\tag{11}
\]

Swap the ACTUAL endpoints, s=t⁻¹,û=v/t³,v̂=u/t³. It exchanges the section roles: Z₁ now has the auxiliary-infinity-only form(8), with parameters(b,χ) and leading sign u₀, and Z₂ the auxiliary-zero-only form(7), with parameters(a,β) and zero sign w₀. Z₀ retains(6), with the endpoint signs exchanged. The sign ratio is u₀/w₀=η.

The first actual cubic and b|Z₁≠0 make Sections2–5 applicable in this swapped setup. Its defining and adjoint transport factors are units at the relevant nonzero finite critical point. The source conductor remains EXACTLY Δ. Consequently(11) now forces b³=−η,a³=η. This contradicts the original b³=η,a³=−η, because characteristic five is not two and η≠0. The three-section sector is excluded.

## Scope and provenance

The [self-contained source note](../../Research/notes/oct03_ten_hour/split_fifteen_three_section_critical_parity_exclusion.md) retains the derivation and the corrected prime-generator issue. The exclusion needs BOTH original cubics and their EXACT common conductor; an arbitrary section list or square-ratio model supplies neither. The proof keeps both finite étale endpoint legs on their SAME actual source and does not descend them to a section. Other reducible conductor-adjoint configurations and the unmarked common-cover problem remain separate.

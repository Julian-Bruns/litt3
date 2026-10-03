# Proof: a squarefree anti-diagonal derivative and all finite endpoint cases

Version1, 3 October2026. [Fresh independent whole scoped review](../../Research/audits/OCT03_CRITICAL_ANTI_NEW_CERTIFICATE_AND_CONIC_APPLICATION_WHOLE_AUDIT_2026_10_03.md): PASS, no required mathematical repairs. Original audited input pins and executed-evidence provenance are preserved; only this status banner changes at integration.

## 1. The exact new certificate

Work over F25=F5[β]/(β²−β−3), encoding a+bβ by a+5b. The fixed centered polynomial has ascending coefficients[8,3,21,23,22,12,22,21,1,22,1]; d0=[23], p0=[8], p1=3 and p9=[22] are nonzero. Put pe=(p(U)+p(−U))/2 and po=(p(U)−p(−U))/2.

The ONE new [combined source](../../scripts/oct03_all_phase_critical_anti_contact_three_and_negative_two_gate.sage) executed once, with one worker and all eight numerical thread variables set to one. It records H,H′,pe,pe′,po,po′ and three exact identities
\[
B_0H+B_1H'=1,\qquad C_0p_e+C_1p_e'=1,
\qquad D_0p_o+D_1p_o'=1.
\]
All coefficient vectors and direct source assertions are in the [fresh external stdout](../../../litt3-computation-data/oct03_all_phase_critical_anti_contact_three_and_negative_two_gate_20261003T1814/stdout.jsonl). The [receipt](../../../litt3-computation-data/oct03_all_phase_critical_anti_contact_three_and_negative_two_gate_20261003T1814/receipt.json) binds source SHA256 a2d1113b51b457b9f438a2dd4d1d619acf5c48ac6f60abb01f04b2a6c89fe8fc and stdout SHA256 d6fa34158de13939d94a3783882c86451d057512750aeca7e5b030789ac1b581. It has exit zero, no timeout, empty stderr, external wall2.724 seconds and arithmetic0.0574 seconds. The hard external process-group bound was30 seconds. The earlier H-only prepared source was not executed; no settled certificate was replayed.

These polynomial identities exclude EVERY geometric repeated root of the three polynomials. No parameter sampling or phase enumeration enters the argument.

The archived source's preparation-only docstring records its earlier state. The receipt and emitted assertions document the authorized execution; that historical comment is retained to preserve the certified source hash.

## 2. Actual frozen contact at the ordinary anti-diagonal

Let z(P)³=1, A(P)=a≠0, B(P)=−a and p(a)p(−a)≠0. Write k=ordP(z−z(P)), and u=A−a; the first actual étale X-leg makes u a source parameter. Put v=ordP q(A), equal0or1. Differentiation gives
\[
2B\,dB=2z^3A\,dA+3z^2q(A)\,dz.
\]
Cubing the ORIGINAL θ-comparison and subtracting the cube of the first term gives
\[
K=B^3p(B)^2-\rho z^{33}A^3p(A)^2,
\qquad \operatorname{ord}_P K\ge k-1+v.
\]
Indeed ordP(dz)≥k−1, including when characteristic five kills its leading coefficient; if dz=0 the cleared numerator is identically zero. The other endpoint factors are units, and higher terms in the difference of cubes cannot lower this estimate.

The q-relation gives ordP(B+A)=k+v because B−A is a unit. Freezing B to−A changes its polynomial term by order≥k+v, and freezing z³³ to1 changes its phase term by order≥k. Thus
\[
-A^3\bigl(p(-A)^2+\rho p(A)^2\bigr)
\]
has contact at least k−1 in the ACTUAL parameter u. This includes q-zero points and does not assume a uniform or Galois local extension.

Put R(U)=p(−U)/p(U) on this unit chart. Direct differentiation gives
\[
R'=-H/p^2,\qquad H=p'(-U)p(U)+p(-U)p'(U).
\]
If Gρ=p(−U)²+ρp(U)² has a triple root at a, then R²+ρ has a triple root there. Its derivative −2RH/p² therefore has order at least two. Since2,R,p are units, H(a)=H′(a)=0, contradicting the first Bézout identity. Hence k≥4 is impossible at the ordinary anti-diagonal for everyρ.

Forρ=−1 the frozen bracket is−4pepo. The two factors have no common root: otherwise p(a)=p(−a)=0, contrary to the settled no-opposite-P-root input in [the all-phase critical proof](finite_uniform_wild_critical_value_exclusion.md). The other two Bézout identities make each factor squarefree. Contact at least two is therefore impossible, proving k≤2 in this phase.

## 3. All remaining finite types whenρ≠1

Suppose first A(P)=B(P)=a≠0 and p(a)≠0. If k≥2, the q-identity gives ord(B−A)=k+v≥2. Thus dB/dA and p(B)/p(A) have residue one. The original cubed comparison
\[
\left(\frac{dB}{dA}\right)^3
=\rho^{-1}z^{-24}\left(\frac{p(B)}{p(A)}\right)^2
\]
forcesρ=1, since z(P)²⁴=1. This contradicts the stated phase.

If either centered coordinate is zero, both are zero. In u=A, let B=λu+… . For k≥4, the q-identity forcesλ²=1 and the cubed comparison forcesλ³=ρ⁻¹. Sinceρ≠1, necessarilyλ=−1 andρ=−1. Write B=−u+w with ordw=k−1≥3. Then B′=−1+O(u²), while
\[
p(B)/p(A)=1-2(p_1/p_0)u+O(u^2).
\]
The cubed comparison has a nonzero linear coefficient on its right side and none on its left, a contradiction. Centered k≥4 is impossible.

If exactly one endpoint is a finite P-branch, its centered value is nonzero and q is a unit. The constant q-relation makes the other value its negative. The branch endpoint has q-variation of source order three, while the ordinary endpoint has q-variation of order one. Hence z³−1 has exact order one; no k≥4 occurs.

If both endpoints are P-branches, the settled no-opposite-root input forces their centered values equal to one simple p-root a. Both a and q(a) are units. For k≥4, the q-identity gives ord(B−A)=k>3. The actual étale branch parameters make A−a and B−a have order three and equal leading coefficients. Consequently dB/dA and p(B)/p(A) again have residue one, forcingρ=1. This is impossible.

The constant q-relation allows only the diagonal and anti-diagonal finite endpoint values. The preceding cases are exhaustive, proving the finite source index bound.

## 4. Transfer to an actual whole block

Retain an actual separating Q/z and π:C0→Q, without replacing the endpoint source. Local indices multiply. Forρ≠1, every common infinity point at unit z has source index EXACTLY three by the accepted original third jet; see [the common-infinity bound proof](canonical_ten_whole_block_common_infinity_bounds.md). At a critical value every finite point has source index≤3 by §§2–3.

Therefore every Q/z-index f above z³=1 is at most three. If f=2or3 and a point above it had π-index e≥2, its source index ef would be at least four, contradicting either the finite bound or the common index three. All such π-fibers are unramified. No X-leg descends to either quotient, and no remaining global source configuration is excluded by this transfer alone.

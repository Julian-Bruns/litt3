# Proof: resonance three and the quadratic-zero intersection budget

Version1, 3 October2026. [Fresh independent whole final audit PASS](../../Research/audits/CANONICAL_FIFTEEN_SPLIT_CONSTANT_Q0_CONDUCTOR_EXCLUSION_AUDIT_2026_10_03.md), including the checked local branch wording. No computation is used.

## 1. The actual conductor and the four constant sections

Retain BOTH actual finite étale maps and all source identities in the statement. The accepted conic construction has u=x₂+1,v=t³(x₁+1), u²−v²=d(t⁶−1), disjoint boundary D±, D=D₊+D₋ and L=D+3F. The actual C has normalization C₀, g(C₀)=121, CF=15, CD±=0 and CL=45. Its normalization-duality section gives the effective actual divisor
\[
R=C-6L,\qquad RF=3,\quad RD_\pm=0,\quad RL=9,
\qquad\nu^*R=\Delta.
\]
In the blowup basis C=15B+45F−ΣaᵢEᵢ, Σaᵢ=45. The integer minimum Σaᵢ²≥339 gives C²≤336 and
\[
\delta=p_a(C)-121\le33,\qquad\deg\Delta=2\delta\le66.
\]
The independently audited [vertical-adjoint exclusion](canonical_fifteen_split_disjoint_vertical_adjoint_exclusion.md) also gives F∞ not a component of R. The actual homogeneous cubic-Wronskian identity and its U=0 unit obstruction are retained from that proof; no additional extension or source model is presumed.

Fix α₁²=α₂²=−d. The equations u=α₂,v=α₁t³ define a smooth rational section Z. It avoids D, has FZ=1 and DZ=0. Adjunction gives Z²=0, and consequently Z is nef: all other integral curves have nonnegative intersection with it, and its self-intersection is zero. Write Z′ for the section with the other sign of α₁ and the same α₂. Then
\[
Z+Z'=L,\qquad LZ=3,
\]
since the zero divisor of u−α₂ is precisely Z+Z′ and its pole bundle is D+3F∞. This equality is linear as well as numerical. The sections meet at t=0 with contact3, but the actual C avoids that point: at a noncommon H₁-point, t has a simple zero and q₀(x₁) has pole6, so q₀(x₂)=t⁶q₀(x₁) has nonzero finite value. Similarly it has nonzero q₀(x₁) at a noncommon H₂-point. At infinity the constant sections have U=0,V=α₁, which is also outside the actual C by x₂ pole3 and t pole1. Therefore EVERY normalized point of C∩Z has a finite nonzero t-value and both actual q₀-values zero.

## 2. At a simultaneous quadratic zero, all branches share two jets

At such an image point write t=a≠0, xᵢ+1=αᵢ, and choose w=x₂−(α₂−1). The fixed P is nonzero at these q₀-root values. The actual étale map to X therefore makes w a local parameter on EACH normalized branch. The conic surface solves ξ₁=x₁+1 as a regular function ξ₁(t,w) with ξ₁(t,0)=α₁, since α₁ and t are units. At w=0,
\[
r(t)=\xi_{1,w}(t,0)=\frac{\alpha_2}{\alpha_1t^6},\qquad
\xi_{1,t}(t,w)=w\,\frac{-6r(t)}t+O(w^2).
\]
The actual yᵢ³=P(xᵢ) are units here. Choose their actual local cubic roots and set Y(t,w)=(y₁/y₂)². On a normalized branch the canonical differential identity is exactly
\[
\xi_{1,w}+\xi_{1,t}t'(w)=\kappa t^{16}Y(t,w).
\]
At w=0 it requires r(a)=κa¹⁶Y(a,0). For a FIXED image (x₁,x₂,t), this determines the relative cubic phase uniquely, because squaring permutes μ₃. Simultaneous scaling of both actual roots by a cube root leaves Y unchanged. Thus all actual branches at this image use the SAME regular function Y(t,w), not arbitrarily varying phase equations.

Write A=ξ₁,t/w and B=κt¹⁶Y−ξ₁,w. The branch equation is the regular-singular ODE
\[
wA(t,w)t'(w)=B(t,w),\qquad B(a,0)=0.
\]
Because ξ₁(t,0)=α₁ is constant, Y(t,0) is constant in t. Thus
\[
A(a,0)=-6r(a)/a\ne0,\qquad
B_t(a,0)=(16+6)r(a)/a=22r(a)/a,
\qquad B_t/A=-22/6=3\text{ in characteristic five}.
\]
For a formal solution t(w)=a+c₁w+c₂w²+…, the recursion at order j has coefficient jA(a,0)−B_t(a,0) multiplying cⱼ. It is nonzero for j=1,2. The remaining terms depend only on earlier coefficients and on the SAME A,B. Hence c₁ and c₂ coincide for all branches at this image.

Since each branch is smooth over w, two DISTINCT branches have intersection multiplicity at least3. No uniqueness at the resonant coefficient j=3 or afterward is assumed. For b such branches the conductor exponent on each is the sum of its pairwise contacts, hence at least3(b−1). For a single smooth branch it is zero. This gives the essential local alternative
\[
\Delta_p=0\quad\text{or}\quad\Delta_p\ge3,
\]
and the quantitative cluster bound ΣₚΔₚ≥3b(b−1).

## 3. A multiplicity-one or multiplicity-two component exceeds the total conductor

Suppose R contains Z with maximal multiplicity m and write R=mZ+R₀, where R₀ is effective and does not contain Z. Let
\[
q=R_0Z=RZ,\qquad N=CZ=6LZ+RZ=18+q.
\]
The equality R₀Z=RZ uses Z²=0. Since Z and Z′ are both nef and Z+Z′=L,
\[
0\le q\le RL=9.
\]
Every normalized point over C∩Z has intersection multiplicity EXACTLY one: at its nonzero finite t-value the other component Z′ is absent, and the local equation of Z is a unit times x₂−(α₂−1), the actual étale parameter w. Consequently N counts normalized branches, including every branch at a multiple image.

If m=1 or2, an image in C∩Z outside R₀ would have actual conductor Δₚ=m on each branch, by the exact pullback ν*R=Δ. This contradicts Section2. Thus all N branches are supported at images in R₀∩Z. There are at most q such images. For q=0 the contradiction is immediate. For q>0 let b_Q be their branch counts. Every branch of C at such an image passes through the same ordinary q₀-root pair, because x₂ is the fixed q₀-root and t≠0; so Section2 applies to all pairs. The total conductor bound and Cauchy's inequality give
\[
2\delta\ge3\sum_Q b_Q(b_Q-1)
\ge3(N^2/q-N)
=54(18+q)/q\ge162,
\qquad1\le q\le9.
\]
But2δ≤66 by Section1. This excludes both m=1 and m=2. All other singularities could only increase the left side; no concentration is omitted.

## 4. Multiplicity three leaves the other auxiliary infinity point uncovered

Because RF=3 and FZ=1, the remaining possibility m≥3 forces m=3 and R₀ vertical. The accepted vertical-adjoint exclusion removes F∞. Therefore R|F∞=3Z|F∞ is supported at only ONE of P±. At the other auxiliary point ρ∞ is a unit, and Q∞ is a unit since the actual C avoids U=0. The retained homogeneous surface identity then gives h³−U¹⁰=unit·δh for a regular h at that point, with δ=U·unit·∂_U. Its all-order contradiction was proved in the accepted degree-fourteen/degree-fifteen arguments. Hence m=3 is impossible as well.

This excludes every constant q₀-zero section as a component of the ACTUAL conductor adjoint. Both original finite étale maps and their actual cubic phases were indispensable in the local jet argument. The auxiliary section is never assigned an X-map or used as a replacement source. The other nonvertical degree-fifteen conductor sectors and the unmarked common-cover problem remain open.

The [derivation note](../../Research/notes/oct03_ten_hour/split_fifteen_constant_q0_conductor_component.md) and [independent focused check](../../Research/notes/oct03_ten_hour/split_fifteen_constant_q0_conductor_component_check.md) record the new route. A fresh whole audit of this exact canonical pair is required before integration.

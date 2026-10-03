# Proof: actual infinity jets remove the vertical adjoint and bound degree fourteen

Version1, 3 October2026. [Independent focused audit PASS](../../Research/audits/CANONICAL_FOURTEEN_SPLIT_DISJOINT_CUBIC_ADJOINT_NORMAL_FORM_AUDIT_2026_10_03.md). Mathematical scope is unchanged by canonical metadata integration.

## 1. The singular-image adjoint and whole cubic identity

Use the accepted actual conic construction and the conductor-adjoint mechanism proved in [the degree-thirteen proof](canonical_thirteen_split_disjoint_cubic_adjoint_exclusion.md), with the following degree change made explicitly. Here g(C₀)=113, CF=14, CD±=0, CL=42, and K_SC=−28. The actual θ₂ produces a conductor section of O_C(C−D−18F). The independent vanishings H¹(−D−18F)=H¹(−D−8F)=0 and fixed factors5D and2D are unchanged. They produce an effective divisor
\[
R=C-6L,\qquad RF=2,\quad RD_\pm=0,
\]
and a section a of3D+10F+R whose actual restriction is ρy₂, where ρ defines R. The divisor R pulled back to C₀ is exactly the conductor divisor: its degree is2δ. Both actual maps and the jointly generated field remain essential inputs.

Choose a rational R frame having total generic boundary pole degree2. The actual defining section Q of C has generic poles6D+R_polar; the extended a has poles3D+R_polar. The exact residue comparison remains 𝒟Q=λa²/ρ on C, with 𝒟(t)=v, 𝒟(u)=0, 𝒟(v)=−3dt⁵. The quotient from the actual cubic and the Wronskian both have generic pole divisor at most4D+2R_polar, total degree12. Since the actual generic t-fiber has14 reduced points, their agreement on C promotes to the WHOLE surface identity
\[
a^3-P(u-1)\rho^3=cQ(\rho\mathcal Da-a\mathcal D\rho),\qquad c\ne0.
\]
This argument uses characteristic-free divisor-degree counts on the generic conic, not a tame ramification assumption or an arbitrary polynomial source.

Near the base infinity, in compatible regular local frames for R, put s=t⁻¹, U=t⁻³u,V=t⁻³v, and Δ=s²𝒟. After factoring the10F difference between a and ρ, the same identity reads
\[
a_0^3-P_\infty(s,U)\rho_0^3
=cQ_0(\rho_0\Delta a_0-a_0\Delta\rho_0),
\]
where P∞=s³⁰P(s⁻³U−1), Δ(s)=−sV, Δ(U)=−3UV, Δ(V)=−3(U²+ds⁶). The frame derivative cancels in the Wronskian because the remaining weight difference10 is zero in characteristic5. Its boundary restriction has P∞=U¹⁰ and δ=Δ|F∞=−3(UV∂U+U²∂V).

Every actual infinity branch has s as a local parameter, and U is a unit by the actual pole orders of x₂ and t. Hence Q₀ is a unit at P±. If ρ₀ were a unit at either P, h=a₀/ρ₀ would give the impossible local equation h³−U¹⁰=unit·δh proved in the degree-thirteen audit. Therefore, unless R contains F∞, its degree-two restriction must be P₊+P₋.

## 2. Actual infinity branches meet with contact one or at least five

This uses the original θ₁ identity, rather than only the surface cubic model. At an actual infinity point write H=t⁻¹⁰y₂. It is a unit and
\[
H^3=P_\infty(s,U),\qquad
\frac{V'}{y_1^2}=\kappa\frac{-3U+sU'}{H^2}.
\]
The latter equality is interpreted in its regular canonical form if y₁=0. Since U is a unit, the conic equation solves U as a regular function of(s,V) near the common image point.

If y₁ is nonzero there, both y₁³=P(V−1) and H³=P∞ are units and admit their chosen regular local roots. Eliminating U′ yields a regular first-order ODE V′=F(s,V). Simultaneously scaling y₁ and H by the same cube root leaves it unchanged. There are therefore three phase classes; the initial slope is −3κU₀y₁(0)²/H(0)² and distinguishes them. Two branches with the same slope have the same ODE and initial value. Formal recursion uniquely determines the coefficients of s,s²,s³,s⁴, since1,2,3,4 are units in characteristic5. Their projected series consequently agree modulo s⁵.

If y₁=0, its étale endpoint map makes w=y₁ a local coordinate and V−V₀ is a unit times w³. Writing θ₁=3dw/P′(V−1) gives a regular ODE for w as a function of s. Simultaneously scaling w and H by a cube root preserves its projection. After fixing the H phase, the same formal recursion gives identical projected jets through s⁴ for all branches with the given image point.

Thus for two DISTINCT smooth image branches at infinity their intersection multiplicity is either1, for different slopes, or at least5, for equal slopes. There are at most three distinct tangent directions at a common image point. This does not assert uniqueness beyond the fourth jet in characteristic5.

## 3. No complete infinity fiber can be in the actual adjoint

Suppose R contains F∞. Its positive intersection with each D± forces D± to be components of R: otherwise every intersection there is nonnegative and the total cannot be zero. Since RF=2, those two boundary sections have multiplicity1 and exhaust all horizontal components. Therefore
\[
R=D+V_{\rm vert},\qquad V_{\rm vert}D_\pm=3.
\]
Its multiplicity k along F∞ lies in{1,2,3}. At every finite actual infinity image point the remaining vertical components and D are absent. The pulled-back conductor consequently has EXACT order k on each normalized infinity branch. All branches are smooth because s is a parameter. For a reduced curve consisting of smooth local branches, the conductor order on one branch is the sum of its intersection multiplicities with all the others.

If k=2, Section2 forces every cluster to have exactly three transverse branches. Fourteen branches cannot be partitioned into triples. If k=3, a two-branch cluster would require contact3, and a three-branch cluster would require a contact2; both are forbidden. A cluster of four would have to be ordinary with four distinct tangents, contradicting the three-phase bound. A larger cluster already has conductor order at least4. Thus k=3 is impossible.

If k=1, every cluster is a transverse pair, so there are seven distinct image points. In the local-frame surface identity of Section1, ρ₀ has one factor s. Restricting to F∞ first gives a₀³=0, so a₀ also has a factor s. It has exactly one such factor: more would make the actual ratio a₀/ρ₀=t⁻¹⁰y₂ vanish on every actual infinity branch, contrary to its being a unit. Write ρ₀=sρ₁,a₀=sa₁. The derivative of the common factor cancels in the Wronskian. Divide the identity by s² and restrict to F∞; it gives δ(a₁/ρ₁)=0.

Here ρ₁ vanishes precisely on the two boundary points as a section, and is a unit at every finite point. The rational function h=a₁/ρ₁ has poles of order at most4 at each boundary point and none elsewhere. In characteristic5, δh=0 makes h a fifth power in the rational conic field. A nonconstant fifth power would have a pole of order at least5 somewhere; hence h is constant. The actual infinity units make that constant nonzero. At every actual infinity image, h³=U¹⁰. This equation has at most two U-values and at most four conic points. It cannot account for the seven node images. This excludes k=1 and proves that F∞ is absent from R.

## 4. Exact residual geometry and smooth infinity

Section1 now implies R|F∞=P₊+P₋. In particular R contains neither boundary section. Since RD±=0, no vertical component can occur either: every vertical component meets at least one boundary section and all intersections of the remaining components with D± are nonnegative.

Write C=14B+42F−ΣaᵢEᵢ in the six-fiber blowup basis. The residual class is
\[
R=2B+6F-\sum(a_i-6)E_i.
\]
It has no fiber component, so its intersections with Eᵢ and F−Eᵢ are nonnegative. Therefore6≤aᵢ≤8. Their sum42 makes the number of6s equal the number of8s, say j≤3. Adjunction gives δ=21−j and R²=6−2j. All conductor zeros lie on R, and R∩F∞ consists only of P± outside C. Thus the actual image is normal, hence smooth, at each infinity point. Its fourteen normalized infinity points have distinct images and Q∞ has fourteen distinct roots.

## 5. The actual Laurent normal form

At F∞ choose the balanced R frame whose polar divisor is D. Then ρ∞ is proportional to U, and a∞ has poles at most4 at each boundary. The surface identity and δ(P±)=0 force a∞ to vanish at both P±. Thus h=a∞/ρ∞ is regular on the affine conic and has poles at most3 at either boundary. Put z=U+V, so z∈k× on this affine conic and
\[
U=(z+d/z)/2,\qquad V=(z-d/z)/2,\qquad
\delta=-3Uz\partial_z.
\]
The boundary identity becomes h³−U¹⁰=γq(z)z h′(z), with γ≠0. Here q is the defining section of actual C∩F∞ and has poles exactly7 at both boundary points. The Laurent function h has degrees at most3 in each direction. Since U¹⁰ has exact pole10 at each boundary while h³ has pole at most9, the equation forces z h′, and hence h, to have exact poles3 at each.

Write h=z⁻³H(z), H degree6 with nonzero constant and leading coefficient. Then z h′=z⁻³K, K=zH′−3H has degree6 and nonzero constant. Also
\[
h^3-U^{10}=z^{-10}B,
\qquad B=zH^3-2^{-10}(z^2+d)^{10}.
\]
Thus q is a nonzero scalar times z⁻⁷B/K. Its regularity on the affine conic proves K|B, its two exact boundary poles give quotient degree14 and nonzero constant, and its fourteen distinct actual roots make B/K squarefree. These are exact necessary conditions supplied by the actual cubic source.

No claim of emptiness or realization of this polynomial normal form is made. Its fourteen roots must still belong to the same globally defined actual source with BOTH étale X legs, the original θ₁ identity and the actual conductor. General split degree15 and higher, common infinity and nonsplit comparisons remain outside this theorem.

The theoretical exploration and actual infinity ODE details are recorded in [the higher split note](../../Research/notes/oct03_ten_hour/split_higher_cohomology.md). No computation or settled-certificate replay is used.

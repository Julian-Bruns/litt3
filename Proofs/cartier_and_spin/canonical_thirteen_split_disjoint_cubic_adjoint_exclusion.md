# Proof: a conductor-adjoint cubic identity excludes split degree thirteen

Version1, 3 October2026. [Independent whole-proof audit PASS](../../Research/audits/CANONICAL_THIRTEEN_SPLIT_DISJOINT_CUBIC_ADJOINT_AUDIT_2026_10_03.md), with no required corrections. See the [statement](../../Theorems/cartier_and_spin/canonical_thirteen_split_disjoint_cubic_adjoint_exclusion.md). Both actual étale maps remain on their same source.

## 1. Actual normalization and the conic surface

Set u=x₂+1 and v=t³(x₁+1). The actual quadratic identity is u²−v²=d(t⁶−1). Use the smooth projective conic surface S from the accepted [conic proof](canonical_ten_split_tensor_conic_bundle_exclusion.md). It has six degenerate fibers, two disjoint boundary sections D± of self-intersection−3, D=D₊+D₋, fiber class F, and
\[
K_S=-D-2F,\quad D^2=-6,\quad DF=2,\quad L=D+3F,\quad L^2=6.
\]
The actual map C₀→S extends, avoids D because H₁∩H₂=∅, and is birational onto its integral image C by the actual equality k(C₀)=k(t,u,v). Thus ν:C₀→C is the normalization, CF=13, CD±=0, CL=39, K_SC=−26, and either actual étale map gives g(C₀)=105. The simple t-poles make t separating.

C need not be smooth. If δ=p_a(C)−g(C₀), then C²=234+2δ. Hodge gives C²≤253.5 and adjunction makes C² even, so C²≤252 and δ≤9. Neither this improvement nor a prescribed singularity type is needed below.

For rational representations of divisor classes, fix B=D₋ and in each degenerate fiber let Eᵢ be the component not meeting B. These six disjoint−1 curves can be contracted to a ruled surface with negative section B²=−3, namely F₃. The Picard basis is B,F,E₁,…,E₆, with D₊=B+3F−ΣEᵢ. Consequently
\[
C=13B+39F-\sum a_iE_i,\qquad\sum a_i=39,
\]
as a linear class. The surface is rational and its Picard intersection lattice has no numerical kernel. Put bᵢ=aᵢ−6; then the class C−6L is B+3F−ΣbᵢEᵢ. No numerical allocation is presumed realized by an actual source.

## 2. Actual duality supplies the missing extension

The exact actual differential θ₂ has divisor16H₂, where H₂=ν*F∞ is reduced. Finite duality for the normalization of the integral Cartier curve gives
\[
\nu_*\omega_{C_0}\subset\omega_C.
\]
Locally, after trivializing the invertible dualizing module of C, this inclusion is Hom(O_C₀,O_C)⊂O_C, the conductor ideal. Thus θ₂ determines a nonzero global section
\[
\sigma_C\in H^0(C,\omega_C\otimes O_C(-16F))
=H^0(C,O_C(C-D-18F)).
\]
Its pullback has precisely the conductor zero divisor. This construction remains valid at singular points; it does not assume θ₂ or y₂ is an ordinary function on the singular image.

For k=18 or8, the line bundle E_k=O_S(−D−kF) has h⁰=0 because E_kF=−2. Rational-surface Riemann–Roch and Serre duality give
\[
\chi(E_k)=k-1,\qquad h^2(E_k)=h^0((k-2)F)=k-1.
\]
Hence H¹(E_k)=0. In particular σ_C lifts to σ∈H⁰(S,O_S(C−D−18F)). The zero divisor of σ intersects each D± by−15. Since D₊D₋=0, removing its multiplicity along that section leaves a divisor with nonnegative intersection there; each multiplicity is therefore at least5. Factor the canonical section of5D, obtaining
\[
0\ne\rho\in H^0(S,O_S(R)),\qquad R=C-6D-18F=C-6L.
\]
Here and below R also denotes the effective zero divisor of ρ.

The product σ_Cy₂ is a regular global section of O_C(C−D−8F). Indeed conductor multiplication sends every normalization section to the corresponding regular section on C, and y₂ has poles bounded by10F. By H¹(−D−8F)=0 it lifts to a section A on S. Its zero divisor intersects each D± by−5, so A contains at least2D. Dividing by the canonical section of2D gives
\[
a\in H^0(S,O_S(C-3D-8F))
=H^0(S,O_S(3D+10F+R)).
\]
On C, after using the canonical nonvanishing section of D to trivialize D|_C, this is exactly a=ρy₂. The same procedure also extends ρt¹⁰y₁, although only the original y₂ extension is needed for the contradiction.

## 3. The effective residual divisor has no infinity fiber

The actual residual divisor satisfies
\[
RF=1,\qquad RD_+=RD_-=0.
\]
There is exactly one horizontal irreducible component H, with multiplicity1 and degree1 over the base. If H is neither boundary section, all component intersections with D± are nonnegative. Every irreducible vertical component of this conic bundle meets at least one boundary section, so the two zero intersections force the absence of all vertical components. If H=D₊, its zero intersection with D₋ forces every vertical component to avoid D₋; no smooth whole fiber can occur. The case H=D₋ is symmetric. In particular R does NOT contain the smooth F∞.

Thus R|F∞ is an effective divisor of degree1. On its affine conic V²=U²−d, at least one of
\[
P_\pm=(U=0,V=\pm\sqrt{-d})
\]
is outside R. These two points are distinct.

## 4. Actual residue and a global cubic-Wronskian identity

Represent the section ρ by a rational function whose divisor is
\[
\operatorname{div}(\rho)=R-B-3F_\infty+\sum b_iE_i.
\]
Use the same rational frame for R, and represent a and the defining section Q of C accordingly. Their allowed poles are respectively3D+10F∞+R_polar and6D+18F∞+R_polar, where R_polar=B+3F∞−ΣbᵢEᵢ is a divisor class representative. Negative vertical coefficients cause no issue on the generic conic or near F∞ away from D. The rational Q has exact zero divisor C and these frame divisors; on the generic conic it has exact pole orders7 at B and6 at the other boundary point, since C avoids both.

Let
\[
\mathcal D(t)=v,\quad\mathcal D(u)=0,\quad\mathcal D(v)=-3dt^5.
\]
It preserves the conic equation. The rational two-form Ω=dt∧du/v has divisor−D−2F∞. Its residue along C from Ω/Q is, up to sign, du/(𝒟Q). Finite duality and the actual adjoint section in the preceding construction show on the normalization that this residue equals a nonzero constant times θ₂/ρ: the quotient has zero divisor because the conductor divisor is precisely that supplied by σ_C, while the D factors are canonically nonvanishing on C. Equivalently, for λ∈k×,
\[
\mathcal DQ=\lambda\rho y_2^2=\lambda a^2/\rho\quad\text{on }C.
\]
This uses the ACTUAL θ₂=du/y₂². The separating x₂-map makes du nonzero.

The actual cubic identity on C gives a³−P(u−1)ρ³=QW in the rational function field of S. Locally where the frames are regular, vanishing on the prime Cartier divisor C means membership in its ideal, so W has no pole along C; on the generic conic it has no finite poles. Its boundary poles are bounded by4D+2B, because the numerator is bounded by10D+3B and Q has exact boundary poles6D+B. Differentiating and restricting to C yields
\[
W=(3/\lambda)(\rho\mathcal Da-a\mathcal D\rho).
\]
The derivation raises each generic boundary pole order by at most1. Thus the Wronskian has the same polar bound4D+2B, of total degree10. Their difference vanishes at the13 generic reduced points of C, since the actual t-map is separating. On a projective smooth conic a nonzero rational function cannot have13 zeros and only10 poles. Therefore the difference is zero in k(S), proving
\[
\boxed{a^3-P(u-1)\rho^3=(3/\lambda)Q(\rho\mathcal Da-a\mathcal D\rho).}
\]
No arbitrary surface polynomial is being substituted for the actual source: the defining Q, its conductor-adjoint ρ, the extended actual ρy₂ and the exact residue comparison all come from that source.

## 5. Compatible infinity frames and the local contradiction

Use s=t⁻¹,U=t⁻³u,V=t⁻³v. Set Δ=s²𝒟; explicitly
\[
\Delta(s)=-sV,\quad\Delta(U)=-3UV,\quad
\Delta(V)=-3(U^2+ds^6).
\]
Near P± the rational frame for R has only its3F∞ weight: bᵢEᵢ and B are absent. Thus
\[
\rho_0=s^3\rho,\qquad a_0=s^{13}a,\qquad Q_0=s^{21}Q
\]
are regular local sections there; their zeros are respectively R, the extended section, and C. The scaled Wronskian satisfies
\[
s^{18}(\rho\mathcal Da-a\mathcal D\rho)
=\rho_0\Delta a_0-a_0\Delta\rho_0+(13-3)V a_0\rho_0.
\]
The last coefficient is10=0 in characteristic5. Scaling the boxed identity by s³⁹ and specializing s=0 gives
\[
a_0^3-U^{10}\rho_0^3=(3/\lambda)Q_0(\rho_0\delta a_0-a_0\delta\rho_0),
\qquad\delta=-3(UV\partial_U+U^2\partial_V).
\]
Here P is monic of degree10, so s³⁰P(s⁻³U−1) specializes to U¹⁰.

At each actual H₂-point, x₂ has pole order3 and t has pole order1, so U=t⁻³(x₂+1) is a unit. Hence the actual C avoids P±, and Q₀ is a unit at both. By Section3, ρ₀ is a unit at at least one of them. At that point h=a₀/ρ₀ is regular and the exact identity becomes
\[
h^3-U^{10}=(3/\lambda)(Q_0/\rho_0)\delta h.
\]
U is a local parameter on the conic, and δ=U·unit·∂_U. Its vanishing first forces h(0)=0. Write n=ord(h)≥1; h cannot be identically zero since the left term U¹⁰ would remain. If n=1,2,3, then ord(h³−U¹⁰)=3n and ord(δh)=n, a contradiction. If n≥4, the left order is10. A nonzero δh has order equal to the smallest Taylor exponent of h not divisible by5, which is never divisible by5 and thus cannot equal10. If δh=0, equality is again impossible. This excludes every regular h and proves the theorem.

## Scope and further route

The [self-contained exploration note](../../Research/notes/oct03_ten_hour/split_thirteen_cubic_adjoint.md) records the remaining degrees. The actual adjoint extension exists for general disjoint split r, but its cubic pole comparison promotes the identity only for r≤15. At r14 or15 the effective residual divisor has fiber degree2 or3 and may meet both P± or contain F∞. At r≥16 the promotion step also remains open. Common infinity is not included. No calculation, numerical certificate or group enumeration is used; the unmarked common-cover problem remains open.

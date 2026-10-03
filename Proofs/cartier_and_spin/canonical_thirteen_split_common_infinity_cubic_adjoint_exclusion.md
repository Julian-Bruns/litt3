# Proof: extra common-infinity adjoint factors and the remaining cubic obstruction

Version1, 3 October2026. [Independent focused audit PASS](../../Research/audits/CANONICAL_THIRTEEN_SPLIT_COMMON_INFINITY_CUBIC_ADJOINT_AUDIT_2026_10_03.md). Mathematical scope is unchanged by canonical metadata integration.

## 1. Actual common poles and the duality-adjoint section

Use u=x₂+1,v=t³(x₁+1), and the accepted smooth conic surface S with u²−v²=d(t⁶−1). Its boundary sections D± are disjoint, have self-intersection−3, and D=D₊+D₋ gives K_S=−D−2F, L=D+3F. By actual field generation the image C is integral with normalization ν:C₀→C. At common infinity points its boundary normal coordinate has EXACT order3. Write J=J₊+J₋ according to the boundary section of the image, and c±=degJ±. Then
\[
CF=13-c,\quad CD_\pm=3c_\pm,\quad CL=39,
\quad K_SC=-26-c,\quad g(C_0)=105.
\]
Let Δ be the normalization conductor divisor. Since H₂=ν*F∞+J, the actual θ₂ has divisor16ν*F∞+16J. Normalization duality therefore gives a nonzero section
\[
\sigma_C\in H^0(C,O_C(C-D-18F)),
\qquad\nu^*\operatorname{div}(\sigma_C)=\Delta+16J.
\]
The actual extra16J is retained throughout. As in the audited disjoint proof, H¹(−D−18F)=0 lifts σ_C to S: h⁰=0, χ=h²=17. No different vanishing or y₂ descent is assumed.

## 2. The extra boundary factor is forced

The lifted σ has intersection3c±−15 with D±. For c±≤3, negativity first forces at least5−c± copies. If c±>0 and precisely that many have been removed, the residual line bundle has degree0 on D±. At an actual common branch assigned to that section its pullback zero order is at least
\[
16-3(5-c_\pm)=1+3c_\pm>0.
\]
Hence the residual section vanishes at the image point on D±. A degree-zero line bundle on D±≅P¹ has either no nonzero section or a nowhere-vanishing section. Its restriction must consequently be zero, forcing ONE more copy of D±. Thus σ contains at least6−c± copies of an affected boundary, and at least5 copies of an unaffected one.

If both boundaries are affected, the total removed fiber degree is12−c, whereas σF=11−c. The remaining effective divisor would have negative fiber degree, impossible. Therefore all common infinity points lie on one boundary. Call it D₊; the other case is symmetric.

Remove(6−c)D₊+5D₋ from σ. The residual effective divisor satisfies
\[
R=C-(7-c)D_+-6D_--18F,
\quad RF=0,\quad RD_+=3,\quad RD_-=0,
\qquad\nu^*R=\Delta+(3c-2)J.
\]
Every component is vertical. Nonnegative intersections with D₋ exclude every smooth whole fiber and every degenerate component meeting D₋. Consequently
\[
R=\sum_i k_iE_i,\qquad k_i\ge0,\quad\sum_i k_i=3,
\]
where Eᵢ is the component of the i-th degenerate conic fiber meeting D₊ and avoiding D₋. In particular R avoids F∞.

## 3. The whole c=2 and c=3 cases contradict the actual genus

Fix B=D₋. The six disjoint−1 curves Eᵢ give the Hirzebruch blowup basis with D₊=B+3F−ΣEᵢ. The above actual residual identity gives the linear class
\[
C=(13-c)B+3(13-c)F-\sum_i(7-c-k_i)E_i.
\]
Thus
\[
C^2=255-3c^2-\sum_i k_i^2,
\qquad\delta=p_a(C)-105
=\frac{21-c-3c^2-\sum_i k_i^2}{2}.
\]
For c=3 this is negative, which is impossible for an integral curve and its normalization. For c=2, Σkᵢ=3 implies Σkᵢ²≥3, hence δ≤2.

At every common infinity point the local t-index is at least3. Here is the needed local statement without a complete-fiber hypothesis. Cubing the actual θ identity and using q₂=t⁶q₁ gives proportionality of the actual tensors q₀(x)⁸(dx)³/P(x)². In a source uniformizer w, write ξᵢ=xᵢ+1=lᵢw⁻³+mᵢw⁻²+nᵢw⁻¹+O(1). The normalized tensor begins
\[
\frac{3}{l_i}\left[1+3(m_i/l_i)w+2(n_i/l_i)w^2+O(w^3)\right](dw)^3.
\]
Its first two coefficient comparisons give ξ₂−λξ₁ regular, λ=l₂/l₁. Therefore q₀(x₂)/q₀(x₁)−λ² has order at least3. The sixth-power map is étale at the nonzero value t(P), so ord(t−t(P))≥3. This is exactly the local common-pole calculation in the accepted [shared-infinity proof](canonical_ten_full_bridge_shared_infinity_profile.md); only its local jet implication is used, not its degree-ten completeness conclusion or a cubic-index-three coarse budget.

Near a section point of the smooth conic surface, the base coordinate t−t(P) and the boundary normal coordinate form regular surface parameters. Their orders on this actual branch are at least3 and exactly3. Thus its plane-curve multiplicity is3. Blowing up a plane branch of multiplicity m lowers its delta invariant by m(m−1)/2 and leaves nonnegative defect, so this branch alone has delta invariant at least3. Other branches and pairwise intersections only increase the total defect. This contradicts δ≤2 for c=2. Therefore both c=2 and c=3 are wholly excluded.

## 4. The actual cubic extends with asymmetric boundary poles when c=1

Now c=1. The residual divisor is R=C−6L, with ν*R=Δ+J, and it is vertical away from F∞. The product σ_Cy₂ descends to a regular section of O_C(C−D−8F). Indeed y₂ has pole divisor10ν*F∞+10J, while σ_C has the conductor and extra16J; after accounting for its10F twist the remaining normalization zero divisor contains the conductor and6J. Conductor multiplication therefore puts the product in the singular curve's invertible sheaf.

The unchanged vanishing H¹(−D−8F)=0 lifts this section to A on S, with h⁰=0, χ=h²=7. Its intersections with D₊ and D₋ are respectively−2 and−5. Thus A contains D₊+2D₋. Removing those factors gives a section
\[
a\in H^0(S,O_S(4D_++3D_-+10F+R))
\]
whose rational restriction, in the canonical boundary frames, is exactly a=ρy₂ on C. No descent of y₂ itself was assumed.

Represent R by any compatible rational frame; it has generic conic degree0. Represent the actual defining Q of C in class6D+18F+R. On the generic conic Q has exact poles6 at both boundary points because C has no D component. The actual a has bounds4 on the affected boundary and3 on the other, while ρ has no generic poles.

The rational form Ω=dt∧du/v has divisor−D−2F∞. Its residue from Ω/Q on the normalization has divisor
\[
16\nu^*F_\infty+15J+\nu^*R_{\rm polar}-\Delta.
\]
Since θ₂ has16ν*F∞+16J and the rational ρ has divisorΔ+J−ν*R_polar, this is EXACTLY the divisor of θ₂/ρ. The quotient is a global unit, hence constant. Thus
\[
\mathcal DQ=\lambda\rho y_2^2=\lambda a^2/\rho
\]
on the actual C, with λ≠0 and 𝒟(t)=v,𝒟(u)=0,𝒟(v)=−3dt⁵.

The actual cubic gives a³−P(u−1)ρ³=QW. As a rational function on the generic conic W has no finite poles and has boundary bounds(6,4): the numerator bounds are(12,10), and Q has exact poles(6,6). Differentiating on C gives W=(3/λ)(ρ𝒟a−a𝒟ρ). The latter has bounds(5,4). Their difference has at most10 poles and vanishes at the12 reduced points of the generic actual t-fiber. Hence it is zero, proving the global surface identity
\[
a^3-P(u-1)\rho^3=(3/\lambda)Q(\rho\mathcal Da-a\mathcal D\rho).
\]

## 5. The same characteristic-five infinity obstruction finishes c=1

Because R is supported only on finite degenerate-fiber components, near F∞ choose its rational frame with no fiber weight or zero. Then ρ is regular and a unit at both P±. Use the usual s=t⁻¹,U=t⁻³u,V=t⁻³v and local weights a₀=s¹⁰a,Q₀=s¹⁸Q,ρ₀=ρ. The asymmetric boundary degrees affect only the boundary points, not the finite P±. The scaled derivative uses Δ=s²𝒟; its frame correction is10Va₀ρ₀=0 in characteristic5. Specialization of the exact identity gives
\[
a_0^3-U^{10}\rho_0^3=(3/\lambda)Q_0(\rho_0\delta a_0-a_0\delta\rho_0),
\qquad\delta=-3(UV\partial_U+U^2\partial_V).
\]
At actual noncommon H₂-points x₂ has pole order3 and t has pole order1, so U is a unit. Common H₂-points are t-units and do not belong to F∞. Therefore the actual C still avoids P±, and Q₀ is a unit at both.

At either P let h=a₀/ρ₀. It is regular and satisfies h³−U¹⁰=unit·δh. The completed local derivation is δ=U·unit·∂_U. The equality forces h(0)=0. For n=ordh in{1,2,3}, the two sides have orders3n and n. For n≥4, the left order is10, while any nonzero δh has order equal to the first Taylor exponent of h not divisible by5, so never10; δh=0 also contradicts equality. The all-order local obstruction excludes c=1.

The companion thus closes c=1,2,3. Combined with the separately audited c=0 result it covers an actual split degree-thirteen carrier once its residual t-degree is known to be at least10. Both actual étale maps and any original T endpoint legs have been retained. Higher degrees, larger overlap and the unmarked common-cover problem are not decided. The [self-contained companion note](../../Research/notes/oct03_ten_hour/split_thirteen_common_infinity_companion.md) and [independent preliminary ledger check](../../Research/notes/oct03_ten_hour/split_thirteen_common_infinity_adjoint_check.md) record the derivation. No computation or certificate replay is used.

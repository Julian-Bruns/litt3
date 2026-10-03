# Proof: an integral degree-three conductor violates paired auxiliary parity

Version1, 3 October2026. Fresh independent [whole or canonical scope/fidelity audit](../../Research/audits/CANONICAL_FIFTEEN_SPLIT_INTEGRAL_CONDUCTOR_EXCLUSION_AUDIT_2026_10_03.md): **PASS**, no mathematical correction. Original component evidence and audited input hashes are preserved. No numerical replay at integration.

## 1. The actual surface, conductor and two cubics

The accepted [conic construction](canonical_ten_split_tensor_conic_bundle_exclusion.md) uses BOTH actual finite étale degree-fifteen maps on the SAME C₀, with their actual field equality, q₀ identity, disjoint reduced infinity divisors and θ₁=κt¹⁶θ₂. It identifies C₀ with the normalization of the integral image C on S. The affine conic is u²−v²=d(t⁶−1), u=x₂+1,v=t³(x₁+1). Its boundary consists of D±²=−3,D₊D₋=0; K_S=−D−2F,L=D+3F,L²=6. Actual étaleness gives g(C₀)=121 and the actual coordinate and infinity data give
\[
CF=15,\quad CD_\pm=0,\quad CL=45.
\]

The accepted [paired adjoint construction](canonical_split_paired_cubic_adjoint_counterterms.md) lifts the actual θ₂ conductor section, removes its fixed5D factor, and gives effective R=C−6L with RF=3,RD±=0 and section ρ. Its normalization pullback is exactly the conductor Δ. It uses the SAME conductor for both actual cubic extensions a,b, with
\[
a|C₀=\rho y₂,\qquad b|C₀=t^{10}\rho y₁.
\]
Their possible integral errors belong to C−8L and vanish by fiber degree−1. In regular finite rational frames the second-leg whole identity is
\[
a³-P(u-1)\rho³
=\gamma₂Q(\rho\mathcal Da-a\mathcal D\rho),\qquad \gamma₂\ne0,
\tag{1}
\]
where Q defines C and
\[
\mathcal D(t)=v,\quad\mathcal D(u)=0,\quad\mathcal D(v)=-3dt⁵.
\tag{2}
\]
The first-leg whole identity comes from the SAME actual adjoint and exact θ identity. Its precise swap will be used in Section5. Neither equation is an arbitrary cubic extension on an arbitrary curve of S.

Assume R is integral. It is horizontal of degree3, hence not a boundary or a fiber. Its zero intersections with each boundary imply it is disjoint from D. The [full single-cubic extension exclusion](canonical_fifteen_split_full_cubic_extension_exclusion.md) says that the entire ρ cannot divide either a or b. Because R is integral on the smooth surface, vanishing of either section identically on R would imply this forbidden full sheaf divisibility. Consequently both sections have nonzero restrictions to R.

## 2. Both auxiliary points are forced at each end

We specify the accepted auxiliary obstruction needed here. At F∞ put s=t⁻¹,U=s³u,V=s³v, so V²=U²−d there. Its auxiliary points are U=0,V=±√(−d). Every ACTUAL branch of C at F∞ has s as parameter and U a unit: this is exactly the original x₂ pole3 and the simple poles of t. Thus C avoids both points, and its local equation Q is a unit there.

The whole cubic, with its exact infinity scaling, forces ρ to vanish at both points whenever R does not contain F∞. Indeed at a hypothetical unit ρ point the regular function h=a/ρ would satisfy
\[
h³-U^{10}=\text{unit}\cdot\delta h,
\qquad \delta=-3Uz\partial_z,
\quad z=U+V.
\tag{3}
\]
At U=0, U is a local parameter and δ is U times a unit derivation. Equation(3) forces h(0)=0. If its leading order n is not divisible by5, the right side has order n, incompatible with min(3n,10); the equality3n=10 never occurs. If n is divisible by5, its first non-fifth-power exponent exceeds n. For n=5 or n≥10 the left order is10, whereas the order of δh, if finite, cannot equal10: δ is a unit times U∂U. If δh=0 the left equation would require h³=U¹⁰, which is impossible by valuation. This proves the obstruction. The actual scaling in(3) is valid because the weight10 derivative is zero in characteristic5. The accepted [vertical exclusion](canonical_fifteen_split_disjoint_vertical_adjoint_exclusion.md) makes this obstruction available in the full degree-fifteen setting; under the present integral assumption R already contains no fiber.

Swap the ACTUAL endpoints. The same argument forces R through both auxiliary points of F₀,
\[
t=v=0,\qquad u=\pm\sqrt{-d}.
\tag{4}
\]
C avoids these as well: at its actual H₁ branches, v=t³(x₁+1) is a unit by the original x₁ pole3 and simple t zeros. The swap transports the same divisor R, as detailed in Section5; it is not a replacement by a new independent adjoint.

Because R.F₀=R.F∞=3 and both auxiliary points occur at each end, at least one auxiliary point at EACH end has local intersection multiplicity1 with that fiber. Intersection positivity includes all branches, so such a point has one branch of R and that branch is smooth and unramified over the base parameter.

## 3. The second actual cubic forces order-three tangency at zero

Choose the simple auxiliary point p of F₀. Let u₀=u(p), u₀²=−d. The smooth surface has local coordinates(t,v), since 2u₀≠0. The curve R, of intersection1 with t=0, is a formal graph
\[
v=f(t),\qquad f(0)=0.
\]
Its local equation is w=v−f(t); in a regular local frame ρ=εw with ε a unit. Q is a unit here because C avoids p. All extension frames and t-pole conventions are regular at this finite point.

Restrict(1) to R and cancel the nonzero rational function a|R. The result is the exact square identity
\[
(a|R)²=-\gamma₂(Q|R)(\mathcal D\rho|R).
\tag{5}
\]
Derivative terms from a change of the common R frame multiply w and vanish on R. Thus Dρ|R is a unit multiple of Dw|R, and(5) forces its valuation at p to be finite and EVEN. Directly from(2),
\[
\mathcal Dw|R=-3dt⁵-f'(t)f(t).
\tag{6}
\]
If f=0 identically, its order is5 and contradicts evenness. Otherwise write f=ct^ℓ+O(t^{ℓ+1}), c≠0. For ℓ=1 or2, the nonzero leading order of f'f is2ℓ−1=1 or3. For ℓ=3, the two order5 terms in(6) sum to−3(d+c²)t⁵. For ℓ≥4, f'f has order at least2ℓ−1≥7, or higher if its leading derivative vanishes in characteristic5, so the nonzero−3dt⁵ term dominates. All cases have odd order unless
\[
f=ct³+O(t⁴),\qquad c²=-d.
\tag{7}
\]
Evenness therefore forces(7), without presuming that R has any endpoint map or that any derivative-square model alone realizes the original source.

## 4. An order-seven zero of the actual coordinate on R

Substitution in the conic gives
\[
u²+d=f(t)²+dt⁶=O(t⁷).
\]
Since u+u₀ is a unit at p, either u is constant on R or
\[
\operatorname{ord}_p(u-u₀)\ge7.
\tag{8}
\]
The constant case is impossible. If u=u₀ on the integral R, the conic says v²=−dt⁶ and its integral image is one of the two sections v=±√(−d)t³. Each has fiber degree1, contradicting RF=3. Thus(8) is a zero of a NONCONSTANT rational function on the normalization of R. Its total pole degree must be at least7. This elementary divisor-degree assertion also holds for an inseparable function.

## 5. The first ACTUAL cubic forces cancellation of infinity poles

Use the actual swap
\[
s=t^{-1},\qquad u₁=v/t³=V,\qquad v₁=u/t³=U.
\tag{9}
\]
It gives u₁²−v₁²=d(s⁶−1). Its zero-fiber auxiliary points are precisely the two original auxiliary points on F∞. The first-leg extension before the multiplication by t¹⁰ lies in3D+10F₀+R and restricts to ρy₁. Hence in the swapped pole convention it is the extension appropriate to the second-leg form(1).

For completeness, this change retains the SAME effective conductor divisor. If Ω_t=dt∧du/v and Ω_s=ds∧du₁/v₁, then Ω_s=−t⁻²Ω_t. With θ₁=κt¹⁶θ₂, the rational adjoint representative changes by t¹⁸ up to a constant. This precisely transports C−6D−18F∞ to C−6D−18F₀ while preserving the effective R. The first-leg extension is transported with the same adjoint factor. The paired construction proves the corresponding exact cubic with its nonzero residue constant. Neither the vanishing locus on R nor its full-factor obstruction changes under this line-bundle identification.

Choose a simple auxiliary point p∞ of R at F∞, which exists by Section2. The transported extension is nonzero on R by the full single-cubic exclusion, and the local Q is a unit because the ACTUAL C avoids p∞. Repeating Sections3–4 for the swapped conic, with s its local parameter and v₁=U its graph coordinate, forces
\[
U=c_\infty s³+O(s⁴),\qquad c_\infty²=-d.
\tag{10}
\]
In the original coordinate u=U/s³, there is therefore NO pole at p∞. At the OTHER forced auxiliary point of R∩F∞, the function U vanishes on its normalized branches, so at least one further pole order is lost. This remains true if that other point is ramified over s, or has two branches: at least one positive U valuation is enough.

There are no other poles of u on R away from F∞, because R is disjoint from D. Its polar divisor on the normalization is bounded by3 times the pullback of F∞, whose total degree is9. Formula(10) removes all three of the possible poles at p∞, and the other auxiliary point removes at least one more. Therefore
\[
\deg(u|\widetilde R)\le9-3-1=5.
\tag{11}
\]
The nonconstant u−u₀ has the same polar divisor, yet(8) gives a zero of order at least7. Equality of total zero and pole degrees contradicts(11). This proves the theorem.

## Scope and provenance

The [self-contained note](../../Research/notes/oct03_ten_hour/split_fifteen_integral_conductor_auxiliary_parity_exclusion.md) records the new implication and its independent focused check. The proof requires both ACTUAL cubics, the exact original θ identity, the actual conic joint field and the actual avoidance of the auxiliary points. It does not infer that either original étale X leg factors through R, and it uses no purported bound of three branches from the three cubic phases. Reducible conductor-adjoint configurations remain outside this theorem.

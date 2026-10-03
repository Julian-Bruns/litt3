# Proof: characteristic-five contact resonances of the two actual cubics

Version1, 3 October2026. The exact source calculation has a fresh [independent focused PASS](../../Research/notes/oct03_ten_hour/split_actual_infinity_contact_congruences_audit.md), with no corrections. Canonical presentation scope is pending. No computation is used.

## 1. The source, phases and projected branches

The [actual conic construction](canonical_ten_split_tensor_conic_bundle_exclusion.md) identifies C₀ with the normalization of its integral image C. At an actual t-pole, s=t⁻¹ is a parameter because its pole divisor H₂ is reduced. Actual étaleness over the original infinity of X gives x₂ pole three and y₂ pole ten. Thus
\[
U=s³(x₂+1),\quad V=x₁+1,\quad H=s^{10}y₂
\]
are regular with U,H units. The local conic relation is
\[
U²-V²=d(1-s⁶).
\tag{1}
\]
After fixing the nonzero value U₀, it makes U=U(s,V) a regular formal function. Likewise
\[
H³=s^{30}P(s^{-3}U-1)
\tag{2}
\]
has three regular formal unit roots. Distinct normalized source points over one image give distinct formal projected branches: s is a branch parameter; its V expansion and the chosen unit U₀ determine its U expansion by(1), hence determine its actual image branch. The exact joint field ensures C₀ is that normalization, rather than a further cover of the image.

For two projected graphs V₁(s),V₂(s), their intersection multiplicity is the finite order of V₁−V₂. We will not infer formal uniqueness of ODE solutions in characteristic five.

## 2. Ordinary first endpoint: contacts are one or divisible by five

Suppose P(V₀−1) is a unit. The actual first cubic y₁ is a regular formal root Y(V) of P(V−1). Since x₂=s⁻³U−1 and x₁=V−1, the actual canonical identity becomes, along a branch,
\[
\frac{dV}{Y²}=\kappa\frac{-3U+sU'}{H²}\,ds.
\tag{3}
\]
Here U'=U_s+(V/U)V', and U_s denotes its partial s derivative with V fixed. Thus the projected graph satisfies
\[
V'=\frac{\kappa Y(V)²(-3U+sU_s)}
{H(s,V)²-\kappa s(V/U)Y(V)²}=:F(s,V).
\tag{4}
\]
Its denominator is a unit. The simultaneous scaling Y,H↦ζY,ζH by ζ³=1 leaves(4) unchanged. There are exactly three possible relative phase classes, whose initial slopes
\[
-3\kappa U₀Y(V₀)²/H₀²
\]
are distinct: all factors are units and the three squared relative phases are distinct. Different slopes give contact one.

For equal slopes the relative phase classes agree. Simultaneously normalize the phases, so both graphs satisfy the SAME regular formal equation(4) and have the same initial value. Let their first difference be cs^ℓ+… with c≠0. Then F(s,V₁)−F(s,V₂) is divisible by V₁−V₂ and has order at least ℓ, whereas the derivative of their difference has leading coefficient ℓc at order ℓ−1 unless five divides ℓ. Therefore
\[
5\mid\ell.
\tag{5}
\]
This argument controls the first difference only, permitting further resonances and arbitrarily many branches in one phase class.

## 3. A cubic first-endpoint zero: the projected contact is shifted by two

Now suppose P(V₀−1)=0. Its root is simple. At each actual source point, the original y₁=w is a parameter by étaleness, and
\[
V=V(w³),\quad V-V₀=\text{unit}\cdot w³,
\qquad\theta₁=\frac{3\,dw}{P'(V-1)}.
\tag{6}
\]
Use s as the actual source parameter as before. The canonical identity gives
\[
w'=\frac{\kappa P'(V-1)(-3U+sU_s)}
{3H²-\kappa sP'(V-1)U_w}.
\tag{7}
\]
The denominator and initial derivative are units. Simultaneously scaling w,H by ζ preserves this equation and the projected V, since V depends on w³ and the partial derivative U_w transforms inversely. Normalize all H phases. The resulting w graphs have common initial value zero, common nonzero first derivative and the SAME regular formal equation(7).

For two distinct projected branches their normalized w graphs have finite first difference of order ℓ divisible by five, by the subtraction argument of Section2. The map from w³ to V has unit derivative, so
\[
\operatorname{ord}(V(w₁³)-V(w₂³))
=\operatorname{ord}(w₁³-w₂³)=\ell+2.
\tag{8}
\]
Indeed w₁²+w₁w₂+w₂² has exact order two, with leading coefficient three times the common nonzero squared linear coefficient. Therefore the projected contact is2 modulo five and at least seven. All projected V slopes are zero because V−V₀ starts in order three.

## 4. The ACTUAL swap and scope

The swap τ=t⁻¹,u₁=v/t³,v₁=u/t³ gives u₁²−v₁²=d(τ⁶−1). Its pole fiber is the original zero fiber; the simple zero divisor of t and original first étale X leg supply the same parameter and unit statements. The inverse actual θ identity supplies its nonzero constant, and the exact joint field is unchanged. The preceding proof therefore applies with the two ACTUAL endpoints interchanged.

No conjugate field, auxiliary curve or separable replacement receives an endpoint map here. The conclusions refine the coarse contacts1 or≥5 from the accepted [infinity jet proof](canonical_fourteen_split_disjoint_cubic_adjoint_normal_form.md); the sharper congruences are not used to re-audit that foundation. Characteristic-five nonuniqueness remains explicit, and the theorem makes no bound on the total number of branches at one image. The [self-contained source note](../../Research/notes/oct03_ten_hour/split_actual_infinity_contact_congruences.md) and its fresh receipt preserve the original evidence.

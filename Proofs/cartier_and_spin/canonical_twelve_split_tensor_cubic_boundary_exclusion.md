# Proof: the actual cubic coordinate contradicts the split equality boundary

Version1, 3 October2026. [Independent whole-proof audit PASS](../../Research/audits/CANONICAL_TWELVE_SPLIT_CUBIC_BOUNDARY_AUDIT_2026_10_03.md), covering all seven critical checks. See the [statement](../../Theorems/cartier_and_spin/canonical_twelve_split_tensor_cubic_boundary_exclusion.md). Both actual maps remain on the same source.

## 1. The actual joint image reaches the exact conic equality

Set ξᵢ=xᵢ+ONE, so q₀(xᵢ)=ξᵢ²+d, and put u=ξ₂,v=t³ξ₁. The actual quadratic identity is
\[
u^2-v^2=d(t^6-1).
\]
Its projective compactification is the smooth conic bundle π:S→P¹_t, with affine base charts
\[
u^2-v^2=d(t^6-1)w^2,
\qquad U^2-V^2=d(1-s^6)W^2,
\]
where s=t⁻¹ and [U:V:W]=[s³u:s³v:w]. It has SIX simple degenerate conic fibers. Their nodes are smooth points of the total surface because the base derivative is a unit. The two disjoint infinity sections w=ZERO,u=±v are D₊,D₋. For D=D₊+D₋ and fiber class F,
\[
D_\pm^2=-THREE,\quad D^2=-SIX,\quad DF=TWO,\quad F^2=ZERO,
\qquad K_S=-D-TWO F,
\qquad L=D+THREE F,\quad L^2=SIX.
\]
These exact geometric identities and the common-infinity extension are independently reviewed in [the conic-bundle proof](canonical_ten_split_tensor_conic_bundle_exclusion.md).

For completeness, if J=min(H₁,H₂) has degree c, the actual map [u:v:w]=[ξ₂:t³ξ₁:ONE] pulls D back to THREE J. At the noncommon infinity points its coordinate poles cancel using the simple zero/pole of t. The actual field equality gives
\[
k(C₀)=k(t,x₁,x₂)=k(t,u,v),
\]
so C₀ is the normalization of its integral image C⊂S. Hence CF=TWELVE−c, CD=THREE c, CL=THIRTY-SIX and K_SC=−TWENTY-FOUR−c. Hodge index and adjunction give
\[
g(C₀)\le p_a(C)\le ONE+\tfrac34(12)^2-12-c/2=97-c/2.
\]
Both actual étale maps give g(C₀)=EIGHT·TWELVE+ONE=97. Therefore c=ZERO, every genus/Hodge inequality is equality, C is smooth, C₀=C, and C≡SIX L. In particular C avoids D and its t-pole divisor H₂=t⁻¹(∞) is reduced of degreeTWELVE.

Numerical equality here implies LINEAR equality. Indeed S is rational: t,u+v generate its function field because (u+v)(u−v)=d(t⁶−ONE). On a smooth projective rational surface the Picard group has no nonzero numerical kernel. This follows by resolving a birational map to a minimal rational surface, whose Picard intersection lattice and the additional exceptional-curve lattices are nondegenerate and torsion-free. Thus
\[
O_S(C)\simeq O_S(SIX D+EIGHTEEN F).
\]

## 2. The actual cubic coordinate extends with an exact pole bound

Put A=t*O_{P¹}(ONE)|_C. The actual y₂ has pole divisor TEN H₂, so it is a section of A¹⁰, and t⁻¹⁰y₂ is a UNIT at every point of H₂. Because C avoids D, the canonical nonvanishing section trivializes O_C(D).

The restriction map
\[
H^0(S,O_S(THREE D+TEN F))\longrightarrow H^0(C,A^{10})
\]
is surjective. Its kernel line bundle is E=O_S(−THREE D−EIGHT F). Since EF=−SIX, h⁰(E)=ZERO. Riemann–Roch on the rational surface gives
\[
E^2=42,\qquad EK_S=10,\qquad\chi(E)=ONE+(42-10)/TWO=17.
\]
Serre duality gives h²(E)=h⁰(TWO D+SIX F)=17. The last space consists exactly of
\[
a₀(t)+a₁(t)u+b₁(t)v+a₂u^2+b₂uv,
\]
where deg a₀≤SIX, deg a₁,deg b₁≤THREE, and a₂,b₂ are constants. The conic relation gives this basis, including at the degenerate fibers. Its dimension is SEVEN+FOUR+FOUR+ONE+ONE=17. Thus h¹(E)=ZERO.

Choose an extension a of the ACTUAL y₂. On the affine conic chart, a is a polynomial subject to u²−v²=d(t⁶−ONE), of fiber degree at mostTHREE and weighted degree at mostTEN for wt(t)=ONE, wt(u)=wt(v)=THREE. These bounds are precisely its allowed poles THREE D+TEN F∞. We may reduce to degree at mostONE in v.

Choose a defining polynomial Q for the actual C, representing its section of O_S(SIX D+EIGHTEEN F). Its rational divisor is
\[
\operatorname{div}(Q)=C-SIX D-EIGHTEEN F_\infty.
\]
It has fiber degree at mostSIX and weighted degree at mostEIGHTEEN. Since C avoids BOTH boundary sections, on the generic conic Q has poles of EXACT orderSIX at EACH of its two infinity points.

## 3. Exact residue comparison and global cubic derivative factor

Let the affine derivation be
\[
\mathcal D(t)=v,\qquad\mathcal D(u)=ZERO,\qquad\mathcal D(v)=-THREE d t^5.
\]
It preserves the conic equation in characteristicFIVE. The rational two-form Ω=dt∧du/v on S has exact divisor −D−TWO F∞. Near a degenerate-fiber node, the equation gives dt=(u du−v dv)/(THREE d t⁵), so Ω=du∧dv/(THREE d t⁵) is a unit form. The other boundary charts show its stated poles and no additional divisor.

The residue of Ω/Q on the ACTUAL smooth C is, up to sign, du/(𝒟Q). Its divisor is SIXTEEN H₂: the divisor of Ω/Q is FIVE D+SIXTEEN F∞−C, and D is disjoint from C. The ACTUAL θ₂=du/y₂²=du/a² has exactly the same divisor. Their quotient is a global unit on the smooth projective curve, hence a nonzero constant. Thus for some λ∈k×,
\[
\mathcal DQ=λa^2\quad\text{on }C.
\]
The actual separating x₂-map makes du nonzero, so this comparison is nondegenerate. No half-canonical identification on Γ is used.

The actual cubic equation a³=P(u−ONE) on C implies an exact identity in the affine conic ring
\[
a^3-P(u-ONE)=QR.
\]
There is no integrality gap: C is a prime reduced Cartier divisor defined by Q in the smooth affine surface; its ideal is (Q). The quotient R is regular there. On the generic projective conic the numerator has pole order at mostTEN at EACH boundary point and Q has exact pole orderSIX there. Therefore R has pole order at mostFOUR at each. The derivation 𝒟 increases the fiber degree by at mostONE, so 𝒟a also has pole order at mostFOUR at each.

Differentiate the cubic identity and restrict to C. Since 𝒟u=ZERO and 𝒟Q=λa², cancellation of the nonzero actual function a² gives
\[
R=(THREE/λ)\mathcal Da\quad\text{on }C.
\]
The difference on the generic conic has total polar degree at mostEIGHT. It vanishes on the actual degreeTWELVE fiber divisor of C. This divisor is generically reduced because the t-map is separating (its pole orders are ONE). After an algebraic extension of k(t), a nonzero rational function on the smooth conic cannot have at leastTWELVE zeros and at mostEIGHT poles. Consequently the difference is identically zero, giving the exact surface identity
\[
\boxed{a^3-P(u-ONE)=(THREE/λ)Q\mathcal Da.}
\]

## 4. Infinity scaling preserves the characteristic-five derivative

Near the base infinity use s=t⁻¹,U=t⁻³u,V=t⁻³v. Its smooth affine conic fiber is V²=U²−d. Define
\[
h=(t^{-10}a)|_{F_\infty},\qquad Q_\infty=(t^{-18}Q)|_{F_\infty},
\qquad\delta=-THREE(UV\partial_U+U^2\partial_V).
\]
The function h has poles of order at mostTHREE at EACH of the two projective conic boundary points. It is nonzero, because at every actual point of C∩F∞ its restriction is the UNIT t⁻¹⁰y₂.

The exact scaling calculation is
\[
\mathcal D(s)=-s^{-1}V,\qquad
\mathcal D(U)=-THREE t^2UV,\qquad
\mathcal D(V)=-THREE t^2(U^2+d s^6).
\]
Crucially 𝒟(t¹⁰)=ZERO in characteristicFIVE. Writing a=t¹⁰a∞(s,U,V), division of 𝒟a by t¹² makes the s-derivative term −sV∂_s a∞ vanish at s=ZERO. Thus
\[
(t^{-12}\mathcal Da)|_{F_\infty}=\delta h.
\]
Divide the boxed exact identity by t³⁰ and specialize s=ZERO. P is monic of degreeTEN, so t⁻³⁰P(t³U−ONE) tends to U¹⁰ and every lower term vanishes. We obtain
\[
h^3-U^{10}=(THREE/λ)Q_\infty\delta h.
\]

## 5. The two auxiliary infinity-fiber points contradict actual étaleness

The TWO finite points P±=(U=ZERO,V=±√(−d)) are distinct because d≠ZERO and characteristicFIVE is notTWO. At EVERY actual point of H₂, x₂ has pole orderTHREE and t has pole orderONE. Hence U=t⁻³(x₂+ONE) is a UNIT there. Thus C avoids P±, and Q∞ is a UNIT at BOTH of these points. This step uses the actual endpoint pole orders and actual reduced t-poles, not an abstract polynomial model.

The derivation δ vanishes at P±. The displayed identity forces h(P±)=ZERO. Since h is nonzero and its total polar degree is at mostSIX, its total zero degree is at mostSIX. Therefore at leastONE of P± has
\[
ONE\le n=\operatorname{ord}(h)\le THREE.
\]
At that point U is a local parameter and δ(U)=−THREE VU has a simple zero with nonzero leading coefficient. Because n is not divisible byFIVE, ord(δh)=n. On the other hand ord(h³−U¹⁰)=THREE n since THREE n<TEN. The right side has order n because Q∞ is a unit. This contradicts the exact identity.

The contradiction excludes the entire split degreeTWELVE configuration. Together with the independently reviewed conic genus bound, every nonconstant split cubic-indexONE comparison of joint degree at mostTWELVE is impossible. Both actual maps were needed to create the birational joint conic image and its genus/pole data; the actual cubic coordinate and its canonical differential supply the decisive final identity.

## Scope and verification

The self-contained research derivation is [the degree-twelve note](../../Research/notes/oct03_ten_hour/split_twelve_cubic_boundary.md). An earlier tiny necessary-operator calculation is preserved there with source and external raw receipt, but is NOT a proof dependency and has not been rerun. This proof is geometric and algebraic. It does not infer original tensor proportionality, decide the nonsplit square-root case or solve the unmarked common-cover problem. The independent whole-proof audit passes all seven critical checks.

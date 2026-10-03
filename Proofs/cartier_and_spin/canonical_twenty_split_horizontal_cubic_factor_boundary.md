# Proof: degree-twenty horizontal factors force the entire original cubic factor

Version1, 3 October2026. [Theorem](../../Theorems/cartier_and_spin/canonical_twenty_split_horizontal_cubic_factor_boundary.md). The underlying exact implication has fresh bounded whole PASS. This canonical presentation is frozen pending focused scope/presentation review and root registration. No computation is used.

## 1. The actual source and exact conductor are retained

Keep BOTH actual finite étale degree-twenty X maps on the SAME smooth projective C₀, their ACTUAL yᵢ³=P(xᵢ), canonical differentials, disjoint reduced infinity divisors and
\[
k(C₀)=k(t,x₁,x₂),\quad q₀(x₂)=t⁶q₀(x₁),\quad
\operatorname{div}(t)=H₁-H₂,\quad\theta₁=\kappa t^{16}\theta₂.
\tag{1}
\]
The [actual conic construction](canonical_ten_split_tensor_conic_bundle_exclusion.md) makes their integral Cartier image C in the smooth conic bundle S, with C₀ its normalization. In affine coordinates
\[
u=x₂+1,\qquad v=t³(x₁+1),\qquad u²-v²=d(t⁶-1).
\tag{2}
\]
The two boundary sections are disjoint with squares−3. For D=D₊+D₋,L=D+3F one has K_S=−D−2F,L²=6. The actual source gives CF=20,CD±=0,CL=60 and g(C₀)=161.

The [paired cubic theorem](canonical_split_paired_cubic_adjoint_counterterms.md) gives the SAME effective exact conductor-adjoint R=C−6L,RF=8,RD±=0,ν*R=Δ and its section ρ. The original extensions a,b restrict to ρy₂,t¹⁰ρy₁. No descent of an unmultiplied normalization cubic to the singular C is assumed. For
\[
\mathcal Dt=v,\qquad \mathcal Du=0,\qquad\mathcal Dv=-3dt⁵
\]
the GENERAL identity is
\[
a³-P(u-1)\rho³
=\gamma Q(\rho\mathcal Da-a\mathcal D\rho)+Q²\varepsilon₂,
\qquad \varepsilon₂\in H⁰(C-8L),\quad\gamma\ne0.
\tag{3}
\]
Q defines the actual C. The calibrated original first-endpoint identity is also retained. We prove the implication for a and then apply the actual swap.

## 2. All horizontal multiplicities remove this individual error

Assume R_hor divides a with its FULL multiplicities. Put R=R_hor+V and h=a/ρ. Initially h has allowed poles3D+10F∞ and additional poles only on V, bounded by V. Its generic horizontal coefficients are regular in those allowed boundary frames.

In the common bundle10D+30F∞+3R, the cube term of(3) has the horizontal section factor3R_hor, and the Wronskian has the factor2R_hor:
\[
\rho³(h³-P(u-1))=\gamma Q\rho²\mathcal Dh+Q²\varepsilon₂.
\tag{4}
\]
The derivation has already been accounted for by its4D+12F derivative bound; this is a statement about regular section coefficients at each horizontal prime, including a boundary prime. Vertical poles have no effect there. C is integral and cannot be a component of R, because CF=20>RF=8. Thus Q is a unit at those generic primes, and2R_hor divides ε₂. The residual bundle satisfies
\[
(C-8L)-2R_{\rm hor}=4L-C+2V,\qquad
(4L-C+2V)F=8-20=-12.
\tag{5}
\]
F is nef, so this bundle has no nonzero section. Consequently ε₂=0, without automatic vanishing of the general paired errors. Cancelling in(4) gives
\[
\rho(h³-P(u-1))=\gamma Q\mathcal Dh.
\tag{6}
\]
Only this individual's error has been removed.

## 3. A signed compatible frame makes the critical ratio a base function

Use the accepted six-fiber blowup basis B=D₋,F,Eᵢ, where Eᵢ does not meet D₋ and Eᵢ′ is its complementary fiber component. The actual class is
\[
C\sim20B+60F-\sum_i a_iE_i,\quad\sum_i a_i=60,\quad0\le a_i\le20,
\qquad D=2B+3F-\sum_iE_i.
\tag{7}
\]
Choose the compatible SIGNED reference divisor
\[
C_{\rm ref}=10D+30F_\infty-\sum_i(a_i-10)E_i,
\qquad\operatorname{div}(Q)=C-C_{\rm ref}.
\tag{8}
\]
The reference need not be effective. In particular, a_i>10 means a zero of the rational Q coefficient at Eᵢ. The matching R reference is C_ref−6L. Its choices rescale a,ρ,Q compatibly and preserve h=a/ρ and(6); the later ratios are rational functions in these specified frames, not derivatives of an unspecified line-bundle frame.

On the generic complete conic over k(t), h has poles at most three at EACH boundary and no other pole. Monic P has degree10 and u has a simple pole at each boundary. Therefore
\[
N=h³-P(u-1)
\]
has EXACT pole ten at each boundary, since its cube competitor has pole at most nine. Q has the same exact generic polar divisor and zero divisor the actual degree20 generic C divisor. On that actual divisor h=y₂, so N vanishes there. The map t is separating because all its original poles are simple; thus its degree20 does not introduce an inseparability exception. Equivalently one can use prime Cartier divisibility on the generic integral C divisor. It follows that N/Q is regular everywhere on the generic projective conic. The boundary gives a k(t)-rational point, so its global regular functions are k(t). Hence
\[
g(t)=\frac{h³-P(u-1)}{\gamma Q}\in k(t)^*.
\tag{9}
\]
It is nonzero by the exact pole comparison. Equation(6) identifies g=Dh/ρ wherever the ratio is written.

## 4. The finite-fiber noncube test and exact allocation ledger

Every smooth finite conic fiber is rational and u has degree two on it. On either component of a reducible fiber, u has degree one. P(u−1) is not a cube in any of these fields: its irreducible Kummer field over k(u) has degree three, because P is squarefree and not a cube. Such a field cannot embed in an extension of degree two or one. This checks EVERY finite smooth parameter, including special smooth fibers and t=0, as well as both components of the six reducible fibers.

At the generic point of any finite vertical prime, P(u−1) is regular. If h is regular there, this noncube test says the residue of N is not identically zero, so ord(N)=0. If h has an additional pole of order p>0, its cube dominates and ord(N)=−3p. Both cases give ord(N)=−3p with p≥0.

At every smooth finite fiber, Q has valuation zero in(8), and therefore
\[
\operatorname{ord}_a(g)=-3p\le0.
\tag{10}
\]
At t=tᵢ, the chosen reference gives ord_Eᵢ(Q)=a_i−10 and ord_Eᵢ′(Q)=0. The base uniformizer has order one on BOTH components. Thus
\[
\operatorname{ord}_{t_i}(g)=-3p_i'\le0,
\qquad a_i-10=3(p_i'-p_i).
\tag{11}
\]
In particular g has NO finite zero. The signs of this signed-frame ledger are essential; the necessary congruence a_i≡1 modulo3 by itself would not eliminate finite poles.

## 5. Infinity excludes additional poles and positive zeros of g

Put s=t⁻¹,U=s³u,V=s³v. The smooth infinity fiber is U²−V²=d. In frame(8), q=s³⁰Q has EXACT poles ten at EACH boundary and is nonzero there as a regular defining-section coefficient. No correction Eᵢ lies at infinity.

Every actual C₀ point over infinity has s as a parameter and x₂ pole order exactly three by actual étaleness, so U=s³(x₂+1) is a unit. Consequently C avoids both auxiliary points U=0 and q is a unit there. This uses every actual branch without placing a bound on how many branches share an image. For z=U+V,
\[
U=(z+d/z)/2,\qquad V=(z-d/z)/2,
\tag{12}
\]
so U has two simple zeros, distinct from the boundaries z=0,∞.

Suppose h has an extra infinity pole of order k>0. Write h=s^{-(10+k)}H with H₀=H|F∞ nonzero. Its boundary pole bounds are still three at each end, with no other fiber pole. Formula(9) makes the nonzero leading coefficient of the BASE function g at order s⁻³ᵏ equal to
\[
H₀³/(\gamma q).
\tag{13}
\]
This is a nonzero rational function vanishing at BOTH boundaries, since its numerator has poles at most nine and q exact pole ten. It cannot be the nonzero constant leading coefficient of a base rational function. This contradiction removes every extra infinity pole.

Without an extra pole, write h=s⁻¹⁰H in its allowed frame. Then
\[
g=\frac{H³-s^{30}P(s^{-3}U-1)}{\gamma q}
\tag{14}
\]
has no infinity pole. A positive infinity zero would imply H₀³=U¹⁰, which is impossible: at either simple zero of U its right side has order ten, not divisible by three. Hence g has neither a pole nor a zero at infinity.

## 6. Constancy forces every vertical multiplicity and the exact linear boundary

Every finite valuation of g is nonpositive by(10)–(11), and its infinity valuation is zero. Its principal divisor on P¹ has degree zero; therefore every valuation is zero and
\[
g=g_0\in k^*.
\tag{15}
\]
At every smooth finite fiber, (10) forces p=0. At a reducible fiber, (11) first forces p_i′=0 and then a_i−10=−3p_i≤0. The six allocations sum to60, so every a_i=10 and every p_i=0. Section5 removed all extra infinity poles. Hence h has no divisorial pole beyond3D+10F∞ and is a genuine global section of that bundle on smooth S. This is exactly ENTIRE divisor divisibility ρ|a, including vertical multiplicities.

Now(7) gives the LINEAR classes C~10L,R~4L. In the compatible uncorrected canonical frame, (9), (6) and(15) give
\[
h³-P(u-1)=\gamma g_0Q,\qquad\mathcal Dh=g_0\rho.
\tag{16}
\]
Thus the remaining critical quotient is a nonzero scalar, consistent with the accepted [entire-factor boundary](canonical_split_full_cubic_extension_degree_twenty_boundary.md). The exact invariants follow from L²6,K_SL−4 and actual genus161:
\[
C²=600,\quad K_SC=-40,\quad p_a(C)=281,
\quad\delta=120,\quad\deg\Delta=240,\quad RL=24.
\tag{17}
\]
These are necessary boundary data, not its existence or exclusion.

## 7. The other ACTUAL endpoint and audit provenance

For b use the established original endpoint swap τ=t⁻¹,u₁=v/t³,v₁=u/t³. Its conic has the same form and its exact common-adjoint transport retains the SAME effective R. The original first extension differs from b by the vertical factor t¹⁰; hence the full horizontal-divisibility premise is preserved with every multiplicity. Repeating Sections2–6 yields ENTIRE divisibility for that same individual first extension and its corresponding zero error. No mixed row has been substituted for an original cubic, and neither actual étale map leaves its SAME original C₀/T.

The new implication was independently whole-audited in the [self-contained source note](../../Research/notes/oct03_ten_hour/split_twenty_horizontal_cubic_factor_boundary.md), SHA256 `713e1d5ba9d79a7c024c0242277f02e5f3d4ef2491966172d314b829745d32cd`, and [twelve-check PASS receipt](../../Research/notes/oct03_ten_hour/split_twenty_horizontal_cubic_factor_boundary_audit.md), SHA256 `bc4993320835a9dd85f83f84ea6b869d8948d7fe5de98e2c41f3a9a75065e11e`. During that audit the reference terminology was corrected to the explicit SIGNED divisor(8); the amended source was read back and pinned before PASS. No numerical job or settled certificate replay was used.

This canonical presentation needs only a fresh focused scope/presentation read of the new pair against that accepted implication. General horizontal factor forcing and the exact actual degree-twenty source boundary remain OPEN. The unmarked common-cover problem remains UNSOLVED.

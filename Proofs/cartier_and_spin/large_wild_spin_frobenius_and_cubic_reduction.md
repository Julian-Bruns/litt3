# Proof: genus-two differential torsion, actual cubic lowering, and deep local jets

Version2,3 October2026. [Statement](../../Theorems/cartier_and_spin/large_wild_spin_frobenius_and_cubic_reduction.md). The whole proof, including the second-tier section, passed [root's independent review](../../Research/audits/LARGE_WILD_SPIN_FROBENIUS_AND_CUBIC_REDUCTION_AUDIT_2026_10_03.md). Both original finite étale endpoint maps stay on the SAME T. Reuse the accepted [eleven-profile classification](wild_ramified_spin_complete_inertia_profiles.md), [actual quotient Picard presentation](../quotient_geometry/local_actions/two_point_wild_orbifold_picard_group.md), [full Hermitian completed-local classification](../quotient_geometry/local_actions/hermitian_local_normality.md) and original carrier identifications. No computation or certificate is needed or replayed.

## Weighted branch divisors include every distinguished position

Put B0=Γ/G. At a point of either branch value, Y→B0 has the corresponding Γ/B0 local type unless it is P; at P its local index is doubled and its different is ONE plus twice the Γ/B0 different. This follows from the ACTUAL tower through the étale q and the index-two φ, not from a hypothetical simultaneous Galois closure.

Let A,B be the branch fibers divided by their normal indices e,m. Away from P their multiplicities are ONE, and at P the multiplicity is TWO if it belongs to that branch. For both large profiles deg A=7,deg B=1000. In particular ordinary/tame distinguished position has seven wild points away from P, while the distinguished-wild position has five away from P and P with weight TWO. For a pole coordinate β on B0 whose zero is the tame branch,
\[
\operatorname{div}\beta=mB-eA,\qquad
\operatorname{div}(d\beta)=(\Delta-2e)A+(m-1)B+P.
\]
The extra P coefficient is correct at ALL positions: it accounts for the additional local different ONE in the φ tower, including when P is already in A or B.

## Canonical21000 forces the norm classes to be trivial

For e=3000,m=21,Δ=3143 the invariant section formula is
\[
d_j=\lfloor143j/3000\rfloor-\lceil j/21\rceil.
\]
The genuine weight21 and3000 generators have order THREE on the wild and tame orbit respectively, and no other zeros. Their normalized functions F*,G* therefore satisfy
\[
\operatorname{div}F_*=3A-21P,\qquad
\operatorname{div}G_*=3B-3000P,
\qquad\beta=G_*^7/F_*^{1000}.
\]
Indeed their powers at weight21000 have coarse divisor degree ONE and different branch zeros, so their ratio is an ACTUAL coarse coordinate.

Let τ=[A−7P],ρ=[B−1000P] in Pic0(Y). The displayed norms kill both classes by THREE. The β divisor gives7ρ−1000τ=0. Modulo THREE this isρ−τ=0. On the other hand divσ=2P, and the exact dβ divisor gives
\[
0=[\operatorname{div}(d\beta/\sigma)]
=-2857\tau+20\rho.
\]
Its P coefficient cancels because−2857·7+20·1000−1=0. Since ρ=τ and−2837≡1 modulo THREE, τ=ρ=0. This uses the Weierstrass differential and the actual index-two tower; no assumption that the weighted fibers avoid P is made.

Consequently F* and G* are cubes in k(Y), up to constants which are cubes over k. Their root divisors are A−7P and B−1000P. In particular β is a cube in Y and not in the rational B0-field.

## The cubic target lies inside the original source

Because G acts faithfully on Γ and k(T)/k(Y) is Galois with group G, the actual compositum ΓY is T; degree comparison gives linear disjointness over B0. Thus Γ1=Γ(β^(1/3)) inside T has EXACT degree THREE over Γ. This is not a separately imagined cover. The divisor of β on Γ has valuations−3000 and21, both divisible by THREE, so this prime-to-five root cover is connected finite étale.

G fixes the chosen root in Y and acts on Γ1 with trivial kernel, since its action on Γ was already faithful. The coarse curve of Γ1/G is the rational curve with coordinate β1=β^(1/3). At the two values its new inertia orders are1000 and7; the tame tower gives wild different3143−3000+1000=1143. The factor φ1:T→Γ1 has degree7000 and the SAME different qP. Pulling M and N along the étale target cover keeps N1≅ωΓ1 genuinely. Old Γ(a)=T gives Γ1(a)=T, and all original infinity sections pull from Γ1. Both original endpoint maps and their degrees are unchanged.

## Canonical7000 has the same low Cartier gate as canonical140

Now use e=1000,m=7,Δ=1143. The weight7 and1000 canonical generators have order ONE on their respective branch orbit and no other zeros. Their normalized functions satisfy divF=A−7P and divG=B−1000P, and β=G⁷/F¹⁰⁰⁰ is the actual coarse coordinate. Its exact differential divisor is−857A+6B+P. Since
\[
d\beta=2G^6F^{-1000}dG,
\]
one gets div(dG)=143A−999P. This is precisely div(F¹⁴³σ), so dG=cF¹⁴³σ for a nonzero global constant. The formula includes the distinguished-wild point: its coefficient is2·143−999=−713, not−999. The ordinary/tame points have coefficient−999. Thus the actual weighted-divisor derivation covers all positions.

F¹⁴³=(F²⁸)⁵F³. Cartier exactness consequently gives0=C(dG)=c^(1/5)F²⁸C(F³σ), hence C(F³σ)=0. The fixed-pole F is a function in L(7P), of pole7 ordinarily/tamely and pole5 in the distinguished-wild case. This gate is the SAME low-degree endpoint condition occurring in ordinary canonical140, although no canonical140 carrier is thereby constructed.

## A primitive with pole at most eighteen

Choose a monic quintic model Y:y²=Φ(z) with P at infinity, σ=dz/y. Write F=A3+yB1, degA3≤3,degB1≤1. Then
\[
F^3\sigma=U(z)dz+V(z)dz/y,
\quad U=3A_3^2B_1+\Phi B_1^3,\quad
V=A_3^3+3A_3\Phi B_1^2,
\]
with degU≤8,degV≤9. Cartier vanishing separates its invariant and y⁻¹ sectors. Thus U has a polynomial primitive of degree≤9.

For the odd sector put R=VΦ², degR≤19. Cartier zero says all coefficients of R with exponent4 modulo FIVE vanish. Hence R has a polynomial primitive T0 of degree≤20. At every simple branch root b, T0' is divisible by(z−b)², so T0 modulo(z−b)³ is constant. Choose a polynomial Q0 of degree≤4 interpolating Q0(b)⁵=−T0(b) at the five branch roots. Then T0+Q0⁵ is divisible by Φ³ and still has degree≤20. Write T0+Q0⁵=Φ³C0, degC0≤5. Because y⁵=yΦ²,
\[
d(yC_0)=d((T_0+Q_0^5)/y^5)=Vdz/y.
\]
Adding the even primitive gives H0 regular away from P with pole≤18P and dH0=F³σ. This establishes the bounded primitive explicitly, including boundary coefficients, rather than assuming a rational primitive has no finite poles.

Since dG=cF¹⁴⁰dH0 and F¹⁴⁰ is a fifth power, the difference G−cF¹⁴⁰H0 has zero differential and is J⁵ for a rational J. Both terms are regular off P and have pole≤1000P: F¹⁴⁰H0 has pole≤998P. Therefore J is regular off P with pole≤200P. This proves the stated Frobenius remainder identity.

## Full local normality forces deep remainder jets and a common scalar

Fix a wild point R≠P. Here F has a simple zero, G is a unit, and the actual completed field Y/B0 is the Γ/B0 completed Galois extension, because BOTH q and φ are étale here. In the local coordinate t=F, put f=β⁻¹=t¹⁰⁰⁰G⁻⁷. The accepted Hermitian theorem with p=5,tame complement8 has E=1000,A=120,B=144,r=3. It forces all f-coefficients of increments1,…,119 to vanish, and its coefficients of increments120 and144 to be nonzero.

Because raising a unit to its−7 power has nonzero linear derivative, the first condition equivalently kills all G-coefficients of increments1,…,119. In the Frobenius remainder identity, the first term vanishes to order at least140, while J⁵ has only increments divisible by FIVE. Thus J has zero coefficients1,…,23; its coefficient aR of F²⁴ is nonzero. Its constant J(R) is nonzero because G(R)=J(R)⁵ is a unit. Since24 is nonzero in characteristic FIVE, dJ has exact zero order23.

If σ=(fR+O(F))dF, the derivative identity gives G144=4cfR. The three Hermitian quotient coefficients are
\[
c_{1000}=G(R)^{-7},\quad
c_{1120}=3G(R)^{-8}a_R^5,\quad
c_{1144}=2c f_R G(R)^{-8}.
\]
Substituting them into the FULL fixed-base invariant c1000³(c1120/c1144)¹²⁵ gives exactly4aR⁶²⁵/(c¹²⁵fR¹²⁵J(R)¹⁰⁵). Since the actual Γ/B0 Galois cover identifies its completions over the SAME β-base, these values agree across every such point. The other finite Hermitian normality equations remain required; matching this scalar alone is not asserted to recognize arbitrary nongalois series.

Finally dJ has no poles away from P and has pole at most200P: a pole200 term differentiates to zero, and any smaller pole gives derivative pole≤200. The exact order23 at every finite F-zero makes dJ/(F²³σ) regular there, hence regular everywhere off P. If F has pole νP, ν=7or5, then F²³σ has pole(23ν−2)P, giving the asserted remainder bound200−(23ν−2)=41or87.

## Version2: a second Frobenius tier with a pole-forty remainder

Put \(\mathcal R=dJ/(F^{23}\sigma)\). The preceding bounds give \(\mathcal R\in L(41P)\) if F has pole7P, and \(\mathcal R\in L(87P)\) if it has pole5P. Since dJ=F²⁰\(\mathcal R\)F³σ and F²⁰ is a fifth power, Cartier exactness gives C(\(\mathcal R\)F³σ)=0.

Construct a bounded primitive K0 by the SAME explicit polynomial-sector integration, now applied to \(\mathcal R\)F³σ. In the ordinary/tame case write \(\mathcal R\)=A20+yB18 and F=A3+yB1. The invariant polynomial coefficient of dw has degree at most28; the odd coefficient of σ has degree at most31. Their primitives consequently have invariant degree at most29 and odd degree at most27 after division by Φ³. Thus K0 has pole at most59P.

In the distinguished-wild case F has pole5P, hence F=A2+yB0; write \(\mathcal R\)=A43+yB41. The invariant and odd differential coefficients have degrees at most48 and51. The same interpolation at the five branch roots produces a primitive with invariant degree at most49 and odd degree at most47, giving pole at most99P. All functions remain regular off P. These bounds do not assume the remainder is invariant or that its odd leading term vanishes.

Now d(F²⁰K0)=dJ. Thus J−F²⁰K0=K1⁵. The first term has pole at most200P; the second has pole at most199P in BOTH cases, since20·7+59=20·5+99=199. It follows that K1 lies in L(40P). Substitution into the original decomposition gives exactly G=cF¹⁴⁰H0+F¹⁰⁰K0⁵+K1²⁵.

At an unramified wild point, F²⁰K0 vanishes to order at least20. The already established J-gap of orders1,…,23 therefore kills the K1 coefficients of orders1,2,3 (which would contribute orders5,10,15 in its fifth power). K1 is nonzero there because J(R)=K1(R)⁵ and J(R) is a unit. Consequently dK1 vanishes to order at leastTHREE at every finite F-zero. It has no other finite pole and has pole at most40P: a possible pole40 term differentiates to zero. Dividing by F³σ therefore gives \(\mathcal R_1\) regular off P with pole at most40−(3·7−2)=21 ordinarily/tamely, or40−(3·5−2)=27 in the distinguished-wild case. The ratio is allowed to be zero; no unsupported nonvanishing assertion is made.

Locally dJ=F²³σ\(\mathcal R\) gives aR=4\(\mathcal R(R)\)fR. Substitute this and J(R)=K1(R)⁵ into the prior Hermitian scalar: it becomes \(\mathcal R(R)^{625}f_R^{500}/(c^{125}K_1(R)^{525})\). Its unique twenty-fifth root is the stated \(\mathcal R(R)^{25}f_R^{20}/(c^5K_1(R)^{21})\), and is constant across the same completed branch fields.

This is a global Frobenius and local-jet constraint on an ACTUAL carrier. It neither removes the pole-forty remainder nor proves a uniform source-degree bound. The entire degree21000 branch lowers to degree7000, but the remaining degree7000 branch and the separate étale source problem are OPEN. The full Hermitian finite coefficient relations are additional constraints, not replaced by this one common scalar or by generic exactness alone.

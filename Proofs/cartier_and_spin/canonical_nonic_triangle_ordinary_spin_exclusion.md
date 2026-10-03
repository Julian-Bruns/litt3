# Proof: an exact Cartier gate on the complete cubic-torsion algebra

Version1. [Statement](../../Theorems/cartier_and_spin/canonical_nonic_triangle_ordinary_spin_exclusion.md). Implication passed [independent whole review](../../Research/audits/ORDINARY_DEGREE_EIGHTEEN_SPIN_EXCLUSION_AUDIT_2026_10_03.md). Reuse the accepted tame signatures, [different primitivity](tame_spin_different_primitivity.md), and primitive-even-polynomial obstruction. All original maps and the actual source remain in place.

## Actual canonical generators and the regular differential

Canonical signature(2,3,9) weights(1,2,8) make N=ω_[Γ/G]. The exact stack Hurwitz/different identity gives ωY=O(2P), hence P Weierstrass. The invariant generator weights below18 are6,8,9,12,14,15,16,17. Put
\[
F=t_6/s^6,\quad G=t_8/s^8,\quad H=t_9/s^9.
\]
Their sole pole orders are EXACTLY6,8,9. Their zero divisors are3D, D+E, and the complete order-two fiber respectively, where D is the TWO distinct order-nine fiber points and E the SIX distinct order-three fiber points. In particular H is a unit at D, while G has order ONE there. The invariant N24 space has dimension TWO and basis t6⁴,t6t9². The forced zero of t8³ at the order-three cone differs from both basis cone zeros, so
\[
G^3=F(\alpha F^3+\beta H^2),\qquad \alpha\beta\ne0.
\]

The rational differential
\[
\nu=(F\,dG-3G\,dF)/(F H)
\]
is regular. At H=0, F,G are units; differentiating the identity gives the numerator divisible by H. Explicitly
\[
3G^2(F\,dG-3G\,dF)=2\beta FH(F\,dH+H\,dF),
\]
where characteristic five reduces4 to−1 and9 to4. At D, F,G have orders3,1, H is a unit; numerator and denominator have order at least THREE, so ν is regular. Other finite points have no denominator zero. At P, the numerator's leading pole15 cancels because8−3·6=−10=0, whereas FH has pole15; hence ν vanishes at least ONCE. It is nonzero because G/F³ has pole order EIGHT at each D point, not divisible by five, and its differential is a nonzero scalar times the numerator. Thus
\[
\nu=c\sigma,\quad \sigma=dz/y,\quad c\ne0,
\]
with z of pole2P and y²=Φ(z) monic squarefree of degree FIVE.

## A separating Kummer extension gives C(Fσ)=0

Adjoin ξ6=F. This extension is used only for a necessary differential identity, not as an étale replacement source. Put x=G/ξ8,z_E=H/ξ9. The generator identity gives
\[
z_E^2=(x^3-\alpha)/\beta,
\]
a nonsingular elliptic curve with Cartier-zero invariant differential in characteristic five. Direct differentiation, using8/6=3 in the ground field, gives
\[
dx/z_E=\xi\nu=c\xi\sigma.
\]
As in the [degree24 proof](canonical_octavic_triangle_ordinary_spin_exclusion.md), Cartier commutation and ξ25=ξF4 give C(σ/F4)=0, equivalent to C(Fσ)=0 on the ORIGINAL endpoint.

Write F=B3(z)+a y with degB3=3. The coefficient a is nonzero: otherwise its polynomial zero divisor would be invariant under the hyperelliptic involution, forcing D to be a canonical pair and its three-torsion class zero. If D were a canonical pair, the ratio F would be a scalar cube of a degree-two function. This invariant possibility is ALSO excluded directly by the characteristic parity argument below; hence we treat the nonzero class here first.

Scale F so B3 is monic and put λ=a²≠0. Since divF=3D−6P,
\[
B_3^2-\lambda\Phi=V_2^3,\qquad V_2=z^2+r z+s.
\]
The Cartier gate is C(B3σ)=0, because a dz is exact. Its two components, before harmless fifth roots of constants, are
\[
[z^4]B_3\Phi^2=0,\qquad [z^9]B_3\Phi^2=0.
\]

## Complete BACKUP gate exclusion without replaying the torsion census

The accepted [complete BACKUP cubic norm algebra](../quotient_geometry/endpoint_exclusions/backup_hermitian_atlas_exclusion.md) contains all40 normalized cubic norm points, representing ALL80 signed nonzero three-torsion classes. Its retained [input certificate](../../../litt3-computation-data/legacy_workspace_computations/backup_genus_two_torsion.json) has a degree40 separator and four degree39-or-less polynomials giving the coefficients of the monic cubic B. No norm equations or torsion enumeration are rerun.

The NEW focused [source](../../scripts/genus_two/oct03_n18_cartier_gate.py) computes the two Cartier components in that exact finite algebra for each of the SIX Weierstrass origins. At a finite origin p, use z=1/(x−p); the monic cubic numerator transforms as
\[
B_p(z)=z^3B(p+1/z).
\]
This transformation is valid for all norm classes because2p∼2O: the unique effective divisor D representing K_Y+τ is the SAME divisor at either origin, and Fp=FO/(x−p)³. The new hyperelliptic polynomial may be scaled to monic; this changes only nonzero scalar factors in Cartier tests.

The retained [new gate certificate](../../../litt3-computation-data/oct03_n18_cartier_gate/backup_cartier_gate.json) records both component polynomials and their gcd with the separator for every origin. ALL SIX gcds equal ONE. Thus no nonzero cubic class at any Weierstrass origin satisfies the necessary gate. The sign of a is immaterial, since C(a dz)=0. Reproduce only these NEW checks with `python3 scripts/genus_two/oct03_n18_cartier_gate.py`.

## Proper incidence and an explicit MAIN exceptional-parameter bound

Over the smooth parameter curve t5−t≠0, remove the zero section from the finite étale relative J[3]. Every remaining class τ has a UNIQUE effective degree-two representative D of K_Y+τ: Riemann–Roch gives h0(K_Y+τ)=1 because τ≠0. No D contains a Weierstrass point. Indeed its norm function with divisor3D−6P would have an odd order THREE at such a point, but B3+a y with a≠0 has either order zero or ONE there. If a=0 its zero divisor is hyperelliptic and τ=0. This also excludes a repeated Weierstrass representative. Hence its normalized monic cubic norm data exist and vary algebraically on this finite scheme.

The Cartier-zero condition on that normalized line is closed. Its incidence Z is therefore CLOSED in a finite proper parameter scheme. All SIX BACKUP fibers are empty by the exact gate check. Thus no component of Z dominates the parameter curve, and its parameter support is finite. This is a PROPER torsion argument; no projection of an arbitrary affine norm relaxation is presumed closed.

For an explicit bound, treat each of the SIX labelled origins separately. Its monic transformed Φ has coefficients rational in t with a common denominator Δ(t) of degree at most FOUR and numerators of degree at most FOUR: at origin t use the four denominators c−t for c=0,1,2,3; at the other finite origins only the denominator t−p varies. At infinity take Δ=1.

Use variables t,b0,b1,b2,r,s,λ,w, with
\[
B=b_0+b_1z+b_2z^2+z^3,\qquad V=z^2+r z+s.
\]
The SIX coefficient equations of B²−λΦ=V³ have total degree at most SEVEN after multiplying by Δ. The TWO Cartier equations have degree at most NINE after multiplying by Δ². Add wλΔ−1=0, of degree at most SIX, to retain λ≠0 and the coordinate open. On smooth parameters, this norm system is finite over t: its solutions give exactly the nonzero three-torsion classes up to the two signs a, as checked directly from the norm identity and its divisor. The common Cartier gate locus is finite by the preceding proper incidence argument.

Choose ONE generic constant linear combination of the two Cartier equations. It is not identically zero on any norm component meeting the smooth parameter open, because such a component would dominate that open and both gates would then meet the BACKUP fiber, contrary to its empty incidence. Thus the good common gate points are isolated points of the intersection of EIGHT equations: six norm equations, this one combination, and the inverse equation. Affine isolated Bézout bounds their number by
\[
7^6\cdot9\cdot6=6353046
\]
per origin. Components confined to excluded parameters do not increase this bound for isolated good points. Union over SIX origins gives at most38118276 geometric parameters. The original finite gate support is defined over F5, hence Frobenius-stable. The accepted selected MAIN parameter degree exceeds336000², and therefore exceeds38118276; it avoids this support. The nonzero cubic-class case is excluded on MAIN too.

## The invariant F possibility is separately excluded

If F is polynomial in z, divF=3D−6P and D consists of TWO distinct points. Its zero multiplicities THREE are odd, so the two points must be a non-Weierstrass conjugate pair, and F is a constant times z³ after shifting z so this pair is zero. The pole-eight generator has divisor D+E−8P, so G/z has sole pole SIX and can be written U3+v y. The regular differential identity ν=cσ becomes
\[
\frac{z^3\,dG-3G\,d(z^3)}{z^3H}=c\sigma.
\]
With G=z(U3+v y), it gives
\[
cH=y(zU_3'-3U_3)+v(z\Phi'/2-3\Phi).
\]
The polynomial term has exact degree FIVE if v≠0, since5/2−3=−3≠0, whereas H has sole pole NINE. Hence v=0. Thus F,G are invariant, and H is anti-invariant by this same identity. The norm N18 space is spanned by F³,H², so its normalized coefficient is invariant too. All even characteristic coefficients are monomials in F,G; the surviving odd ones are H and FH (e17=0 at the ordinary point). Evaluation forces H(a+bF)=0 after taking the odd part. Distinct pole orders of1,F force a=b=0, giving the forbidden even primitive polynomial. This excludes the zero cubic-class case on both endpoints, completing the canonical ordinary degree18 row.

The branched Kummer extension was used only to prove a necessary Cartier identity; the original common-cover maps remain the actual ones. No unmarked common-cover decision is inferred.

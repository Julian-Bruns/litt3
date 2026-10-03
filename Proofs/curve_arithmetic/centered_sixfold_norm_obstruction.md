# Proof: Frobenius halving and the centered pole-fifteen pencil

Version2, 3 October2026. The simplified centered-support proof passed [fresh four-check static extension review](../../Research/audits/OCT03_CENTERED_SIXFOLD_FROBENIUS_HALVING_STATIC_EXTENSION_AUDIT_2026_10_03.md), with no correction. The independent fixed42/78 claims retain their [five-check whole review](../../Research/audits/OCT03_COMPLETE_CENTERED_SIXFOLD_NORM_FIXED_RR_RANK_WHOLE_AUDIT_2026_10_03.md). See the [statement](../../Theorems/curve_arithmetic/centered_sixfold_norm_obstruction.md). The exact [Version1 certificate proof snapshot](../../Research/history/centered_sixfold_norm_obstruction_version1_certificate_proof.md) preserves the earlier orientation argument and audit provenance.

## 1. Frobenius halves every sixfold centered relation

Put β²=β+3, p0=p(0)=3+β and ζ=p0⁸=3+3β. Field identities give p0³=2 and ζ³=1 with ζ≠1. Choose y0³=p0, Ti=(0,ζ^i y0), and σ(U,y)=(U,ζy). This deck rotates the three centered points and fixes infinity O. If F is25-Frobenius, y0²⁵=y0p0⁸ gives FTi=σTi.

On the cyclic module of v=[T0−O] in the geometric Jacobian,
\[
Fv=\sigma v,\qquad(1+\sigma+\sigma^2)v=0.
\]
The second equality is the principal divisor of U. These identities hold on every integer linear combination of the three centered point classes.

The settled [real Frobenius polynomial](fixed_pair_arithmetic.md) is
\[
Q(V)=V^9-2V^8-254V^7+457V^6+21826V^5-29834V^4
-703917V^3+354810V^2+6210225V+6613875,
\]
with characteristic polynomial T⁹Q(T+25/T). Frobenius is bijective on geometric Jacobian points. Cancelling F⁹ and using F=σ, σ⁻¹=σ²=−1−σ on this module gives
\[
Q(F+25F^{-1})=Q(-25-24\sigma)=0.
\]
Modulo two, Q(V)=V⁹+V⁶+V³+V+1 and −25−24s=1, so Q(-25−24s)=1+2R(s) for an integer polynomial R. Consequently this centered module has no nonzero element killed by two: applying the annihilator to such an element x gives x+2R(σ)x=x=0.

Let E be any effective centered divisor of degree five and D=[E−5O]. If6D=0, then x=3D is killed by two and lies in that module. Thus x=0 and
\[
3E\sim15O.
\]
This deduction needs no torsion-order computation or certificate.

## 2. The pole-fifteen space excludes every support size

Choose a function f of divisor3E−15O. Its pole order at O is exactly fifteen. The affine superelliptic basis and pole semigroup⟨3,10⟩ give
\[
f=A(U)+B(U)y,\qquad\deg A\le5,\quad\deg B\le1.
\]
If E contains exactly two distinct centers, f vanishes at their two distinct y-values at U=0. Therefore A(0)=B(0)=0, making f vanish at the absent third center as well. This contradicts the exact divisor.

If all three centers occur in E, their vanishing orders are at least three. The same evaluation gives U|f. The quotient f/U still vanishes at all three centers, to order at least two, so a second evaluation gives U²|f. Now
\[
f/U^2\in L(9O)=\operatorname{span}\{1,U,U^2,U^3\}.
\]
Its pole order is exactly nine and all zeros lie over U=0, so f/U² is a nonzero constant times U³. Hence f is a constant times U⁵, having order five at EACH center. These orders cannot be3ei with integer positive multiplicities ei. Full support is impossible.

For one-point support E=5Ti, the halved relation is15[Ti−O]=0. Put x=3[Ti−O], so5x=0. Reducing the same Frobenius annihilator modulo five and σ²+σ+1 gives2+3σ, a unit with inverse2+σ. It follows that x=0. But L(3O)=span{1,U}; a nonconstant function in this pencil vanishing at Ti has all three centered points as simple zeros. It cannot have divisor3Ti−3O. This excludes one-point support and completes the proof for every repeated multiplicity pattern.

## 3. Independent fixed42/78 nonprincipality certificates

The earlier newly executed matrices prove two additional claims, although they are no longer needed for the centered-support obstruction. Work in K=F5[y0]/(y0⁶+3y0³+4), with β=y0³−3 and y0³=p0. The encoding Σci5^i for Σciy0^i,0≤i<6 differs from the F25 encoding. At T0, U is an étale parameter. The exact basis of L(mO) is
\[
\{U^i y^j:0\le j\le2,\ 3i+10j\le m\}.
\]
Distinct monomials have distinct pole orders and the affine ring is free with basis1,y,y² over k[U], so the list has no missing element. For m42and78 it has34and70 members. A function of divisor mT0−mO would lie in the kernel of the m-jet evaluation of this space.

The [one newly executed source](../../scripts/oct03_centered_abel_42_78_riemann_roch_gate.sage) computes y(U) through order77 by the exact cube recurrence, dividing only by3y0², and asserts the complete cube identity. The [complete output](../../../litt3-computation-data/oct03_centered_abel_42_78_riemann_roch_gate_20261003T1702/events.jsonl) stores both full matrices, all y/y² series, ordered bases, pivot rows and nonzero square minors:

|m|matrix|column rank|encoded pivot determinant|
|---|---|---|---|
|42|42×34|34|127|
|78|78×70|70|3|

These determinants stay nonzero over the algebraic closure. Hence neither42(T0−O) nor78(T0−O) is principal; deck rotation proves the same for T1,T2. The [receipt](../../../litt3-computation-data/oct03_centered_abel_42_78_riemann_roch_gate_20261003T1702/receipt.json) records source SHA2560b903ef9b2c0d18cedfacc744e7be08f924e8a977cfe032d73c4ac334e217bc7 and input SHA256ad2af09c342a2d06ebf1d4a88209dd84023e893dc53fd1631f85ee6ea84fdd68. Exactly one one-thread process exited in2.770 seconds, with mathematical completion at0.135 seconds, no timeout and empty stderr. The independent five-check review inspected the data without replay. No nontorsion claim follows.

## 4. The actual conditional third fiber

Retain both actual finite étale degree25 maps h1,h2:C0→X. If the remaining critical Q/z fiber is3R, π*R=2E_C with E_C reduced of degree five, and all five points are centered on the endpoints, then
\[
\operatorname{div}_{C_0}(z-\gamma)=6E_C-2D_2.
\]
Here degD2=15 and every D2 point maps to O under h2. Its actual endpoint norm has divisor6(h2)_*E_C−30O. This is the forbidden centered degree-five relation. The other actual étale map stays on the same C0; neither is transferred to Q.

The argument deletes only this conditional all-centered uniform-sixfold branch. The local three/six classification is separate, and unramified or single-fold third fibers, other Q/z profiles and the common-cover problem are not settled by the centered theorem alone.

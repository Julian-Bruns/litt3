# Proof: a pole-five horizontal function contradicts the complete oper coefficient list

Version2,3 October2026. [Statement](../../Theorems/cartier_and_spin/large_wild_distinguished_wild_spin_exclusion.md). Pending independent whole review. Use the accepted actual large-wild reduction and the newly proved explicit logarithmic oper classification; no arithmetic calculation is needed. The exclusion of Cartier eigenforms at selected origins is proved below directly from branch coordinates.

## The actual large carrier produces a reduced pole-five function

For degree7000, the actual different and weighted branch formula give divF=A−7P. In the distinguished-wild position A contains2P and FIVE distinct unramified wild points. Therefore F has pole exactlyFIVE at P and simple zeros at those five points. The same actual reduction proves C(F³σ)=0 with divσ=2P. Both endpoint maps remain on T.

For degree21000, [the actual connected étale cubic target lowering](large_wild_spin_frobenius_and_cubic_reduction.md) produces a degree7000 carrier inside k(T). The coarse cube root leaves P on the wild branch, preserves its index-two different and retains all genuine spin data and both original maps. Thus the same pole-five conclusion applies.

For degree140, the canonical weight7 and20 generators have wild/tame orderONE, yielding divF=A−7P,divG=B−20P and β=G⁷/F²⁰, with degA=7,degB=20. The actual étale/index-two tower gives divdβ=−17A+6B+P in EVERY distinguished position. Since dβ=2G⁶F⁻²⁰dG, one obtains divdG=3A−19P=div(F³σ). Thus dG=cF³σ and C(F³σ)=0. In the distinguished-wild position F again has poleFIVE and FIVE simple finite zeros. This argument uses the actual carrier ledger, not a hypothetical degree140 carrier extracted from a large Frobenius primitive.

## Every selected Weierstrass origin has q≠0

Choose a monic quintic y²=Φ(z),P=∞,σ=dz/y, and write Φ=z⁵+qz⁴+rz³+sz²+tz+u. Direct Cartier extraction gives
\[
C(\sigma)=(2qu+2rt+s^2)^{1/5}\sigma+(2q)^{1/5}z\sigma.
\]
If q=0, σ is a Cartier eigenform, including possibly eigenvalueZERO. Here is a direct coordinate verification that this cannot happen at any selected Weierstrass origin. The branch set of Yt is {∞,0,1,2,3,t}, with t∉F5. The stabilizer of4 in PGL2(F5) acts transitively on its other FIVE rational points. Hence for any fixed origin among∞,0,1,2,3, a transformation over F5 moves it to∞ and preserves that set of five branch points; it sends t to another t′∉F5. The resulting monic quintic u(u−1)(u−2)(u−3)(u−t′) has quartic coefficient q=−(1+t′)≠0.

For the moving origin P=t, set x=1/(u−t), r0=t+1 and K=r0⁴−1. Normalizing the quintic y0²=ΦP(x) to be monic gives quartic coefficient q=4r0³/K. Both numerator and denominator are nonzero because t∉F5: r0≠0 and every fourth root ofONE lies in F5. Further affine change of the Weierstrass coordinate preserves nonvanishing of q; translation does not alter a monic quintic's quartic coefficient in characteristic FIVE, and scaling multiplies it by a nonzero factor. BOTH selected endpoints have t∉F5. Thus q≠0 at every possible actual P, without a finite-field audit, Jacobian simplicity or source containment.

## The intrinsic pole-five impossibility

The [genuine log-oper construction](genus_two_cartier_cubic_log_dormant_oper.md) gives E∈L(5P) with ∂²F=EF, ∂=y d/dz. Its [complete coefficient list](genus_two_cubic_cartier_oper_classification.md) says that for q≠0 either E is polynomial with quadratic coefficient2q, or E=C0+vy with v≠0 and C0=Φ″/2=qz²+3rz+s.

Write F=A2(z)+B y, where B is a nonzero CONSTANT because F has poleFIVE. Then
\[
\partial^2F=\Phi A_2''+\tfrac12\Phi'A_2'
+B\tfrac12\Phi''y.
\]
If E is polynomial, comparison of odd parts forces E=Φ″/2. Its quadratic coefficient would be q rather than2q, contradicting q≠0.

If E=C0+vy is nonpolynomial, comparison of odd parts forces vA2=0, hence A2=0. The even part of ∂²F is nowZERO, while the even part of EF is vBΦ≠0, another contradiction. Thus no such F exists.

This intrinsic contradiction excludes the actual distinguished-wild carrier in all THREE profiles and on both endpoints. It does not remove any remaining ordinary/tame packet or decide the common-cover problem.

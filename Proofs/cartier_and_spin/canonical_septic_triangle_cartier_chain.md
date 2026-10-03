# Proof: pullback of the complete Cartier matrix of the septic genus-three curve

Version1. [Statement](../../Theorems/cartier_and_spin/canonical_septic_triangle_cartier_chain.md). Root focused mathematical review: PASS; retain author-prose evidence status. No independent whole-branch audit or exclusion is claimed. Reuse the exact generator and differential identities in the accepted [septic reduction](canonical_septic_triangle_ordinary_spin_reduction.md). Both original endpoint maps stay on their actual source.

Choose a root ξ of ξ14=G in an algebraic closure of k(Y), and use the resulting connected function field. This extension is finite separable, since fourteen is prime to five. Put
\[
x=F/\xi^6,\qquad w=H/\xi^{21}.
\]
The generator identity gives the smooth genus-three curve
\[
w^2=\alpha x^7+\beta.
\]
It is smooth because αβ≠0 and seven is prime to five. In characteristic five6/14=4, and−4=1. Therefore its actual differential pullback is
\[
\frac{dx}{w}=\frac{\xi^{15}}H
 \left(dF-4\frac F GdG\right)=\xi\nu.
\]
This is nonzero because ν is nonzero, so the induced curve map is separating. No étale property of this auxiliary map is assumed.

Let ω_i=x^i dx/w for i=0,1,2. These are a basis of regular differentials. The characteristic-five Cartier formula uses
\[
(\alpha x^7+\beta)^2=\alpha^2x^{14}+2\alpha\beta x^7+\beta^2.
\]
Cartier selects exponents congruent to FOUR modulo five. Thus exactly
\[
C(\omega_0)=\alpha^{2/5}\omega_2,\qquad
C(\omega_2)=(2\alpha\beta)^{1/5}\omega_1,\qquad
C(\omega_1)=0.
\]
The pulled-back forms are ξν, Fξ^-5ν, F²ξ^-11ν. Cartier commutes with separating pullback and obeys C(a5ζ)=a C(ζ). First,
\[
C(F\xi^{-5}\nu)=\xi^{-1}C(F\nu)=0,
\]
so C(Fν)=0 on the ORIGINAL Y.

For ω0 use ξ=(ξ³)5/G and ξ^-11=ξ³/G. Cancelling the common nonzero ξ³ gives
\[
C(\nu/G)=\alpha^{2/5}F^2\nu/G.
\]
Since ν/G=G^-5(G4ν), this is exactly C(G4ν)=α2/5F²ν.

For ω2 use ξ^-11=(ξ9)5/G4 and ξ^-5=ξ9/G. Cancelling ξ9 gives
\[
C(F^2\nu/G^4)=(2\alpha\beta)^{1/5}F\nu/G.
\]
Since F²ν/G4=G^-5(F²Gν), this becomes C(F²Gν)=(2αβ)1/5Fν. Every expression on the resulting two sides belongs to the original Y field; injectivity of the auxiliary separating pullback makes these identities hold there.

F,ν,α,β are nonzero, so both nonzero images are nonzero. The complete nilpotent Cartier chain, not merely its terminal zero, is retained. It supplies necessary tests for the residual septic source but no common-cover decision.

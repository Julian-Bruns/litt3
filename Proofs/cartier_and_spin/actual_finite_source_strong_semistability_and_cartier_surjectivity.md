# Proof: finite actual source descent, small-degree saturation and kernel stability

Version1, 3 October2026. [Independent bounded audit](../../Research/audits/OCT03_GENERAL_ACTUAL_SOURCE_STABILITY_AUDIT.md): mathematical PASS allSIX tasks; literal scope and twist clarifications applied. No computation is needed. The original source, scalar roots and BOTH actual endpoint maps are retained throughout.

## All dimensions and all relative Frobenius iterates

The paired original multipliers cancel in V⊗Λ², giving its specified genuine action onT₁. Effective faithfully flat descent along the ACTUAL free finite étale G-torsor q₁ gives A_V. The degree identity is
\[
N\deg A_V=\deg(q_1^*A_V)
=n\deg\Lambda^2=nN/FOUR.
\]
Thus n=FOUR m and degA_V=m. This uses integral degree, and no averaging over the FIVE-divisible group. The same construction applies to each retained coefficient submodule U, with its actual paired action.

Each relative Frobenius iterate of A_V pulls back along the corresponding actual twisted torsor to a direct sum of the same line. More precisely put Y_e=Y^(ONE−e), T_e=T^(ONE−e), q_e=q^(ONE−e), e≥ZERO, using inverse scalar Frobenius twists over the perfect k when the exponent is negative, and use the composite relative Frobenius Y_e→Y₁. Étale Frobenius base change is Cartesian; pulling the original descent datum through these exact squares preserves its genuine action. The scalar line is the actual corresponding Frobenius pull ofΛ²; its projective coefficient multipliers still cancel those of the pulled-back constant module. No unidentified root or unlabelled entrywise action is introduced. With the original calibration the coefficient module is V^[5^e]. Scalar rescaling does not change invariant subspaces, and coefficient Frobenius preserves irreducibility over the perfect constant field.

A direct sum of one line is semistable. If a Frobenius iterate of A_V had a strict destabilizing subbundle, pulling back along its separable torsor would multiply all degrees byN and preserve ranks, contradicting that semistability. This proves strong semistability for arbitrary V, without semisimplicity of the finite module.

Suppose V is irreducible and a proper subbundle B of an iterate had equality slope. After pulling to its connected projective actual torsor and dividing by the common line, it would be a degreeZERO rank-r subbundle of O^n. Choose a generically invertible projection to r coordinate factors. Its determinant is a nonzero section of a degreeZERO line, so it vanishes nowhere. The projection is consequently an isomorphism, and the inclusion has global regular matrix coefficients, hence constant coefficients. This produces a proper constant r-dimensional subspace. The genuine descent datum preserves it; canceling the common line says precisely that the actual projective coefficient-Frobenius action preserves it. Irreducibility forbids this. Thus each iterate is stable. Constant-field irreducibility is used here; no function-field independence is needed.

## Stability of the actual degreeONE rankTHREE quotient

Any torsion-free quotient of a semistable A_V has slope at leastONE/FOUR. If K had a strict destabilizing proper subbundle of rankONE orTWO, its integer degree would be at leastONE, since μ(K)=ONE/THREE. Its rankTWO orONE quotient would have degree at mostZERO. Composing the retained full-source surjection A_V→K with that quotient contradicts the positive quotient slope. Equality of slope for a proper rankONE orTWO subbundle ofK is impossible by integral degree. Hence K is stable. Irreducibility of the full source was unnecessary.

Now let U be an actual nonzero coefficient submodule with nonzero ORIGINAL map A_U→K, and let I be its integral image. If I had rankONE orTWO, stability ofK would give degI≤ZERO, including any saturation loss. Since I is also a torsion-free quotient of the semistable A_U, it must have positive degree, a contradiction. Thus rankI=THREE. Quotient semistability gives degI≥THREE/FOUR; integrality gives degI≥ONE. But I⊂K and degK=ONE imply degI≤ONE. Therefore degI=ONE and the full-rank inclusion has zero torsion quotient. This proves the literal integral surjection A_U→K.

Nonzeroness of this map must be checked in the ORIGINAL calibrated coefficient source. When the original constant evaluation is injective, a nonzero U cannot be mapped identically toZERO. This does not turn a constant module into an independent family over k(T) or k(Γ), and no quotient module is silently substituted for a submodule.

## Stable kernels in every irreducible dimension

For a U with the preceding NONZERO original map, suppose U is irreducible of dimensionFOUR m. The established surjection gives an exact sequence
\[
ZERO\longrightarrow C_U\longrightarrow A_U
\longrightarrow K\longrightarrow ZERO,
\]
with rankC_U=FOUR m−THREE and degC_U=m−ONE. For m=ONE it is a line, hence stable. For m=TWO, every proper rank r≤FOUR subbundleB of C_U is a proper subbundle of stable A_U, so degB<r/FOUR implies degB≤ZERO. Its slope is therefore strictly smaller than ONE/FIVE=μ(C_U).

For m≥THREE, a proper subbundle B of C_U has rankONE≤r≤FOUR m−FOUR and integral degree
\[
\deg B<r/FOUR,
\qquad \deg B\le\lfloor(r-ONE)/FOUR\rfloor.
\]
If degB≤ZERO its slope is already smaller than μ(C_U). Otherwise write j=floor((r−ONE)/FOUR). Then ONE≤j≤m−TWO, r≥FOUR j+ONE, and
\[
\mu(B)\le\frac{j}{FOUR j+ONE}
\le\frac{m-TWO}{FOUR m-SEVEN}
<\frac{m-ONE}{FOUR m-THREE}=\mu(C_U).
\]
The last strict cross-product difference isONE. Thus C_U is stable in every irreducible dimension. This argument does not imply its strong stability: after Frobenius the integrality bounds change. In particular the known first-Frobenius semistability for m=TWO is retained as a special case, not extrapolated to larger m.

## All actual adjoint subrows are basepoint-free

The embedded original K has nonzero Cartier evaluation λ_Y:F_Y*K→ωY. Write its image as ωY(−D), D effective. Since A_U→K is now integrally surjective, its first Frobenius pull makes this image a torsion-free rankONE quotient of F_Y*A_U. Strong semistability alone gives
\[
TWO-\deg D\ge FIVE/FOUR.
\]
Integral degree and effectiveness force degD=ZERO. Hence λ_Y is surjective. Its kernel has rankTWO and degreeTHREE.

On the ACTUAL T the original calibration gives q*F_Y*A_U=W_U⊗L¹⁰ and q*ωY=ωT=L¹⁶. Dividing the pulled-back evaluation by L¹⁰ produces the SAME original adjoint scalar map W_U O_T→L⁶, now surjective. It globally generates L⁶ for every actual submodule covered by the stated nonzero-map condition, including nonsemisimple modules. The argument keeps the original Λ with F_T*Λ=L⁵; it does not identify Λ with any other Frobenius-twisted root. No choice concerning the original q₁ quotient, zero-Gram row, endpoint descent or source existence is settled here.

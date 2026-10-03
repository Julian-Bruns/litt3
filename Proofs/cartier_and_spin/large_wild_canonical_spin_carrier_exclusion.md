# Proof: the last two fixed mixed forms violate the first Hermitian/Cartier packet

Version1,3 October2026. [Statement](../../Theorems/cartier_and_spin/large_wild_canonical_spin_carrier_exclusion.md). Independent root whole-scope review PASS: [report](../../Research/audits/LARGE_WILD_WHOLE_CARRIER_AUDIT_2026_10_03.md). Retain the actual inherited spin data and BOTH original finite étale maps on the SAME T. All calculations below are on the actual Y and use necessary global consequences of full SAME-base completed-field normality.

## Reduce the actual large profiles to the two fixed mixed forms

The accepted actual [étale cubic extraction](large_wild_spin_frobenius_and_cubic_reduction.md) lowers profile21000 to profile7000 inside T without changing Y, either endpoint map or the inherited different coefficient. The accepted Weierstrass reduction applies to P. The [distinguished-wild exclusion](large_wild_distinguished_wild_spin_exclusion.md) removes that distinguished position; the [whole moving-origin exclusion](large_wild_moving_origin_spin_exclusion.md) removes the moving Weierstrass P in the remaining ordinary/tame positions.

The [complete fixed-origin inventory](selected_genus_two_cubic_cartier_pencil_inventory.md) has THREE pure-odd forms and TWO mixed forms. The [pure-odd first-tier criterion](large_wild_fixed_pure_odd_spin_exclusion.md) removes all three uniformly. Thus it remains to exclude
\[
y^2=\Phi=w^5+qw^4+4w+4q,
\quad F=A+yB,\quad A=\nu w^3+\nu^{-1},\quad B=w,
\quad \nu^2=q,\quad q\notin\mathbf F_5.
\]
Both choices of ν are handled by the same symbolic parameter. The norm A²−ΦB²=4w⁷+3w³+qw²+q⁻¹ has seven simple zeros; the inventory establishes that these are the actual reduced finite F-zero fiber.

## Normalize the first necessary packet and remove its gauges

Put σ=dw/y, ∂=d/σ and D=∂F. The actual leading/fourth packet supplies c≠0, α≠0, R∈L(41P), and H0∈L(18P), with dH0=F³σ, C(RF³σ)=0, R−αD⁵ divisible by F⁴, and fourth coefficients r4⁵=2cH0D⁵ on the seven finite F-zeros. Scaling this NECESSARY system's R and α by c⁻¹/⁵ sets c=ONE; the original maps and actual source do not change.

The full H0 ambiguity is U⁵, U∈L(3P)=⟨1,w⟩. As in the pure-odd proof, the simultaneous change
\[
H_0\longmapsto H_0+U^5,\qquad
R\longmapsto R-(3F^4UD+F^5\partial U)
\]
stays within the pole bound, preserves the leading/first-three jet conditions, gives exactly the required fourth-jet shift, and changes RF³σ by−d(F⁸U). Hence both gauges can be removed globally.

For this mixed F the gauge-zero primitive is explicit:
\[
H_0=H_e+yH_o,
\quad H_e=4w^9+3qw^8+qw^4+4q^{-1}w^2,
\quad H_o=3\nu w^6+\nu^{-1}w^3+3\nu^{-3}.
\]
Write F³σ=Udw+Vσ, where U=3A²B+ΦB³ and V=A³+3AΦB². Direct differentiation gives He′=U and ΦHo′+Φ′Ho/2=V. These identities are explicitly checked in the new source.

The first three zero coefficients imply
\[
R=\alpha D^5+F^4J,\qquad J=C_{11}(w)+yE_8(w)\in L(22P).
\]
Its fourth values obey J(x)⁵=2H0(x)D(x)⁵ on the finite F-zero fiber. Replacing J by J+tF changes R by tF⁵, which has pole≤35, preserves these values, and preserves Cartier exactness because C(F⁸σ)=F C(F³σ)=0. Therefore the coefficient of w in E8 can be set to ZERO. This removes the constant interpolation freedom, leaving exactly TWENTY-ONE unknown coefficient fifth powers, including α⁵.

## The exact linear system records every relevant condition

Use f^[5](w)=Σfi⁵wi for coefficient Frobenius. The unknowns are the TWELVE coefficients of C11^[5], the E8^[5] coefficients of degrees ZERO,TWO through EIGHT, and α⁵. Expand
\[
F^4=Q_e+yQ_o,
\quad Q_e=A^4+A^2\Phi B^2+\Phi^2B^4,
\quad Q_o=4A^3B+4A\Phi B^3,
\]
and D=De+yDo, where De=ΦB′+Φ′B/2 and Do=A′. The even and odd parts of R are
\[
R_e=\alpha D_e^5+Q_eC_{11}+\Phi Q_oE_8,
\quad R_o=\alpha\Phi^2D_o^5+Q_oC_{11}+Q_eE_8.
\]
R∈L(41P) means degRe≤20 and degRo≤18. This imposes FIVE even high-coefficient equations and FOUR odd ones; the expansions have maximal degrees25 and22 respectively.

For the seven fourth-value equations, work in k[w]/(N), N=A²−Φw². Its constant is q⁻¹, so w is invertible. The actual F-zero points have y=−A/w; set Hf=He−AHo/w and Df=De−ADo/w modulo N. The equality J⁵=2H0D⁵ becomes the SEVEN coefficient equations of
\[
w^5C_{11}^{[5]}(w^5)-A^5E_8^{[5]}(w^5)
\equiv 2w^5H_fD_f^5\pmod N.
\]
These are actual one-sheet values, not values on both hyperelliptic sheets.

Finally R F³σ=(ReU+RoV)dw+(ReV+ΦRoU)σ. Cartier exactness imposes FIVE coefficients in degrees4,9,14,19,24 of the first polynomial, and EIGHT coefficients in degrees4,9,14,19,24,29,34,39 of (ReV+ΦRoU)Φ². Raising these equations to fifth powers makes all TWENTY-NINE equations linear in the TWENTY-ONE unknowns. Denote their coefficient matrix by M and their right side by b.

## A small exact symbolic row identity rules out the selected parameters

The new source [oct03_fixed_mixed_first_cartier_gate.sage](../../scripts/genus_two/oct03_fixed_mixed_first_cartier_gate.sage), with `--symbolic`, constructs precisely this matrix over F5(ν). It checks the primitive identities and norm identity, and that every original matrix-entry denominator is a power of ν. It computes a row transformation by appending an identity matrix and directly checks the resulting equality. The cleared witness z is then directly multiplied against the ORIGINAL augmented matrix, verifying
\[
zM=0,\qquad zb=D(\nu),
\quad D(\nu)=\nu^{131}(\nu^8-1)^{18}(\nu^8+1)^{25}(\nu^8+3).
\]
The exact receipt [first_tier_witness.json](../../../litt3-computation-data/oct03_fixed_mixed_cartier/first_tier_witness.json) contains the original row/unknown labels, all cleared polynomial witness coefficients, and the degree483 right-side polynomial. The source asserts this displayed factorization exactly. These checks passed in the final one-core execution; mathematical CPU time was0.795 seconds. No Gröbner basis, numerical endpoint job or settled certificate was replayed. The matrix ranks were21 and22 before/after adjoining b, but the DIRECT row identity is the certificate used here.

All formulas specialize honestly at ν≠0. A solution Mv=b would imply D(ν)=0. Its nonzero-ν roots require q⁴=ν⁸∈{1,−1,−3}⊂F5. At any fixed origin, the F5-Möbius normalization and q=−(1+t′) preserve F5(q)=F5(t). On MAIN, the selected degree over F25 is greater than FOUR, so [F5(q):F5]>4, whereas q⁴∈F5 would give degree≤4. On BACKUP, q∈F125\F5; q⁴∈F5 would give q¹⁶=1, while q¹²⁴=1, hence q⁴=1 and q∈F5, a contradiction. Thus D(ν) never vanishes on either endpoint, for either choice of ν.

This excludes both fixed mixed forms. Together with the actual cubic reduction and the prior distinguished-wild, moving-origin and fixed pure-odd exclusions, it closes EVERY canonical profile7000/21000 distinguished case. Both original endpoint maps remain on the SAME T throughout; the smaller surviving wild branches and the original common-cover problem are not decided by this theorem.

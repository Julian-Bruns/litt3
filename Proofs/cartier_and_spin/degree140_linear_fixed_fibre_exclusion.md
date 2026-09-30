# Proof: fixed-q affine elimination with degree drops

[Statement](../../Theorems/cartier_and_spin/degree140_linear_fixed_fibre_exclusion.md).
The exact incoming reconstruction and witness format are in
[the retained report](../../../litt3-computation-data/finite_loci_v4_replies_20260926/extracted/linear/linear140/REPORT.md).

Fix w=<101>, q=w^3. Reconstruct the actual residual and put
A(T)=T^140 R(T^-1;wH,w,w mu). Any square residual satisfies the first
three square equations E71,E72,E73 obtained from A(T)^63. Only powers
of H, already invertible, are removed. Their scale degrees are53,54,54.

For each root form the fixed-degree Sylvester resultants P72 and P73
of E71 with E72 and E73. They belong to the respective two-generated
ideals before any specialization or leading-coefficient inversion.
The exact retained identities are
\[
P_{72}=H^{1545}\Theta^{6270}A_{72},\qquad
P_{73}=H^{1405}\Theta^{6120}A_{73},
\]
\[
s A_{72}+t A_{73}=p_r(H)^5.
\]
Here deg A72=75114, deg A73=76004, p_r is squarefree of degree9,
and gcd(p_r,H Theta)=1. Its coefficients and the complete Bezout
multipliers are retained for each root, without an assumed symmetry
between root choices.

In the whole algebra Q_r=K[H]/p_r, the actual E71,E72 scale degrees
drop to52,52. The second retained identity is
\[
U_{71}E_{71}+U_{72}E_{72}=1\quad\text{in }Q_r[\mu].
\]
Thus every candidate, including extension-valued H, fails the affine
equations. More strongly, in the localized quotient by all three E's,
the first identity gives p_r^5=0. Lifting the second gives1=-p_r J.
Raising to the fifth power gives1=0. This proves the unit-ideal claim
without a reducedness assumption. In particular, the common factor
of the resultants is not discarded as an alleged leading-coefficient
boundary; the quotient identity checks that boundary explicitly.

The bivariate equations and resultants are reconstructed by exact
interpolation with proved bounds. The residual H-degree is at most72;
the square-equation transforms have coefficientwise support bounds;
row/column potentials bound the resultant degrees by95469 and95769.
The incoming all-ten replay reconstructed120 files byte-for-byte,
and a separate absolute-field GMP implementation replayed both large
and small identities. The integration replay independently regenerated
the first root's12 files and all its identities with exact agreement.
No full ten-root replay is claimed as newly run during integration.

The other defining square equations are used only as necessary
conditions in the original problem. An empty subsystem suffices for
this negative result; it would not certify a positive square witness.
This one fibre does not decide the varying-q schemes, even given their
geometric finiteness.

See [the focused integration audit](../../Research/audits/FINITE_LOCI_V4_REPLIES_2026_09_26.md).

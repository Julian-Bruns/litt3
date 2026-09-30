# Proof: a small complete determinant calculation

[Statement](../../Theorems/cartier_and_spin/quintic_common_phase_exclusion.md).
Opposite phase translation at the two ends, with its corresponding
invertible changes of moments, preserves the determinant. Its proof
is substitution in the displayed equation and is independent of the
number of labels. Thus fix Q's single phase to0, leaving all29 possible
single phases at H. There are C(8,5)=56 five-element multisets of four
root types. Four are pure, already excluded for actual comparisons;
the remaining52 possibilities at each end give
\[
52^2\cdot29=78,416
\]
pairs, including equal labels, distinct labels and arbitrary repeated
root types. No quotient by type rotations or endpoint interchange is
needed for this small enumeration.

Set A=E_Q/[22], B=C_Q/[22], C=C_H/[22], D=E_H/[22]. The determinant
expands as
\[
AD-BC-Ax-D\bar x+B\bar y+Cy+N(x)-N(y),
\]
where N is the norm from K0 to S=F_(5^7). In the established basis
F_(5^56)=S(beta,theta), beta^2=beta+3, theta^4=[20], write
x=x0+beta*x1,y=y0+beta*y1. All seven nonscalar S-coordinates give
an affine-linear system in these four S-unknowns. Its remaining scalar
coordinate is one quadratic equation.

The [complete enumeration](../../scripts/arithmetic/quintic_common_phase.cpp)
finds precisely32 consistent affine systems, all of rank4. Every one
of their unique solutions has nonzero scalar quadratic residual. No
consistent lower-rank family remains. Therefore there is no determinant
solution over the specified coefficient field. This is not a scan over
candidate moments: Gaussian elimination solves each full affine system.

All32 candidates and residuals are retained in
[quintic_common_phase.txt](../../../litt3-computation-data/two_sheet_quintic_replies_20260927/quintic_common_phase.txt).
The [independent verifier](../../scripts/arithmetic/verify_quintic_common_phase.py)
reconstructs every candidate in the different presentation
K0=F25[zeta]/(4,22,7,20,21,7,24,1), F=K0[alpha]/(5,2,6,7,1).
It uses direct polynomial arithmetic, sends the S-generator to
zeta+zeta^-1, reconstructs the root conjugates and phase powers, and
checks the ORIGINAL determinant against each recorded nonzero residual.
All32 checks passed. The affine rejection and coverage are justified
by the complete C++ enumeration, not by these surviving-case checks alone.

The actual trace equations force this determinant to vanish. Together
with [one-endpoint exclusion](pole_fifteen_one_endpoint_exclusion.md),
this closes every actual pair with a single phase at each end. The
remaining mixed-phase pairs, and the original unmarked problems, are open.

# Integral charts for the original rank125 canonical reference

Version1,2026-09-14. This constructs the reference charts and their maps;
it does not evaluate a moving Hodge obstruction.

Use the cubic ordinary base, product coefficient lift, theta, flat line
and canonical source overlap of
[the base reference theorem](../cubic_ordinary_base_reference.md).
Write R_m=(Z/5^m)[T]/(T^3+T+1), 2<=m<=5, and retain the original
normalized etale double

    kappa^2=u(u-3), y^2=(u-1)(u-2)(u-T), v=kappa*y.

The symbol kappa is distinct from the base flat-line symbol w^2=u-T.
The original scaled AS characters and constants are

    chi1=[31]y/u, chi2=[24]v/u+[118]v/u^2,
    chi3=[112]v/u+[43]v/u^2,        c=(3,1,2).

Let FU_i be the nonnegative-u-power part of c_i*chi_i^5 over the residue
field. In increasing u degree their polynomial coefficients are

| i | Factor | Polynomial coefficient field codes |
| --- | --- | --- |
| 1 | y | 2,35 |
| 2 | v | 4,44,87,26,16,48 |
| 3 | v | 106,7,88,123,101,17 |

Lift these coefficients by the stated polynomial section, and put
a_i=Teich(c_i^-1). At either infinity branch, set

    FO_i=FU_i-c_i*chi_i^5+chi_i,
    c_i*RO_i^5-RO_i=FO_i,       RO_i in z*k0[[z]].

The latter equation has a unique whole solution. The formal algebra

    B_m=R_m[S1,S2,S3]/(S_i^5-a_i*S_i)

is finite etale of rank125. In B_m((z)), the uniquely specified Hensel
roots

    W_U,i^5-a_i*W_U,i=a_i*FU_i,
    W_U,i mod5=S_i+chi_i+RO_i

give the images of the ACTUAL affine etale coordinates. Together with
the canonical base source overlap they present the lift of the ORIGINAL
connected rank125 cover. The residue infinity coordinate is
W_O,i=S_i+RO_i, so W_U,i-W_O,i=chi_i and the original marking is retained.
The constant algebra is a LOCAL formal presentation; no global splitting
of this connected cover or trivialization of the periodicity line is
asserted.

The lifted derivation fixes S_i. Formal Witt Frobenius sends
S_i to a_i*S_i, and the actual regular affine Frobenius is obtained by
the finite ordinary Laurent Taylor substitution described in the proof.
The canonical source overlap fixes S_i and acts on the whole root
coefficients by its actual exponential. These are integral maps through
source modulus3125, including their carries.

There is also an exact multiplication simplification. For
R'_m=R_m[zeta]/(zeta^4-Teich(2)),

    B_m is isomorphic to R_m^5 times (R'_m)^30.

This is a decomposition of the constant etale algebra. It permits
componentwise multiplication instead of repeated AS polynomial products.
The full Witt Frobenius on R'_m has zeta->Teich(2)*zeta.

The execution verifies all three affine equations, lifted derivatives,
affine Frobenius maps, Frobenius residues and canonical source transports
modulo3125. A second execution changes the Frobenius gauge, infinity
branch and Laurent precision; the original character polynomials and
the predicted root parities agree. The whole roots are defined by their
Hensel equations, not by the finite windows saved in the certificate.

The full base filtered tuple therefore has explicit charts on this
original cover. The moving fourth-reference coefficients are evaluated
in a [separate theorem](rank125_actual_fourth_reference.md). The combined
second repairs and affine fifth value are evaluated in the later
[whole fifth theorem](rank125_fixed_line_fifth.md). This integral-chart
theorem alone asserts no marked fifth existence or exclusion.
No unmarked common-cover conclusion follows.

[Proof, source and certificate](../../../Proofs/deformations/elementary_covers/rank125_integral_reference.md).

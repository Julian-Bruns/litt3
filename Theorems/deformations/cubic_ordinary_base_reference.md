# An explicit canonical ordinary base reference through W5

Version1,2026-09-14. Exact computation with a bounded independent audit;
the certificate and its validation scope are specified in the proof.

Let k0=F5[t]/(t^3+t+1), k=bar(F5), and

    Y: v^2=P(u)(u-t),   P=u(u-1)(u-2)(u-3).

Take theta=O_Y(infinity), eta=du/v, D=eta^-1 and z=u^2/v at infinity.
Retain the nontrivial flat two-torsion line L=O_Y(W_t-infinity).
On its etale double write w^2=u-t; w is not a function on Y. The active
oper is specified by the horizontal column

    a=(t+1)v/w,   b=(t+1)w*P'/2,
    Da=b,        Db=R*a,
    R=P'/4+(u-t)P''/2,       a^2=A=(t+1)^2*P.

Use the PRODUCT coefficient lift over
R5=(Z/3125)[T]/(T^3+T+1), the induced formal coordinate z, and the single
exponential source-overlap convention below. For an integer
m=m0+5m1+25m2, 0<=mi<5, [m] denotes m0+m1*t+m2*t^2 in k0.
Its chosen integral lift is m0+m1*T+m2*T^2, rather than an unspecified
Teichmuller representative. All displayed source coefficients use these
chosen lifts.

The oper is indigenous-ordinary. In the complete normal basis
(z^-3,z^-1,z)D its primary is Psi(x)=M*x^[5], where

    M=[[115,7,36],[22,114,34],[5,81,13]],  det(M)=[15]=3t !=0.

Matrix entries here and in the following table are field codes. The
canonical marked curve through W5 has source overlap

    tau=exp((5*xi-25*n3-125*n4-625*n5)*D) modulo3125,

with coefficients in the basis (z^-3,z^-1,z):

| Cochain | Coefficients |
| --- | --- |
| xi | [118], [113], [119] |
| n3 | [31], [119], [44] |
| n4 | [2], [0], [123] |
| n5 | [77], [86], [64] |

The reconstruction also specifies the actual compatible filtered flat
objects and graded identifications through W4. It retains L and its
flat connection, the preceding oper potential modulo25, and the whole
regular affine and formal Hodge repairs. The formal repairs are defined
by quotient expressions in the proof and executable source; saved finite
coefficient windows do not replace their whole tails.

In the normalized affine frame used by the reconstruction, the WHOLE
preceding oper potential modulo25 is the polynomial

    P2_U=(11+19T)+(14+8T)u+(5+4T+15T^2)u^2
         +(7+10T+5T^2)u^3+(10+20T)u^4 modulo25.

These are ordinary integral coefficients in the displayed cubic ring,
not field codes. Both tested Frobenius gauges give this same polynomial.

Changing the regular affine Frobenius lift by the explicit tested gauge,
and increasing Laurent precision from3200 to3600, gives the same source
coefficients. These coordinate values depend on the stated integral
atlas and coefficient convention, while the marked canonical curve does
not depend on the auxiliary local Frobenius choices.

For any specified finite etale cover Z->Y, this reference and its full
tuple pull back to the unique lift of that ORIGINAL cover. This supplies
the canonical reference underlying the rank125 laboratory. The later
[integral charts](elementary_covers/rank125_integral_reference.md)
retain its original covering coordinates, the
[actual fourth comparison](elementary_covers/rank125_actual_fourth_reference.md)
evaluates alpha,beta,omega, and the
[whole fifth comparison](elementary_covers/rank125_fixed_line_fifth.md)
evaluates the affine fifth obstruction using the combined second
repairs. Those calculations are additional inputs, not consequences
of the base reference alone. No unmarked common-cover verdict follows.

[Proof, full reconstruction and certificate](../../Proofs/deformations/cubic_ordinary_base_reference.md).

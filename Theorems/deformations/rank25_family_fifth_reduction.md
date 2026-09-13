# The actual rank25 fifth comparison, support and calibrated trace

Version2,2026-09-13. Use the original marked genus26 tuple, field encoding,
full fourth polynomial E and reduced loci S_x,S_y of
[rank25_fourth_locus](rank25_fourth_locus.md). The comparison and finite
calibration formulas below concern every fourth choice of that tuple.
The [whole marked height theorem](rank25_whole_fifth_exclusion.md)
uses them to exclude W5.

For any actual compatible fourth reference above x∈S_x, its fifth
obstruction C5(x) varies over all fourth choices by

    E5(x,beta)=C5(x)+J(x^[5])*beta^[5], J=dE/dy.          (1)

Changing the fourth reference adds J*gamma^[5]; changing a final smooth
fifth digit adds -M*chi^[5] before projection by Lambda. Thus the class
in coker J is intrinsic. Formula(1) is arithmetic polarization of the
actual Witt comparison, with the ordinary response killed by Lambda*N=0.
It is not differentiation of x↦x^[5]. The critical-potential pairing
identifies its quotient bundle with F^*Omega^1_S_y.

On s=y6!=0 put

    Arow=J[4,{7,8}]-2*J[3,{7,8}], Btop=J[{5,6},{7,8}],
    Ktop=((2013,1041),(3243,2231)), det(Ktop)=1012,
    J[{7,8},{7,8}]=s*Ktop.

Four coordinates giving the COMPLETE quotient coker(J) are

    c0,
    c4-2*c3-Arow*(s*Ktop)^-1*(c7,c8),
    (c5,c6)-Btop*(s*Ktop)^-1*(c7,c8).                   (2)

On each full boundary family s=0, Btop is invertible and the criterion is

    c0=c7=c8=0,
    c4-2*c3-Arow*Btop^-1*(c5,c6)=0.                    (3)

A fifth lift exists exactly when(2), or(3) on the boundary, vanishes at
C5. The first row of J is zero on S_y, so c0 is independent of fourth
choice there.

The fourth curve digit satisfies a separate identity. With
lambda0=Lambda[0], whose only nonzero entries are the last three
(4420,1200,2000), every compatible digit has lambda0*zeta=0. A fixed
adjoint row ell satisfies

    ell*M=lambda0^[5],
    ell*R4(x)=2031*E1(y)+1230*E2(y)

on y5=0224*y6,y7=y8=0. This trace identity does not set the other eight
direct fourth-digit projections to zero.

In the coherent regular comparison of the proof, the full fifth CLASS
has parameter support

    C3(Y)+sum_i X_i*L_i(Y)+P2(X), Y=Phi(X),
    deg(C3)<=3, deg(L_i)<=1, deg(P2)<=2.                (4)

Here i ranges over the seven moving directions0,...,6.
The ordinary mixed and direct-fourth terms are explicitly computed in
the same gauge and origin. Only the trace simplifies to a cubic fifth
power; applying that smaller support to the full class would be wrong.

Put U=x0, A=x3-3003, B=x4-0314, q=x6. On the entire reduced fourth locus,

    c0=Theta(U,A,B,q)^5,
    Theta=3440+q^2*(2110*U+0343+1313*A+2324*B)
      +2142*A^2+2010*A*B+3022*B^2
      +0023*A^3+3122*A^2*B+4224*A*B^2+2132*B^3.        (5)

In the order of the four center points in rank25_fourth_locus, the
boundary traces are2010,4140,1330,3120, all nonzero and independent of
all three free boundary parameters. On q!=0, reduced trace zero is the
smooth graph

    U=-Theta(0,A,B,q)/(2110*q^2), (A,B,q)∈A^2×Gm.       (6)

The fixed W4 witness x* of rank25_fourth_locus has, in its ORIGINAL
fourth reference, the full fifth constant

    c*=(2010,1132,2401,0000,0000,0012,1403,0000,0000).

The reconstructed reference agrees with that original one (gamma=0).
At x*, J has image {v:v0=v7=v8=0,v4=2v3}; hence the exact affine image
of all fifth obstructions there is

    {v:v0=2010,v7=v8=0,v4=2v3}.                         (7)

The proof also retains the independently established surface trace,
the exact one-parameter scalar and BOTH actual CRT residual functions
on its30-point zero scheme. These calibration values precede(5) and
the whole-locus reconstruction; their proof does not use the final
height verdict.

[Proof, formulas and evidence](../../Solutions/deformations/rank25_family_fifth_reduction.md).

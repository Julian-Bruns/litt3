# Two actual high-kernel fourth-lift exclusions, and the F4 slice

Version2,2026-09-14. This is a fixed cubic-parameter, marked W4 theorem.
It does not decide the whole rank125 fourth locus or an unmarked
common-cover problem.

Use the actual maximal C5^3 cover and canonical ordinary-Y reference
specified in the
[quadratic-channel proof](../../../Proofs/deformations/elementary_covers/fourth_hodge_quadratic_channel.md),
at k0=F5[t]/(t3+t+1), k=algebraic closure. The scalar coordinates are
AFTER coefficient Frobenius, in the ORIGINAL scaled logarithmic deck
variables s_i=zeta^(j_i)log(sigma_i), j=(3,0,1), zeta4=2. Put
R=k[s1,s2,s3]/(s_i5), J=(s1,s2,s3), K=Ann(f), with the actual Schur f.
Retain the original cover, source marking, previous filtered object,
projective grading and actual square-trivial flat periodicity line.
The convention is X3(H)=X3^0+n(H), rho(S+xi)=rho(S)-Psi(xi).

Field codes [m] mean m0+m1*t+m2*t2, m=m0+5m1+25m2. Define H#=H5+H7 by

    H5=[12]s1^3*s2*s3+[29]s1*s3^4+[16]s1*s2*s3^3
       +[58]s1*s2^2*s3^2+[15]s1*s2^3*s3
       +[73]s1^3*s3^2+[93]s1^3*s2^2+[9]s1*s2^4;
    H7=[90]s1*s2^2*s3^4+[11]s1*s2^3*s3^3
       +[88]s1*s2^4*s3^2+[43]s1^3*s3^4+[107]s1^3*s2*s3^3.

Each affine family K intersect(plus-or-minus H#+J8) has dimension25.
For E in R let E_abc denote its s1^a*s2^b*s3^c coefficient, and put

    Lambda(E)=[101]E102+[42]E104+[71]E113+[108]E122
              +[64]E131+[22]E140+[56]E302+[54]E311+E320.

Then Lambda annihilates (f) and J6. The COMPLETE fourth obstruction is

    Lambda(E4(H))=1+2t2 !=0,   H= H# modJ8;
    Lambda(E4(H))=4+2t2 !=0,   H=-H# modJ8.

Consequently neither family has ANY compatible fourth Witt lift,
allowing all geometric completion parameters and all final source
digits. The returned value1+3t2 is a normalization error, not the
value in these coordinates. The earlier positive-jet low-quotient
cancellation also had a carry-sign error: it holds for the reflected
jet -H#, which is nevertheless excluded by this theorem.

There is a separate positive result on K8=K intersect J8, dimension25.
Let C denote the first integral product carry in the odd logarithms,
with s_i5/5=-c_i*s_i, (c1,c2,c3)=(3,1,2). Then

    {H in K8 : X3(H) admits a compatible W4 lift}
      = ker(H -> [C(q2*H8)+C(q2*H9)] in R/(f)),

where Hd is the homogeneous degree-d part and q2=f2. This is a
15-dimensional k-linear scalar subspace, not just a finite-field
point count. The degree-six carry has rank6; once it vanishes the
ACTUAL quadratic channel vanishes, and the degree-seven carry has
four further independent coordinates. Higher H10,H11,H12 are free.
The result is an equality on geometric points; no scheme-theoretic
reducedness of the original Frobenius-parameter locus is asserted.

In fact this exhausts EVERY fourth-compatible point with H5=0:

    Z4 intersect(K intersect J6) = Z4 intersect(K intersect J8).

The genuine low comparison first forces H6=0, and then H7=0.
The first implication uses explicit polynomial radical identities;
the second uses polynomial ideal identities for all eight H7
coordinates. They are valid over every geometric coefficient field,
not only at k0-points. All remaining possible fourth lifts outside
the15-dimensional locus therefore have nonzero degree-five part.

Its four free coefficients can be taken as
a0=(H5)_014, a1=(H5)_104, a2=(H5)_113, a3=(H5)_203;
q2H5=0 determines all others. A necessary degree-one obstruction is

    [78]a0²+[47]a1²+[96]a1*a2+[56]a2²=0.

Equivalently the leading part lies in one of the two geometric planes

    a1+[34]a2 = plus-or-minus zeta²*t*a0.

Their intersection a0=0 must be retained. The two planes are not
defined separately over k0. This is a NECESSARY equation only. The
subsequent [fourth-escape theorem](rank125_fourth_escape.md) constructs
a nonzero leading point in their intersection and an eight-dimensional
affine fourth-compatible fibre. Thus S15 is a proper subset of Z4;
this does not contradict either particular excluded family above.
Classification of the full higher completion locus remains open.

[Proof, sign audit and exact evidence](../../../Proofs/deformations/elementary_covers/rank125_fourth_exclusion.md).

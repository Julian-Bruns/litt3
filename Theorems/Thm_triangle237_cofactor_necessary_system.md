# Six pole coefficients determine the degree84 numerator factor

Version1,2026-09-10. Proved necessary reduction; two focused geometric
audits PASS. This is not an emptiness theorem for the degree84 row.

Let C_alpha be the specified backup. For every actual remaining tame
degree84 map of complete profile(2,3,7), its hyperelliptic quotient is

    q=s F A^2/C^7,       s F A^2-B^3=C^7,
    F=u(u-1)(u-2)(u-3)(u-alpha),
    A monic degree18, C monic degree6, B degree14 with leading -1,
    s=3b13+2c5 !=0.

The letters A,B,C here denote polynomials; C_alpha denotes the curve.
All three polynomial divisors are squarefree and disjoint on an actual
cover. Its following necessary equations hold:

    (F'A+2FA')C-2FAC'+B^2=0,
    3(BC)'+sA=0,
    F(AC)''+4F'(AC)'+(3F''-P)AC=0.

Here P=2u^3+beta*u^2+b1*u+b0 is one of the five known dormant
potentials, with b1=beta^2+3F4*beta+3F3 and
b0=-F2+(F4+2beta)*b1. The five beta form one Frob125 orbit, so one
representative over F_(5^15) suffices for a geometric unit-ideal test.

Choose a basis H0,H1 of the degree-at-most-four polynomial solutions
of the displayed horizontal equation. They have gcd1 and Wronskian a
nonzero constant times F. Put T=u^5. Form the5x6matrix, over k[T],
with columns

    C, C*u, C*u^2, C*u^3, -H0, -H1,

written in the basis1,u,...,u^4 modulo u^5-T. Let v_j be its signed
maximal minors, indexed0,...,5. Define

    A_raw(u)=sum_(j=0)^3 u^j v_j(u^5),    L=[u^18]A_raw.

For EVERY actual cover, L!=0 and A=A_raw/L. In particular there is no
additional actual boundary chart where this cofactor normalization
fails. The coefficients of A_raw have degree at most3 in the six C
coefficients; L has degree2. The exact symbolic identities and degree
bounds replay in about0.22s.

One may therefore substitute A_raw/L, clear denominators, and keep the
guard L*s!=0 to obtain a necessary polynomial system without any of
the eighteen unknown coefficients of A. The full passport must remain
enforced. A solution of this necessary system is not asserted to be a
cover; omitted squarefree/disjointness conditions only enlarge it.

[Proof](../Solutions/Sol_triangle237_cofactor_necessary_system.md) ·
[dictionary audit](../Research/audits/DEGREE84_DIFFERENTIAL_SYSTEM_AUDIT_2026_09_10.md) ·
[cofactor audit](../Research/audits/DEGREE84_COFACTOR_REDUCTION_AUDIT_2026_09_10.md).

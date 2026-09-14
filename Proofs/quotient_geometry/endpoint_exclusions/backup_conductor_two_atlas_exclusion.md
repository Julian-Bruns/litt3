# Conductor two: a twisted cubic section and its primitive

Version2,2026-09-14.
[Statement](../../../Theorems/quotient_geometry/endpoint_exclusions/backup_conductor_two_atlas_exclusion.md).

Work over an algebraically closed field of characteristic5. Write
C:v²=F(u), with F a monic squarefree quintic, O=infinity, eta=du/v and
D=v*d/du. Normalize the wild and tame coarse values to infinity and0.

## 1. The primitive and its common local scalar

First take coarse degree120, with wild(e,delta)=(20,27) and tame index3.
The cubic tensor (df)^3/f² has the reduced six-point wild divisor D_w.
Its coefficient S relative to eta³ satisfies div(S)=D_w-6O. There is
a rational primitive B_* with

    f=B_*³/S^20,       DB_*=S^7,       B_* in L(40O).       (1)

This requires no root extraction: s0=(Df)^3/f² and
b0=(Df)^20/f^13 satisfy b0³=f*s0^20 and Db0=2s0^7. Set
S=l*s0, B_*=(l^7/2)b0 and rescale f by a constant.

The wild inertia has a tame quotient of order4 and lower break2:
27=19+4*2. Over its tame fixed field, v0^-4=f, an Artin--Schreier
equation has reduced form y^5-y=a*v0^-2+b*v0^-1. The order4 action
has different eigencharacters on the two terms, so b=0. Thus

    y^5-y=a*sqrt(f),       a!=0.

The invariant a^4 is the same at every wild point: an actual orbifold
atlas has the same Galois completion over the fixed coarse field there.
Put lambda=3/a^4.

At a finite wild point use z=S, eta=H(z)dz. From (1),

    B_*=B0+B5*z^5+2H0*z^8+4H1*z^9+O(z^10).

If b²=B0, the principal part of sqrt(f) is

    b³*z^-10+4b*B5*z^-5+3b*H0*z^-2+b*H1*z^-1.

Vanishing of the two reduced Artin--Schreier coefficients gives

    a^4=3/(B0*H0^5),       B5=3B0*(H1/H0)^5,
    B0=lambda*(DS)^5,      B5=2lambda*(D²S/DS)^5.

Consequently the function

    R=(B_*-lambda*(DS)^5)/S^5

is regular away from O: at each finite zero of S the numerator vanishes,
and its derivative has order at least7, so its next possible term has
degree5. The pole bounds at O are S:6 or5, DS:at most9 or8, B_*:40.
They give

    R in L(15O),       DR=S²,
    R*(DS)^5=lambda*(D²S)^5 at finite zeros of S.          (2)

The last equality is the constant term of R in the preceding expansion.
We may omit the analogous infinity condition when O is wild.

For degree240, div(f)=6D0-40D_w is even. Adjoining z=sqrt(f) gives an
actual etale double pi:T->C. In the split case either component has
degree120 and the data above. In the connected case z has local data
(20,27;3) and degree240 on T: the tame quadratic base change reduces
the different from47 to27. The completions still agree over their
fixed coarse field. Applying (1) to z gives anti-invariant S,B_*;
R in (2) is invariant and descends to C. Replacing z by-z multiplies
sqrt(z) by a fourth root of unity, so lambda is unchanged. The same
pole bounds hold at both points above O. Thus s=S*eta³ belongs to
omega_C³ tensor the two-torsion line of pi and has reduced zero divisor.

## 2. One system for all two-torsion lines

Every class in J(C)[2] is represented uniquely by E=1 or a product of
one or two of the five finite branch factors. Set J=F/E and m=deg E.
For a nontrivial class the double has w1²=E, w2²=J, v=w1*w2, with both
w's anti-invariant. For E=1 simply take w1=1,w2=v on C. In either case

    S=w1*A(u)+w2*B(u),

where deg A<=3, deg B<=0 for m=0, and deg A<=2, deg B<=1 for m=1,2.
These five independent sections have the required finite regularity
and pole bound6; Riemann--Roch shows that they form the full space.

Write R=P+vQ, deg P<=7, deg Q<=5. The equation DR=S² becomes

    P'=2AB,       FQ'+(F'/2)Q=EA²+JB².                   (3)

Integrating 2AB leaves only r0+r1*u^5 free in P. The second equation
is a constant9-by6 linear system for Q, leaving at most three quadratic
conditions on A,B. Its matrix has rank6: a kernel vector would make
vQ a fifth power with pole<=15 at O, hence the fifth power of an
element of L(3O)=<1,u>, incompatible with its odd hyperelliptic parity.

To encode the second equation in (2), put

    C1=J B'+(J'/2)B,       G1=E A'+(E'/2)A,
    C2=J G1'+(J'/2)G1,     G2=E C1'+(E'/2)C1,
    L1=P E² C1^5+J³ Q G1^5-lambda E² C2^5,
    L2=P J² G1^5+E³ Q C1^5-lambda J² G2^5,
    N=EA²-JB².

Since DS=w1*C1+w2*G1 and D²S=w1*C2+w2*G2, the local residual is
w1*L1+w2*L2. Dividing it by S gives

    [EA L1-JB L2+v*(A L2-B L1)]/N.

This quotient is regular on the affine curve (or on the affine double,
where it is invariant): the residual vanishes at all the simple zeros
of S. The affine ring is free over k[u] with basis1,v. Thus the full
necessary conditions are

    EA L1-JB L2 =0 mod N,       A L2-B L1 =0 mod N.       (4)

Both divisibilities hold with full multiplicities, even for repeated
roots of N, common roots of A,B or Weierstrass points. No saturation
removes these cases. In particular E=1,B=0 gives N=A² and (4) reduces
to A dividing both L1 and L2.

## 3. Two charts per line

At O the cubic differential can have order0 or1, since its zero
divisor is reduced. Hence S has pole6 or5. Scalar normalization gives
exactly the following charts; a_i,b_i denote coefficients of A,B.

| m | Pole6 chart | Pole5 chart |
|---|---|---|
| 0 | a3=1 | a3=0, b0=1 |
| 1 | b1=1 | b1=0, a2=1 |
| 2 | a2=1 | a2=0, b1=1 |

If both relevant coefficients vanish, the differential has a multiple
zero at O and is inadmissible. In each chart N has degree6 or5 and
leading coefficient1 or-1, so division introduces no parameter inverses.

In a pole6 chart the coefficient of pole45 in
B_*=S^5 R+lambda*(DS)^5 is the fifth power of the normalized leading
coefficient times Q5+3lambda. The monic quintic normalization gives
this same expression at both points of a nontrivial double. Since
B_* has pole<=40, impose lambda=3Q5. In a pole5 chart leave lambda free.
Omitting its additional local condition only enlarges the necessary ideal.

## 4. The fixed backup

Now use F=u(u-1)(u-2)(u-3)(u-alpha), alpha³+alpha+1=0. The
[verifier](../../../scripts/genus_two/verify_backup_conductor_two.sage)
forms (3)--(4) over F125 in all32 charts. It uses generic finite-field
matrices and checks the inverse again after coefficient-ring extension.

    sage scripts/genus_two/verify_backup_conductor_two.sage

All16 pole6 ideals and15 pole5 ideals have Groebner basis[1].
The remaining chart is E=u-alpha, pole5; its ideal contains lambda.
Every chart therefore contradicts lambda!=0 over the algebraic closure.
The default run verifies all charts and writes no files; --twist 0
selects the trivial line, and --chart generic or infinity selects a chart.

The original audits check the
[primitive and local coefficients](../../../Research/audits/BACKUP_WILD120_DICTIONARY_AUDIT_2026_09_10.md)
and the
[double-cover transfer and norm divisibility](../../../Research/audits/BACKUP_WILD240_TWIST_AUDIT_2026_09_10.md).
The uniform trivial-twist charts received a bounded medium audit on
2026-09-14; the consolidated verifier passed all32 exact ideal checks.

# Audit: degree120 wild atlas dictionary

- Verdict: PASS for the geometric dictionary and its three necessary
  polynomial systems; all three unit ideals independently replayed.
- Auditor: `/root/audit_backup_wild120_dictionary`.
- Date: 2026-09-10.
- Blocking objections: none.
- Scope: the author candidate in
  [canonical normal-form proof](../../Solutions/Sol_backup_wild120_atlas_exclusion.md)
  and [verify_backup_wild120.sage](../../scripts/verify_backup_wild120.sage).
  This audits the exclusion of an ACTUAL degree120 atlas from the stated
  backup curve, with exactly the wild(20,27) and tame3 branch fibers.
  It does not audit or assert the proposed degree240 transfer, nor exclude
  arbitrary maps having only numerically similar ramification.

The actual fixed-base Galois extension at every point of a wild fiber is
an established input from `completed_local_orbifold_rigidity`, Section1
of its canonical proof. I checked that statement and dependency record,
then the relevant proof section. No simultaneous Galois closure of the
original two endpoint maps is used here.

## Global cubic primitive

Writing the reduced fibers as D0 and Dw gives

    div(f)=3D0-20Dw,
    div(df)=2D0-13Dw,
    div((df)^3/f^2)=Dw.

At a wild point the differential order is delta-2e=27-40=-13;
at a tame zero it is 3-1=2. Since div(eta)=2O, the coefficient S
lies in L(6O) and has div(S)=Dw-6O. Thus S=A+c*v, deg A<=3.

The explicit formula b0=(Df)^20/f^13 satisfies

    b0^3=f*s0^20,  Db0=2*s0^7,  s0=(Df)^3/f^2,
    div(b0)=D0-40O.

The derivative constant is -13=2 in characteristic5; the derivative
of the twentieth power is zero. For S=l*s0, B=l^7*b0/2 gives DB=S^7
and B^3/S^20=(l/8)*f. Scaling the coarse function is allowed and keeps
both branch values fixed. This constructs B globally and uses no
three-torsion trivialization or global cube root. If O belongs to D0,
B has pole39 rather than40, which only strengthens the stated bound.

## Fixed-base local invariant and signs

For inertia of order20, the wild group has order5. The different27
forces its lower break to be2. Over the unique tame degree4 subfield
T=k((v0)), with v0^-4=f, the reduced Artin--Schreier class is
a*v0^-2+b*v0^-1, with a nonzero. The order4 tame action preserves the
F5-line of this class. Its leading term has eigenvalue -1, whereas
the degree-one term has eigenvalue i^-1, so b=0. A fixed-base
isomorphism induces v0 -> zeta*v0, zeta in mu4=F5*, and rescales the
Artin--Schreier line by F5*. Consequently a^4 is a well-defined
invariant of the completed extension. The actual atlas makes it common
to all six points. Local square-root signs do not change a^4.

At a finite wild point z=S is a uniformizer and eta=H(z)dz with H0
nonzero. From dB/dz=H*z^7, the displayed B and square-root jets in
the candidate are correct. Independently, if b^2=B0, the two reduced
Artin--Schreier coefficients vanish precisely when

    3*a*b*H0+(a*b^3)^(1/5)=0,
    a*b*H1+(4*a*b*B5)^(1/5)=0.

Taking fifth powers gives a^4=3/(B0*H0^5) and
B5=3*B0*(H1/H0)^5, with the signs as stated. For lambda=3/a^4,
H1/H0=-D^2S/(DS)^2 gives B0=lambda*(DS)^5 and
B5=2*lambda*(D^2S/DS)^5.

To check the final constant of R explicitly, set h=DS. Then
dh/dz=D^2S/DS, so the z^5 coefficient of h^5 is
(D^2S/DS)^5. Subtracting lambda*h^5 from B changes its z^5
coefficient from 2*lambda*(D^2S/DS)^5 to
lambda*(D^2S/DS)^5. This proves

    R*(DS)^5=lambda*(D^2S)^5

on the finite wild divisor, including the final factor and sign.

## Pole bound and complete normalization charts

The numerator of R vanishes at each finite wild point; its derivative
has order7. Hence its terms of degrees1 through4 vanish, and division
by S^5 is regular. There are no other finite poles. At O, the bounds
in the candidate imply R in L(15O). In the O-wild chart the actual
bound for DS is at most7, even stronger than the safe bound8 used there.
Also DR=S^2 because derivatives of fifth powers vanish.

Thus R=P+vQ with deg P<=7, deg Q<=5, and direct differentiation gives
exactly the two equations(7) and the stated form of P. The possible
pole45 term of B=S^5*R+lambda*(DS)^5 has coefficient
a3^5*(Q5+3*lambda), since DS has leading term 3*a3*v*u^2.
Therefore lambda=3*Q5 whenever a3 is nonzero. No missing higher-pole
conditions are silently assumed: omitting them enlarges the necessary
systems.

The charts are exhaustive. For c nonzero, normalize c=1 and distinguish
a3 nonzero from a3=0. In the latter chart the cubic differential has a
simple zero at O. If c=0, a polynomial A of degree at most2 would give
a zero of order at least2 at O, contradicting the reduced wild divisor;
thus normalize a3=1. Scaling S by t scales B by t^7, R by t^2 and
lambda by t^2, consistently with every imposed equation.

## Exact divisor and scheme membership

For c=1 the finite divisor S=0 has coordinate algebra
k[u]/(A^2-F), obtained by substituting v=-A. In a valid atlas this
algebra is reduced, so the identity at every finite wild point is
equivalent to the polynomial congruence modulo its monic normalization
N. At a finite Weierstrass point with A=F=0, N' is a nonzero scalar
multiple of F'; the point is retained and is simple. Eta remains
nonvanishing there. No division by v, A, or a branch coordinate is used.
The formulas for DS and D^2S after v=-A are correct.

For c=0, the full divisor has coordinate algebra
k[u,v]/(A,v^2-F), free with basis1,v over k[u]/(A). For a valid atlas
A is squarefree and coprime to F; otherwise the divisor would not be
reduced. Multiplying R by (DS)^5 gives even part Q*F^3*(A')^5 and
odd part v*P*F^2*(A')^5, exactly the two implemented congruences.
Both sheets are therefore retained. Omitting discriminant and
branch-intersection guards cannot exclude a valid atlas from these
necessary systems. No infinity identity is needed in the a3=0 chart
because its five finite equations already have empty solution scheme.

## Implementation and independent replay

The script uses the actual squarefree F=u(u-1)(u-2)(u-3)(u-alpha),
alpha^3+alpha+1=0 over F125. The Q matrix has rank6 and pivot rows
[0,1,3,4,5,6]. The implementation explicitly requests generic matrices
and checks its inverse after extension to the polynomial ring. Every
pivot reconstruction error was zero in each replay. The remaining
three equations impose exactly the residual coefficients of(7).
Monic reduction in the quotient by this base ideal and lifting
coefficients back give the intended scheme equations.

Independent local replays without `--certificate` returned:

| Chart | Local equations | Final basis | Internal seconds |
| --- | ---: | --- | ---: |
| generic | 6 | [1] | 4.631 |
| infinity | 5 | [1] | 0.161 |
| even | 6 | [1] | 0.141 |

These are unit ideals over F125, hence remain empty after algebraic
closure; they are not searches for F125-rational points. This audit
replayed the Sage/Singular computations and inspected their dictionary;
it did not independently implement a second Groebner engine or extract
polynomial unit multipliers. No blocking mathematical repair is needed.

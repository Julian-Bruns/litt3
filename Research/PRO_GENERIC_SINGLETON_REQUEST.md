Decide this specific generic-parameter question in characteristic five.
It would transfer an unbounded-degree exclusion from one curve to the
one-parameter family used in an independent no-cored-common-cover theorem.
You are NOT asked to solve the common-cover problem, invent strategies,
or audit the supplied geometric reduction. A counterexample is useful too.

## Goal

Let t be transcendental over F5, K=overline(F5(t)), and

    C_t: v^2=F(u)=u(u-1)(u-2)(u-3)(u-t),
    O=infinity, eta=du/v, div(eta)=2O.

Determine whether there exist a finite nonbranch P, an effective
degree-two divisor D (repetitions and O allowed), and h in K(C_t)^*
such that

    div(h)=5D-2P-8O,  Cartier(eta/h)=0.                 (*)

A NO should give a proof valid over F5(t), preferably an explicit
nonzero exceptional polynomial E(t) outside whose zeros the proof
specializes. A YES must verify an ACTUAL divisor and Cartier identity
over a specified algebraic extension, not merely a fifth-power norm.
No torsion condition on [D-2O] is imposed in this question.

## Supplied reduction: all three necessary charts are complete

Write P=(b,c), F(b)!=0. The function n=h(u-b)^2=A+vB has divisor

    div(n)=5D+2iota(P)-12O.

Its norm is A^2-FB^2=(u-b)^2 R^5, where R records the finite part of D.
Scalar factors are absorbed in R. Since

    eta/h=(A/v-B)du/R^5,  A/v=AF^2/v^5,

and all charts have deg B<=3, the Cartier condition is exactly

    [u^4](AF^2)=[u^9](AF^2)=[u^14](AF^2)=0.           (C)

These are THREE LINEAR equations on A. The third is identically zero
in the smaller-degree chart. All coefficients below are in characteristic5.

1. D avoids O and P. Normalize A monic of degree6; deg B<=3 and
   A(b)!=0. Put N=A^2-FB^2. The norm equations are

       N3=N4=N8=N9=0,
       N_(j+1)=-2b N_(j+2), N_j=b^2 N_(j+2), j=0,5,10.

   Using(C) leaves three affine A parameters, four B parameters, b,
   and an inverse variable z with z A(b)=1:9 variables/11 equations.

2. D=Q+O, Q!=O. Normalize B=u+B0 and take deg A<=3 satisfying(C).
   One has Q!=P and A(b)!=0. Impose N3=N4=0, the same paired norm
   relations for j=0,5, and z A(b)=1. This is5 variables/7 equations.

3. D=P+Q avoids O, allowing Q=P. Write

       A=(u-b)^2 A0, B=(u-b)^2 B0,
       A0 monic degree4, deg B0<=1.

   The necessary norm is N0=A0^2-FB0^2=(u-b)^3(u-x(Q))^5.
   Writing n_j for coefficients of N0, impose

       n4=0,n7=-3b,n6=3b^2,n5=-b^3,
       n2=-3b n3,n1=3b^2 n3,n0=-b^3 n3,

   together with(C) on the ORIGINAL A=(u-b)^2 A0 and z F(b)=1.
   This is8 variables/11 equations.

D=2O is impossible since P is nonbranch. The three charts include
D containing iota(P), other branch points, and repeated points.
They are necessary systems, sufficient for a NO if all are excluded.
For a YES, shared factors of A,B at a root of R can split the norm
between sheets; retain actual valuations rather than accepting the
norm as a divisor certificate.

## What is already known and what was tried

An alternative to those charts is now available: an explicit theta
equation for the ENTIRE generic family, derived symbolically in0.13s.
On J(C_t^(1)), in standard Kummer coordinates Z=(Z0,Z1,Z2,Z3),
Theta_B has support Q_t=sum c_ij Z_i Z_j=0, where

    c00=t^8(t+1)(t^5-2t^4+t^2-2t-1)
    c01=-2t^7(t+1)(t^4-t^3-t^2-t+1)
    c02=t^2(-2t^10+t^9+2t^7-2t^6-2t^4+2t^3+t-2)
    c03=t^4(t+1)(t^4-2t^3+t^2-1)
    c11=t^6(t^2+t+1)
    c12=t^2(t+1)(-2t^4+2t^3+2t^2+2t-2)
    c13=-t^3(t+1)(2t^2+t+2)
    c22=(t+1)(-t^5-2t^4+t^3-2t+1)
    c23=(t+1)(-t^4+t^2-2t+1)
    c33=(t+1)^4.

For M represented by U1=z^2-Sz+P and V1=q0+q1 z on C_t^(1),
the coordinates are Z=[1,S,P,w], with

    w=q1^2-f_2^5-f_3^5*S-f_4^5*S^2-f_5^5*S*(S^2-P),

where F_t=sum f_i*u^i. Note the Frobenius convention: the underlying
curve polynomial on C_t^(1) has parameter t^5, while Q's coefficients
above involve t. The goal(*) is exactly a nonbranch pair(P,M) with
Q_t(M)=0 and V(M)=2[P-O]. No prime-to5 order condition is imposed.
The global support identity includes the projective/Mumford boundaries.
Its specialization agrees with a separate torsion-interpolation certificate.
It does not yet decide the intersection or assert a multiplicity formula.

There is now a smaller alternative to the nine-variable norm system.
Reparametrize by N=3M-Fr_J([P-O]); equivalently M=2N and V(N)=[P-O].
These are inverse identities using V Fr_J=Fr_J V=[5]. Thus decide
Theta_B(2N) on V^(-1)(the Abel curve), still retaining P nonbranch.

Here are exact SMALL matrices for both loci, already proved. Write
N=(U1,V1) with U1=z^2-Sz+P0, V1=q0+q1z, and F1=sum f_i^5 z^i.
This paragraph uses P0 for the Mumford constant, not the curve point P.
For each A=u^j, j=0,...,5, put c_i=[u^i](AF^2) and form the column

    c4-P0*c14,
    c9+S*c14,
    q1*(c_r-P0*c_(r+10)-S*P0*c_(r+15))
      -q0*(c_(r+5)+S*c_(r+10)+(S^2-P0)*c_(r+15)), r=0,...,3.

The determinant of this SIX-square matrix vanishes EXACTLY when
V(N) lies in the Abel curve, on the nonbranch degree-two Mumford chart.
Keeping the first two rows avoids any missing kernel-rank stratum.
It is homogeneous degree4 in(q0,q1). Substituting

    q1^2=y=w+f2^5+f3^5*S+f4^5*S^2+S*(S^2-P0),
    q0^2=r0+P0*y, 2q0*q1=r1-S*y, F1 mod U1=r0+r1*z,

and reducing modulo the Kummer equation gives an explicit16-term CUBIC
E_t(S,P0,w), up to the invertible norm factor Res(U1,F1).
This was symbolically executed in0.13s. Precisely, if d is the
substituted determinant, Delta=S^2-4P0, R=Res(U1,F1), and
K=Delta*y^2-(2S*r1+4r0)*y+r1^2, then

    Delta*(d-R*E_t)=([w^2]d-R*[w^2]E_t)*K.

The identity only asserts the criterion on R*Delta!=0; do not silently
discard its boundary. The displayed six-square matrix defines E_t
unambiguously through this identity and its total-degree-three bound.

For Theta_B(2N), use the EIGHT-dimensional space

    S2={A:deg A<=11,[u4,u9,u14,u19](AF^2)=0}.

Let V2 be the unique square root of F1 modulo U1^2 reducing to V1.
For a basis A_j of S2 and r=0,...,3, form

    C_rj(z)=sum_l [u^(r+5l)](A_j F^2)z^l.

The eight-square matrix with column j consisting of coefficients z^2,z^3
of V2^(-1)*C_rj mod U1^2, for all four r, has kernel dimension
h0(B_C tensor N^2). This is an EXACT section-space identity, including
valid repeated Mumford divisors; it is not a norm-only condition.
Equivalently use Q_t on the Kummer doubling of N. No intersection
computation has yet been run using these two smaller matrices.

For t=alpha with alpha^3+alpha+1=0, ALL THREE charts have verified
original polynomial unit identities. After eliminating(C), generation
took about14 seconds total and no-solver replay0.54 seconds on one core.
Thus(*) is impossible for that specialized curve, with no restriction on
the order of the Jacobian class. Do not redo that specialization.

The same direct Groebner call for chart1 over F5(t) hit a one-minute
diagnostic cap. This proves nothing about the generic fiber. In particular,
an empty specialized saturated chart does NOT imply generic emptiness:
solutions might approach a removed boundary under specialization.

There is also a geometric size bound you may use without rederiving it.
For any ordinary genus-two curve in characteristic5, form
T=C x_(2[P-O],J,V) J(C^(1)), with V=F_C^* etale of degree25.
Its Raynaud-theta intersection has degree160. The144 distinct pairs
(W,M), W Weierstrass and0!=M in ker V, are forced. Subtracting them
once leaves an effective divisor of length16. Every solution of(*)
lies in its nonbranch part. Thus the genuine residual problem is tiny;
the displayed systems may retain spurious norm components.

Please pursue a decision of(*) using this structure. If unresolved,
identify the exact smaller algebra or mathematical implication left,
and distinguish executed computations from conjectural reductions.

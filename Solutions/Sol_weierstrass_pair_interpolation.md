# Proof: complete interpolation charts, not a generic-rank shortcut

[Statement](../Theorems/Thm_weierstrass_pair_interpolation.md).
Author /root,2026-09-08, incorporating the user's returned Pro argument
and source. Certificate replay is not an independent whole-proof audit.

## 1. The parameterized residual-point argument

Riemann--Roch gives dim L(3gO)=2g+1 and dim L((3g-1)O)=2g.
The asserted divisor gives 3gO-gP-gQ linearly equivalent to gT.
If h0(gT)=1, the space of sections of L(3gO) vanishing at least g
times at P,Q is exactly the line kf. Since f has exact pole3g at O,
this line has zero intersection with L((3g-1)O). The latter space
therefore injects into the2g-dimensional jet target, and is isomorphic
to it. This proves the general assertion, in any characteristic.
Jets are local Taylor coefficients (Hasse jets), not repeated ordinary
derivatives divided by factorials that may vanish.

## 2. The exceptional-point polynomial on X

Write D^[n] for the n-th Hasse derivative in x, and set it to zero for
negative n. For4<=n<=8 put

    H_n=F^5 D^[n](F^2)+3(F')^5 D^[n-5](F^2),
    W=det(H_(6+i-j))_(0<=i,j<=2)/F^3.

The [exact C++ certificate](../scripts/check_three_point_weierstrass.cpp)
checks that W is a polynomial of degree161, squarefree and coprime to F.
Here is its geometric meaning. A canonical basis is
(1,x,...,x^5,y,xy,x^2y)theta, with div(theta)=16O. At a nonbranch point
(u,v), write y(u+t)=v sum h_n t^n. From y=F^2/y^5 one gets through
order8

    h_n=D^[n](F^2)(u)/F(u)^2
          +3F'(u)^5 D^[n-5](F^2)(u)/F(u)^7
        =H_n(u)/F(u)^7.

Indeed h1=2F'/F, and the degree5 correction in the inverse fifth power
is -h1^5=3(F'/F)^5. Eliminating the first six polynomial columns in the
canonical nine-jet matrix gives determinant

    v^3 det(h_(6+i-j))=W(u)/F(u)^17.

As W is nonzero, the curve is classical. Riemann--Roch says
h0(9P)=1+h0(K-9P); hence h0(9P)=1 exactly when W(u)!=0. At a root
of W, the jet matrix has corank exactly one: corank at least two would
annihilate its adjugate and force a multiple zero of its determinant,
contrary to squarefreeness. Thus h0(9P)=2 there. This argument uses an
ordinary derivative only to detect simplicity, not high-order vanishing.

## 3. Exhaustive finite exclusion of two exceptional support points

The actual class [P+Q+T-3O] is killed by9 and is nonzero for distinct
abscissas. The low-Abel theorem and uniqueness of its effective divisor
give pi^12(P+Q+T)=P+Q+T. Each support point is therefore defined over
one of F_(25^12), F_(25^24), F_(25^36). The middle field cannot be dropped.
Modular powering and exact polynomial gcds in the certificate give

    gcd(W,x^(25^d)-x)=G, d=12,24,36,
    G=x^6+(a+4)x^5+(3a+2)x^4+(2a+2)x^3+x^2+4ax+4a+4.

The certificate proves G irreducible and F(alpha) a nonzero cube in
F_25[alpha]/G. Thus precisely eighteen possible nonbranch Weierstrass
points can occur in a target divisor. They form one orbit under rho
and pi. This is exhaustive over the algebraic closure after the proved
field bound, not sampling a finite field without justification.

There are135 pairs among them with different abscissas. For EVERY pair
the certificate constructs the18-by19 evaluation matrix for L(27O),
checks rank18, replays its kernel against all18 original Hasse equations,
and checks its x^9 coefficient is nonzero. Normalize that coefficient
to one. The norm polynomial is monic of degree27 and divisible by
((x-u)(x-v))^9. Its quotient H is monic of degree9. A residual ninth-order
zero at any finite T would require H=(x-t)^9, hence H7=H8^2 in
characteristic five. For all135 pairs the certificate proves H7-H8^2!=0.
The nonzero leading coefficient also excludes a residual point at O.
Thus a target divisor cannot contain two such points. The additional
540-triple rank check in the source agrees, but is not needed here.

Root read all197 source lines before execution. The supplied final PASS
guard only required135 pairs and zero norm candidates, even though its
printed counts also showed zero unhandled ranks and smaller poles. The
retained source strengthens that guard to require all those zero counts
AND135 failures of the first norm condition. No observed result changed.
Replay with that strengthened guard passed in0.32s on2026-09-08.
Hashes and limitations are in the [replay record](../Research/computations/pro_three_point_replay.json).

## 4. The nine-by-nine pair chart is complete after relabelling

At least two points of a possible target are outside W. Omit such a
point T and apply Section1. Put u=x(P), v=x(Q). For selected-sheet
Taylor truncation at P define

    Phi_i=x^i y-Taylor_(P,8)(x^i y), 0<=i<=5,
    Psi_i=x^i y^2-Taylor_(P,8)(x^i y^2), 0<=i<=2.

Every section with x^9 coefficient one and ninefold vanishing at P is

    f=(x-u)^9+sum b_i Phi_i+sum c_i Psi_i.

This follows by uniquely solving for the nine remaining coefficients
of A. The nine Hasse conditions at Q form a9-by9 matrix M(P,Q) on
(b0,...,b5,c0,c1,c2), with right side minus the jets of (x-u)^9.
Its homogeneous kernel would yield a section vanishing ninefold at
both points with x^9 coefficient zero. Section1 excludes that kernel.
Therefore Delta=det M is nonzero for at least two omitted-point choices.
This proves coverage of EVERY hypothetical solution, not invertibility
at all pairs on X times X.

## 5. Exact recovery of the third sheet

On Delta!=0 the interpolated f is unique and has exact pole27 at O:
x^9 is the unique basis monomial of pole27, while By and Cy^2 have
pole orders at most25 and26. Its norm is monic degree27 and divisible
by ((x-u)(x-v))^9. Expanding (x-t)^9 in characteristic five gives exactly
the eight equations in the statement, with t=H8.

Norm multiplicities alone would not specify a sheet. The polynomial
identity

    (B^2-AC)y-(C^2F-AB)
       =C^2(y^3-F)-(Cy-B)(A+By+Cy^2)

shows that a zero of f with U=B^2-AC nonzero must have y=V/U.
The discriminant and resultants ensure three distinct nonbranch fibers
and U nonzero on each. The norm's order9 in each such fiber is the
sum of the orders of f on its three points, since x is unramified.
Exactly one sheet can be a zero, so that sheet has order9. This proves
sufficiency and reconstructs T. It also rules out unseen finite zeros;
all poles are at O.

Conversely let f have the genuine target divisor. If U vanishes at a
root of R, the same identity gives V=0 there. If C is nonzero at that
abscissa, put b=B/C. Then A=B^2/C and F=b^3, with b nonzero because
the fiber is nonbranch. The quadratic f=C(y^2+by+b^2) vanishes at the
two distinct sheets zeta*b and zeta^2*b, a contradiction. If C=0,
then U=B^2 forces B=0; a selected zero forces A=0 as well, making
all three sheets zeros. This is again impossible. Hence Res(R,U)!=0,
and all other nonvanishing conditions follow from the prescribed support.
The optional nonzero B,C restriction retains exactly the remaining
trinomial cases; the earlier binomial theorem excludes the others.

Finally simultaneous rho on P,Q sends B to zeta^-1 B and C to zeta^-2 C,
leaving A and the norm fixed by uniqueness of interpolation. Delta's
nonvanishing and the resultant open are preserved. The invariant function
field of the diagonal deck action on the pair surface is k(u,v,z),
z=y(Q)/y(P), with z^3=F(v)/F(u). Its index in the full pair field is3.
Thus the residual equations descend to that explicit surface. No claim
that its remaining zero locus is empty, finite or transverse is inferred.

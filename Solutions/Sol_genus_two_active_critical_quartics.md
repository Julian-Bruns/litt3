# Proof: the only new equation is a critical quartic

[Statement](../Theorems/Thm_genus_two_active_critical_quartics.md).
Author /root,2026-09-09; Section5 added2026-09-10. All claims concern
the specified endpoint. No independent audit of the new boundary
computation is claimed.

## 1. Exhaustion by branch pairs

Every active genus-two regular nilpotent connection is admissible by
[nilpotent_scalar_model](../Theorems/Thm_nilpotent_scalar_model.md).
Its normalized quartic s has divisor2E with E reduced of degree4.
The hyperelliptic involution fixes every regular projective connection:
it acts trivially on its affine translation space H0(omega²), and a
translation of order2 is zero in characteristic5. The Hasse invariant
is natural, so s=A(u)eta^4 is invariant, with deg A<=4.

At O, ord(s)=8-2deg A. Thus deg A is3 or4. A finite branch root of
A has multiplicity1, and every finite nonbranch root has multiplicity2.
Hence, after retaining its nonzero scalar, A=R0 H² with R0 a squarefree
factor of F, H squarefree and coprime to F. If deg R0 is odd, O belongs
to E. The split case is R0=1. In a nonsplit case E therefore has either:

- two Weierstrass points and the two points of a nonbranch u-fiber; or
- four Weierstrass points.

The fifteen pairs of Weierstrass points represent the fifteen nonzero
two-torsion classes. Their square roots are sqrt(R), with the finite
root convention in the statement. Complementary branch subsets represent
the same class because F=v². This also proves distinctness: the symmetric
difference of two different pair subsets is neither empty nor all six
points, so their ratio is neither a square in k(u) nor F times a square.

For a fixed pair R, the two possibilities for A are consequently

    A=a² R(u)(u-h)², a!=0, F(h)!=0;   or   A=a² S, a!=0.

This classification checks infinity as well as the finite branch points;
there is no lost degree-three polynomial chart.

## 2. Cartier reduces the fiber case to D'(h)=0

For the first possibility, adjoin w^4=A, and put

    kappa=w²/(a(u-h)),  kappa²=R,  z=vw/kappa.

Then z^4=R S² a²(u-h)², and the tautological root differential is
alpha=a(u-h)du/z. The normalized quartic condition is equivalent to
Cartier(alpha)=alpha, by the Cartier projection formula and injective
separable pullback. Using z^5=z*z^4 gives

    alpha=z^-5 a³ D(u)(u-h)³ du,       D=RS².

The polynomial has degree at most12, so Cartier extracts only its u^4
and u^9 coefficients. Put

    c0(h)=D_1-3hD_2+3h²D_3-h³D_4,
    K(h)=D_6-3hD_7+3h²D_8-h³D_9=D^[6](h).

Comparison with a(u-h)du/z is exactly

    a²=K(h),       c0(h)+h^5 K(h)=0.

In characteristic5 the second polynomial is IDENTICALLY D'(h).
But D'=S(R'S+2RS')=SJ. Also gcd(J,F)=1: at a root of R its value
is R'S!=0, and at a root of S it is2RS'!=0. Since deg R is1 or2,
the leading coefficient of J is respectively4 or3, so deg J=4.
This proves that the permitted abscissas are exactly J(h)=0 with K(h)!=0.
The scalar a² is uniquely K(h), so the normalized tensor is the displayed
one, independent of either square-root choice for a. Its divisor has the
required four double zeros, including O when deg R=1.

For the four-branch case interchange R and S, keep H=a constant, and
make the same root construction. Now the polynomial before Cartier is
a³ S R², of degree at most7. Only its u^4 coefficient contributes.
The condition is exactly a²=c. This proves both necessity and sufficiency
of the stated list. The scalar nilpotent dictionary reconstructs the
actual regular connection. There is no assertion that root maps to Y
are etale: they are auxiliary ramified maps used for the coefficient check.

## 3. A small certificate applies to the whole high-degree family

Label the finite roots0,1,2,3,t. Take all ten finite pairs and the five
pairs with O. For each resulting R the coefficients of J have parameter
degree at most1, those of K at most2, and c has degree at most2. These
bounds hold because either R is independent of t and S is affine in t,
or R is affine in t and S is independent of t.

The quartic discriminant therefore has t-degree at most6. Write m=deg_u K,
which is at most3. The resultant Res_u(J,K) is homogeneous of degrees
m and4 in the two coefficient lists; hence its t-degree is at most
m+8<=11. Specialization can lower the degree of K, but the Sylvester
resultant with its fixed generic degree specializes as usual; J has a
constant nonzero leading coefficient, so this causes no false nonvanishing.

The standalone standard-library verifier specializes t to a with
a²+4a+2=0. For ALL fifteen classes it proves exactly

    gcd(J,J')=gcd(J,K)=1,       c!=0.

Thus every relevant discriminant, resultant and c is a NONZERO polynomial
in F5[t] of degree at most11. None can vanish at a parameter of degree
greater than11. This is a complete algebraic nonvanishing argument, not
finite-field sampling of the desired geometric roots.

For an independent check of the root formulas, the verifier also works
in the full four-dimensional algebra F25[h]/(J), without choosing roots.
It checks the ORIGINAL quartic Cartier equations for A=K(h)R(u)(u-h)²
and A=cS:

    [u^(5i+4)] F² A^4 = A_i^5,        i=0,...,4.

All coefficient powers in this check are actual fifth powers, including
those of h in the quotient algebra. The specialization replay took about
0.04seconds on2026-09-09 and requires no Sage installation or data file.

It follows that every class has four distinct fiber-type data and one
four-branch datum, hence75 distinct nonsplit active connections altogether.

## 4. Ordinariness follows by exhausting the canonical doubles

The [universal dormant quintic](../Theorems/Thm_genus_two_dormant_quintic.md)
has resultant with its derivative -[t(t-1)(t-2)(t-3)]². Thus this family
has exactly five reduced dormant connections at every smooth parameter.
The [canonical-double theorem](../Theorems/Thm_etale_double_dormant_pairs.md)
then gives ten split active connections. It also gives, for each nonzero
two-torsion class L,

    #Dorm(Y_L)=5+2 #Active_L(Y)=15.

The dormant scheme on the genus-three Y_L has length15. Its fifteen
geometric points therefore ALL have length1. Canonical-double tangent
factorization proves that every nonsplit active connection on Y is
ordinary. The split connections are ordinary by the same factorization
on Y itself. This proves the asserted85 active ordinary connections.

Finally a dormant tangent space on Y_L at the pullback of a base dormant
connection splits into the untwisted and L-twisted base tangent spaces.
Both vanish, giving the stated uniform Pic[2] test. This is the previously
proved counting implication, now applicable to the CURRENT selected
high-degree Y, not only to the small backup curve.

## 5. A critical-point collision gives an actual corank-one example

Take t^4+4t^3+t^2+4t+3=0. This polynomial is irreducible over F5,
as checked exactly by the boundary verifier. Thus t lies in F625,
not F5, and F is squarefree. Use the branch pair {t,infinity}:

    R=u-t, S=u(u-1)(u-2)(u-3), h=4t+3.

The polynomials of Sections1--2 are

    J=4u^4+(2t+3)u^3+t u^2+(t+2)u+2t,
    K=4u^3+(2t+4)u^2+(4t+1)u+2t+1.

Exact division gives

    J=(u-h)^2[4u^2+(4t+2)u+3t^2+1].

Moreover gcd(J,J')=u-h, J''(h)!=0, F(h)K(h)!=0, and gcd(J,K)=1.
This degeneration was found systematically: with this R and arbitrary
t, disc_u(J)=3(t^4+4t^3+t^2+4t+3), while Res_u(J,K)=4.
It is a collision of two legitimate critical data, not a singular
curve or a root lost to a denominator.

Put A=K(h)(u-t)(u-h)^2. Section2 constructs the active tensor
s=A eta^4. Its half-divisor is

    W_t+O+P_h+iota(P_h),

four DISTINCT points: h is nonbranch and h!=t. Thus admissibility
includes infinity. Its canonical double has class O(W_t-O), nontrivial
two-torsion; do not replace it by a split double.

Locally take q=sqrt(A)/F as a quadratic-tensor coefficient and put

    b=q'/q=1/(u-h)+3/(u-t)-F'/F, r=b'+b^2.

The verifier cancels this rational function and obtains precisely the
regular connection stated in the theorem. Equivalently it is the usual
regular genus-two connection with correction polynomial of degree3 and
leading coefficient2. It checks the ORIGINAL scalar identities

    E=r''-3r^2=3A/F^2, N=-(E')^2-3E(E''+3rE)=0.

To find its whole nilpotent tangent space, vary r by e times
phi_i=u^i/F, i=0,1,2; these are the complete regular quadratic basis.
For any such variation put e_i=phi_i''-r phi_i. Linearizing N gives

    L_r(phi_i)=-2E' e_i'-3e_i(E''+3rE)
                -3E(e_i''+3phi_i E+3r e_i).

Clearing the least common denominator gives an11-by3 coefficient
matrix of rank EXACTLY2. For transparency, columns0,1 and rows0,5
have minor

    [2t^3+t^2+t+2, 3t+2;
     2t^3+t^2+t+2, 2t^3+t^2+t+1],

whose determinant is2t^2+4t+4!=0. Its kernel contains the explicit
vector (2t^2+4,t+3,1), because

    4J/(u-h)^2 = u^2+(t+3)u+2t^2+4.

These checks prove the asserted one-dimensional kernel, without
inferring scheme multiplicities from the repeated critical root.
The generic identity dr/dh=4J/[F(u)(u-h)^2] explains the tangent:
the double critical root makes this infinitesimal variation REGULAR.

Finally the Jacobian Cartier determinant3(t+1)^4 reduces to4. Thus
ordinary Jacobian and corank-one nonordinary indigenous connection
coexist in this explicit nonsplit example.

The Sage verifier ran all these exact assertions in0.096seconds,
apart from startup, on2026-09-10. It computes NO higher Witt class.
Receipt: Research/computations/nonordinary_active_playground.json.

## Boundary retained

There can still be new tangent vectors on a general joint etale source.
The computation and the canonical-double argument do not rule them out.
In particular ordinary dormant points and ordinary nilpotent connections
are different notions; no lifting theorem is applied to a dormant point
merely because its dormant scheme is reduced.

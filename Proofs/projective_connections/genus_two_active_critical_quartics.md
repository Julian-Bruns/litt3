# Proof: the only new equation is a critical quartic

[Statement](../../Theorems/projective_connections/genus_two_active_critical_quartics.md).
Author proof,2026-09-09–13; verification scopes are in the statement.

## 1. Exhaustion by branch pairs

Every active genus-two regular nilpotent connection is admissible by
[nilpotent_scalar_model](../../Theorems/projective_connections/nilpotent_scalar_model.md).
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

## 3. Two affine orbits give the family count

In z=1/(u−4), the branch set is F5∪{a}, a=1/(t−4). The
[affine-family theorem](../../Theorems/curve_arithmetic/prime_field_branch_family.md)
gives actual curve isomorphisms under z↦sz+b, s∈F5×, b∈F5.
They preserve the parameter degree and act on nonzero two-classes
with two orbits: pairs of constant branch points, and pairs containing
a. In the u coordinate take representatives R=u and R=u−t.

The [symbolic verifier](../../scripts/genus_two/check_genus_two_active_twists.py)
computes their discriminants, resultants and branch scalars over F5[t].
Up to nonzero constants the only factors are:

| R | disc(J) | Res(J,K) | c |
|---|---|---|---|
| u | t⁶+t⁵+2t⁴+2t²+t+1 | (t³+t²+3t+1)(t³+3t²+t+1) | t+1 |
| u−t | t⁴+4t³+t²+4t+3 | 1 | (t+1)² |

All have degree at most6. Thus every parameter of degree>6 has five
active data in both representative classes. Transport these actual
connections by affine isomorphisms: the transformed parameter still has
degree>6. Every root class therefore has five active data. Sections1–2
bound each class by one branch datum and four distinct fiber data, so
equality forces every J squarefree, every gcd(J,K)=1 and every c≠0.
This argument transports points and their intrinsic root classes; it
requires no coordinate transformation formula for J.

The [certificate](../../Research/computations/genus_two_affine_twist_certificate.json)
also checks the original quartic Cartier identities for both representative
branch data and in both entire critical algebras F5(t)[h]/(J):

    [u^(5i+4)] F² A⁴ = A_i⁵,        i=0,...,4.

These use actual fifth powers of all coefficients, including t and h.
There are75 distinct nonsplit active connections, five in each class.

For the backup t³+t+1=0, the same verifier with --backup checks all
fifteen conditions and all75 original identities directly over F125.
Its [receipt](../../Research/computations/backup_nonsplit_twists.json)
uses the complete critical algebras. The additional twist tests are
unneeded for the count. The original
[85-point table](../../Research/computations/backup_active_twist_table.json)
remains independent evidence for the backup.

## 4. Counts and local lengths

The [universal dormant quintic](../../Theorems/projective_connections/genus_two_dormant_quintic.md)
has resultant with its derivative -[t(t-1)(t-2)(t-3)]². Thus this family
has exactly five reduced dormant connections at every smooth parameter.
The [canonical-double theorem](../../Theorems/projective_connections/etale_double_dormant_pairs.md)
then gives ten split active connections. It also gives, for each nonzero
two-torsion class L,

    #Dorm(Y_L)=5+2 #Active_L(Y)=15.

The [scalar determinant theorem](nilpotent_scalar_model.md#2-n-equations-their-exact-length-and-infinity)
gives a zero-dimensional complete intersection of length125 on Y.
At a dormant point the determinant of p-curvature has no linear term,
so its three local equations lie in the square of the maximal ideal.
Its local length is at least2³=8. The85 distinct active points each
contribute at least1. Equality5·8+85=125 forces all these bounds to
be equalities: dormant multiplicity8 and85 reduced, hence ordinary,
active points. This works for both parameter loci and replaces the
older backup solution-list census.

The dormant scheme on the genus-three Y_L has length15. Its fifteen
geometric points therefore all have length1.

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

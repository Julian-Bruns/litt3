# Proof: Fermat quotients and the remaining nine-torsion support

[Statement](../../../Theorems/jacobians/torsion/kummer_norm_and_nine_torsion_support.md).
Author proof; the two exact calculations below are reproducible from one
[verifier](../../../scripts/arithmetic/verify_fixed_x_nine_torsion.sage).
The shared-fiber calculation originated in the returned Pro answer of
2026-09-08; its original certificate and replay provenance remain local.

## 1. A binomial norm produces a Fermat quotient

For n>=3 prime to the characteristic and gcd(j,n)=1, the deck orbit gives

    Norm(A+B y^j)=A^n−(−1)^n B^n F^j.

If this equals H^n, choose epsilon^n=(−1)^(n+1). The functions
U=A/H and V=epsilon B y^j/H satisfy U^n+V^n=1 and define a nonconstant
map C→H_n: V cannot be constant because y^j is not in k(x).
The map extends to the smooth projective curves. Its Jacobian
pushforward is nonzero, since pushforward after pullback is multiplication
by the positive degree on J(H_n), also for an inseparable map.
This contradicts Hom(J(C),J(H_n))=0.

In particular an absolutely simple J(C) of dimension greater than
g(H_n) has no such quotient. For n=3, H_n is elliptic, so the established
absolute simplicity of the genus-nine J(X) suffices.

## 2. The degree-two three-primary locus

The [low-Abel theorem](cyclic_cubic_low_abel_torsion.md) bounds every
three-primary W_2 class by nine and identifies W_1[3^infinity] with
the eleven branch classes. If 9[E−2O]=0 and E=P+Q contains a branch
point, then Q is also a branch point.

Otherwise E is finite and branch-free. Its certificate lies in L(18O):

    div(f)=9E−18O,   f=A+B y,   deg A=6, deg B<=2.

If B=0, a nonbranch zero brings the entire cubic x-fiber, impossible
on a degree-two support. For B!=0, let R be the monic degree-two
polynomial whose root divisor is x_*E, including multiplicities.
Then Norm(f)=cR^9 is a cube, contradicting Section1.
Conversely every branch-supported E is killed by three. There are
binomial(12,2)=66 distinct classes because X has no degree-two function.

## 3. Preliminary degree-three support reductions

Every function of degree at most six belongs to k(x), by the
low-Abel theorem. A degree-three effective class therefore has a unique
representative unless it is zero and represented by a complete x-fiber.

Let D represent an exact-order-nine class. A branch point in D is
excluded by Section2. The pattern D=3P gives 27[P−O]=0, so P would be
branch. For two points in one nonbranch fiber, D=2P+rho P gives

    [D−3O]=(2+rho)[P−O],   (2+rho)(2+rho^2)=3,

again forcing 27[P−O]=0. The other ordering is identical.

The remaining shared-fiber pattern is D=P+rho P+Q with x(Q)!=x(P).
Put R_0=rho^2P; then [D−3O]=[Q−R_0]. The field bound and uniqueness
give pi^12D=D. Fiber multiplicities two and one force the abscissas
to be fixed. A permutation of a cubic fiber commuting with rho and
preserving two points is the identity. Thus Q and R_0 are individually
F_(25^12)-rational and 9(Q−R_0) is principal.

## 4. The rational Weierstrass locus excludes shared fibers

Both l(9R_0) and l(9Q) must be at least two. The canonical basis is

    (1,x,...,x^5,y,xy,x^2y) dx/y^2.

At a finite nonbranch point, the Riemann–Roch jet test for l(9R_0)>=2
reduces to det(y_(6+i−j))_(0<=i,j<=2)=0, where subscripts denote
Hasse coefficients. Since y=F^17/y^50 and y^(-50) is a twenty-fifth
power, these jets differ by a common nonzero scalar from those of F^17.
The verifier computes

    Dcal=det(H_(6+i−j)(F^17)),
    W=(Dcal/F^33)_monic,  deg W=161,
    gcd(W,x^(25^12)−x)=T,
    T=x^6+(a+4)x^5+(3a+2)x^4+(2a+2)x^3+x^2+4ax+4a+4.

It verifies that T is irreducible and F has no root on W. In the
degree-six field K=F_25[b]/(T), F(b) has a cube root c.
The eighteen possible points form one orbit under rho and pi;
fix R_0=(b,c).

For t=x−b, expand y(t) modulo t^9. The matrix of its coefficients
6,7,8 after multiplication by a quadratic C_*(t) has rank two.
Its kernel has a unique representative with C_*(0)=1. Set

    B_*=(C_*y)_(<=5),   A_*=(C_*y^2)_(<=8),
    N=A_*+B_*y+C_*y^2,   h_0=N/t^9.

The verifier checks that N vanishes modulo t^9 on the other two sheets,
but N(R_0)!=0. Its pole order at O is at most26, below that of t^9.
Thus h_0 has its unique pole of order nine at R_0. The same jet rank
gives l(9R_0)=2, so 1,h_0 is a basis.

The fifteen possible points with different abscissa are
Q=rho^j pi^i R_0, 1<=i<=5, 0<=j<=2. At each, the verifier evaluates

    E=t[3F(A_*'+B_*'y+C_*'y^2)+F'(B_*y+2C_*y^2)]−2FN,

the numerator of 3F t^10 h_0'. Their product is the nonzero element

    (4a+1)+(2a+4)b+2ab^2+3ab^3+(2a+3)b^4+(a+3)b^5.

Hence no nonconstant alpha h_0+beta vanishes to order nine at Q.
This excludes the shared-fiber pattern. All higher-order conditions
use Hasse jets; the ordinary derivative only certifies nonvanishing.

## 5. Two polynomial identities exclude double support

It remains to exclude div(f)=18P+9Q−27O with P finite nonbranch,
Q finite and x(Q)!=x(P). This calculation covers every geometric P;
it uses neither the field bound nor Jacobian simplicity.

Write P=(b,c), c^3=F(b)!=0, and set

    S=(x−b)/F(b),  Y=y/c,  T_b(S)=F(b+F(b)S)/F(b).

The coefficients of T_b belong to F_25[b], with constant term one.
Its cube root H modulo S^18 also has polynomial coefficients:
H=T_b^17 modulo S^18, since 3*17=1+2*25.

A section of L(27O) is A(S)+B(S)Y+C(S)Y^2, with degrees at most
9,5,2. Vanishing to order18 determines A=−(BH+CH^2)_(<=9);
the remaining equations form an eight-by-nine matrix J(b), with
rows n=10,...,17 and columns

    B_i (0<=i<=5): H_(n−i),
    C_i (0<=i<=2): (H^2)_(n−i).

For its signed maximal minors Delta_j the verifier produces

    sum_j u_j Delta_j=1.

Thus J has rank eight everywhere and kernel generated by Delta.
Use these coefficients for B,C and the determined A. The norm

    N=A^3+B^3T_b+C^3T_b^2−3ABC T_b

has degree at most27 and is divisible by S^18. Write
N/S^18=sum_(j=0)^9 h_j(b)S^j. The proposed divisor would require

    N/S^18=h_9(S−d)^9,   h_9!=0,
    d=(x(Q)−b)/F(b)=h_8/h_9.

The next two coefficients force

    E_7=h_7h_9−h_8^2=0,   E_6=h_6h_9^2−h_8^3=0.

The verifier produces v_7E_7+v_6E_6=1, a contradiction.
If h_9=0, the unique section line has pole order less than27 and
cannot give the required divisor. The first Bezout identity excludes
all rank-drop exceptions.

The maximal-minor degrees are 810,818,827,836,845,855,804,813,822;
the two norm-equation degrees are 5310,7956. Run

    sage scripts/arithmetic/verify_fixed_x_nine_torsion.sage

to regenerate both calculations without writing files. Add --replay
to verify the retained [double-support coefficients](../../../Research/computations/fixed_x_double_support_torsion.json)
using the independent seventeenth-power construction of H.

Consequently D has three distinct finite nonbranch points at distinct
abscissas. Its certificate in L(27O) has deg A=9, deg B<=5, deg C<=2.
Both B and C are nonzero: otherwise its norm is a forbidden binomial
cube, or f belongs to k(x) and its support contains a full x-fiber.

## 6. Residual rigidity

On U, representatives are x-reduced and avoid ramification. The
[general pencil lemma](reduced_divisor_rigidity.md#2-almost-fixed-classes)
applies with n=r=3, since every function of degree<=6 belongs to k(x).
It makes lambda=1−rho injective on U and gives
(gamma−1)^2xi=0⇒(gamma−1)xi=0 for gamma=rho^i pi^j.
These actions fix O, commute with rho and have finite point orbits;
the representative has no ramification part.

The image under lambda can leave U and W_3. This injectivity therefore
does not eliminate the remaining three-point exact-order-nine locus.

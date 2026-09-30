# Proof: nonempty double-base locus and its determinantal presentation

The manually returned endpoint computation is integrated here.
The supplied [source](../../scripts/genus_two/pro_isotropic_double_base_locus.py)
was executed locally. Its generated
[JSON](../../../litt3-computation-data/endpoint_loci_20260923/double_point_local_data.json)
equals the supplied JSON exactly. This checks the divisor, determinant
order, linear minor, Jacobian and first-jet arithmetic. The global
exhaustion argument below is a prose argument, not a claim that a
computer enumerated all geometric points or components.

## Dimension correction

For the primitive norm test, M has degree minus two. At the order-four
adjunction zero P, write s=t^5. In a regular frame the coefficients
r0,r1,r2,r3 are divisible by s and r4 is a unit. Therefore
Q(r)=r2^2+2r0r4+2r1r3 vanishes at P1. The norm lies in
H^0(C,M^-2(-P1)), of dimension two, not in an unconstrained
three-dimensional space. The Picard Frobenius-root cover of the
three-point parameter space is smooth of dimension three. Locally
the norm equations cut out at most two conditions. Every nonempty
component has dimension at least one. The earlier expectation of
a finite locus was an incorrect heuristic; it is not retained as a
possible conclusion for this open locus.

## Divisor and saturation certificate

The polynomial identity in the statement is checked exactly, together
with H+eT=0 mod d, H+eQT=0 mod q, gcd(d,q)=1 and gcd(dq,Phi*T)=1.
Thus it determines the sheets and exact multiplicities. At infinity
df has order minus twelve. Hence div df=5D+2E-12O, of total degree
two as required. The primitive span([f],[f^2]) is isotropic since
Cartier(f d(f^2))=Cartier(d(2f^3/3))=0.

The saturated canonical line is kappa=O_C(F(D)-3O_C), whose
adjunction has divisor3O+2E. Subtract a Frobenius constant from a
local primitive g. At O its first order is four; at either Q its
first order is three. The saturated plane lattice is [g],[g^2]/s
at each of these three points. Each contributes one to the
determinant relative to kappa^3. Elsewhere there is no correction.
This gives L=kappa^3(O_C+F(E)) and the required evaluated orders
(2,3),(0,2),(0,2). Their raw Wronskian orders are4,1,1.

Exact Mumford addition on C gives L0=((89,25,1),(28,29)). The script
checks 1850L0=0 and (1850/l)L0 nonzero for l=2,5,37. The computed
Jacobian order is14800. The order assertion is thus exact, not merely
a divisor of a point-count bound. The residual quadratic has nonsquare
discriminant[116], so its two points are exchanged over F125.

## Algebraic component through the seed

Use two points (X1,Y1),(X2,Y2) on C near ([90],[85]),([70],[23]),
with Mumford polynomials d_C,e_C. Put a(u)=d_C(u^5), b(u)=e_C(u^5).
For P near O set s=1/u,z=u^2/v, so s=z^2G(s), where
G=1+[24]s+[6]s^2+[24]s^3+[5]s^4. Solve linearly for deg H<=8,
deg T<=6 with
\[
T4=0,\quad [\Phi^2H]_4=[\Phi^2H]_9=[\Phi^2H]_{14}=0,
\quad \Phi^2H+bT=0\pmod a,\quad T3=1.
\]
Writing J=s^6T(1/s)+z s^8H(1/s), impose J=partial_z J=
partial_z^2 J=0 at P, with partial_z s=2zG/(1-z^2G').
The normalized linear system has a12-by12 minor[70], so is uniquely
solvable near the seed. The equations use points on the relative
twist, not coefficientwise untwisted substitutes.

On this chart write (H^2-Phi*T^2)/a=(1-su)^3 m(u), deg m<=4.
For m4 nonzero set mbar=m/m4, q1=3mbar3, q0=3(mbar2-q1^2).
The remaining equations are
\[
mbar0-q0^2=0,\qquad mbar1-2q0q1=0.
\]
Retain all nonzero minors, discriminants and resultants specifying
the three distinct points and exact orders. The Jacobian with respect
to X1,X2 at the seed is (([71],[66]),([21],[32])), determinant[88].
Consequently there is a unique geometric curve component through this
smooth point, etale over the P-coordinate there. The point and
equations are F125-rational; uniqueness through this smooth point
makes that component geometrically irreducible and defined over F125.
The canonical-line recovery is inverse to the plane construction,
so this is a component of the plane locus, not only a covering
parameter space. Forgetting the two auxiliary-point labels preserves
this local conclusion since the points are distinct.

## Exhaustiveness without a component census

For every degree-minus-one kappa, kappa(3O_C) has degree two. Its
effective representative is unique unless it is canonical, in which
case kappa=O_C(-O_C) and choose D1=2O_C. The three reduced Mumford
strata D1=Dred+(2-r)O_C, r=0,1,2 cover all cases.

H^1(C,O_C(3O_C))=0. The exact sequence defining B therefore gives
each section of B(3O_C) a rational primitive, unique modulo
Frobenius constants. The twelve monomials V in the statement form
a complementary space: all have pole order at most15 at O, and
the omitted monomials1,u^5 are precisely the Frobenius constants
within that space. Differentiation is injective on V.

The divisor Z=F^*D1+3P+2Q1+2Q2 has degree17, equal to
deg omega_Y(15O). A nonzero kernel primitive has div df+15O=Z.
The kernel is at most one-dimensional, since it injects into the
sections of the degree-zero line omega_Y(15O)(-Z). Thus the
12-by12-minor condition is exact and reconstructs a unique projective
primitive whenever nonempty. The preceding local saturation gives
the plane and determinant formulas at every such point.

Conversely the canonical kappa inside any required isotropic plane
has adjunction divisor3P+2Q1+2Q2. Multiplication by the section of
O_C(D1) places it in B(3O_C), giving exactly the primitive in V and
the divisor equality above. This proves exhaustion. At a finite
boundary point use the full divisor ideal
(d_C(u^5),v^5-e_C(u^5)); at infinity use the local series with the
actual sum of the multiplicities. The coordinate-chart divisions
by Phi are not used in this global argument. Finally, if M=L omega_C^-1,
then kappa=M^2 omega_C(P1) and
M=kappa^3(P1+Q11+Q21)omega_C^-1 are inverse on the locus.
There is no loss of fifth-root choices.

Nonemptiness refutes endpoint emptiness as an exclusion of this
branch. Nothing here supplies the competing X-map or shows that
the necessary full-orbit flags can be realized.

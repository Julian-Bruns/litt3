# Proof: the backup's four degree-one Cartier planes

Version1,22September2026. Independently audited. This classifies the geometric degree-one
nonisotropic rank-two subbundles of B_Y for the actual backup Y.
They EXIST: there are exactly four, forming two orthogonal pairs,
all defined over F125. Thus this endpoint condition does not
exclude the degree-one rank-two radical-orbit case.

The classification retains the quadratic norm and its prescribed
zero divisor. It is stronger than solving the adjunction degree
condition alone. No actual map from an étale cover of Y to fixed X
is constructed.

## 1. Curve, twists and the result

Write a^3+a+1=0 over F5, and let
\[
Y:\ v^2=f(x)=x(x-1)(x-2)(x-3)(x-a),\qquad
\eta=dx/v,\quad\operatorname{div}(\eta)=2O.
\]
Set
\[
t=a^2+3a+4,\qquad s=a^2+4a+4,\qquad
P_\pm=(t,\pm s),\qquad z=(a,0)\in Y.
\tag{1}
\]
Then s^2=f(t) is nonzero, t^5=a, and
s^5=4a^2+2a+1. For the relative Frobenius F:Y -> Y^(1), put
\[
y_\pm=F(P_\pm)=(a,\pm(4a^2+2a+1))\in Y^{(1)}.
\tag{2}
\]
The target curve has branch parameter a^5. In particular the point
y_\pm on Y^(1) must not be confused with the branch point z on Y.

For each y=y_+ or y_-, there is exactly one primitive line image
\[
O_{Y^{(1)}}(-y)\hookrightarrow
P_Y:=F_*\omega_Y^{-2}
\tag{3}
\]
whose nonzero quadratic norm has divisor 2y, up to scaling the
map. Each gives exactly two saturated rank-two Plücker planes
E_{y,+},E_{y,-} in B_Y, which are mutual symplectic orthogonal
complements and have degree one. There are no other degree-one
nonisotropic planes.

All four are stable, since a line subbundle of the stable
slope-one B_Y has degree at most zero. Their first Frobenius
pullbacks have the SAME exact branched type
\[
0\longrightarrow\omega_Y^2(-z)
\longrightarrow F^*E_{y,\pm}
\longrightarrow\omega_Y\longrightarrow0.
\tag{4}
\]
The first adjunction map is everywhere surjective; the adjacent
connection map has its single zero at z. Thus these are stable
degree-one bundles with first Frobenius instability, with upper
line degree three and lower quotient degree two. No assertion of
an unbranched dormant projective oper is made.

## 2. Local normalization of the quadratic form

This fixes the scalar needed to construct the actual Plücker
planes. In an étale coordinate u put b_i=u^i du, 0<=i<=3,
as the basis of B_Y over the Frobenius target. The Raynaud pairing
has
\[
\beta(b_i,b_j)=\frac{\delta_{i+j,3}}{i+1}\,du^{(1)}.
\]
Let e_ij=(b_i wedge b_j)/du^(1). A contraction-one scalar
bivector is rho=3e_03+e_12. The primitive summand has basis
\[
e_{01},\ e_{02},\ e_{03}+3e_{12},\ e_{13},\ e_{23}.
\]
The intrinsic Wronskian map
\[
(b\,du)\wedge(c\,du)\longmapsto
(bc'-b'c)(du)^3
\]
followed by the inverse Frobenius pull of the target canonical
line identifies the primitive summand with F_*omega_Y^(-2).
It kills rho and sends the five displayed basis vectors to
\[
1,\ 2u,\ u^2,\ 2u^3,\ u^4
\]
times (du)^(-2). The transformation rule for the Wronskian is
weight three, so this description is coordinate independent.
The local matrix is invertible, proving that it is the actual
primitive-summand isomorphism.

Normalize wedge square by b_0 wedge b_1 wedge b_2 wedge b_3.
If a(u)=a_0+a_1u+...+a_4u^4 represents a primitive vector, its
quadratic norm is
\[
Q(a)=a_2^2+2a_0a_4+2a_1a_3
 =\frac{\operatorname{Cartier}_{\rm rel}(a(u)^2du)}
 {du^{(1)}}.
\tag{5}
\]
For a scalar component c and a primitive component a, the full
wedge square is c^2+Q(a). Direct expansion verifies this formula:
the primitive inverse has coefficients
(a_0,3a_1,a_2,3a_2,3a_3,a_4) in the ordered e_ij basis,
and adding c rho changes e_03,e_12 by 3c,c.

Consequently a saturated map j:O(-y) -> P_Y with
Q(j)=C s_y^2, C nonzero, gives the two decomposable lines
\[
s_y\rho+\lambda j,\qquad s_y\rho-\lambda j,
\qquad \lambda^2 C=-1.
\tag{6}
\]
Here s_y is the canonical scalar map O(-y) -> O. The full lines
are nowhere zero: away from y their scalar part is a unit, and
at y their primitive part is nonzero. They therefore define
actual saturated Grassmannian subbundles. Orthogonal
complementation reverses the primitive component in (6).

Conversely every nonisotropic degree-one plane has a restricted
pairing with divisor one point y, and its Plücker source is
O(-y). Its primitive component must satisfy exactly this
nonzero-norm condition. Thus classification of (3) with the
specified norm is equivalent to classification of the planes.

## 3. The complete non-Weierstrass adjunction locus

Let P=(t_0,s_0) be any non-Weierstrass point on Y, and y=F(P).
Adjunction identifies the possible primitive maps with
\[
H^0\bigl(Y,\omega_Y^{-2}(5P)\bigr).
\tag{7}
\]
Since omega_Y^2=O(4O), such a section is r eta^(-2), where
div(r)+5P-4O is effective. The function r(x-t_0)^5 is regular
on the affine curve and has pole order at most six at O.
It is therefore A(x)+b v with deg A<=3 and b constant.
Vanishing at the conjugate of P to order at least five forces
b nonzero, so scale b=1.

The polynomial A is uniquely determined by the first four
Taylor coefficients of v at P, with the sign chosen so that
v+A vanishes at its conjugate. The fifth required coefficient
is
\[
[h^4]\sqrt{f(t_0+h)}
 =\frac{s_0}{f(t_0)^3}[h^4]f(t_0+h)^3.
\tag{8}
\]
In characteristic five the square-root expansion through order
four agrees with the cube expansion after this normalization.
Lucas's congruence gives
\[
[h^4]f(t_0+h)^3=H(t_0)^5,\quad
H(T)=\sum_{j=0}^2\bigl([x^{5j+4}]f^3\bigr)^{1/5}T^j.
\]
Exact arithmetic in F125 gives
\[
H(T)=(2a^2+a)T^2+(2a^2+4)T+3a
 =(2a^2+a)(T-t)^2,
\tag{9}
\]
with t from (1), and gcd(H,f)=1. Thus the ENTIRE geometric
non-Weierstrass locus consists of P_+ and P_-. At each the
space (7) has dimension one. The double root in (9) is retained
in the certificate; no reducedness assertion about a parameter
scheme is made.

## 4. Exact section, residual zero and norm

For P=P_+, put A=sB, where
\[
B(x)=(a^2+4a)x^3+(3a^2+4a+1)x^2
 +(3a^2+a+2)x+a^2+a+1.
\tag{10}
\]
Then A(t)=s and the exact polynomial identity is
\[
A(x)^2-f(x)
 =(4a^2+a+3)(x-t)^5(x-a),\qquad A(a)=0.
\tag{11}
\]
The adjoint section of (3) is represented by
\[
r=\frac{v+A(x)}{(x-t)^5},\qquad
\sigma=r\eta^{-2}.
\tag{12}
\]
At the conjugate of P the numerator has order exactly five.
At z it has order one, because z is a simple branch point and
A(a)=0. Its pole at O has order six. Therefore
\[
\operatorname{div}(r)=z+4O-5P,\qquad
\operatorname{div}(\sigma\text{ in }\omega_Y^{-2}(5P))=z.
\tag{13}
\]
In particular 5P-z is linearly equivalent to 2K=4O.
For P_- replace A by -A. The residual zero is the same z.
Both points P_\pm are disjoint from z, which is fixed by the
hyperelliptic involution.

In the coordinate x, the coefficient of sigma as a rational
weight-minus-two tensor is
\[
g=\frac{f(x)(v+A(x))}{(x-t)^5}.
\]
Its square has numerator
f^3+f^2A^2+2Av^5. The last term has zero Cartier image since
deg A=3. Let x_1 be the x-coordinate on Y^(1). Extraction of
the coefficients in degrees 5j+4 gives the exact identity
\[
\sum_{j=0}^2[x^{5j+4}](f^3+f^2A^2)x_1^j
 =(a+1)(x_1-t^5)^2.
\tag{14}
\]
Thus the RELATIVE duality norm, with the normalization (5), is
the constant a+1 after division by (x_1-t^5)^2. As a section
of O(2y), this nonzero constant has divisor exactly 2y.
The denominator uses t^5=a, not t. This distinction is necessary.

The primitive inclusion is saturated: its adjoint has one
simple zero z, and a simple zero gives a unit coefficient in
the local Frobenius basis. Elsewhere its adjoint coefficient
is a unit. Finally
\[
\lambda=a^2+3a+3,\qquad \lambda^2(a+1)=-1.
\tag{15}
\]
Equations (6) and (15) construct both actual planes over F125
for each of the two points y_\pm. Their degeneracy points differ,
so the two orthogonal pairs cannot coincide.

The Wronskian description in Section 2 also identifies the
primitive adjoint zero with the determinant defect in the
canonical Frobenius filtration. For rank two and degree one
the graded defects D_1<=D_2 have total degree one. Hence
D_1=0 and D_2=z, proving precisely (4).

## 5. The six Weierstrass points do not survive

For a Weierstrass point W, K=2W gives
omega_Y^(-2)(5W)=O(W), with one-dimensional section space.
Its unique primitive section has quadratic norm corresponding
to Cartier of the regular differential with divisor 2W.
The required norm divisor is 2F(W) exactly when this differential
line is a Cartier eigenline.

The established
[backup arithmetic](../curve_arithmetic/backup_curve_arithmetic.md)
excludes all six such eigenlines. The new certificate also checks
this directly using the relative coefficient rows of
f^2 and (x-b)f^2 for b=0,1,2,3,a. At every point the norm is
NONZERO, since Y is ordinary, but its divisor is not 2F(W).
It would be incorrect to discard these points by asserting
that their quadratic norm vanishes.

Together with (9), this proves completeness: two eligible primitive
line images, and exactly four nonisotropic degree-one planes.

## 6. Verification and scope

The [independent audit](../../Research/audits/BACKUP_DEGREE_ONE_PRIMITIVE_LINES_AUDIT_2026_09_22.md)
checks the complete geometric locus, all relative twists, saturation and
the first-Frobenius filtration. The [author certificate builder](../../scripts/genus_two/backup_degree_one_primitive_lines.py)
and [independent standard-library verifier](../../scripts/genus_two/verify_backup_degree_one_primitive_lines.py)
reconstruct the finite arithmetic by different Taylor formulas. Their
[author receipt](../../../litt3-computation-data/backup_degree_one_primitive_20260922/certificate.json)
and [independent receipt](../../../litt3-computation-data/backup_degree_one_primitive_20260922/independent_verification.json)
are retained outside the repository.

This counts embedded geometric subbundles, without asserting reducedness
of a parameter scheme. In an actual radical-orbit span of rank two,
nonisotropic and degree one downstairs, the descended backup bundle must
be one of these four. The later [orbit constraints](../../Theorems/cartier_and_spin/backup_degree_one_orbit_constraints.md)
still requires all actual conjugate X-maps and their radical lines.
No actual common cover or exclusion is supplied by this classification.

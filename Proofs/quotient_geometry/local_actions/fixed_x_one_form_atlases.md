# Proof: every one-form orbifold quotient is trivial

[Statement](../../../Theorems/quotient_geometry/local_actions/fixed_x_one_form_atlases.md).
Version2,22September2026. The argument has independent
[global](../../../Research/audits/ONE_FORM_GLOBAL_INDEPENDENT_2026_09_22.md) and
[local](../../../Research/audits/ONE_FORM_LOCAL_INDEPENDENT_2026_09_22.md) audits,
including reconstruction of the exact matrix.

## 1. Principal parts and Frobenius

Let C be a smooth proper curve in characteristic p, and suppose the
image of Cartier in H0(C,omega_C) surjects onto the length-m jets at P.
There is no nonconstant A with dA regular and poles at most pmP.

Indeed every negative Laurent exponent of A is divisible by p. Take
the unique pth root b of its principal part; b has poles at most mP.
Its connecting class alpha in H1(C,O_C) is killed by Frobenius, since
b^p is the principal part of the global A. By Serre duality, ker F
annihilates im Cartier. The principal-parts pairing is the residue
pairing with length-m jets. Surjectivity of those jets therefore
forces b=0. Hence A has no pole and is constant. This argument keeps
the Frobenius semilinearity; it never identifies Cartier with a
k-linear endomorphism.

Equivalently, one can first infer alpha=0 from the same pairing.
Then b is the principal part of a global B with poles at most mP,
and A-B^p is constant. The asserted conclusion needed below is
dA=0; jet surjectivity also excludes such a nonconstant B.

For fixed X, put theta=dx/y^2, with div theta=16O. The ordinary
six-space is spanned by x^i dx/y, i=0,1,2, together with b_j(x)theta,
j=0,1,2. The three b_j are the columns of M^[5], where
M_(i,j)=(P^3)_(5i+4-j). In the standard F25 code their rows are
\[
b_0=(1,24,1,13,24,18),\quad
b_1=(19,11,20,17,14,7),\quad
b_2=(21,6,10,13,23,22).
\]
The exact calculation gives gcd(P,b0,b1,b2)=1, and their degree-five
coefficients are18,7,22, all nonzero.

Away from the cubic branch points and O, dx/y is a unit and its ratio
with x dx/y is the separating parameter x. At a finite cubic branch,
dx/y has a simple zero, while some b_j theta is a unit by the gcd
calculation. At O, x^2 dx/y is a unit and b_0 theta has a simple zero.
These pairs prove surjectivity onto the two-jets at every point.
The preceding argument with p=5,m=2 excludes a one-pole regular
primitive of order at most ten.

## 2. Signatures supporting a one-form

The [all-orbifold theorem](fixed_x_orbifold_bound.md) already excludes
two wild branch values. At a tame branch, a differential downstairs
cannot have a pole if its pullback is regular. Thus a nonzero such
differential on rational coarse space requires one wild value with
delta/e>=2; put it at infinity.

In fact delta/e<3. Otherwise both dA and A dA are regular and exact
on X. Their beta pairing is Cartier(A^2 dA)=0, since
A^2 dA=d(A^3/3). This contradicts the nonzero double-Cartier pairing
of EVERY independent pair in the fixed three-space, established by
the [Cartier--Petri calculation](../../cartier_and_spin/cartier_petri_excess_one.md).
The space of descended regular forms is therefore exactly k dA.

If there is a tame branch as well, the degree n is at most32. Put
b=delta-2e. Riemann--Hurwitz and the positive ramification groups give
\[
16=(n/e)b+\sum_i n(1-1/m_i),\qquad
0\le b<e,\qquad e+b\equiv3\pmod4.
\]
Here 5 divides e divides n, and each tame m_i divides n. Except for
n=25, which has no tame divisor, the wild subgroup has order five.
Writing e=5t and lower break j gives
\[
4j=e+b+1,\qquad 5\nmid j,\qquad t/\gcd(t,j)\mid4.
\]
The final divisibility is the faithful tame action on the first
ramification quotient; it does not presume a faithful conjugation
action on the entire cyclic wild subgroup.

The complete ranges n=5,10,15,20,25,30 and all tame profiles of cost
at most16 leave precisely
\[
(n,e,b;(m_i))=(10,10,1;(2,2,2)),\quad(15,5,2;(3)).
\]
The second has all eight zeros of dA of multiplicity two, excluded
by the fixed-X uniform-exact-form theorem. The first has exactly one
pole of order ten, excluded by Section1. This eliminates every case
with an additional tame branch, including b=0 possibilities.

With only the wild branch, dA has uniform positive zero multiplicity
b. The fixed-X theorem forces b=1; hence n/e=16. The simple-form
contact bound gives n<=160, so e is5 or10. The same congruence
e+b=3 modulo4 excludes5. Thus n=160,e=10,delta=21, and j=3.
The order-two tame factor acts nontrivially on C5 because j is odd;
the local group is D10.

## 3. Indecomposability

Pass to the Galois closure W of the ACTUAL orbifold atlas, with group
G and point stabilizer H. Suppose H<K<G. The intermediate smooth
curve W/K has genus zero by simplicity of J(X) and separable
Riemann--Hurwitz: any positive-genus intermediate curve would already
equal X.

Because W->X is etale, X=[W/H] maps representably and etale to [W/K].
This is an effective orbifold with rational coarse curve. The original
one-form dA descends through it: on W it is regular and G-invariant,
hence K-invariant. Section2, which did not use indecomposability,
forces [K:H]=160. This contradicts [G:H]=160 and K<G. Consequently H
is maximal and the coarse map is indecomposable. This uses the actual
orbifold intermediate, not a supposed one-pole polynomial factorization.

## 4. The cubic automorphism preserves the quotient

Let R be the reduced fiber relation of A in X times X. Its normalized
projections are etale and have total degree160. The exact form omega
has simple zeros, and gamma*omega=zeta3 omega. Therefore both R and
gamma R gamma^-1 preserve omega. The
[reduced-union contact bound](../../shared_tensors/contact_degree_bound.md)
bounds their UNION by160 as well. Since R already has that degree,
the relations are equal. Thus gamma preserves their fixed field k(A).

The infinity fiber D is gamma-invariant. On its coarse rational curve
gamma consequently acts affinely, and differentiation gives
gamma*A=zeta3 A+c. Translating A removes c. This is an actual field
invariance statement; averaging an arbitrary primitive by gamma
would not have preserved local normality and was not used.

## 5. Two necessary local invariants

Let A on a completed disc have pole order ten and let dA have a simple
zero. Choose a regular primitive q of dA with q(0)=0 and write
q=z^2/2. Then
\[
A=z^2/2+B(z)^5,\qquad B(z)=c z^{-2}+b z^{-1}+O(1),\quad c\ne0.
\]
For an isomorphism of two such extensions over the SAME field k((1/A)),
the two coordinates satisfy z_2=z_1 or -z_1 modulo z_1^4. Indeed their
squares differ by a fifth power of positive order. The corresponding
B's differ by a series of positive order. Thus c is an invariant of
the fixed-base extension, independent of the primitive and sign choice.
All sixteen c's of an atlas must therefore be one common scalar.

If the extension is D10-Galois, its tame involution has
z->-z+O(z^4). Invariance of A says that B(-z+O(z^4))-B(z) is regular.
Its possible pole is -2b/z, so b=0. These are NECESSARY conditions;
their sufficiency is neither needed nor asserted.

Here is the same b-condition in a separating coordinate x at a zero
lambda of h. Write omega=h dx/y^2 and put w=h/y^2. If
G=r/(h^2 y), then the polar part of B equals that of G. With
rho^2=w'(lambda), the coordinate change starts
\[
z=\rho (x-\lambda)\left(1+\frac{[ (x-\lambda)^2]w}{3w'(\lambda)}
(x-\lambda)+O((x-\lambda)^2)\right).
\]
Expansion of G in z gives
\[
c=\frac{r(\lambda)}{P(\lambda)h'(\lambda)},\qquad
b=0\ \Longleftrightarrow\
\frac{r'}r=4\frac{h''}{h'}+3\frac{P'}P\quad\text{at }\lambda.
\tag{1}
\]
All denominators in (1) are nonzero in the proposed atlas. The
coefficients4,3 retain the characteristic-five coordinate correction;
they are not obtained by setting the original coordinate equal to z.

## 6. All cubic-equivariant primitives

Scale A so that h is monic of degree five, and write
\[
h=u h_0+v h_1+h_2,\qquad U^5=u,\quad V^5=v.
\]
Here [n0+5n1]=n0+n1 a, with a^2=a+3, and
\[
h_0=[24]+2x+x^2,\quad h_1=[5]+[16]x+x^3,\quad
h_2=[5]+[20]x+[8]x^4+x^5.
\]
Let J_i be the polynomial primitive J_i'=h_iP with every coefficient
in a degree divisible by five set to zero, and put J_h=uJ_0+vJ_1+J_2.
Since d(J_h/y^5)=omega, the normalized cubic character gives
\[
A=\frac{J_h}{y^5}+\left(\frac{r}{h^2y}\right)^5,
\qquad r\in k[x],\quad\deg r\le14.                 \tag{2}
\]
For completeness, the fifth root of A-J_h/y^5 has cubic character
zeta3^2. Multiplying it by h^2 y gives a rational function in x,
regular at all finite points. At infinity its pole order is at most42,
so its polynomial degree is at most14. This proves completeness of(2).

Let R_i be the unique element of k[x]/P with R_i^5=J_i modulo P.
Regularity at the ten cubic branch points says
\[
r\equiv r_0:=-h^2(UR_0+VR_1+R_2)\pmod P.            \tag{3}
\]
The derivative of J_h h^10+r^5 is P h^11, so vanishing modulo P
already gives the order-two numerator vanishing required there.
Consequently every possible r is r_0+Ps with deg s<=4.

Let t be the degree-at-most-four remainder of r_0/P modulo h. Equality
of the finite leading invariants in(1) gives
\[
s=c h'-t.                                          \tag{4}
\]
At infinity use z_0=x^3/y. Then omega=2z_0 dz_0+O(z_0^4) and
r/(h^2y)=r_{14}z_0^{-2}+O(z_0). Hence its canonical leading invariant
is c=2r_{14}. As deg h'<=3, equations(3)--(4) give
\[
c=-2t_4,\qquad r=r_0+P(-2t_4h'-t).                 \tag{5}
\]
Thus all sixteen leading invariants determine the primitive uniquely
from h. No arbitrary choices of its five free correction parameters
remain.

The remaining necessary b=0 equations at the five finite x-values are
the five coefficients of
\[
\mathcal N(r,c):=
\left(h'r'-c(4Ph'h''+3P'(h')^2)\right)\bmod h=0.   \tag{6}
\]
This calculation needs neither the constant local invariant nor a
classification of primitive monodromy groups.

## 7. An exact rank certificate over the whole algebraic closure

All operations here take place over F25[u,v]. Let M be the matrix
of multiplication by P in the free rank-five algebra F25[u,v][x]/h,
and set D=det M. On the admissible locus D and disc(h) are nonzero.
For i=0,1,2 put
\[
r_{0,i}=(-h^2R_i)\bmod P,\qquad
t_i^{\rm num}=\operatorname{adj}(M)(r_{0,i}\bmod h),
\]
where a coefficient vector is identified with its degree-four
polynomial. Define c_i^num=-2[t_i^num]_4 and
\[
r_i^{\rm num}=D r_{0,i}+P(c_i^{\rm num}h'-t_i^{\rm num}).
\]
Apply(6) to these numerator pairs. Its coefficients form a 5-by-3
polynomial matrix N. For the actual h, equation(6) would force
\[
N(u,v)(U,V,1)^{\mathsf t}=0.                         \tag{7}
\]
The inverse-Frobenius coordinates have been retained; we will prove
the stronger assertion that N has no nonzero kernel vector at all.

The exact certificate supplies ten polynomials a_I, one for each
three-row subset I, with the identity
\[
\boxed{\quad
\sum_{|I|=3}a_I\det(N_I)=[14]D^4\operatorname{disc}(h).
\quad}                                             \tag{8}
\]
Here [14]=4+2a is nonzero in F25. Matrix entries have total degree
at most18, the multipliers degree21, and the nonzero right side has
degree47. Thus N has rank three whenever P and h are coprime and h
is squarefree. This contradicts(7) over EVERY algebraically closed
extension, not just over the coefficient field.

The [reconstruction source](../../../scripts/arithmetic/degree160_symbolic_normality.py)
recomputes J_i,R_i,M,N from the fixed curve and checks(8). The
[46,265-byte coefficient certificate](../../../../litt3-computation-data/regular_primitive_20260922/normality_identity.json)
is also checked by a separate
[standard-library verifier](../../../scripts/arithmetic/verify_degree160_normality_identity.py),
using only exact sparse-polynomial arithmetic over F25. Its
[executed result](../../../../litt3-computation-data/regular_primitive_20260922/identity_verification.json)
uses no Groebner basis or point sampling. An independent
[geometric reconstruction](../../../scripts/arithmetic/verify_degree160_geometric_matrix.py)
also rebuilds every matrix coefficient from P and the three h_i;
its [receipt](../../../../litt3-computation-data/regular_primitive_20260922/independent_geometric_verification.json)
checks the inverse-Frobenius roots and the two determinants as well.
The earlier
[small signature receipt](../../../../litt3-computation-data/regular_primitive_20260922/certificate.json)
retains the independent finite input checks. Its primitive-group
diagnostic is not used in this proof.

Equation(8) excludes the last degree160 atlas. Finally, if the coarse
curve of any one-form quotient has positive genus, simplicity of J(X)
and separable Riemann--Hurwitz make its genus nine and its degree one.
The representable degree-one etale atlas is then an isomorphism.
Every one-form orbifold quotient is therefore trivial.

This does not manufacture a shared one-form on an arbitrary span.
Neither original unmarked common-cover problem is resolved here.

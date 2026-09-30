# Proof: norms, simultaneous cubic symmetry, and actual reconstruction

The [recognition certificate suite](../../scripts/arithmetic/pro_coreless_20260923/recognition/run_all.py)
reconstructs the finite cases below.
The proof below states the geometric arguments and exactly what the finite
certificate proves. The input normal form and cored recognition are used
as established; no simultaneous Galois closure of a coreless span is assumed.

## Norm, local contact, and primitive generation

In the characteristic polynomial of z over K_1, its j-th coefficient
is a section of O_X(min(j,d)O). Indeed, at any finite point z is
integral on every branch; over O its only poles are the d simple poles
in D_1-E. The norm has divisor h_{1*}(D_2-E)-dO, with a nonzero
zero divisor supported on the finite part of R. Thus d is a positive
nongap at O. The pole semigroup is <3,10>, from the affine basis
x^i y^j with0<=j<=2 and pole weights3i+10j.

At O take x=t^{-3}, y=t^{-10}V(t^3). The tensor has form
C t^{16}(1+O(t^3))(dt)^{13}. At a point of E, write the second
parameter beta t+beta_2 t^2+... in the first parameter. Tensor comparison
gives beta^{29}=kappa^5 and (16+26) beta_2=0. Since42!=0 in
characteristic five, beta_2=0. The A and theta comparisons then give
z(P)^29=kappa^18 and ord(z-z(P))>=2. At most29 fibers of the
degree-d map z contain E, and each contains at most floor(d/2)
such points. Hence n-d<=29 floor(d/2).

Let L=K_1(z). Take the finite normal closure W/L of M/L; it is
etale over T and its smooth proper model is allowed. An automorphism
sigma over L fixes A_2=kappa^6 z^{-13}A_1 and the actual tensor.
The K_2 and sigma K_2 comparisons have the nonconstant common function
A_2, so cored recognition identifies their fields. The induced cubic
automorphism of X must fix its tensor exactly and is therefore trivial.
It follows that K_2 is fixed pointwise, hence M=L. Exchange the two
maps for the other equality.

Put N=k(x_1,x_2) and a_0=dx_2/dx_1. The normal form and y_i^3=P(x_i)
give, by eliminating the coprime powers,
\[
z=\kappa^{-3}a_0^9(P(x_1)/P(x_2))^6(A_2/A_1)^{11},
\quad y_2/y_1=\kappa^{-7}z^{16}a_0^{-1}P(x_2)/P(x_1).
\]
Thus both lie in N and M=N(y_1) has degree one or three over N.

## The quotient when d<10

Every coefficient of the minimal polynomial of z over K_1 is then
a polynomial in x_1 of degree at most floor(min(j,d)/3). It is
irreducible over k(x_1), so [k(x_1,z):k(x_1)]=n and
M/k(x_1,z) is cyclic of degree three. Its generator fixes z and
scales y_1; theta recognition forces it to scale y_2 in the same
way and to fix x_2. Hence N=k(x_1,z)=k(x_2,z).

The minimal polynomial has Newton polygon contained in
0<=ell<=m, j>=0, 3ell+j<=n, where m=d/3. Counting its interior
lattice points bounds the genus of the normalization by
(m-1)(n-1)-3m(m-1)/2. Comparing ramification in the commuting
cubic diagrams gives indices one or three for r_i, with branch
values among the eleven branch points of X->P1. For d=3 the
quotient is rational and, using z as its coordinate,
\[
(r_1)_\infty=3\infty+\sum q_j,\qquad
(r_2)_\infty=3\cdot0+\sum q_j,
\quad q_j^{29}=\kappa^{18}.
\]
There are n-3 common poles. This improves the general d=3 bound
to n<=32. The values r_1(0),r_2(infty) are roots of A.

## The complete low-degree exclusion

Degrees one and two follow from the semigroup condition. At n=3,
d=3, both degree-three rational quotient maps have two totally
ramified points, hence are cubic power maps up to Mobius changes.
The two X-legs are Galois and cored recognition applies.

For n=4, normalize the common pole to1. Every degree-four rational
map with poles3infty+1 and only triple ramification has form
\[
r(v)=c+mL(t/(1-v)),\qquad
L(T)=(T^4+3T^2+3)/(3T^3).
\]
Its two finite critical values c+m,c-m are distinct roots of P.
The condition r(0)=rho, a root of A, gives
t^4-3((rho-c)/m)t^3+3t^2+3=0. There are45*4*4=720
geometric candidates. The degree-four verifier splits P and A in
K=F25[b]/(b^4+[7]b^3+[6]b^2+[2]b+[5]). The quartic in t
has nonzero square discriminant2(s^2-1)^2, so its Frobenius
permutation is even. Its roots all lie in K, its quadratic extension,
or its cubic extension; these cases are exhausted, not sampled.
The monic degree15 polynomials proportional to
(1-v)^4 A(r(v))/v never match a reversed polynomial from another
candidate. This is exactly the necessary A-comparison. Counts
152,360,512 in the three fields give720 distinct candidates and
zero matches, with intersections identified over K.

For n=5 the two common poles have ratio a primitive29th root.
After normalizing them to0,1, the extra marked value is
t=1/(1-rho) with [K(t):K]=7. Every relevant rational map is
mF_ell(s)+c, where
\[
F_\ell=2s^3+(\ell-1)s^2+(\ell^2-2\ell-1)s
-\ell^2/s-(\ell-1)^2/(s-1),\quad\ell\notin\{0,1,-2\}.
\]
Its derivative is the square of
(s^3+(ell-2)s^2-ell s+ell)/(s(s-1)). The three distinct finite
critical values belong to K. For the centered critical-value cubic,
\[
p_\ell=2(\ell+2)^4(\ell^2-\ell+1),\quad
q_\ell=-2(\ell+2)^5(\ell^4-2\ell^3-\ell^2+2\ell-2).
\]
Writing nu=ell(1-ell), the known ratio p_*^3/q_*^2 is
-2(nu+1)(1-nu)^3/(nu^2+2nu-2)^2. Thus the coefficients of r
belong to an extension L/K of degree not divisible by7. The cases
p_*=0 or q_*=0 have the same property by their displayed quadratic
or quartic equations. But r(t) is a root of A in K, giving a
nonzero degree-five equation for t over L. This contradicts the
embedded degree-seven subextension. The symbolic certificate checks
these identities, including the exceptional cases' factors.

## The exact d=3 decision system

Rescale z by one common pole, calling the new coordinate s. The
common poles form a subset of mu_29 and D divides s^29-1.
The poles give r_1=F/D and r_2=G/(s^3D). Their derivatives are
squares with simple ramification zeros, giving the two B_i equations
in the statement. Triple roots of P(r_i) are exactly the B_i
factors. Removing them leaves squarefree J_i of degree7n+6.
Since P(r_2)/P(r_1) is a cube, J_2/J_1 is a cube; two squarefree
polynomials with that property have the same zero divisor. This
proves necessity of every identity and open condition.

Conversely normalize w^3=D^2J. It is connected and branched at
(n-3)+(7n+6)=8n+3 points; infinity is unramified since
deg(D^2J)=9n. Its genus is8n+1. The two displayed function pairs
satisfy y_i^3=P(x_i); their maps to X have degree n and are
separable by the derivative equations. Riemann--Hurwitz gives zero
degree for each effective different divisor, proving etaleness at
EVERY point. Direct calculation gives
\[
\theta_1=m_1D^6 ds/w^2,\qquad
\theta_2=m_2\rho^{-2}s^{16}D^6 ds/w^2.
\]
The A identity implies tensor proportionality. Moreover
s^{13}=alpha A_1/A_2 and
s^{48}=beta^{-3}(dx_2/dx_1)^3(P(x_1)/P(x_2))^2 belong to
k(x_1,x_2), where beta=m_2/(m_1 rho^2). Their coprime exponents
recover s, then y_1 recovers w. The source is jointly minimal.
The fields differ because their x-functions have different triple
poles, whereas every automorphism of X fixes x. They are coreless
by the established cored theorem. This is a conditional construction
from a COMPLETE solution, not an assertion that one exists.

For n=6 the common-pole triples have126 rotation and70 dihedral
classes. For a fixed D with roots q_i, write
B/D=a s+b+sum u_j/(s-q_j). Integrability of its square imposes
a q_i+b+sum_{j!=i}u_j/(q_i-q_j)=0. These three independent
linear equations leave a two-dimensional B-space, hence one shape
parameter up to scale. The follow-up below now excludes the entire
degree-six system.

## The degree-six system is empty

The [reproduction entry point](../../scripts/arithmetic/pro_reconstruction_20260924/degree6/reproduce.py)
generates the exact witnesses for all 4,480 cases and runs the
[independent verifier](../../scripts/arithmetic/pro_reconstruction_20260924/degree6/verify_certificate.py).
The reduction and the certificate's algebraic meaning are as follows.

At a simple common pole q the zero-residue conditions are
\[
2D'(q)B_1'(q)-D''(q)B_1(q)=0,\qquad
2qD'(q)B_2'(q)-(4D'(q)+qD''(q))B_2(q)=0.
\]
Each defines a two-dimensional space of polynomials of degree at
most four. The quartic identity gives
(B_2(q)/B_1(q))^8=alpha(m_1/m_2)^4 q^3.
Since q^29=1, normalize B_2 so that alpha=(m_2/m_1)^4 and
B_2(q_i)=xi_i q_i^4 B_1(q_i), with xi_1=1 and xi_i^8=1.
These are exactly 64 choices for each of 70 dihedral layouts.
Every linear comparison has rank three and a one-dimensional
kernel; all required values are units.

Absorb the common scale in m_1,m_2 and use the certified pair
b_1,b_2 with exact integrals N_1/D, N_2/(s^3D). Put
h=-A_3/(4A_4)=A_3/A_4. Every bounded integral has the form
\[
F=hD+m_1(N_1+t_1D),\quad
G=hs^3D+m_2(N_2+t_2s^3D).
\]
There is no extra nonconstant fifth-power integral with these pole
bounds. Centering A removes its cubic term. Modulo D^2 the first
identity becomes s(N_2+t_2s^3D)^4-(N_1+t_1D)^4=0.
In k[s]/D this is E_0+t_1E_1+t_2E_2=0. In every case the data
give a row w with wE_0=1 and wE_1=wE_2=0. This unit-ideal
identity survives arbitrary field extension and nilpotent parameters.

The certificate field has characteristic five and degree 14, defined
by the ascending polynomial row
(1,2,4,0,4,4,3,1,3,4,4,0,4,2,1).
Its generator has order 29; ord_29(5)=14 proves irreducibility.
All eighth roots are present. Unknown translations and scales still
range over the entire algebraic closure. All divisions used units
from the prescribed opens. No coefficient of P or of the centered
quartic other than its leading term enters this contradiction.

## A residue argument excludes degrees 27 through 32

This continuation needs only the second square-derivative identity,
exact degrees and nonvanishing at common poles. Put m=n-3,
C=(s^29-1)/D and k=deg C=32-n. Suppose 0<=k<=5, and set
E=CB_2, of degree 30.

At each root q of D the zero-residue condition gives
B_2'/B_2=2/q+D''/(2D'). From DC=s^29-1 one obtains
D''/D'=3/q-2C'/C. In characteristic five this says
(CB_2)'/(CB_2)=1/q. Therefore
\[
V=sE'-E=DQ,\qquad \deg V=30,\quad\deg Q=k+1.
\]
The degree equality uses 30-1=29 nonzero in the field. Divide
Q=C(as+b)+R, with deg R<k (R=0 when k=0). Then
V=(s^29-1)(as+b)+DR.

Every coefficient of V in a degree congruent to one modulo five
vanishes. In particular DR has zero coefficients in degrees
6,11,16,21,26. For j<29 these are the negatives of the
coefficients of R/C at zero. Write
R/C=sum_i u_i/(s-rho_i), where rho_i are the k distinct roots
of C. The five conditions are
\[
\sum_i u_i\rho_i^{-7}(\rho_i^{-5})^r=0
\quad(r=0,1,2,3,4).
\]
For k<=5 the first k equations give an invertible Vandermonde
matrix. Thus every u_i is zero, and R=0. The coefficient of s
in V is now -a, which must also vanish. This forces deg V<=29,
a contradiction. Hence n=27..32 is impossible for d=3.
The next certificate excludes the intervening degrees 7..26 as well.
The separate d=6 branch at covering degree six is unaffected.

## Complete exclusion of degrees 7 through 26

The [reproduction entry point](../../scripts/arithmetic/pro_rational_rankdrop_20260924/rational/reproduce.py)
generates and independently verifies the remaining d=3 certificates.
Here write m=n-3 for the number
of common poles, to distinguish it from the comparison pole degree d=3.

At every root q of D the necessary equations are the two linear
residue conditions already displayed, followed by
B_2(q)^8=K q^3 B_1(q)^8 with K nonzero. Scaling B_2 normalizes K=1.
Write B_2(q)=xi_q q^4 B_1(q), xi_q^8=1, and normalize one xi to one.
The polynomials B_i may now have degree at most m+1; neither their
squarefreeness nor the full P-equations are used.

The residue matrices for each B_i have m rows and m+2 columns.
Every allowed pole layout has rank m, so both kernels have dimension
two. After choosing bases, the values at the first three poles give
a 3-by-4 matrix for each of 64 choices of the two remaining phases.
Every such matrix has rank three. Its signed maximal minors give
a nonzero kernel vector v, so over ANY field extension every
solution of these first three conditions is tv.

The retained witness for each case is either a required pole value
which vanishes on v, or a pole q for which
H_q(v)=B_2(q;v)^8-q^3B_1(q;v)^8 is nonzero. The former violates
the open condition identically; the latter forces t^8=0 and has
no point on that open. This excludes nonreduced open components too:
after quotienting by the three linear equations, localization at a
required nonzero pole value kills the ring. The returned proof also
gives explicit difference-of-eighth-powers unit identities recovering
expanded ideal certificates from each compact witness.

Coverage uses only symmetries of this NECESSARY system. Multiplying
all poles by a 29th root and applying coefficient Frobenius preserve
the residue and eighth-power equations. Their action on exponent
subsets is i -> 5^t i+b modulo29, of order406. This does not assert
that Frobenius preserves the original nonscalar coefficients of A
or P. Every record is checked as a canonical orbit representative;
all 406 images are inspected, the stabilizer counted, and orbit sizes
sum to binomial(29,m). Thus no unexamined layout is inferred merely
from the enumeration routine.

The arithmetic field is F25[q]/R(q), where
R=(4,21,6,5,9,8,20,1). It is a degree-seven factor of the
29th cyclotomic polynomial; ord_29(25)=7 proves irreducibility.
This field contains the matrix entries and all phases. It is not
a bound on the unknown coefficients, which remain in the algebraic
closure by the kernel argument.

All 1,324,308 layouts and 84,755,712 cases passed the complete local
verification. There are 84,755,000 eighth-power contradictions and
712 forbidden pole zeros. The full verifier reconstructs residue
spaces through independent partial fractions:
\[
B_1/D=a+bs+\sum_i t_i/(s-q_i),\qquad
B_2/(s^2D)=A/s^2+B/s+\sum_i u_i/(s-q_i).
\]
The zero constant Laurent coefficients give Cauchy matrices with
extra columns (1,q_i) and (q_i^-2,q_i^-1). Their kernels recover
exactly the same polynomial spaces, with evaluations t_iD'(q_i)
and q_i^2u_iD'(q_i). The complete independent replay, field
cross-check and separately labeled bounded Python audit passed on the
retained original data. The published
[source](../../scripts/arithmetic/pro_rational_rankdrop_20260924/README.md)
generates fresh exact witnesses and counts.

Combining with the previous low-degree and n>=27 arguments excludes
every d=3 comparison. The next case is d=n=6, whose degree-two
simultaneous quotient can have genus zero, one or two; it is not
part of this degree-one quotient calculation.

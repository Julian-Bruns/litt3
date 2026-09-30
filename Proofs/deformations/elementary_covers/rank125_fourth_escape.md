# Proof: reference-relative W4 escape and an affine fifth obstruction

Version7, 2026-09-15. This proof retains the uniform reference-relative
construction, complete relative image and actual affine support theorem.
Numerical fifth and later comparisons have their own canonical proofs.
The polynomial Witt argument is stated once in Section9; Section11
uses it together with the general chart bound and whole-primitive lemma.

## 1. Actual comparison and the two fixed regular coefficients

Use the geometry and normalizations in the
[quadratic-channel proof](fourth_hodge_quadratic_channel.md)
and [integral oper calculus](../integral_oper_calculus.md).
In the transported scalar coordinates the complete obstruction is

    E4(H)=Q(H)-[f_hat H_hat/5]+D_regular(H) in R/(f), H in K.

The whole integral product is formed before division. D_regular is
the actual fixed mixed-additive deck-equivariant correction and
preserves every J^d. Through degree five its possible terms lie in
RH+R Phi^-1(H)+R Phi(H). No higher unknown regular term is dropped.
Indeed the moving curve starts at flat weight25 and its first
Hodge graph at weight5. A second curve displacement or quadratic
Taylor displacement reaches weight125 after Frobenius division, so
the only surviving quadratic term is the complete \(Q\). Linear
first-graph and source operations are deck-equivariant on the free
descended reference lattices; after the stated coefficient
transport they give precisely the regular terms above. The
preceding scalar enters the graded connection with an additional
weight25 and contributes nothing at this precision. For the linear
primary numerator, apply the integral normal projection *before*
division: it kills the whole boundary primitive. Ordered
ordinary-block elimination then leaves \(-\widehat f\widehat H/5\)
modulo \(f\). Changing an integral Schur lift adds a regular term
or an \(f\)-multiple. Compatibility of the fixed reference gives
\(E_4(0)=0\).
The actual quadratic filtration is Q(K_i,K_j) subset J^(i+j-9) in
the relevant range, and J8 subset(f).

Use the completed RREF basis nu0,...,nu42 of K. Order columns first by
(014),(104),(113),(203), then by total degree and lexicographic order.
Order rows by pivots. The leading-degree blocks are

    5:0..3; 6:4..9; 7:10..17; 8:18..26;
    9:27..33; 10:34..38; 11:39..41; 12:42.

All vectors are actual full kernel completions. The normal form in
R/(f) is obtained by reducing the rows f*s^e in increasing total
degree/lex order. Its degree-five monomials are
(041),(131),(140),(221),(230),(311),(320),(410), and its degree-seven
monomials m0,...,m3 are (241),(331),(340),(430).

Set B0=[101]nu1+[14]nu2 and h=(B0)5. Exact reconstruction gives

    h=q2*([45]s1*s3²+[41]s1*s2*s3+[91]s1*s2²+[58]s1³).

Thus [h]5=0 in the associated quotient. The two transported classes are

    v_minus=[Phi^-1(h)]5=(0,16,115,0,0,19,108,0),
    v_plus =[Phi(h)]5  =(0,62,15,0,0,10,29,0),

in field-code notation. Their independence minor is[99]. Therefore
the actual degree-five regular correction uniquely defines alpha,beta:

    [D_regular(B0)]5=alpha*v_minus+beta*v_plus.

Every later seed differs from B0 by J7, so its degree-five regular
correction is the same, even if D_regular is not k-linear. A change
of integral scalar lift adds gH to the divided comparison; in degree
five this is a multiple of h and hence zero in the quotient. Remaining
unknown degree-seven terms will be retained as an actual residual.

## 2. An odd seed solves all lower output degrees

Define, in the actual fixed alpha,beta,

    b12=[34]+[64]alpha+[12]beta,
    b15=[6]+[111]alpha+[93]beta,
    b16=[15]+[100]alpha+[42]beta,
    b11=[103]-[34]b12,
    p=[55]alpha²+[123]alpha*beta+[59]beta²
      +[90]alpha+[81]beta+[124],

and put

    H_A=[101]nu1+[14]nu2+b11*nu11+b12*nu12
        +b15*nu15+b16*nu16+p*nu27.

The independent coefficient calculation proves [E4(H_A)]<=5=0 as
an identity in k0[alpha,beta], not at finite-field test points. The
calculation uses the actual Q, NEGATIVE whole carry, and the fixed
regular term above. It includes the higher terms in every nu_i.

There is a genuine order-two symmetry, not a presumed lifted wild
deck action. The involution (u,kappa,y)->(u,kappa,-y) preserves the
theta divisor, actual square-trivial flat line and ordinary canonical
reference. It sends W to -W and D=v*d/du to -D. After the normalized
Schur column and coefficient transport, both scalar source and target
transform by H(s)->-H(-s). Thus odd H_A has an odd COMPLETE E4, including
all actual regular terms. Since f is even, there is no degree-six
obstruction. The residual is therefore

    E4(H_A)=omega0*m0+omega1*m1+omega2*m2+omega3*m3.

The omega_i are defined from this actual seed and actual comparison.
No numerical value or vanishing is assumed for them.

## 3. The exact universal terminal repair

For V in K9, Q(V,V) and D_regular(V) are in J9 subset(f).
The audited whole K8 comparison gives E4(V)=-C(q2*V9). The divided
product is additive and k-linear modulo(f): lifts of sums and scalar
multiples may be chosen compatibly, and changing a lift adds only an
f-multiple. Consequently

    E4(H+V)-E4(H)=2 Q(H,V)-C(q2*V9)=L_H(V).

This is an EXACT relative formula, not its first derivative. Moreover
L_(H+V0)=L_H for every V0 in K9, since Q(K9,K9)=0 in the quotient.

Take the completed odd vectors

    gamma0=[29]nu28+nu29,
    gamma1=[11]nu27+nu30,
    gamma2=[87]nu27+nu31,
    gamma3=nu32.

Set

    A=[64]+[67]alpha+[33]beta, B=[81]+[68]alpha+[50]beta,
    C=[2]+[38]alpha+[70]beta, D=[8]+[67]alpha+[33]beta,
    G=[42]+[14]alpha+[66]beta.

All four images vanish below degree seven. Their rows in m0,...,m3 are

    [57]  0  0  G
    0     A  B  0
    0     C  D  0
    0     0  0  [107].

Exact polynomial identities give AD-BC=[58] and determinant[44],
both nonzero CONSTANTS. The correct transpose-oriented solution is

    c0=omega0/[57],
    c1=(D*omega1-C*omega2)/[58],
    c2=(A*omega2-B*omega1)/[58],
    c3=(omega3-G*c0)/[107].

Then H*=H_A-sum c_i*gamma_i satisfies E4(H*)=0. This is noncircular:
first fix alpha,beta, then H_A, then its actual omega, then apply the
universal inverse. The relative operator stays fixed throughout this
K9 translate. The degree-five part remains h, with pivot coefficients
(0,[101],[14],0), so is nonzero.

Vanishing of the COMPLETE obstruction permits a primary preimage as
the terminal fourth source digit with rho(S+xi)=rho(S)-Psi(xi). Whole
regular primitives then give actual Hodge generators, prescribed
grading and twisted periodicity. This proves a genuine compatible W4
extension of the specified X3(H*), not only a zero of low equations.

For the fixed canonical reference, the separate
[actual comparison and proof](rank125_actual_fourth_reference.md)
now determine alpha=1,beta=0 and omega=(0,[57],[17],0).
The universal correction above then subtracts[81]gamma1+[97]gamma2.
Its explicit completed coefficients are those in the
statement, and an additional actual matrix comparison at that point
has zero full scalar obstruction. This specializes the universal
argument without discarding its reference-independent form.

## 4. The exact eight-dimensional fourth-compatible fiber

The parent calculation evaluates L_H_A on all sixteen K9 directions
coefficientwise over k0[alpha,beta]. Translation invariance identifies
this with L_H*.

The odd subspace has dimension10 (seven degree-nine and three
degree-eleven directions). Its image has only degrees five and seven.
The degree-five matrix is constant and has rank2. In the above
degree-five quotient order its only nonzero rows, for nu27,...,nu31,
are respectively

    (0,0,0,0,0,[37],[116],0),
    (0,0,0,0,0,0,0,[65]),
    (0,0,0,0,0,0,0,[118]),
    (0,0,0,0,0,[5],[17],0),
    (0,0,0,0,0,[44],[5],0).

The four gamma images, in the kernel of this low matrix, are
universally onto the four-dimensional degree-seven target by the
constant determinant already proved. Therefore the odd relative rank
is EXACTLY6 for every geometric alpha,beta, not merely generically.

The even K9 subspace has dimension6 (five degree-ten directions plus
the norm). Its relative matrix is constant and supported in degree6.
The only nonzero rows are

    L(nu34)=[62]*(420),
    L(nu35)=[10]*(321)+[9]*(330),
    L(nu36)=[58]*(321)+[10]*(330).

They have rank2. Images of nu37,nu38 and the norm nu42 vanish. The
whole K11 also has zero relative image in this particular family.
Odd and even targets are disjoint, so the total relative rank is8.
Its kernel has dimension16-8=8 for every actual reference value.

Since the relative formula is exact, the ENTIRE fibre in H*+K9 is

    Z4 intersect(H*+K9)=H*+ker L_H*,

an eight-dimensional affine scalar space. This result makes no claim
about any other third jets, any fifth obstruction, or scheme reducedness.

## 5. The complete relative fifth comparison

Apply the polarization consequence of
[integral oper calculus](../integral_oper_calculus.md), Section4,
to the WHOLE normal comparison. Its residue quadratic term is the
actual Q of the [quadratic-channel proof](fourth_hodge_quadratic_channel.md),
not a quadratic approximation to the primary symbol. The reference
has E4(0)=0, so its additive term is A4(V)=E4(V)-Q(V).

Here are the actual input identifications. Write the normalized
source variable as Y=X/5. A third direction H changes it by
-5*n(H), and its whole first graphs have weight5. Thus the
current input modulo25 is v0+5*h(H), where h(H) includes the
original transported source and signed whole graph pair.
A fourth direction V changes Y by -25*n(V), with primary graphs
of weight25. The whole primary equations make the complete first
variations of h(H) and h(V) divisible by5.

The actual current connections modulo25 agree with the reference:
their lower-left entries have factor25. The varying preceding
potential has no effect on either required relative coefficient,
by its two-power gain in the integral calculus. Higher old repairs
start in25 and do not affect the new derivative modulo25.
They remain in the absolute fifth comparison. Coefficient Frobenius
fixes5, so these are the original H,V transports, with no extra
Frobenius introduced by changing the digit.

The general polarization identity, with r=2, now gives

    E5(H;beta+V)-E5(H;beta)=A4(V)+2Q(H,V)=R_H(V).

This retains the complete additive term, including the whole
divided primary carry, and the complete polarized quadratic
term. It is independent of the compatible fourth origin because
that origin changes only higher background inputs at this precision.

On K9, A4(V)=-C(q2*V9), so the previously computed L_H is also
an actual relative fifth response. Its rank8 image is available
for fifth repairs. The full R_H is additive and can retain mixed
coefficient transports; it is not identified with a field-linear
Jacobian. The absolute fifth obstruction is its separate class
modulo R_H(K), with all43 fourth directions allowed.

## 6. The exact four-coordinate odd fifth quotient

Restrict the preceding eight-dimensional scalar escape fibre to odd
H. The odd K9 source has dimension10 and relative rank6, so the odd
fourth-compatible fibre F_odd is a nonempty affine space of dimension4.
Fix H in it, and write H=H_A+V0 with odd V0 in K9.

Both the odd source K_odd and odd target O_odd=(R/(f))_odd have
dimension22. In the target normal form, the degree-one coordinates are
(001),(010),(100), and the degree-three coordinates are
(021),(030),(111),(120),(201),(210),(300). The exact calculation
finds that the complete low relative image is annihilated by

    P5(E)=(E001,E010,E100,E030+[45]E021).

The identities hold coefficientwise over k0[alpha,beta] on all22 odd
kernel basis vectors. The low matrix has a constant six-by-six minor
[42], so its image is EXACTLY this six-dimensional subspace of the
ten-dimensional degree-one/three target, for all geometric reference
coefficients. D_regular starts in J5. Also replacing H_A by H changes
the relative map on K by 2Q(V0,K), in J5. Thus neither unknown actual
term affects these low equations or the minor.

It remains essential to show that all higher odd targets can be
repaired; a low-rank calculation alone would not give an iff criterion.
On the18-dimensional odd K7, the degree-three relative map is constant
of rank2. Its16-dimensional kernel is checked explicitly. The degree-five
map on that kernel has a constant eight-by-eight minor[104], hence is
onto all eight degree-five coordinates. On K7 the actual regular term
lies in odd J7, and the change 2Q(V0,K7) lies in J7 too. These may alter
the degree-seven tail but not this computed degree-five map. For any
desired degree-five vector, choose a source by the constant minor and
then cancel its ACTUAL degree-seven tail using the four gamma directions.
Their universal matrix remains unchanged at H and includes all four
degree-seven coordinates. This proves

    (J5/(f))_odd subset R_H(K_odd).

Now solve any allowable six-dimensional low vector using the constant
minor[42], and cancel its actual high tail by the preceding construction.
Conversely P5 kills all low relative outputs. Hence

    R_H(K_odd)=ker P5 subset O_odd, dimension18.

This is a constructive equality of geometric images despite possible
mixed-additive higher coefficients. It does NOT assert that R_H itself
is a k-linear matrix. The computations are finite polynomial identities,
not generic minors or finite-field point tests. The exact
[pure-Python verifier](../../../scripts/deformations/rank125/certify_w5_escape_quotient.py)
and [matrix/minor receipt](../../../../litt3-computation-data/rank125_reference_20260914/computations/rank125_w5_odd_relative_quotient.json)
record them. The constructive lifting includes the unknown regular
tails and actual coefficient transports.

Apply [tame obstruction averaging](../marked_obstruction_torsors.md),
Section1, to the actual fourth-choice torsor and its complete fifth
class, with the first involution and q=2. Its fixed source and target
are the odd spaces. The complete fixed image just proved is ker P5.
Moreover P5 kills the even target, so composing with averaging does
not change P5 on an arbitrary class. Unique lower Hodge structures
retain the actual twist and grading.

The lemma therefore makes theta5(H)=P5(C5(H)) independent of all
fourth choices, and theta5(H)=0 is equivalent to cancelling the
entire fifth class. A full terminal primary source and whole regular
primitives then complete the genuine fifth tuple. This establishes
the iff criterion with all43 directions allowed.

The ordinary scalar trace cannot give a nonzero separator here. The
complete additive fourth channel A4(K) starts in J3: the minimum
product degree is7 and one odd-log carry lowers it by4, while regular
terms start in J5. Q(K,K) starts in J1. Hence augmentation of R_H(V)
is zero for EVERY V in K. At the invariant fourth origin, oddness
makes augmentation of C5(H) zero. It is therefore zero for every
fourth choice over every H in F_odd. The geometric audit Section9
checks this argument separately. The fixed-line value is computed in the separate fifth theorem;
this quotient argument supplies no other absolute values.

## 7. Explicit odd translation kernel and a second actual involution

The independently reconstructed actual-AS coefficient table gives,
polynomially in alpha,beta,

    L_H_A(nu32)=[107]m3, L_H_A(nu33)=[72]m3,
    L_H_A(nu39)=L_H_A(nu40)=L_H_A(nu41)=0.

Since [117][107]+[72]=0, delta=[117]nu32+nu33 is in the kernel.
Its full vector, not only its leading term, is

    delta=[117]s1^4*s2*s3^4+s1^4*s2^2*s3^3
          +[41]s1^4*s2^3*s3^2+[35]s1^4*s2^4*s3.

The other three vectors are nu39=s1^3*s2^4*s3^4,
nu40=s1^4*s2^3*s3^4 and nu41=s1^4*s2^4*s3^3.
They are independent. The previously verified rank-six minor on columns
nu27,nu28,gamma0,...,gamma3 is [37][65][44]=[91], with rows
(311),(410),(241),(331),(340),(430). Thus these four vectors span the
ENTIRE odd translation kernel, for every actual reference value.

Consider now the actual involution

    jmath:(u,kappa,y,W1,W2,W3)->(u,-kappa,-y,-W1,W2,W3).

It is the original double-cover involution over Y; it fixes v,D,eta,z,A.
The first original AS character and its affine/formal parts change sign,
while the other two are fixed. This verifies the actual AS equations
and gluing, and jmath^2=1 exactly. All oper, theta and flat-line data are
pulled from Y, so are naturally preserved without trivializing the twist.
The original finite etale reference and its automorphism lift together;
tuple functoriality retains the canonical reference and grading.

Precisely, jmath acts on the same marked deformation FUNCTOR. It does
not reduce to the identity of the marked special fibre. It conjugates
the specified sigma1 to sigma1^-1 and fixes sigma2,sigma3. This is an
explicit action on the original labels, not a substituted cover marking.

On the six normal basis coefficients the signs are
P=diag(-1,1,1,1,-1,-1). With T(s)=(-s1,s2,s3), the full primary matrix
satisfies M(Ts)=P M(s) P. The normalized Schur column and row therefore
satisfy a_S(Ts)=-P a_S(s), ell_S(Ts)=-ell_S(s) P, and f(Ts)=f(s).
Restoring the full column, Top, and original coefficient transport gives
the same scalar action on source and target:

    S_j(H)=-H(-s1,s2,s3).

The full completed rows of H_A are odd in s1, as independently checked
in all43 rows of the reconstructed kernel. Hence H_A is fixed by S_j.
The target signs on m0,...,m3 are(-1,1,1,-1), so naturality of the
COMPLETE fourth obstruction forces the ACTUAL omega0=omega3=0.
This includes its divided carry and all regular reference terms.

Consequently the invariant origin can be written

    ell1=(C*omega2-D*omega1)/[58],
    ell2=(B*omega1-A*omega2)/[58],
    Hstar=H_A+ell1*gamma1+ell2*gamma2.

The transpose-oriented signs follow from
A*ell1+C*ell2=-omega1 and B*ell1+D*ell2=-omega2.
Both gamma1,gamma2 are S_j-fixed, so Hstar is fixed too. The exact K9
relative formula proves E4(Hstar)=0 without evaluating omega1,omega2.
This is the same genuine fourth-compatible construction in a stronger
symmetry-preserving form, not a new arbitrary reference.

## 8. The genuine fixed line leaves one absolute fifth scalar

We now have the exact affine description

    H(x)=Hstar+x0*delta+x1*nu39+x2*nu40+x3*nu41.

The scalar signs on these translations are(-1,1,-1,-1), respectively.
Therefore jmath acts by(x0,x1,x2,x3)->(-x0,x1,-x2,-x3), whose fixed
locus is exactly H_lambda=Hstar+lambda*nu39 over the geometric field.

On P5 the scalar target signs are(-1,-1,1,-1). Transport any compatible
fourth origin under jmath. Naturality of the fifth obstruction gives
the same signs on its class, and the previously proved independence of
P5 from ALL fourth-origin choices gives the intrinsic identity

    theta5(-x0,x1,-x2,-x3)=diag(-1,-1,1,-1)*theta5(x).

This argument does not require a globally chosen family of invariant
fourth origins. Restriction to the fixed line and invertibility of two
give

    theta5(H_lambda)=(0,0,vartheta(lambda),0),
    vartheta(lambda)=E100(C5(H_lambda)).

The exact relative-image theorem in Section6 makes vartheta(lambda)=0
equivalent to a genuine fifth extension over that third point, with all
fourth and final fifth freedoms allowed. The symmetry alone does not
compute vartheta or imply nonconstancy. Section9 supplies global
perfect-polynomiality, and Section11 strengthens it to actual affinity.
Neither argument evaluates a coefficient.

## 9. Uniform polynomial Witt families

The parameter argument has a useful form independent of this cover.
For any perfect field k of characteristic p and finitely many
parameters T, put

    B=k[T_1^(1/p^infinity),...,T_d^(1/p^infinity)],
    A_m=W_m(k)[T_1^(1/p^infinity),...,T_d^(1/p^infinity)].

The monomial map A_m -> W_m(B), sending T^a to its Teichmuller
monomial, is injective. Indeed, a nonzero polynomial has a minimum
coefficient p-order r<m. Divide its coefficients by p^r and reduce
modulo p. Distinct rational monomials remain independent in B, so
the image cannot vanish. The same argument proves saturation:
if an image is p^r-divisible, every coefficient is p^r-divisible.
Division into A_(m-r) therefore preserves monomial support. The
image is stable under actual Witt Frobenius and its inverse.

This concerns coefficientwise polynomial lifts. A new intermediate
sum is not replaced by the Teichmuller lift of that entire sum.
Use fixed linear sections and basis primitives coefficientwise,
and apply inverse Frobenius to the whole source expression.
Residue-unit inverses with parameter-independent residue have
finite nilpotent expansions. Thus these operations introduce no
parameter denominators; equal exponents are combined before
whole division.

Apply this with p=5,d=1,T=lambda. A fixed smooth formal deformation
chart exists because H2(T_X)=0. Substituting source coordinates in
25W5(B) gives a uniform curve family; its special fiber is constant.
This asserts smoothness of the curve chart, not of a space of
compatible tuples. The original Schur source and whole boundary
sections construct its actual third tuple uniformly, and the chart
supplies a fourth curve reference.

The finite-precision oper operations are integral by
[integral oper calculus](../integral_oper_calculus.md). Whole normal
projection and fixed linear primitive sections act on finite
B-linear combinations. Formal series in the curve coordinate do
not complete the parameter ring: only finitely many nilpotent
operations occur, and their scalar outputs remain in B.

The preliminary class in the FULL fourth primary cokernel is
therefore B-valued. It
vanishes at all k-points by the established fourth-admissibility
of H_lambda. Each of its finitely many coefficients lies in some
k[lambda^(1/5^e)] and vanishes identically by polynomial detection
over the algebraically closed k. Reducedness alone would not
suffice for this inference.

Choose a fixed k-linear section S of the FULL constant primary
matrix on its image. For the full normal target b,
Phi^(-1)(S(b)) solves its primary equation uniformly. The whole
boundary section supplies regular fourth repairs, with the given
grading, twist and periodicity. This does not solve a varying
mixed-additive map or choose separate pointwise origins.

Lift the fourth curve family to W5(B) and form the actual fifth
comparison. Its whole normal numerator is divisible by125.
The saturated coefficientwise lift above preserves every parameter
monomial on division. E100 gives the intrinsic vartheta, by
independence from all fourth origins. Hence

    vartheta belongs to k[lambda^(1/5^infinity)].

A single element uses only finitely many roots, so it becomes an
ordinary polynomial after one finite Frobenius reparameterization.
Over algebraically closed k, a nonconstant such function is
surjective. Section11 proves the stronger actual affine dependence;
the numerical coefficients are evaluated in the separate fifth
theorem.

## 10. Exact special-fibre two-trace projection

Use the original scaled AS equations W_i^5=c_i^-1(W_i+F_U,i), with
c=(3,1,2). For Z=sum b_a W^a, 0<=a_i<=4, the actual fibre traces give

    Tr Z=-b444, Tr(W1 Z)=-b344.

Indeed the single-variable traces in degrees0,1,2,3,5 vanish and the
degree4 trace is -c_i^-1; c1*c2*c3=1. In the derivative-Top realization
Z=r(partial_W)(W1^4 W2^4 W3^4), this gives

    r000=-Tr Z, r100=Tr(W1 Z),

since differentiating W1^4 introduces4=-1. No target Frobenius is
applied. Let N be the six-dimensional base normal projection in order
(kappa/u,v/u,v/u²,v/u³,y/u,y/u²). Recursive overlap reduction gives

    h000=N(r000), h100=N(r100+chi1' P_O,000),

where P_O,000 is the WHOLE infinity primitive and chi1'=[31]y/u.
In component order(1,kappa,y,v), infinity tangent coefficients have
u-exponents at most(-1,-2,-3,-4). Only the v-component can produce
kappa after multiplication by chi1'. Since yv=kappa E, deg E=3,
its highest possible exponent is -4-1+3=-2, never -1. Therefore
N0(chi1' P_O,000)=0, including all regular formal tails.

The reconstructed Schur row has

    ell000=(1,0,0,0,0,0), ell100=(0,[85],[85],[48],0,0).

Consequently E100=h100,0+ell100*h000 equals

    N0(Tr(W1 Z))+[85]N1(-Tr Z)+[85]N2(-Tr Z)+[48]N3(-Tr Z).

The full expression, not each weighted trace individually, is the
cohomological functional. Since f is in J², quotient reduction leaves
this degree-one coordinate unchanged. For fifth application Z must be
the fully repaired, wholly divided-by125 normal cochain. The lemma does
not replace its missing construction or authorize tracing before division.

The actual varying first repair is explicit. Put n0=kappa/u, chi=[31]y/u, W_O,1=W_U,1-chi, and

    F_U,1=y*([2]+[35]u),
    S_U=kappa*([119]+[36]u+[83]u²+[36]u³),
    S_O=[36]*kappa/u².

Then A*n0^5=S_U+S_O. Define

    T=4 F_U,1*A*n0^5+[112]A*(v/u)^5
      +[11]A*(v/u²)^5+[36]A*(v/u³)^5.

The whole Laurent splitting T+4 chi S_O=R_U+R_O has

    R_U=v*([59]+[99]u+[97]u²+[70]u³+[38]u⁴+[82]u⁵
           +[88]u⁶+[104]u⁷+[86]u⁸+[37]u⁹),
    R_O=v*([99]u^-12+[113]u^-11+[117]u^-10+[81]u^-9
           +[46]u^-8+[39]u^-7+[5]u^-6+[28]u^-5+[14]u^-4).

Thus q_U=-4 W_U,1*S_U-R_U and z²q_O=4 W_O,1*S_O+R_O
satisfy A*n(nu39)^5+q_U-z²q_O=0 as a WHOLE identity, with no
cohomology residual. The affine terms have nonnegative u powers;
S_O and R_O satisfy the infinity tangent bounds, so q_O is regular
in the specified infinity graph frame. The source Schur column has
a000=(1,0,0,0,0,0), a100=(0,[43],[19],[119],0,0); original-deck
inverse coefficient Frobenius gives the displayed n(nu39). Consequently
n(lambda*nu39)=lambda^(1/5)*n(nu39), and its first graph pair is
(lambda*q_U,lambda*q_O). The free parameter is not raised to25.

This exact first-order input does not remove the whole mixed boundary
with the old repairs: its cokernel class may vanish while its regular
primitive is nonzero. That primitive and the second repairs still enter
the actual fifth numerator.

## 11. The actual fifth increment is affine
It concerns the complete mixed-characteristic comparison. It retains
the mixed sectors that the auxiliary cubic does not compute.

Let F_d be total AS degree at most d in the original scaled W_i. The
derivative-Top description identifies J^a with F_(12-a). Fixed base
functions have degree zero. Section10's complete projection gives

    E100(F_10)=0,                                             (11.1)

for the cochain AFTER whole fifth division. The old source and first
Hodge pair at Hstar lie in F7. The new source is mu*n(nu39) and its
whole first pair is lambda*(q_U,q_O), with mu=lambda^(1/5); both varying
directions lie in F1. All fourth origins give the same scalar, so we
may choose a convenient genuine polynomial family of full fourth
sources and whole regular second graphs.

Use the coefficientwise polynomial Witt lifts of Section9. The
whole fourth equations vanish identically, so after equal parameter
exponents are combined their repaired numerator is coefficientwise
divisible. Its divided mixed lambda sector is still lambda times
a fixed coefficient. This is stronger than pointwise Witt arithmetic
and is needed in the support ledger below.

### Integral carries from a single weighted filtration

On reference patches use the actual monic etale charts
W_i^5-a_i W_i-b_i=0 with base units a_i. Their chart/Frobenius maps
have affine-linear residues in W. The general
[all-precision chart theorem](etale_artin_schreier_carry_bound.md)
applies to the weighted filtration G_d=sum_j 5^j F_(d+4j).
Actual etale lifting, composition and differentiation preserve G_d.
Taking its first three digits gives exactly the estimate needed here:

    Ftilde_d + 5*Ftilde_(d+4) + 25*Ftilde_(d+8) modulo125.     (11.2)

The proof uses two facts: mixed fifth powers acquire a factor5,
and pure fifth powers reduce by the actual chart equations. This
also handles later carries without repeating the Hensel calculation.
The reference is pulled from the base; this neither imposes a cover
structure on a moving source nor bounds arbitrary positive-degree
unit inverses. Products with old moving repairs are counted separately.

### Filtered solutions of the whole fourth variation

After projection by the full primary Schur row, the established FULL
nil-coordinate bounds for the genuine quadratic cochain give

    pi_nil Q(F7,F1) in F5=J7,    pi_nil Q(F1,F1)=0.            (11.3)

The mixed scalar class vanishes because L_Hstar(nu39)=0 and nu39 has
no degree-nine part. Its full scalar representative therefore belongs
to (f) intersect J7. In nodal coordinates q2 is a unit times uv; its
homogeneous multiplication is injective in degrees0..3. Hence any
preimage of a J7 target lies in J4, giving an F8 preimage. There IS a
degree-four q2-kernel, so no J5 preimage is asserted.

The complete first product carry of f*nu39 lies in J9. The known
inclusion J9 subset f*J7 gives its source in F5. Regular additive terms
on this direction lie in J11. For the ordinary coefficient mu retain
the sharper bound: its cochain is F1, its nil target lies in J11, and
J11 subset f*J9 gives a source in F3. The pure quadratic coefficient
has zero full nil target by (11.3), so its ordinary source is F2.
The ordinary Schur block and both Schur basis changes preserve the AS
filtration; all these are FULL primary sources, not rank82 substitutes.

After correcting the full primary class, the only fact needed to
control WHOLE regular primitives is the following general lemma.
If E_d is a subsheaf of E with H0(E/E_d)=0, a Cech cochain in E_d
which is the boundary of regular local sections in E has those
sections in E_d: their images glue to a global section of E/E_d,
which is zero. In particular, H1(E_d)->H1(E) is injective. Here
E=T_C tensor pi_*O_X and E_d is its AS-degree filtration. The
quotient has a filtration by copies of T_C, with no global sections
since g(C)>=2. Thus the COMBINED repaired cochain has whole regular
primitives of the same degree. Local coefficient sections preserve
this bound. The lemma does not supply primitives before primary
exactness has been established; it cannot repair Q alone.

The varying second data above the genuine fixed fourth tuple may thus
be chosen with the following bounds:

| Flat coefficient | Fourth-normal sector | Full source response and whole second graph |
| --- | --- | --- |
| mu | Ordinary first-source response | F3 |
| lambda | Divided first-direction response | F5 |
| lambda | Mixed old/new quadratic response | F8 |
| lambda² | Pure new/new response | F2 |

In a gauge retaining a separate Frobenius-pulled first-repair term,
its coefficient lambda^5 has an F1 normal cochain, so the same F3
solve and all the exclusions for the ordinary row apply. This harmless
overestimate avoids assuming that particular term occurs.
The fourth source itself uses inverse-Frobenius coefficients. Its
direct ordinary contribution at final weight has the same AS bounds.

The [finite certificate](../../../../litt3-computation-data/rank125_reference_20260914/certificates/rank125_fixed_line_affinity_support.json),
produced by the
[independent support verifier](../../../scripts/deformations/rank125/certify_fixed_line_affinity_support.py),
checks q2 ranks(1,3,6,10,13), the actual filtered preimages for every
monomial in J9 and J11, the COMPLETE first product carry of nu39,
and all121 reduced F10 monomials under the two traces. The geometric
nil bounds and whole regularity follow from the preceding arguments,
not from a fifth-engine replay.

The certificate was moved without changing its bytes; its original path
and generating source are retained in the
[storage relocation record](../../../../litt3-computation-data/rank125_reference_20260914/provenance/relocation.json).

### The complete fifth-weight ledger

Source third variations start at25 and first graphs at5. Second source
responses and second graphs start at25; ordinary fourth sources enter
at125. Expansion of the actual normal/Riccati numerator through flat
weight125 retains linear first data with two carries, quadratic first
data with one carry, cubic first data, linear second data with one
carry, and first--second products. Second--second products vanish at
this precision. The following bounds kill every coefficient except a
constant and lambda by (11.1):

* Linear first-direction terms, even through two carries, have degree
  at most1+8=9. This includes linear coefficient transports.
* Pure new/new quadratic terms with their first carry have degree at
  most2+4=6. Cubic terms with two new factors have degree at most7+2=9.
* The ordinary mu second row with one carry is F7; multiplied by the
  OLD first pair it is F_(3+7)=F10. The sharper F3 bound is essential:
  an aggregate F5 estimate would fail to exclude this root coefficient.
  The same holds for the optional lambda^5 row just described.
* The lambda² second row with a carry is F6; multiplied by an old
  first factor it is F9. A mixed second row times a NEW first factor
  is also at most F9.
* Ordinary source pullbacks and divided quadratic source variations
  occur at final weight and have mixed degree at most7+1=8 or pure
  degree2. Direct ordinary fourth sources, including all parameter
  roots introduced by their solves, are at most F8.

Higher divided Taylor terms are not discarded by an ordinary-degree
guess. Write the divided displacement as delta0+5d1+25d2, with fixed
base-valued delta0. In Taylor term j with n new first insertions the
valuation is at least

    j-1+n-v5((j-n)! n!).

For one insertion only j<=3 survives below625; for two, only j=2
survives, at125; for three or more none survives. Thus the varying
order4/5 terms vanish despite their factorials, while their fixed
absolute terms cancel only in the increment. The quadratic surviving
displacement has degree at most2 or8 as above. Second-displacement
insertions obey the second-data ledger. The moving preceding potential
changes first at5 and enters the tilde connection through25 times that
potential. Its final-weight matrix response is linear in a degree-one
variation, also after actual Frobenius, and its product with a moving
graph has excessive weight. Its projection is therefore zero.

In contrast, the first carry of the mixed lambda second row may reach
F12, and the divided lambda row times an old first factor may also
reach F12. A new first factor times the COMPLETE OLD second data can
survive as well. These sectors are retained. By the polynomial Witt
argument each has coefficient lambda times a fixed, unevaluated scalar.
All discarded sectors obey their bounds through the necessary carries
before the whole final division, so (11.1) is used at its valid precision.

We have proved the actual identity

    vartheta(lambda)=vartheta(0)+a*lambda.                    (11.4)

It holds for the actual reference values, without specializing them.
If a!=0 there is exactly one third point on the line admitting W5,
at lambda=-vartheta(0)/a; the relative-image theorem then supplies
the required fourth translation and whole final repairs. If a=0,
the constant decides the entire line. The support argument itself
computes neither coefficient and does not identify a with d_aux.
The [whole fifth computation](rank125_fixed_line_fifth.md) evaluates
these coefficients using complete mixed-characteristic repairs.

## 12. Verification interface

The coefficient claims used above have independent exact verifiers:
[whole quadratic and carry replay](../../../scripts/deformations/rank125/replay_w4_existence_geometry.py),
[uniform polynomial inverse](../../../scripts/deformations/rank125/audit_w4_existence_polynomial.py),
[fourth-fiber ranks](../../../scripts/deformations/rank125/certify_w4_escape_family.py),
[two-trace projection](../../../scripts/deformations/rank125/audit_reference_increment_return.py),
and [affinity support](../../../scripts/deformations/rank125/certify_fixed_line_affinity_support.py).
The replay checks all 566 quadratic coefficient vectors and 43 carries;
the full primary rank is 707. The
[actual fourth-reference proof](rank125_actual_fourth_reference.md)
supplies the numerical origin and whole first repairs. The later fifth,
sixth and all-height calculations use this fourth-stage result;
their numerical conclusions are not premises here.

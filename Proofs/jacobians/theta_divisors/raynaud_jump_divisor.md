# Proof: an inherited theta cone controls the mixed jump divisor

[Statement](../../../Theorems/jacobians/theta_divisors/raynaud_jump_divisor.md).
The [bounded independent audit](../../../Research/audits/RAYNAUD_JUMP_DIVISOR_AUDIT_2026_09_15.md)
passes the argument and a separate compact arithmetic check.
This proof uses the complete two-term cohomology complex. It does
not replace that complex by its cup-product matrix. The last matrix
is used only to identify the initial term after the splitting is proved.

## 1. The one-leg slice and two primitive kernel vectors

Write r=a(X). For the universal twist N on Z^(1) x P, let

    C=R pi_*(B_Z tensor N),  L=H0(C),  Q=H1(C).

The complex is perfect of amplitude[0,1] with equal virtual ranks,
and its derived fibers compute the indicated cohomology. Etale
base change and the prime-to-p trace give on H

    f^(1)_*O_(Z^(1))=O_(X^(1)) direct_sum E_f.

The trace-free summand B_X tensor E_f has one section at O.
Raynaud's properness theorem gives generic h0(B_X tensor L_X)=0.
Therefore the one-leg generic h0 is at most1, and delta<=1.
If delta>0, upper semicontinuity gives h0>=1 everywhere on P.
The trace-free summand consequently has generic h0=1, hence exactly1
in a neighborhood of O. Its h1 is also1 since its Euler characteristic
is zero. Its local cohomology complex splits as a zero map of lines.
Thus the restriction of C to H has a local minimal representative

    diag(D_X,0),

where D_X is an r-square minimal matrix and det(D_X)=theta_X,
a local Raynaud theta equation. This is a statement about actual
derived restriction, so it also identifies the determinantal schemes.

Assume delta=1 and work over the completed regular local ring
R at o. A minimal representative of C is an (r+1)-square matrix D,
all of whose entries vanish at o. Its kernel is a line bundle:
a kernel of free modules is reflexive (the image is torsion-free),
and a rank-one reflexive module on a regular scheme is invertible.

The canonical alternating pairing B_Z tensor B_Z->omega identifies
B_Z with B_Z^dual tensor omega. Relative duality and normalized
Poincare inversion iota=[-1] give

    RHom(C,O)=iota^*C[1],   Q^dual=iota^*L.              (1)

The pairing and its compatibility with trace are recalled in the
[Cartier--Petri proof](../../cartier_and_spin/cartier_petri_excess_one.md).
In particular the left kernel of D is free of rank one too. Choose
generators a of ker(D) and b of ker(D^t). Both vectors are primitive:
if a nonunit irreducible divided every entry, dividing by it would
give another kernel vector and contradict generation. The same holds
for b. Generic rank r now gives

    adj(D)=s a b^t,    s in R, s!=0.                   (2)

Initially s lies in Frac(R). At each height-one prime primitivity
makes some a_i and some b_j units; the corresponding adjugate entry
shows v(s)>=0. Normality then gives s in R. Over the height-one
DVR, Smith normal form shows that v(s) is exactly the torsion length
of Q. Thus div(s) is its effective divisorial torsion cycle.

Choose the restriction basis diag(D_X,0). Then

    a|H=alpha e_(r+1), b|H=beta e_(r+1),
    theta_X=unit * s|H * alpha * beta.                 (3)

All three factors on the right are nonzero. Duality(1) is represented
by an invertible chain map of the minimal free complexes, since a
quasi-isomorphism between minimal complexes over a local ring is
termwise invertible. It identifies b with an invertible matrix
times iota(a), up to a unit. On H this matrix must preserve the last
kernel line: its other entries in that column vanish after multiplying
by the nonzero iota(alpha). Its last entry is a unit. Therefore

    theta_X=unit * s|H * alpha * iota(alpha).           (4)

This is an equality of actual local functions. It is stronger than
an equality of determinant line-bundle classes.

## 2. Squarefree initial term: splitting, reducedness and flatness

On the associated graded ring of the smooth Jacobian, inversion
acts by -1 on degree one. If alpha has positive order d, the initial
term of alpha*iota(alpha) is (-1)^d in(alpha)^2. Initial terms of
nonzero products multiply in the regular local ring. A geometrically
squarefree initial theta equation in(4) therefore forces alpha to
be a unit. The same holds for beta. Both a and b have a unit entry
at o; the kernel-line base-change map is consequently nonzero and
its image is the trace-free line identified on H.

An invertible change of basis now puts D in the form

    D=diag(E,0),     E an r-square matrix, det(E)!=0.    (5)

The jump scheme V2 is defined by the r-minors of D, hence by det(E).
The restriction of this equation to H is a unit times theta_X.

Squarefreeness of the initial theta equation implies that the theta
germ is reduced. If det(E) had a repeated irreducible factor in R,
its restriction to H would either be zero or a repeated nonunit
factor of theta_X. Both are impossible. The same argument shows
that det(E) is irreducible if the inherited initial theta equation
is irreducible. These arguments hold after geometric base extension.

For flatness, choose formal X-coordinates so that theta_X is regular
in one of them, say x_1. This is possible over the infinite field k
by its nonzero initial term. Weierstrass preparation makes R/(det E)
finite free over k[[x_2,...,x_h,y_1,...,y_dim(JY)]]. It is therefore
flat over the second parameter ring. Each component through o
dominates that base: minimal primes of a flat algebra over this
regular domain contract to zero. Faithfully flat completion transfers
the assertions to a neighborhood of o. No codimension-three
Gorenstein or parity theorem is needed for this argument.

## 3. Exact second-order computation on the fixed X

Use F25=F5[a]/(a^2+4a+2), with code c0+5c1 denoting c0+c1*a.
The curve is y^3=F(x), with ascending coefficient list

    F=(11,22,18,5,19,20,15,16,9,22,1).

It has one point at infinity, semigroup <3,10>, and gaps

    G={1,2,4,5,7,8,11,14,17}.

Take t=x^3/y. Writing q=t^3, v=1/x and f(v)=v^10 F(1/v),
the formal chart is v=q f(v), and with u=q/v

    x=t^-3 u(t^3),  y=t^-10 u(t^3)^3.                  (6)

The [audited Cartier calculation](../../cartier_and_spin/cartier_petri_excess_one.md)
gives a(X)=3, with kernel differentials alpha_i=B_i dx/y^2, where

    B1=(24,2,1,0,0,0),
    B2=(5,16,0,1,0,0),
    B3=(5,20,0,0,8,1).

Choose AFFINE primitives h_i=y Q_i(x), solving the exact polynomial
identities F Q_i'+F'Q_i/3=B_i. The chosen Q_i have degrees20,25,20.
They represent global sections of B_X: after removing t-exponents
divisible by5, their negative Laurent parts vanish. The full
coefficients and derivative checks are in the external receipts.

Represent B_X by functions modulo fifth powers. Its Cech spaces on
the affine curve and formal disk are respectively R_U/R_U^5 and
k[[t]]/k[[t^5]], with overlap k((t))/k((t^5)). Remove all exponents
divisible by5. Negative Laurent coefficients, modulo affine
boundaries, compute H1(B_X). Exact row reduction gives the three
representatives t^-2,t^-8,t^-11. Let pi be this projection and
H_aff its chosen affine splitting.

On X^(1), the functions (t^5)^-g, g in G, give the ordinary gap
basis of H1(O). Glue a universal second-order line by exp(U), where

    U=sum_(g in G) z_g t^(-5g),  exp(U)=1+U+U^2/2 mod(z)^3.

These are etale formal Picard coordinates through order2; only 2
needs to be invertible. Eliminate the affine-boundary block in the
whole Cech differential. Its reduced matrix has terms

    D1(:,i)=pi(U h_i),
    D2(:,i)=pi(U^2 h_i/2-U H_aff(U h_i)).               (7)

For clarity, use the equation exp(U)*a-b=0. The first affine repair
is -H_aff(U h_i), which explains the second term in(7). This block
elimination is valid even when the first obstruction is nonzero;
it is not a choice of first lifts only in unobstructed directions.

The Serre pairing matrix for these bases is

    G0=[[0,0,2],[0,2,22],[2,2,4]]                      (field codes).

For example its i,j entry is Res(t^e_j d h_i), equivalently
-e_j times the coefficient of t^-e_j in h_i. The matrix G0 D1
is alternating, hence det(D1)=0. Consequently the degree-four
initial candidate for the theta equation is exactly

    P4=trace(adj(D1) D2).                              (8)

Terms of order3 or higher in the reduced matrix cannot affect(8).
The entire computation takes place in characteristic5; it requires
no mixed-characteristic lift or uncomputed higher comparison.

## 4. A compact irreducibility certificate

Put A=(z1,z4,z7). If q=(D23,-D13,D12) for D=G0 D1, the computed
linear forms are

    q1=2z2-2a z5-(2a+2)z8-a z11+(2a+2)z14-(a+2)z17,
    q2=-(2a+1)z5+a z8+(a-2)z11+(-a+2)z14+(a-1)z17,
    q3=-2a z5+(-2a+1)z8+(-a+1)z11-2z14+2z17.

They are independent and involve only the complementary six
variables. Exact calculation of all45 quadratic blocks in(7) gives

    det(G0) P4 = q^t S(A) q,                          (9)

where S is symmetric and its upper-triangular entries are

    S11=a z4^2+(a+2)z4 z7-(a+2)z7^2,
    S12=(-a+2)z4^2+a z4 z7+(a+2)z7^2,
    S13=-a z1 z4+(a+2)z4^2-z1 z7+(-a+2)z4 z7-(a+2)z7^2,
    S22=(-a+2)z4^2-(2a+2)z4 z7-(2a+1)z7^2,
    S23=-z1^2+z1 z4+z4^2+(-a+2)z1 z7-2a z4 z7-(2a+2)z7^2,
    S33=(2a+1)z1^2-(2a+1)z1 z4+2a z4^2+(-a+2)z1 z7
        -(a+1)z4 z7+(2a+2)z7^2.

These short data prove geometric irreducibility without a large
factorization. The coefficient content of q^t S q over k[A] is1:
a common factor divides the nonzero S11, which is independent of
z1, and hence is independent of z1; it then divides the coefficient
-1 of z1^2 in S23, so is a unit. Moreover

    det S(1,0,1)=4a+4 != 0.                            (10)

Over the algebraic closure of k(A), the ternary quadratic form has
rank3. It is irreducible, since a product of linear forms has rank
at most2. Gauss's lemma, and then adjoining the other three free
coordinates, prove that P4 is geometrically irreducible. In particular
it is nonzero and squarefree, proving multiplicity exactly4.

A small additional check is the plane z1=s,z4=z5=t, all others0:

    P4=(2a+1)t^2(s-(a+4)t)(s-(a+2)t).

It already rules out a square initial equation, though(9)--(10)
give the stronger assertion used here.

## 5. Finite precision and reproducibility

An affine primitive whose non-fifth-power negative part has pole
at most L can be chosen with actual pole at most max(L,85). Indeed
a larger leading pole divisible by5 can be removed by a global
fifth power unless its fifth part is a gap; the largest gap is17.
All sufficiently large nondivisible poles are nongaps and give
triangular affine elimination. Thus the bounded negative quotient
captures the entire H1(B_X), not a truncated quotient with hidden
boundaries at larger poles.

The second-order inputs have nondivisible pole at most169: the
sections h_i have no negative nondivisible terms, and U has pole
at most85. The chosen repairs have the same negative class as their
inputs modulo representatives with poles at most11. Pole bounds200
and180 therefore both suffice. Positive coefficients through170
suffice for every multiplication in(7). Formula(6) is expanded to
q-precision160 and140 respectively, exceeding the required bound
(pole_bound+170)/3 even after losing one digit in v/q.

The [source](../../../scripts/arithmetic/fixed_x_theta_tangent.py)
checks all polynomial primitives, negative splittings, first matrices,
second blocks, Serre alternation and the whole identity(9).
The two original receipts are
[baseline](../../../../litt3-computation-data/theta_jump_20260915/fixed_x_theta_quartic.json)
and [changed bounds](../../../../litt3-computation-data/theta_jump_20260915/fixed_x_theta_quartic_replay.json).
Their complete first and second matrices, all117 quartic coefficients,
primitives, Serre matrix and compact forms agree exactly. Only the
workspace dimensions and input precision fields differ. Generated
data stay outside Proofs and outside the litt3 workspace.

## 6. The full mixed tangent cone and the third jump locus

For the fixed X and Hom(JX,JY)=0, the
[audited first-order theorem](../../../Theorems/cartier_and_spin/cartier_petri_excess_one.md)
shows that delta=1 forces all mixed second traces to vanish. The
linear part of D is therefore the inherited three-by-three alternating
block and a zero row and column, with no Y-direction entries.
In the splitting(5), E has that alternating linear part, up to
invertible constant basis changes. Hence det(E) has order at least4.
Its restriction to H has order4, so its own order is exactly4.
Its quartic initial form restricts to the irreducible P4. A nontrivial
homogeneous factorization would restrict to a nontrivial factorization
of P4; neither factor can restrict to zero. Thus the full cone is
geometrically irreducible too.

The scheme V3 is defined by the 2-minors of E. The initial forms
of these minors include all products q_i q_j of three independent
linear forms. Their ideal has height3. Consequently V3 has
codimension at least3 in P at o. This concerns actual determinantal
jumps, and is not a claim that all higher obstructions vanish.

## 7. Ampleness of the dual universal kernel

Here let P be any abelian parameter variety with finite kernel in
J(Z^(1)), and suppose the actual generic h0 is1. The preceding
reflexivity argument again makes L=R0 pi_*(B_Z tensor N) a line.
Write M=L^dual. Universal evaluation, at a general z in Z^(1), is
nonzero and implies H0(P,M tensor N_z)!=0. The closed locus V0(M)
therefore contains the entire parameterized Abel curve a(Z^(1))
in P^dual, including its chosen origin. In particular M is effective.
This Abel curve generates P^dual: its dual map is the given
homomorphism P->J(Z^(1)), with finite kernel.

If an effective M were not ample, the connected positive-dimensional
kernel K of its polarization would force V0(M) into a coset of the
proper annihilator K^perp in P^dual. To see this, restrict any
nonzero section of M tensor alpha to a general K-coset. Its
degree-zero restriction can have a section only when it is trivial;
thus alpha|K is a fixed character. A generating Abel curve through
the origin cannot lie in that proper coset. Hence M is ample.

Under Hom-zero, line bundles on the product split as external
products, so both factor duals are ample. Duality(1) also gives

    det(C)^-1=(L tensor iota^*L)^-1 tensor O(D_tors),

with D_tors the effective divisorial torsion cycle. This gives a
polarization bound but no contradiction. Neither this bound nor
the unique flat jump divisor is presently excluded by joint
minimality or corelessness. Generic vanishing and the common-cover
problem both remain open.

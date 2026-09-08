# Proof: Kummer norms and the residual nine-torsion support

Canonical [statement](../Theorems/Thm_kummer_norm_and_nine_torsion_support.md).
Author /root, 2026-09-08, incorporating the user's returned GPT6Pro result.
The original exact certificate was independently replayed in full. This
is not an independent prose audit or a Lean verification.

## 1. The structural binomial obstruction

For odd ell and gcd(j,ell)=1, multiplication over the deck orbit gives

    Norm(A+B y^j)=A^ell+B^ell F^j.

If this equals H^ell, the rational functions U=A/H and V=B y^j/H give
a rational map C to H_ell. It is nonconstant: V cannot be constant,
since y^j does not belong to k(x). The map extends to the smooth
projective curves. Its Jacobian pushforward is nonzero: pushforward
composed with pullback on J(H_ell) is multiplication by its positive
degree. This remains nonzero even if the map is inseparable. It
contradicts Hom(J(C),J(H_ell))=0.

An absolutely simple J(C) of larger dimension has no nonzero quotient
of dimension at most g(H_ell), giving the stated sufficient condition.
For ell=3 the Fermat cubic is a smooth elliptic curve. In particular,
the already established absolute simplicity of J(X) is enough here;
no new Cartier calculation or elliptic-map ramification bound is needed.

## 2. All degree-two three-primary classes

The audited low-Abel theorem bounds every such class by nine and
classifies three-primary W_1 as the eleven branch classes, killed by
three. Let 9[E-2O]=0. If E=P+Q with P a branch point (possibly O),
then 9[Q-O]=0, so Q is also a branch point.

Otherwise E is finite and branch-free. A function with divisor
9E-18O lies in L(18O), whose pole basis gives

    f=A+B y,  deg A=6, deg B<=2.

If B=0, any nonbranch zero brings with it the entire three-point
x-fiber, which cannot be supported on E. Thus B!=0. Let R be the
monic degree-two polynomial with divisor of roots x_*E, retaining
multiplicities. Taking norms yields

    A^3+B^3 F=c R^9,  c in k^*.

The right side is a cube in k(x). Section 1 contradicts the absence
of an elliptic quotient of X. Thus E is branch-supported. Conversely
all such E give classes killed by three. The binomial(12,2)=66 classes
are distinct because X has no nonconstant function of degree at most
two. This proves (2).

## 3. Preliminary support reductions

Every rational function on X of degree at most six belongs to k(x),
as recorded in the low-Abel proof. Consequently an effective degree-three
divisor has more than one representative only if it is a complete
x-fiber, in which case its class in W_3 is zero. In particular the
representative of an exact-order-nine class is unique.

If D=P+E contains a branch point, Section 2 makes E branch-supported,
so [D-3O] is killed by three. The case D=3P gives 27[P-O]=0, hence P
branch by the W_1 theorem. For two support points in one nonbranch
fiber, say D=2P+rho P and e=[P-O], use

    [D-3O]=(2+rho)e,  (2+rho)(2+rho^2)=3 on J(X).

Again 27e=0 is impossible. The other ordering is identical. All three
distinct points of one fiber give zero.

The only remaining shared-fiber pattern is D=P+rho P+Q, x(Q)!=x(P).
Set R_0=rho^2 P. Then [D-3O]=[Q-R_0], so 9(Q-R_0) is principal.
The audited field bound and uniqueness imply pi^12 D=D. The projected
fiber multiplicities two and one imply that x(P),x(Q) are fixed.
Frobenius commutes with rho; on a three-point fiber a permutation
commuting with rho and preserving a two-element subset is the identity.
Thus Q and R_0 are individually F_(25^12)-rational.

## 4. Exact shared-fiber exclusion

Here the returned finite calculation is needed. It is small, exact,
and covers all geometric possibilities after the proved field bound.
If 9(Q-R_0) is principal with Q!=R_0, then both l(9R_0)>=2 and
l(9Q)>=2. A canonical basis of X is

    (1,x,...,x^5,y,xy,x^2y) theta,  theta=dx/y^2.

At a finite nonbranch point, x-b is a uniformizer. Riemann--Roch and
the nine canonical jet conditions show that l(9R_0)>=2 precisely when
the jet matrix is singular. Eliminating the first six columns leaves
det(y_(6+i-j)) for 0<=i,j<=2. Here y_n denotes a Hasse coefficient.
Since y=F^17/y^50 and y^(-50) is a twenty-fifth power, all needed jets
(orders at most eight) differ by a common nonzero scalar from those
of F^17. The certificate computes

    Dcal(x)=det(H_(6+i-j)(F^17)(x)).

It verifies Dcal/F^33 is nonzero of degree 161. For its monic
normalization W it verifies the exact gcd

    gcd(W, x^(25^12)-x)=T,
    T=x^6+(a+4)x^5+(3a+2)x^4+(2a+2)x^3+x^2+4ax+(4a+4),

and verifies T irreducible over F_25. These assertions are computed
by modular powering, not by expanding x^(25^12).
In K=F_25[b]/(T), it verifies a cube root c of F(b). Thus the only
possibilities are eighteen points over F_(25^6), transitive under
rho and pi. It suffices to fix R_0=(b,c).

For t=x-b the certificate computes y(t) modulo t^9. The matrix imposing
vanishing of coefficients 6,7,8 in C_*(t)y(t), for deg C_*<=2,
has rank two. Its one-dimensional kernel has a representative with
C_*(0)=1. Put

    B_*=(C_* y)_(<=5),  A_*=(C_* y^2)_(<=8),
    N=A_*+B_*y+C_*y^2,  h_0=N/t^9.

The two other sheets in this fiber give N=0 modulo t^9, verified
directly using the Hasse expansions; N(R_0)!=0. At O, N has pole
order at most 26 while t^9 has pole order 27. Therefore h_0 has its
unique pole of exact order nine at R_0. The rank-two calculation of
the canonical jets gives l(9R_0)=2, so 1,h_0 is a complete basis.

All possible Q with different abscissa are rho^j pi^i R_0,
1<=i<=5, 0<=j<=2. At these fifteen points the certificate evaluates

    t[3F(A_*'+B_*'y+C_*'y^2)+F'(B_*y+2C_*y^2)]-2FN,

the numerator of 3F t^10 h_0'. The product is

    (4a+1)+(2a+4)b+2ab^2+3ab^3+(2a+3)b^4+(a+3)b^5,

nonzero in the verified degree-six field. Hence dh_0 is nonzero at
every possible Q. No nonconstant alpha h_0+beta can vanish to order
nine there. This excludes the final shared-fiber pattern. Ordinary
derivatives are used only for nonvanishing; every positive high-order
condition uses Hasse jets or valuations.

The exact certificate is stored as the immutable 14 KB
[original ZIP](../Research/computations/pro_nine_torsion_reduction_20260908.zip).
Its five Python source files were read before execution. Extract it into
a temporary directory and run `python3 verify.py` in the contained
`torsion_reduction_certificate` directory. It requires only the Python
standard library and writes its JSON outputs beside the scripts.
/root replayed the whole package on 2026-09-08: exit 0,
`ALL CERTIFICATES PASS`, 0.69 seconds. Its extra degree-two computations
agree with Section 2 but are not needed by this streamlined proof.
Hashes, scope and replay provenance are in the
[certificate record](../Research/computations/pro_nine_torsion_replay.json).

## 5. Both y-coefficients are necessary

At this stage only 2P+Q and P+Q+R with finite nonbranch support at distinct
abscissas remain. Section 6 excludes the former. A certificate in L(27O)
has the displayed three-term form;
the unique monomial of pole order 27 forces deg A=9. Its norm is
cR^9 for the projected degree-three divisor polynomial R. If either
B or C vanishes, Section 1 excludes the remaining binomial. If both
vanish, a nonbranch zero again brings the full x-fiber. Thus B,C!=0.

## 6. A univariate certificate excludes 2P+Q

This step is root's new calculation, beyond the returned Pro result.
It excludes div(f)=18P+9Q-27O for finite nonbranch P and finite Q with
different abscissas. Neither a field bound nor simplicity of J(X) is used.

Use an indeterminate b over F_25. At P=(b,c), c^3=F(b)!=0, set

    S=(x-b)/F(b),  Y=y/c,
    T_b(S)=F(b+F(b)S)/F(b).

The coefficients of T_b lie in F_25[b]; its constant term is one and
its coefficient of S^j for j>=1 is F(b)^(j-1)H_j(F)(b). Let H in
F_25[b][S]/(S^18) be the unique cube root of T_b with H(0)=1.
Its coefficients are polynomial in b because three is invertible.
Equivalently H=T_b^17 modulo S^18: 3*17=1+2*25 and T_b^25=1 modulo
S^25. This is an identity in characteristic five, not a truncated
ordinary-derivative approximation.

After specialization at P, a section of L(27O) is

    A(S)+B(S)Y+C(S)Y^2,
    deg A<=9, deg B<=5, deg C<=2.

The nonzero scalars F(b),c merely change the basis; every possible
section is retained. Vanishing to order at least 18 at P means
A+BH+CH^2=0 modulo S^18. The first ten coefficient equations uniquely
determine A=-(BH+CH^2)_(<=9). The remaining eight equations form J(b),
with rows n=10,...,17 and columns

    B_i (0<=i<=5): H_(n-i),
    C_i (0<=i<=2): (H^2)_(n-i).                          (6)

Let Delta_j=(-1)^j det(J with column j removed), for 0<=j<=8.
The exact certificate supplies polynomials u_j in F_25[b] satisfying

    sum_j u_j Delta_j=1.                                (7)

Thus J has rank EIGHT at every geometric b, including every finite
nonbranch value; there is no omitted lower-rank stratum. Its kernel
is the line spanned by Delta=(Delta_0,...,Delta_8), since J Delta=0.
Take B,C from these nine coefficients and A as above, all polynomial
in b. Their norm over Y^3=T_b is

    N=A^3+B^3 T_b+C^3 T_b^2-3ABC T_b.

It has degree at most 27 in S, and the polynomial identity S^18|N
holds. Write N/S^18=sum_(j=0)^9 h_j(b)S^j. An actual divisor
18P+9Q-27O would have h_9!=0 and

    N/S^18=h_9(S-d)^9,
    d=(x(Q)-b)/F(b).

Its S^8 coefficient gives d=h_8/h_9 because -9=1 in characteristic
five. The next two coefficients consequently impose

    E_7=h_7 h_9-h_8^2=0,
    E_6=h_6 h_9^2-h_8^3=0.                             (8)

The exact calculation supplies v_7,v_6 in F_25[b] with

    v_7 E_7+v_6 E_6=1.                                 (9)

This rules out every geometric b. Points where h_9=0 cannot supply
an alternative: by (7) the entire section space is the same one line,
whose sections then have pole order less than 27. They therefore cannot
have the stated divisor. No denominator stratum or point at infinity
in the parameter b is discarded; P was explicitly finite, and earlier
steps already handle branch and infinite support.

The current [Sage certificate generator](../scripts/check_fixed_x_double_support_torsion.sage)
computes and verifies (6)--(9) exactly. The nine maximal-minor degrees
are 810,818,827,836,845,855,804,813,822; E_7,E_6 have degrees 5310,7956.
Their Bezout identities, the minors and equations are all stored in the
218 KB [coefficient certificate](../Research/computations/fixed_x_double_support_torsion.json).
The full coefficient-generation and exact identity check took 5.69
seconds. This is author computation with explicit polynomial witnesses,
not an independent whole-proof audit. The proof is over the algebraic
closure, with no enumeration of rational points.

## 7. Residual rigidity

Finally, suppose D,E represent points of U and
(1-rho)([D-3O]-[E-3O])=0. The divisor

    D+rho E-E-rho D

is principal of positive degree at most six, so its defining function
belongs to k(x). Its coefficients must be constant on each nonbranch
three-point fiber. But its positive and negative support each occupy
at most two points of a fiber. Every such coefficient is therefore zero.
It follows that D-E is rho-invariant; each sign now occupies at most
one point of a fiber, forcing D=E. This proves lambda-injectivity.

For gamma=rho^i pi^j and (gamma-1)^2 xi=0, apply the same argument to
gamma^2D-2gamma D+D. Its positive support occupies at most two points
of any fiber and negative support at most one, so the divisor vanishes.
Iterating on finite point orbits gives gamma D=D: the integer-valued
coefficient sequences have zero second difference and are periodic.
These are integer divisor coefficients, not coefficients reduced
modulo five. This proves the last assertion without requiring gamma
to fix each branch point.

Three distinct nonbranch points at distinct abscissas remain unexcluded.
In particular lambda-injectivity is not a self-map statement for U.

# Focused audit: degree84 cofactor elimination

Verdict: **PASS on the actual geometric cover locus.**
Auditor: `/root/audit_degree84_differential_system`.
Date: 2026-09-10.
Objections: no blocking objection. The rational-horizontal-basis bridge
is made explicit below. The localization covers every actual map, but
is not asserted to preserve every degenerate point of the earlier
enlarged necessary system. No emptiness assertion is made.

Scope: the cofactor construction in
[diagnose_triangle237_cofactor_reduction.sage](../../scripts/diagnose_triangle237_cofactor_reduction.sage)
and the proposed geometric proof that its leading coefficient never
vanishes for an actual remaining map. The necessary passport and ODE
are inputs from the
[preceding differential-system audit](DEGREE84_DIFFERENTIAL_SYSTEM_AUDIT_2026_09_10.md).

The small script was replayed: its mathematical work took0.224seconds
(about2.9seconds including Sage startup). It returned two degree-four
horizontal polynomials with gcd1, Wronskian a nonzero constant times F,
cofactor T-degrees[3,3,3,3,4,4], Araw degree18, and a degree-two
four-term leading coefficient. Its cofactor and original ODE identities
passed. No heavy calculation was run.

## 1. The four residue classes and the full horizontal space

Work over the algebraically closed geometric coefficient field k of
characteristic five, with T=u^5. Let E=k(u) and K0=k(T). Then E has
K0-basis1,u,u^2,u^3,u^4, and K0 is precisely the constant field of
the derivation d/du.

The second necessary derivative identity is

    3CB'-2BC'+sA=3(BC)'+sA=0,

because-2=3. Since s!=0, A is a nonzero scalar multiple of a polynomial
derivative. Thus A4=A9=A14=0, and the actual monic degree18 polynomial
has the unique form

    A=sum_(i=0)^3 u^i A_i(T),       deg_T A_i<=3.

Let H0,H1 be the script's two degree-four solutions of

    F H''+4F'H'+(3F''-P)H=0.

Their nonzero Wronskian implies that they form a basis over K0 of ALL
solutions in E, not only the polynomials of degree at most four.
Indeed, for any solution H, solving

    H=a H0+b H1,       H'=a H0'+b H1'

by the Wronskian gives rational a,b in E. Differentiating their
Wronskian quotient formulas and using the same second-order equation
shows a'=b'=0. Hence a,b belong to K0. This uses no division by five.
In particular the actual horizontal product H=AC is in K0 H0+K0 H1.

## 2. Rank five at every actual C

Let W be the K0-span of1,u,u^2,u^3, and let M be the five-by-six
matrix with columns

    C, Cu, Cu^2, Cu^3, -H0, -H1

in the displayed basis of E. Multiplication by the nonzero monic
polynomial C is invertible in E. The first four columns therefore
have rank four. If ell:E->K0 extracts the u^4 coefficient, then

    rank(M)<5 iff ell(H0/C)=ell(H1/C)=0.

Since C^5 belongs to k[T] and is nonzero, define

    D_i(T)=ell(H_i C^4).

The last rank condition is exactly D_0=D_1=0 as polynomials in T.

For any root r of C, specialize T=r^5. Reduction modulo u^5-T
then becomes reduction modulo(u-r)^5. Writing x=u-r gives

    C(r+x)^4 = C'(r)^4 x^4 modulo x^5,
    H_i(r+x) C(r+x)^4
      = H_i(r) C'(r)^4 x^4 modulo x^5.

The coefficient of u^4 of a polynomial of degree at most four is
unchanged by translation u=r+x. Consequently the proposed identity
is exact, with no missing scalar or factorial:

    D_i(r^5)=H_i(r) C'(r)^4.

For an actual cover, C is squarefree, so C'(r)!=0 at each root.
The checked gcd(H0,H1)=1 means they cannot both vanish at r. Thus
D_0,D_1 cannot both be zero polynomials. Therefore M has rank five
over K0 for every actual C. This conclusion holds after specialization
of the six C coefficients; it is not merely generic rank.

## 3. Cofactors give the same kernel and the required degree bound

Let v_j=(-1)^j det(M with column j deleted), with indices0,...,5.
The usual repeated-row determinant identity gives Mv=0. Rank five
ensures that the specialized cofactor vector is nonzero and spans
the one-dimensional kernel over K0.

The script computes these determinants over k[c0,...,c5,T]. Each
of the first four columns has T-degree at most one; H0,H1 have no
T dependence. Thus each v_i for i=0,...,3 has T-degree at most three
and degree at most three in the C coefficients: its determinant
uses three C columns and both horizontal columns. It follows
universally, before or after specialization, that

    Araw=sum_(i=0)^3 u^i v_i(u^5),       deg_u Araw<=18.

The matrix identity becomes the exact polynomial identity

    C Araw=H0 v_4(u^5)+H1 v_5(u^5).

Substitution T=u^5 identifies the quotient by u^5-T with the ordinary
polynomial ring in u, so this is not merely a congruence with an
unretained remainder. It also gives the original horizontal ODE,
since derivatives of v_i(u^5) vanish. The determinant sign in the
script agrees with its negative H0,H1 columns.

The actual A and its horizontal coefficients furnish the nonzero
kernel vector(A_0,...,A_3,a,b). Hence the specialized cofactor vector
equals f(T) times this vector for some nonzero f in K0. In particular

    Araw=f(u^5) A,

and Araw is nonzero. No choice of a particular nonvanishing minor
has been made at this point.

## 4. Primitivity forces the multiplier to be constant

The actual passport makes A squarefree. Consequently

    gcd(A_0(T),A_1(T),A_2(T),A_3(T))=1.

Otherwise a nonconstant common factor d(T) would give the divisor
d(u^5) of A. Over k, d(u^5) is a fifth power of a nonconstant
polynomial, contradicting squarefreeness.

Write f=N/D in lowest terms in k(T). Since every coefficient
v_i=f A_i is in k[T], D divides each A_i. Their gcd is1, so D is a
unit and f is a polynomial. The exact product degree is then

    deg_u Araw=5 deg_T f+deg_u A=5 deg_T f+18.

Together with Araw!=0 and deg_u Araw<=18, this forces f to be a
nonzero scalar. Because A is monic, that scalar is precisely

    L(C)=[u^18]Araw.

Therefore L(C)!=0 at EVERY actual cover point and

    A=Araw/L(C).

The proposed single inverse for L(C) covers all actual maps, including
all their specializations that remain in the actual squarefree
passport locus. There is no additional actual boundary chart with
L(C)=0. The other original necessity s!=0 must still be retained.

For implementation one may set A=z*Araw and impose z*L(C)-1=0,
then retain the remaining original equations under this substitution.
This eliminates all eighteen free A coefficients while preserving
the implication from every actual cover. Degenerate solutions of the
earlier weak system may be discarded by this localization; the proof
does not claim equivalence of those enlarged schemes or any result
about whether the reduced system is empty.

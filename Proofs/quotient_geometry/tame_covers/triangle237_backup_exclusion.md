# Proof: exclusion of the backup (2,3,7) map

[Cored-span theorem](../../../Theorems/quotient_geometry/endpoint_exclusions/backup_cored_span_exclusion.md).
Write k=bar(F5), C_alpha:v²=F(u), and
F=u(u-1)(u-2)(u-3)(u-alpha), where alpha³+alpha+1=0.
The proof combines a finite monodromy sieve with a dormant pullback.
The remaining covers would be defined over F_(5^30), whereas their
pole coordinate satisfies an exact polynomial with no root in that field.

## 1. The complete census and its geometric partition

[Tame specialization](tame_cover_frobenius_sieve.md#1-tame-specialization)
injects the proposed covers into the complex classes of transitive
permutation pairs of types 2^42,3^28,(ba):7^12. In fact every pair of
this passport is transitive: an orbit has size divisible by42, and on
a42-element orbit a would be odd while b and ba would both be even.

The [census verifier](../../../scripts/orbifolds/triangle237_certificate/verify84.py)
checks155 pairwise inequivalent tables, using the least of84 rooted
traversal codes, and computes each full centralizer by its possible
images of one sheet. The distribution of centralizer orders is

    order:    1   2   4   6  12
    classes:  6  90  44   9   6.

Their reciprocal-centralizer mass is64. Independently,
[characters84.cpp](../../../scripts/orbifolds/triangle237_certificate/characters84.cpp)
computes the same mass over all26,543,660 partitions of84:

    sum_lambda H_lambda chi_lambda(2^42)chi_lambda(3^28)chi_lambda(7^12)
               / (z_2 z_3 z_7) = 64,
    z_e=e^(84/e)(84/e)!.

Here H_lambda is the hook product. This is the
[Frobenius class-product formula, Jones–Zvonkin Theorem2.1 and Section2.2](https://arxiv.org/pdf/2012.07107#page=4)
and the hook-length degree formula. Characters are evaluated by the
e-quotient form of Murnaghan–Nakayama; direct rim-hook recursion checks
the implementation on3953 small cases. The latter is not a second
full degree84 mass calculation. Every omitted class would add positive
mass, so validity, inequivalence and mass equality prove completeness.

The verifier checks actual commuting permutations and invariant
partitions, with the following disjoint outcomes:

| Geometric outcome | Classes |
|---|---:|
| Deck group larger than2 |59|
| Deck involution with two fixed points |30|
| Another elliptic intermediate quotient |3|
| Degree12 intermediate map of profile(2,2,2,3) |18|
| Hyperelliptic factor with outer degree42 |42|
| Primitive action |3|

A commuting involution fixes exactly the inertia cycles it preserves
setwise. Two fixed points give a genus-one quotient. For a block
system, the induced cycles give the quotient genus by tame Hurwitz;
an outer cycle of length ell above inertia e gives inner index e/ell.
Thus these are actual intermediate maps on the same source.
[Backup arithmetic](../../curve_arithmetic/backup_curve_arithmetic.md)
excludes the extra automorphisms and elliptic quotients, and the
[quadrangular theorem](quadrangular_genus_two_hecke_obstruction.md)
excludes the degree12 maps.

Each of the42 hyperelliptic cases has a unique proper block system,
of block size2. Its degree42 quotient has complete profiles
(1^6 2^18,3^14,7^6); the six simple zeros are precisely the
hyperelliptic branch points. Only three primitive classes remain.

## 2. A dormant pullback excludes the primitive cases

On the normalized target put

    r_0(t)=(2t²+3t+2)/(t²(t-1)²).

The equation y''=r_0 y has the independent rational horizontal solutions

    y_0=t²(t-1)²,    y_1=y_0(2t³+2t²),
    y_0 y_1'-y_0' y_1=t^5(t-1)^5 !=0.

Their fundamental matrix trivializes the rational connection, so its
p-curvature is zero. For an actual tame map f with indices2,3,7,
the projective pullback is

    r_C(z)=(f'(z))² r_0(f(z)) - {f,z}/2.

It is regular: in a tame coordinate t=z^e its double-pole coefficient
is2e²+(e²-1)/4=0 in F5 for e=2,3,7. A base simple pole pulls back
to order e-2>=0. At infinity use inversion, whose Schwarzian is zero.
Hence every proposed cover supplies a regular dormant projective
connection, functorially over F5.

The backup has moduli Frobenius orbit3 and Aut(C_alpha)=C2. Its five
dormant connections form one Frob125 orbit by the
[backup dormant calculation](../endpoint_exclusions/backup_hermitian_atlas_exclusion.md).
The hyperelliptic involution fixes projective connections by the
[scalar-model torsor argument](../../projective_connections/nilpotent_scalar_model.md#2-n-equations-their-exact-length-and-infinity).
The [decorated Frobenius bound](tame_cover_frobenius_sieve.md#1-tame-specialization)
therefore makes every proposed cover orbit divisible by15.
Primitivity and the preceding source exclusions are Frobenius-invariant,
so a primitive cover would require15 classes in a part of size3.

The remaining42-class part is also Frobenius-stable. Every orbit in it
therefore has length15 or30, so its cover class is fixed by Frob5^30.
The source model itself is fixed, since alpha lies in F125. Both of its
automorphisms fix u; the distinct inertia orders fix the normalized
target coordinate. Thus a factorization f=q(u) has q^(5^30)=q as a
rational function. This is an equality of coefficients, without any
field-of-moduli descent assumption. In the unique monic/leading-sign
normalization below, A,B,C and s consequently lie in K2=F_(5^30).

## 3. The differential coefficient system

A remaining map factors through the hyperelliptic quotient. In its
fixed coordinate the outer map and passport have the normalization

    q=s F A²/C^7,          s F A²-B³=C^7,
    deg(A,B,C)=(18,14,6),  leading coefficients=(1,-1,1),
    s=3b13+2c5 !=0.                                      (1)

Here A,B,C are polynomials. Their divisors are squarefree and pairwise
disjoint; they avoid the relevant fixed branch points. Infinity is a
simple zero of q, with q=s/u+O(u^-2).

Ramification and this scalar at infinity give q'=-sAB²/C^8.
Differentiating q and q-1 yields

    (F'A+2FA')C-2FAC'+B²=0,
    3(BC)'+sA=0.                                        (2)

The second identity implies a4=a9=a14=0. These are exact consequences
after adjoining loc*s-1: loc*(s*a_i)-a_i*(loc*s-1)=a_i.

Write the pulled-back regular dormant potential as

    r_u=2(F'/F)²-F''/F+P/F,
    P=2u³+beta*u²+b1*u+b0,
    b1=beta²+3F4*beta+3F3,
    b0=-F2+(F4+2beta)*b1,

where Fi is the coefficient of u^i in F. The possible beta are the
five roots of the irreducible polynomial over F125

    z^5+(alpha+1)z^4+(2alpha²-2)z³-2alpha²z²
       +(-2alpha²+alpha+1)z+(2alpha²+2alpha-2).            (3)

Locally the horizontal solution y_0 pulls back as
Y=y_0(q)/sqrt(q'). For h=F²AC, substitution in(1) gives

    Y²/h²=-s³ A^5 B^10/C^50.

Its derivative is zero, so Y'/Y=h'/h. Expanding h''-r_u h shows that
H=AC satisfies

    F H''+4F'H'+(3F''-P)H=0.                            (4)

All five systems are Frobenius conjugate over F125. Fix one beta in
K=F_(5^15), a subfield of K2. It suffices to exclude K2-valued solutions
of any necessary subsystem: every actual map has its coefficients in
K2, and conjugacy preserves this field.

## 4. The cofactor chart contains every actual map

For the chosen beta, the
[cofactor verifier](../../../scripts/orbifolds/triangle237_certificate/verify_cofactors.sage)
finds two degree-at-most-four solutions H0,H1 of(4), with gcd1 and
Wronskian a nonzero constant times F, and checks these identities.
They span every rational solution over the constant field k(u^5):
differentiate the coefficients expressing (H,H') in their fundamental
matrix.

Put T=u^5. Write, in the basis1,u,...,u^4 of k(u)/k(T), the5x6 matrix
with columns

    C, Cu, Cu², Cu³, -H0, -H1.

The actual solution gives a kernel vector because a4=a9=a14=0.
Its rank is5 on every actual map. Indeed multiplication by C is
invertible, so rank could drop only if both H_i/C had zero u^4
coordinate. Let D_i(T) be the u^4 coordinate of H_i C^4. At a simple
root r of C, reduction modulo(u-r)^5 gives

    D_i(r^5)=H_i(r) C'(r)^4.

These cannot both vanish, since gcd(H0,H1)=1.

Let v_j(T), j=0,...,5, be the signed maximal minors, and set

    A_raw=sum_(j=0)^3 u^j v_j(u^5),    L=[u^18]A_raw.

The first four minors use three multiplication-by-C columns, so have
degree at most3 in T and deg_u(A_raw)<=18. Rank5 gives
A_raw=f(T)A for a nonzero rational f. The coefficient polynomials of
A=sum_(j=0)^3 u^j A_j(T) are primitive: a common factor would give A
a factor g(u^5), contradicting squarefreeness. Gauss divisibility makes
f polynomial, and the degree bound makes it a nonzero constant.
Thus L!=0 and A=A_raw/L for every actual map.

This removes the numerator coefficients without omitting a boundary
chart. The minor identities, the original differential equation and
the coefficient degree bounds are checked symbolically. The
[native chart audit](../../../scripts/orbifolds/triangle237_certificate/verify_native_chart.py)
also reconstructs the exact field, native equations and the joint
three-pole substitutions used by the final certificate.

## 5. A polynomial obstruction to the coefficient field

All data below are relative to
/Users/julian/Documents/litt3-computation-data.

Start with the115 native coefficients of(1),(2),(4), including loc*s-1,
and adjoin their three consequences a4=a9=a14=0. The actual simple
zero at u=0 requires C(0)!=0, so also adjoin pole0_inv*c0-1.
Cancellation of f=c0*g is justified by the identity

    g=pole0_inv*f-(pole0_inv*c0-1)*g.

The retained necessity chain uses the following exact operations.

1. Seven affine pivots and the C(0) inverse give33 variables.
   Polynomial consequences and13 further affine pivots give20 variables;
   c0,c1,c4 are expressed using c2,c3,c5.
2. Tracked partial bases are interleaved with exact division of all216
   equations of the33-variable system through those pivots. The three
   retained full transports give250 equations in20 variables.
3. Substitute the cofactor expression A_raw/L and adjoin lead_inv*L-1.
   This gives251 equations in seven variables.
4. From the63 rows of degree at most6, take14 verified consequences.

Let I be the ideal generated by these14 polynomials over K, and x=c5.
The certificate gives64 distinct monomials m_j, including1, and a
matrix M over K with exact identities

    x m_j = sum_i M_ij m_i mod I.

Each identity is an explicit polynomial combination of the inputs
and110 preceding verified consequences. The listed monomials need
neither span K[variables]/I nor be independent. Closure under x alone
is enough: if e is the coordinate vector of1, induction gives
x^n=sum_i (M^n e)_i m_i mod I.

The certificate supplies a monic degree64 polynomial h with h(M)e=0,
checked by matrix-vector Horner evaluation. Consequently h(c5)=0 at
every solution. Thirty successive fifth-power reductions compute
r(T)=T^(5^30) mod h, and explicit polynomials U,V satisfy

    U(T)h(T)+V(T)(r(T)-T)=1.

Thus h has no root in K2. This contradicts the coefficient-field
bound in Section2. No Gröbner-basis completeness or radicality claim
is needed.

Both source and certificate lie in degree84-three-pole-low6-tracked-20260911:

    basis.json
    SHA256 cdbcb6a11258ca8a0f64723a2098112c276d9fa43f068ed6e626508801d3ddae
    frobenius_obstruction.json
    SHA256 e1f73410531e39b91657a7fe7e2dfd46d8766e61ffc2bffabdb85248cf4f0c8a

[assemble_provenance.py](../../../scripts/orbifolds/triangle237_certificate/assemble_provenance.py)
checks all34 source nodes, including affine pivots, factor cancellations,
subset maps and full equation transports, and always replays the field
obstruction. Its --replay option also reruns the127 retained polynomial
identity checks. Every actual map supplies a K2-valued zero of this
necessary system. Frobenius conjugacy covers all five dormant potentials;
Section2 covers the primitive cases. Hence no class of the passport
occurs on C_alpha.

## Reproduction and audits

The census tables and mass output are in
degree84-census.
The table hash is97aad0a105d12d0905415d16c3df2094e87fd5522f62e11dc86680f6de053926.

```sh
python3 scripts/orbifolds/triangle237_certificate/verify84.py TABLES MASS_OUTPUT
sage scripts/orbifolds/triangle237_certificate/verify_cofactors.sage
sage -python scripts/orbifolds/triangle237_certificate/assemble_provenance.py /tmp/degree84-replay --replay
sage -python scripts/orbifolds/triangle237_certificate/generate_frobenius_obstruction.py SOURCE /tmp/frobenius.json
python3 scripts/orbifolds/triangle237_certificate/verify_frobenius_obstruction.py SOURCE /tmp/frobenius.json
```

Use the saved tables84.jsonl and character_local.txt for TABLES and
MASS_OUTPUT, and basis.json above for SOURCE. The field certificate
regenerates byte-for-byte from its14 inputs; its independent verifier
uses only the Python standard library. To regenerate the census, compile
[the shared enumerator](../../../scripts/orbifolds/enumerate_23m_monodromy.cpp)
and characters84.cpp, then pass the fresh tables and mass output to
the verifier:

```sh
c++ -O3 -std=c++17 scripts/orbifolds/enumerate_23m_monodromy.cpp -o /tmp/triangle237
/tmp/triangle237 84 7 /tmp/tables84.jsonl
```

The character program uses Boost.Multiprecision headers.

The retained independent audits cover the
[dormant pullback](../../../Research/audits/TRIANGLE237_DORMANT_DECORATION_AUDIT_2026_09_10.md),
[differential equations](../../../Research/audits/DEGREE84_DIFFERENTIAL_SYSTEM_AUDIT_2026_09_10.md),
[cofactor coverage](../../../Research/audits/DEGREE84_COFACTOR_REDUCTION_AUDIT_2026_09_10.md),
[native chart](../../../Research/audits/DEGREE84_THREE_POLE_COFACTOR_CHART_AUDIT_2026_09_11.md)
and [source-chain assembly](../../../Research/audits/DEGREE84_FINAL_EXCLUSION_AUDIT_2026_09_11.md).
The last audit originally checked a stronger unit certificate; that
superseded final computation is no longer used here. On2026-09-14 a
bounded independent audit (Lovelace) passed the coefficient-field bound
and closed-monomial argument. The new exact identities pass independent
replay, including rejection of an altered annihilator.

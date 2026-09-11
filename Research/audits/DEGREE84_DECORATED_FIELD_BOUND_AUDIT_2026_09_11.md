# Degree84 decorated field and reducedness audit

- Verdict: **PASS**, including the additional guarded-open recovery in
  Section6. The full passport open may be replaced by the stated
  `C`-squarefree, `gcd(C,F)=1`, `s!=0` guards when all its other equation
  hypotheses are retained.
- Auditor: `/root/audit_degree84_field_bound`.
- Date: 2026-09-11.
- Scope: new decorated cardinality/field bound and geometric reducedness;
  no degree84 exclusion and no new census computation.
- Objection requiring a scope distinction: geometric reducedness and
  length at most two apply to the **complete squarefree/disjoint passport
  scheme**, not automatically to a larger necessary-equation ideal from
  which some opens have been omitted. Section6 proves that those omitted
  opens follow on one specifically guarded necessary system; it does not
  remove the `C`-squarefree or `gcd(C,F)=1` guards.

The audit reads the canonical statements, dependency inventories, and
needed proofs of `triangle237_dormant_orbit_obstruction` and
`triangle237_cofactor_necessary_system`. Their previously audited census,
source-automorphism, dormant-oper, and normalization inputs are retained
as inputs rather than re-audited here.

## 1. Precise cardinality statement

Put `k=bar(F5)`, `K=F_(5^15)`, and

    C_alpha: v^2=F(u),
    F=u(u-1)(u-2)(u-3)(u-alpha), alpha^3+alpha+1=0.

Fix one of its five dormant projective connections `r`, hence fix its
potential `P` over `K`. Let `S_r` be the set of rational functions `q`
in the **fixed** coordinate `u` such that `f=q o pi`, with `pi:C_alpha
->P1_u`, is an actual tame degree84 cover with the individually labeled
branch values `0,1,infinity`, full fibers `(2^42,3^28,7^12)`, and
functorial dormant decoration `r`.

Then

    |S_r| <= floor(42/15) = 2.

Here are the two markings that make division by 15 legitimate.

1. The three displayed Frobenius-conjugate source models have pairwise
   different geometric isomorphism classes. On each of them, the five
   dormant opers are one orbit under coefficient `Frob125`. Every source
   automorphism fixes each of these five opers. Consequently coefficient
   Frobenius gives fifteen pairwise distinct source/decoration fibers,
   all of the same cardinality as `S_r`.
2. On a fixed displayed source, two maps `q_1 o pi` and `q_2 o pi` are
   isomorphic as normalized covers only if `q_1=q_2`. Indeed every source
   automorphism is either the identity or the hyperelliptic involution,
   and both act trivially on `u`. No extra choice of source coordinate
   or field-of-moduli descent is being counted.

All these cover classes lie in the remaining42 hyperelliptic bucket:
the inherited exclusions are invariant under coefficient conjugation,
and the full tame-specialization injection bounds the number of actual
classes by the census. Thus the fifteen fibers contribute at least
`15|S_r|` distinct members to a bucket of size42. An equivariant choice
of the specialization injection is not needed; injectivity suffices.

This argument does not assert that all42 census classes occur in
characteristic five, nor that their sources are conjugates of `C_alpha`.

## 2. Actual fields of definition, not just fields of moduli

Coefficient `Frob_(5^15)` preserves the fixed source, the fixed dormant
connection, and `S_r`. A permutation of a set of at most two elements
has square equal to the identity. Hence every actual `q` is fixed as a
rational function by coefficient `Frob_(5^30)`:

    q belongs to F_(5^30)(u).

Write its uniquely normalized passport as

    q=s F A^2/C^7,       s F A^2-B^3=C^7,
    A monic degree18, C monic degree6,
    B degree14 with leading coefficient -1, s!=0.

The zero and pole divisors determine the monic polynomials `A,C`; then
`s` is determined by `q`. The monic-normalized cube factor is unique
after fixing the leading coefficient of `B`. These constructions are
Frobenius-equivariant. Therefore every coefficient of `A,B,C,s` belongs
to `F_(5^30)` as well. This remains true of the uniquely prescribed
inverse coordinates used to enforce nonzero guards.

If `S_r` has one element, it is already defined over `K`. At cardinality
two, either both elements are defined over `K` or they form a quadratic
conjugate pair over `K`.

## 3. The complete coefficient scheme

For the scheme statement, use the monic and leading-minus-one
normalizations just displayed, the full coefficient identity

    s F A^2-B^3=C^7,

the fixed-`P` horizontal equation from the canonical dictionary, and
the open where `s` is nonzero, `A,B,C` are squarefree and pairwise
coprime, and each is coprime to `F`. For example, one may invert

    s disc(A) disc(B) disc(C)
      Res(A,B) Res(A,C) Res(B,C)
      Res(F,A) Res(F,B) Res(F,C).

The polynomial `F` is already squarefree. Redundant derivative equations
and the cofactor normalization may be imposed as well when their full
actual-domain coverage has been retained. Inverse variables are subject
to their defining inverse equations; they are not free parameters.

Every geometric point of this open is an actual cover. The rational map
has degree42; its zero, one, and infinity fibers have complete profiles
`(1^6 2^18,3^14,7^6)`, with the six simple zeros precisely the fixed
hyperelliptic branch points including infinity. Its composite with the
fixed hyperelliptic quotient has the required uniform profile.
Riemann--Hurwitz accounts for all its ramification, and the indices
2,3,7 are prime to five.

The horizontal equation really selects the fixed dormant decoration,
not an unrelated polynomial condition: the canonical dictionary's
identity identifies the pulled-back scalar as `h''/h` for
`h=F^2 A C`; its horizontal equation is exactly `h''=r_P h`.
Since `h` is nonzero, a point satisfying it has decoration `r_P`.

Thus this finite-type coefficient scheme has at most two geometric
points by Section1.

## 4. An elementary tangent proof of reducedness

No deformation assertion for root stacks is necessary.

Let `f:C_alpha->P1` be one of the covers, and consider a tangent vector
to the complete passport scheme, over `k[epsilon]/(epsilon^2)`. It gives
a first-order variation `delta f` of the map with source and target
fixed, hence a section of `f^*T_(P1)`. This is the ordinary derivation
description of infinitesimal variations of a map; see
[Stacks, infinitesimal deformations of maps](https://stacks.math.columbia.edu/tag/04BU).

At a source point of ramification index `e` above a fixed branch value,
the squarefree divisor factors lift over the dual numbers. In a local
target parameter the map is a unit times an `e`-th power of a local
source parameter whose zero may move. Its first variation is therefore
divisible by the `(e-1)`-st power of that source parameter. The same
argument uses the target parameter `1/t` above infinity. Thus

    delta f belongs to H^0(C_alpha, f^*T_(P1)(-Ram(f))).

For this separable tame map, the differential identifies the line bundle
on the right with `T_(C_alpha)`: its vanishing divisor is exactly the
tame ramification divisor. Since `C_alpha` has genus two,

    H^0(C_alpha,T_(C_alpha))=0.

It follows that `delta f=0`, and therefore `delta q=0`.

This also kills the coefficient tangent, not only the map tangent.
Logarithmic differentiation of the normalized rational function gives

    0=delta q/q=delta s/s + 2 delta A/A - 7 delta C/C.

The squarefree and disjoint `A,C`, and the units `2,7` in characteristic
five, imply respectively `A | delta A` and `C | delta C`. Their leading
coefficients are fixed, so `deg(delta A)<18` and `deg(delta C)<6`;
hence `delta A=delta C=0`, and then `delta s=0`. Differentiating the
full passport identity yields `3 B^2 delta B=0`, so `delta B=0`.
All inverse-coordinate tangents vanish as well.

Every Zariski tangent space of the complete open coefficient scheme is
therefore zero. A finite-type affine scheme with finitely many geometric
points is zero-dimensional and Artinian. At each geometric local ring,
`m/m^2=0`, so Nakayama gives `m=0`. Consequently the scheme is
geometrically reduced, and its geometric length is at most two.

The same conclusion applies to a closed necessary-equation subscheme
of this full open, since a subscheme of a finite reduced scheme over a
field is reduced. It does not apply to the larger scheme before the
omitted discriminants/resultants are inverted.

## 5. Safe computational consequences and limits

Over `K`, the complete coefficient algebra is finite etale of rank
0,1,or2. It is respectively the zero algebra, `K`, `K x K`, or the
quadratic field `F_(5^30)`. Thus all coordinate equations

    z^(5^30)-z=0

hold scheme-theoretically on this complete passport open. Even without
using reducedness, they would still be safe additional **necessary
equations for actual points** in a larger search; that weaker use alone
must not be described as preserving the larger nonreduced ideal.

After a single Rabinowitsch inverse realizes the full open as an affine
scheme, its exact ideal, if proper, has quotient dimension at most two.
For a global monomial order its standard-monomial set is therefore
`{1}` or `{1,z}` for one coordinate `z`. Its reduced Groebner basis has
degree at most two. At dimension two some coordinate generates the
entire algebra, and every other coordinate is affine-linear in it.

This is a structural target for the saturated ideal. It gives no bound
on the degree of a certificate expressing those low-degree generators
in the original equations, no runtime estimate for saturation or a
Macaulay pass, and no current unit certificate. The degree84 row and
the original common-cover problem remain unresolved.

## 6. Additional audit: the guarded necessary system forces the full open

**PASS.** Assume all the following hypotheses at a geometric point:

- The full normalized passport `s F A^2-B^3=C^7`, with the degrees and
  leading coefficients in Section2, and `s!=0`.
- The horizontal equation for `H=C A` and the fixed dormant potential.
- The residue-class restriction `A_4=A_9=A_14=0`. In the stated solver
  system it also follows from `3(BC)'+sA=0` and the nonzero `s` guard.
- The polynomial `C` is squarefree and `gcd(C,F)=1`.

The first derivative identity may also be retained. The argument below
does not need to weaken any of the listed hypotheses.

Let `H_0,H_1` be the established degree-at-most-four fundamental
horizontal polynomials, with Wronskian `cF` for `c!=0`. Put `T=u^5`,
and let `D_i(T)` be the coefficient of `u^4` in the reduction of
`H_i C^4` in the basis `1,u,...,u^4` over `k[T]`. Define

    N_star=H_0 D_1(u^5)-H_1 D_0(u^5),
    A_star=N_star/C.

### Polynomiality and nonvanishing at every root of C

At a root `r` of `C`, reduce in
`k[u]/(u^5-r^5)=k[u]/((u-r)^5)`. Since `C` is squarefree,

    H_i C^4 = H_i(r) C'(r)^4 (u-r)^4 modulo (u-r)^5.

The coefficient of `u^4` in `(u-r)^4` is one. Therefore

    D_i(r^5)=H_i(r)C'(r)^4.

It follows that `N_star(r)=0` at every root of the squarefree `C`, so
`A_star` is a polynomial. Differentiation of the `D_i(u^5)` terms gives
zero in characteristic five. Consequently

    A_star(r)=N_star'(r)/C'(r)
             = +/- c F(r) C'(r)^3 !=0.

The sign depends only on the convention for the Wronskian. This also
proves that `A_star` is nonzero and coprime to `C`.

### The ratio A/A_star lies in k(u^5)

Multiplication by `C` is invertible in the degree-five extension
`k(u)/k(u^5)`. The first four columns `C,Cu,Cu^2,Cu^3` are independent.
The matrix formed by these columns and `-H_0,-H_1` has rank below five
only if both `H_i/C` have zero `u^4` coefficient over `k(u^5)`. Those
coefficients are `D_i/C^5`, with the same nonzero constant-field
denominator. The displayed evaluations at roots of `C`, and the
nonzero Wronskian there, show that `D_0,D_1` are not both zero.
Thus this matrix has rank five and a one-dimensional kernel.

Both `A` and `A_star` belong to its horizontal intersection:
`CA` does by hypothesis; `C A_star` does because its coefficients of
`H_0,H_1` have derivative zero. Moreover `A_star` has zero `u^4`
coordinate, since that coordinate is

    (D_0/C^5)D_1-(D_1/C^5)D_0=0.

The restriction on `A_4,A_9,A_14` says the same for `A`. Therefore

    A=f(u^5) A_star,     f in k(T), f!=0.

This assertion allows `f` to have poles; it does not assert that it is
a polynomial. At a root `r` of `C`, however, `A_star(r)!=0`, and hence

    ord_r(A)=5 ord_(T-r^5)(f).

Since `A` is polynomial, this valuation is a nonnegative multiple of
five. Poles or cancellations at other points do not affect this local
conclusion.

### A common root of A and C is impossible

Suppose `r` were a common root, and write
`a=ord_r(A)>0`, `b=ord_r(B)`. Since `F(r)!=0`, the passport forces
`b>0` and compares the three valuations `2a,3b,7`.

Neither `2a` nor `3b` can equal seven. Their minimum cannot exceed
seven. If they differed, their minimum would be the valuation of their
difference, again not seven. Thus

    2a=3b<7,

which forces `a=3,b=2`. This contradicts the just-proved divisibility of
`a` by five. Hence `gcd(A,C)=1`; the passport then gives
`gcd(B,C)=1` as well.

### Riemann--Hurwitz supplies the remaining opens

The rational function `q=sFA^2/C^7` now has degree42 without
cancellation. Since five does not divide42, it is separable. Its zero
fiber contains at most24 distinct points: the five finite roots of
`F`, infinity, and at most18 additional roots of `A`. Its one fiber
contains at most14 distinct roots of `B`. Its pole fiber consists of
the six distinct roots of `C`.

The sums of `e_P-1` over these three fibers are therefore at least

    42-24=18,     42-14=28,     42-6=36.

Their total82 equals the full different degree `2*42-2` of a
separable degree42 map between projective lines. The different
exponent is always at least `e_P-1`. Equality is consequently forced
throughout, with no further ramification. In particular, `A` has18
distinct roots, none on `F`, and `B` has14 distinct roots. The
passport also makes `A,B` disjoint and makes `B` disjoint from `F`.
Together with the retained guards, this is exactly the full
squarefree/disjoint passport open of Section3.

### Scheme consequence on this specific guarded solver system

The argument so far is pointwise over an algebraic closure. This is
enough to recover the opens scheme-theoretically: the guarded solver
algebra is finite type over a field and hence Jacobson. Each omitted
passport discriminant or resultant vanishes at no geometric closed
point, so it belongs to no maximal ideal and is a unit. Localizing by
these omitted factors therefore leaves this guarded scheme unchanged,
including any initially possible nilpotents.

Section4 now applies to the unchanged scheme and excludes those
nilpotents. Thus the necessary system with the full passport,
horizontal equation, residue-class restriction, and precisely the
retained `s`, `disc(C)`, `Res(C,F)` guards is already finite etale of
rank at most two over `K`, for a fixed dormant potential.

In explicit branch-root form the required guards are

    s disc(C) C(0) C(1) C(2) C(3) C(alpha) !=0.

Keeping only `C(0)!=0` is not enough for this argument. Neither
squarefreeness of `C` nor its disjointness from all five finite branch
points has been derived or removed here.

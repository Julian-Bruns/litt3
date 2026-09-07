# Proof: a characteristic-five secant identity and the actual common intersection

[Statement](../Theorems/Thm_cartier_dormant_secants.md).
Author /root,2026-09-07. No independent audit claimed.

## 1. Intrinsic potentials and exact Cartier identities

Take any separating local parameter t and D=d/dt. It satisfies D^5=0
on k(C). For s=a(dt)^2, changing from x to t gives a_t=a_x(x')^2.
Twice differentiating and using5=0 gives

    a_t''/a_t=(x')^2 a_x''/a_x+2x'''/x'+2(x''/x')^2
             =(x')^2 a_x''/a_x−{x,t}/2.

Adding or subtracting s therefore gives the asserted projective connections.
For E(r)=r''−3r^2, the horizontal companion fifth-iterate matrix is

    [[E',3E],[E''+3rE,−E']].                            (1)

This follows by five iterations M_(i+1)=D M_i+M_i M with
M=[[0,1],[r,0]], M_0=I. The p-curvature of D−M is the NEGATIVE
of this matrix, as the separate connection-iterate check confirms.
Hence dormancy is exactly E=0, even over
parameter rings. This is the same scalar convention used in
`fixed_x_dormant_equations`, not a new oper normalization.

In the separable quadratic field extension with v^2=a, put eta=v dt.
The separating parameter t remains separating. If
v=sum_(i=0)^4 v_i^5 t^i, then D^4v=−v_4^5. Consequently

    C(eta)=0 iff D^4v=0,
    C(eta)=eta iff D^4v+v^5=0.                          (2)

If a is already a square, use either component instead. No regularity
of eta is needed for these rational identities. Since a^3=v^5 v,
Cartier's product rule also gives

    C_1(s^3)=v C(eta) dt.                              (3)

A direct differentiation, with all coefficients in characteristic five,
gives the three identities

    E(a''/a)=2 D^4v/v,
    E(a''/a−a)=E(a''/a+a)=2(D^4v/v+a^2),
    E(r+c a)−E(r)=c(a''−r a)−3c^2 a^2                 (4)

for constant c. Equations(1)–(4) prove both Cartier equivalences.
For an ordered dormant pair r_−,r_+, put a=(r_+−r_−)/2. Subtracting
their equations yields a''=r_−a+a^2, hence r_−=a''/a−a and
r_+=a''/a+a. This also proves uniqueness, including the normalization.
Swapping the pair sends a to−a. A projective eigenform has precisely
two normalizations C_1(s^3)=s, because the nonzero scaling equation is
lambda^2=c^5 when C_1(s^3)=c s. Thus the unordered correspondence follows.

The exact jet and full companion-matrix identities are independently
checked as polynomial identities by
[the short Sage checker](../scripts/check_cartier_dormant_secants.sage).
Its PASS is an algebra check, not an audit of this entire theorem.

## 2. Regularity is an exact condition, not an omitted infinity test

At any zero, write a=t^e u with u a unit. The only possible poles of
a''/a are a double pole of coefficient e(e−1) and a simple pole.
Subtracting or adding the regular coefficient a does not change them.
If e is neither0 nor1 modulo five, that double pole is nonzero.
If e is0 or1 modulo five, there is at most a simple pole. A dormant
potential cannot have a simple pole: r=c/t+O(1), c!=0, would make
r'' have nonzero t^−3 coefficient2c, while3r^2 has pole order at most2.
Thus the possible simple pole vanishes. At a nonzero point of s all
coefficients are regular. This proves the iff statement at EVERY point.

Linearizing E at a dormant r gives a''−r a. A nonzero regular tangent
therefore recovers r=a''/a and, by Section1, a Cartier-zero tensor.
Conversely the zero-Cartier tensor with the stated zero orders recovers
a regular r and its tangent direction. All formulas are intrinsic and
commute with etale pullback; no second endpoint is reconstructed from
Jacobian data.

## 3. At most two shared opers; reducedness for fixed X

Use both actual etale pullbacks to identify connections on the same Z.
For a coreless span, the intersection of its regular quadratic spaces
has dimension at most one: two independent shared sections would have
a nonconstant ratio in k(X) intersect k(Y). If a common connection exists,
the affine common connection space is its translate by that intersection.
On a nonconstant line r+c a, formula(4) permits at most two dormant values
of c, since a^2!=0. This proves the two-point bound without a fixed pair,
degree bound, Galois hypothesis or clump-existence assumption.

Now fix X. Its completed census has28935 reduced points and55 points
with tangent dimension3. At every latter point the tangent has ONLY the
A block in the chart of `fixed_x_dormant_equations`. Thus every nonzero
tangent tensor on X has the form

    A(x) theta^2,       deg A<=10,       theta=dx/y^2.

Its order at O is32−3deg A, a positive integer congruent to2 modulo3.
If it were shared in a coreless span, `canonical_intersection` would
make every zero have this same multiplicity e. Hence e divides32.
Section2 additionally gives e=0 or1 modulo5. Among divisors of32 only
1 and16 satisfy that congruence, and both are1 modulo3, contradiction.
No nonzero infinitesimal dormant deformation is therefore shared.

The two pulled-back oper schemes are finite closed subschemes in the
affine space of projective connections on Z. Their intersection tangent
is exactly the intersection just considered. At every geometric point
it is zero. Nakayama applied to its finite local rings then gives a
reduced intersection, of length at most two. This does NOT imply
emptiness. The55 local lengths8 are preserved in the ambient census;
they are not multiplicities in this particular common intersection.

## 4. The remaining zero-Cartier quadratic profile

If a primitive shared quadratic tensor has Cartier image zero and simple
zeros, Sections1–2 construct a shared regular dormant connection AND its
nonzero shared tangent, contradicting Section3. For any uniform quadratic
profile, its zero multiplicity e divides32. The local Cartier condition
e+2!=0 modulo5 eliminates8. Multiplicity2 is the shared-simple-root case
and forces a core. Multiplicity16 gives a reduced degree-two D with
16[D−2O]=0; `two_primary_w3` makes D=2O, impossible. Multiplicity32
similarly forces its single point to be O, so the tensor is a scalar
theta^2. The endpoint-root test would make theta Cartier-zero, contrary
to the uniform-form assertion in `fixed_x_orbifold_bound`.
Only e=1 or4 was left, and e=1 has just been eliminated.

Thus e=4 and support size8 remain, not an exclusion of that branch.
The positive-Cartier simple-zero branch corresponds to pairs from the
28990 DISTINCT opers, so at most binomial(28990,2)=420195555 projective
tensors occur. Computing this pair list is not needed for the theorem
and has not been undertaken. Known coreless dormant-oper examples are
compatible with every assertion here: one common oper is never claimed
to force a core, and two compatible opers have not been ruled out.

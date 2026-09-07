# Proof: a shared branch divisor and exact Frobenius certificates

[Statement](../Theorems/Thm_picard_simple_common_cover.md).

## 1. The geometry is parameterized and retains both actual legs

More generally work in characteristic different from3, with distinct
lambda,mu not in{0,1}. In the field

    u^3=t, v^3=(t-1)(t-lambda)(t-mu),

valuations at0 and1 prove independence of the two Kummer classes. The
normalization T of P1 in this degree9 field is a connected smooth
projective curve with Galois group C3^2. Its five branch points are
0,infinity,1,lambda,mu. At0 andinfinity inertia is the u-axis; at the
other three it is the v-axis. In particular infinity IS included: v's
pole there has order3 and its leading unit is a cube in the completed
field, so v contributes no inertia. All inertia orders are3. Tame
Riemann--Hurwitz gives2g(T)-2=-18+5*6=12, hence genus7.

The two diagonal subgroups meet neither axis except in the identity.
They therefore act freely on T, and their quotient maps are everywhere
etale Galois of degree3. For the anti-diagonal quotient use w=uv, which
gives C_plus with parameters lambda,mu. For the diagonal quotient use
x=1/t and z=v/(ut). Direct substitution gives

    z^3=x(1-x)(1-lambda*x)(1-mu*x).

Each invariant subfield has index3, as adjoining u recovers both u,v.
The smooth projective quotient curves have genus3 by Riemann--Hurwitz,
also seen from the four simple finite roots and the fully ramified
point at infinity in either quartic cubic model. The two subgroups
generate C3^2, so the endpoint fields intersect in k(t). This is an
actual cored construction, not a simultaneous-closure assumption.

## 2. Exact arithmetic at lambda=a,mu=a+2 over F25

The finite field here is F5[a]/(a^2+2), NOT the differently named
F25 generator used in the fixed genus-nine equation. Counting fibers
of the two quartic cubic equations gives

| Extension of F25 | C_plus | C_minus |
| --- | ---: | ---: |
| degree1 |26|17|
| degree2 |590|509|
| degree3 |15431|15566|

Each affine fiber has1 point when the right side is zero,3 for a
nonzero cube, and0 otherwise. There is exactly one point at infinity.
Newton identities and the genus-three functional equation give

    P_plus(T)=T^6-18T^4-65T^3-450T^2+15625,
    P_minus(T)=T^6-9T^5-18T^4+385T^3-450T^2-5625T+15625.

Both polynomials are irreducible over Q. Their Newton polygons, with
v5(25)=2, have slopes corresponding to0 twice,1/2 twice,1 twice;
in particular both Jacobians have p-rank2, not3.

For each ordered pair P,Q among (P_plus,P_plus), (P_minus,P_minus),
(P_plus,P_minus), compute the exact polynomial

    R_PQ(z)=Res_T(P(T), z^6 Q(T/z)).

Its roots are all ratios of a root of P to a root of Q. The self
resultants have (z-1) with multiplicity exactly6; remove precisely
this diagonal factor. Each remaining self-resultant factors over Q
into three irreducible factors of degrees6,6,6 with multiplicities
1,2,2. The cross-resultant factors into two degree18 factors. None is
cyclotomic. The saved certificate contains all coefficients, not just
the degree pattern, which alone would NOT prove this assertion.

An independent polynomial-gcd check in the same verifier tests all
cyclotomic polynomials of degree at most36 against each remaining
resultant. This is a finite exhaustive test: writing m as a product
of prime powers gives

    m/phi(m)^2 = product_(l^e exactly dividing m) l^(2-e)/(l-1)^2 <=2.

Only l=2,e=1 can contribute more than1. Thus phi(m)<=36 implies
m<=2592; all72 eligible orders in this range have gcd1.

## 3. Why these tests prove the geometric assertions

Irreducibility of P makes its six roots a single Galois orbit. The
self-ratio test says that taking any positive power leaves them
distinct. Consequently every extension-field Frobenius polynomial is
again irreducible of degree6. A proper positive-dimensional abelian
subvariety over that finite field would factor its characteristic
polynomial, which is impossible. Any geometric abelian subvariety
descends to a finite field, proving absolute simplicity. Equivalently,
this verifies Q(pi^n)=Q(pi) for every n, the sufficient condition in
[Howe--Zhu, Proposition3](https://arxiv.org/abs/math/0002205).
No ordinarity assumption is used in this direction.

The cross-ratio test says the two extension-field Frobenius spectra
are disjoint for every extension degree. A geometric homomorphism
descends to some finite field and induces a Frobenius-equivariant map
of rational prime-to-five Tate modules. Such a map is zero for disjoint
spectra; faithfulness of the Tate module then gives Hom=0 in both
directions. This uses neither approximate roots nor unequal point
counts as a substitute for geometric nonisogeny.

The compact executable certificate and its finite-field conventions
are linked from [the computation record](../Research/PICARD_CUBIC_COMMON_COVER_CERTIFICATE.md).
This result repairs the absolute-simplicity limitation of the earlier
genus-two positive test, but deliberately does NOT claim ordinarity
or corelessness for the present pair.

# Fixed endpoint constraints for wild absorption; an ordinary character escape

Date: 2026-09-06. Author: `/root/wild_absorption_fixed_endpoints_obstruction`.
Status: direct proofs; not independently audited. This does not settle the
original common-cover problem or construct a new coreless span.

## 1. Exact local criterion, with no numerical shortcut

Let C have finite separable maps to two rational curves, with fields
M/k(x), M/k(y). Prescribe finite separable endpoint extensions K/k(x),
L/k(y), choose embeddings in a common separable closure of M, and let
N=MKL. At each place z of N, write F=M_c, A=K_P, B=L_Q for the
embedded completed fields in N_z. Then the projective maps from the
smooth model of N to both endpoints are etale everywhere if and only if

                         A = B and F is contained in A

at EVERY z. Indeed N_z is the compositum FAB. Since residue fields are
algebraically closed, an unramified extension of these complete fields
is trivial. Thus etaleness of both legs is exactly N_z=A=B. This handles
non-Galois endpoints as well: one must retain all compatible places and
embeddings. In particular equal indices and differents are insufficient.

## 2. Exact parameter restriction for the two-point Galois construction

Specialize to the seed x-y=(xy)^5 and assume both prescribed endpoint
maps are Galois, branched only at 0 and infinity, and tame at 0. Assume
the usual embeddings of the seed, with its points O,P,Q as in
[the construction](CORELESS_PROJECTIVE_ETALE_SINGLETON_TANGO_COUNTEREXAMPLE.md).
Then both final maps are etale if and only if the following holds:

* Both zero fibers have the same tame index a, where 16 divides a and
  5 does not divide a.
* At infinity each prescribed completion is the corresponding EXACT
  degree-20 normal closure of the seed's pole extension, followed by
  the unique tame extension of degree a/16. On the x side this uses
  the sign twist of the construction. These are statements over the
  fixed rational local fields, not just abstract field isomorphisms.

Here and below the conditions are on existing prescribed covers; no
global realization for every a is asserted.

Proof: At O both seed maps are unramified, so the two tame extensions
must have the same degree a. At P the seed has tame degree 4 over y=0,
and degree 5 over x=infinity. Equality of endpoint completions forces
4|a and makes their common field the unique tame extension of F of
degree a/4. Normality over the x-base forces this field to contain the
degree-20 normal closure E of F, so 4|(a/4). Since E/F is tame of degree
4, the field is precisely the unique tame extension of E of degree
a/16. The argument at Q is identical. Conversely these extensions
agree at P and Q by uniqueness of tame extensions over F; at O they
agree by equality of a. Elsewhere all three covers are unramified,
so the local criterion applies everywhere.

Write q for either endpoint degree. At infinity the ramification index
and different exponent are

               e_infinity=5a/4,     delta_infinity=7a/2-1.

The different formula follows from delta(E/base)=55 and the tame tower:
delta=(a/16)55+(a/16-1). Consequently the nonzero exact differential dx
(or dy) has divisor

                  (a-1)(reduced fiber over {0,infinity}).

There are no other zeros or poles. Its orders at zero and infinity are
a-1 and delta_infinity-2e_infinity=a-1, respectively. Thus BOTH
endpoints are nonordinary, and

                     2g-2 = 9(a-1)q/(5a).

The fiber indices imply 5a|q, and parity then implies 10a|q. Hence

                  9(a-1) divides g-1; in particular g>=136.

These are effective restrictions on actual prescribed endpoints, rather
than restrictions only on the seed. They rule out this construction for
an ordinary endpoint or any endpoint of genus below 136. They do not
rule out Hom(JX,JY)=0 among larger nonordinary endpoints: a shared exact
form need not give a nonzero cross-Jacobian homomorphism.

## 3. Ordinary endpoints can carry the higher-degree zero-Cartier data

Over Fbar_5 take the smooth genus-two curve

                   Y: y^2=(x^2+1)(x^4+x).

The two factors are squarefree and disjoint. Put theta=dx/y and

                   s=(x^2+1)theta^2.

The coefficients c_i of [(x^2+1)(x^4+x)]^2 give the invertible matrix

                   [[c4,c3],[c9,c8]] = [[2,0],[2,1]].

Thus Y is ordinary. The coefficient identity was checked by exact
polynomial convolution over F5. For the Cartier convention and the
invertibility criterion see Achter–Howe,
[Hasse–Witt and Cartier–Manin matrices, Sections 2–3](https://www.math.colostate.edu/~achter/math/hwcm1017.pdf).

Let P,Q be the Weierstrass points with x^2+1=0. Then
div(s)=2P+2Q: the zeros of theta at the two infinities cancel the poles
of x^2+1. The canonical square-root cover is the smooth normalization

           U: a^2=x^2+1, b^2=x^4+x, y=ab;     eta=dx/b=a theta.

The map U->Y is etale EVERYWHERE: div_Y(x^2+1) has even valuation at
P,Q and at both infinities, and units in every completed local ring
have square roots. It is connected: x^2+1 is nonsquare in k(x,y).
Indeed a base element is square in this quadratic field only if it or
its quotient by (x^2+1)(x^4+x) is square in k(x); both alternatives are
excluded by the simple roots of the displayed factors. Therefore s is
not the square of a rational one-form on Y.

The form eta is regular and has four simple zeros, since eta^2 is the
etale pullback of s. It satisfies Cartier(eta)=0. One direct calculation
uses b^5=b(x^4+x)^2 and

                      (x^4+x)^2=x^8+2x^5+x^2;

none of these exponents is 4 modulo 5, so the Cartier formula in the
separating variable x gives zero. The deck involution (a,b)->(-a,-b)
acts on eta by -1. Thus the Cartier kernel lies in the nontrivial
character, compatible with ordinary Y. Here g(U)=3 and U is nonordinary.

In the generalized-Cartier notation r=3,n=1,d=2, one has

                           C_1(s^3)=0.

This follows by pullback to U, or directly from
C((x^2+1)^3 theta)=((x^2+1)/y) C((x^4+x)^2 dx)=0.
The tensor is primitive against taking a square on the endpoint, and
has the uniform multiplicity required of a potential primitive
degree-two common invariant. This is NOT an assertion that s generates
the intersection ring of a coreless span.

## 4. Precise quotient boundary

If an actual etale span X' <- Z' -> Y' is composed with a finite quotient
Y'->Y, the resulting leg Z'->Y is etale if and only if Y'->Y is etale:
ramification indices multiply and the original leg has index one. The
same applies to X'. For a constant finite group on a smooth curve over
an algebraically closed field, this requires a free action. Killing the
character of an exact form by a quotient does not supply freeness.

For the section-2 endpoints, any quotient subgroup of the deck group of
the displayed rational function fixes dx. If its quotient is etale,
dx descends as a nonzero regular exact form, so that quotient is still
nonordinary. An ordinary quotient therefore needs an additional free
automorphism action which acts nontrivially on the chosen differential;
the two-point Galois construction does not provide such an action.

Section 3 proves this extra action is not excluded by ordinarity or
unramified root-cover conditions in general. Its exact form has order
1 at every zero, whereas section 2 has order a-1>=15. Under any free
character quotient of those section-2 forms, a descended dth power has
uniform order d(a-1), so 2g(Y)-2 must be divisible by a-1. Thus genus-two
Y is excluded even after such free character quotients of this specific
uniform-zero construction. Quotienting source and endpoints together
may require a different inertia analysis; the local field criterion in
section 1 remains the exact test, and freeness cannot simply be assumed.

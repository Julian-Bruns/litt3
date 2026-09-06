# Kummer root normal form retaining both actual etale legs

Date: 2026-09-05. Author: `/root/structural_invariant_kummer_exact_log`.
Status: conditional structural reduction, assuming a nonzero invariant
generator. No clump-existence or span-nonexistence assertion.

Let k be the algebraic closure of F_5 and let X <- Z -> Y be the
actual finite etale coreless projective span of smooth connected
curves of genus at least two. Assume its canonical-ring intersection
is k[s], with primitive degree d. Use the results of
[the intersection note](../../Theorems/Thm_canonical_intersection.md)
and [the Frobenius/Cartier note](../../Theorems/Thm_cartier_generator.md):
5 does not divide d, and the generator has divisor eS, where S is
the nonempty unique clump. Its endpoint divisors are eT and eV.

## Result

Normalize the three canonical dth-root covers of s. They need not
be connected. Choose any connected source component W, and let
P and Q be its endpoint image components. There is an actual
finite etale span

                         P <- W -> Q

of smooth projective connected curves. It has a common nonzero
holomorphic one-form eta, whose zero support is exactly the inverse
image of the original clump. This assertion retains both actual
legs, with their original differential pullback identifications.

The form satisfies one of the following alternatives, on all three
chosen components with the same scalar:

* C(eta) = 0;
* d divides 4 and C(eta) = c eta with c nonzero. After a common
  scalar rescaling, C(eta) = eta.

In the first case put P^o, Q^o, W^o for the complements of these
zero supports. There exist finite etale maps

                u_P : P^o -> A^1,   u_Q : Q^o -> A^1

such that du_P = eta_P, du_Q = eta_Q, and on the SAME source W^o

                     f'^*u_P - g'^*u_Q = h^5

for a regular function h on W^o. The maps W^o -> P^o and W^o -> Q^o
are still finite etale and surjective. Equality modulo fifth powers
is the conclusion; equality of the two maps to A^1 is not established.

In the second case the normalized forms are rational logarithmic
differentials: eta_P = dv_P/v_P and eta_Q = dv_Q/v_Q. On W their
pulled-back functions satisfy v_P/v_Q = h^5 for a nonzero rational h.
No assertion that these rational functions give finite etale maps
of the punctured curves to G_m is needed or made.

## Constructing the covers and their two legs

For C = X,Y,Z, the canonical root cover is the finite scheme in
the total space of omega_C defined by xi^d = s_C, followed by
normalization. More explicitly, choose a nonzero rational one-form
theta and write s_C = a theta^d. Its generic algebra is

                         k(C)[z]/(z^d-a),

and the tautological rational differential is eta_C = z theta.
Changing theta gives an isomorphic construction. Since 5 does not
divide d and a is nonzero, the generic algebra is reduced and
separable. Normalization is a finite disjoint union of smooth
projective connected curves.

For an original etale map Z -> X, omega_Z is identified with the
pullback of omega_X. Thus the unnormalized root schemes are exact
base changes. Normalization also commutes here with this etale
base change: base-changing a normal curve by an etale morphism
stays normal, is finite over the root scheme, and agrees with its
normalization generically. Consequently the map of normalized
root covers is finite etale. The same holds on the Y side.
A source component maps onto an endpoint component, since a
finite etale nonempty image is both open and closed. Restricting
gives the asserted two actual etale legs.

At a point of C where s_C has order e_C >= 0, put
g_C = gcd(d,e_C), taking gcd(d,0)=d. The tame local Kummer model
has ramification index d/g_C. On each branch a uniformizer t
downstairs has order d/g_C upstairs, while z has order e_C/g_C.
The resulting differential has order

              ord(eta_C) = (e_C+d)/g_C - 1.

For e_C=0 this is zero; for e_C>0 it is positive. This proves
holomorphicity and identifies the zero support exactly. Units in
the completed local expression have dth roots because d is prime
to 5. The formula applies whether or not the global cover splits.

## Cartier descends the dichotomy without a new corelessness claim

Let 1 <= r <= 4 satisfy rd = 1 modulo 5 and put n=(rd-1)/5.
The earlier twisted Cartier result on each original endpoint is

           C_n(s_C^r)=0                    if d does not divide 4,
           C_n(s_C^r)=c s_C                if d divides 4,

with a common scalar c; in the second case n=d-1. These identities
follow on endpoints from the original common invariant identity
and injectivity of pullback to Z.

Rational Cartier commutes with finite separable pullback, including
ramified pullback. One can check this without an etaleness
assumption: a separating parameter t downstairs remains separating
upstairs, and the unique expansion a=sum(a_i^5 t^i), 0<=i<=4,
continues to be the same expansion in the larger function field.
The formula C(a dt)=a_4 dt therefore commutes with pullback.
The twisted operator has the same compatibility on rational forms.

On a root component eta^d=pi^*s_C. Its rational-frame formula gives

             pi^*C_n(s_C^r)
               = C_n(eta^(5n+1)) = eta^n C(eta).

If d does not divide 4, this forces C(eta)=0. If d divides 4,
substitution of n=d-1 gives C(eta)=c eta. The equations are
identities of rational forms and hence of the regular forms already
constructed. They apply independently on EVERY root component.
No assumption about the core of P <- W -> Q enters this argument.

For c nonzero choose lambda in k with lambda^4=c^5. Semilinearity
then gives C(lambda eta)=lambda eta. The standard field-level
Cartier characterization says a rational one-form fixed by C is
dv/v for some rational v. The equality of the two logarithmic
differentials on W says d(v_P/v_Q)=0; the kernel of d on k(W) is
k(W)^5, giving the asserted multiplicative fifth-power relation.

## Exact primitives with precisely the prescribed poles

Here is the needed affine statement in a form that prevents hidden
extra punctures. Let C be a smooth projective connected curve,
D a nonempty reduced divisor, and eta a nonzero holomorphic
one-form with zero support D and C(eta)=0. Put U=C minus D.

Cartier exactness identifies eta with a section of the image B^1
of d: F_*O_U -> F_*Omega_U^1. The exact sequence on U^(5)

                    0 -> O_{U^(5)} -> F_*O_U -> B^1 -> 0

is a sequence of quasi-coherent sheaves. Since U^(5) is affine,
H^1(U^(5),O)=0, so eta=du_0 for u_0 regular on U. This establishes
a primitive with no poles off D, rather than merely a rational
primitive with uncontrolled poles.

For a sufficiently large integer m, Riemann--Roch supplies a
rational v with pole order exactly m at every point of D and no
other poles. Indeed each requirement that the leading coefficient
at one point not vanish excludes a proper linear subspace of
H^0(C,O_C(mD)); a finite union cannot exhaust that space over the
infinite field k. Increase m so that 5m exceeds every pole order
of u_0. Then

                           u = u_0 + v^5

has poles at exactly all points of D, and du=eta. The nonconstant
map C -> P^1 defined by u is finite, and its inverse image of A^1
is exactly U. Its restriction U -> A^1 is finite and etale because
du is nowhere zero on U. This proves the affine statement.

Apply it separately to P and Q. On W^o the two regular primitives
have equal differentials, so their difference is h^5 in k(W).
It follows that h is regular on W^o: at every point its valuation
is one fifth of the nonnegative valuation of the difference.
This proves all parts of the exact normal form.

For comparison, the one-puncture exact-differential criterion is
stated in Leonardo Zapponi's
[*On the 1-pointed curves arising as etale covers of the affine line
in positive characteristic*](https://arxiv.org/abs/math/0309386).
The argument above explicitly treats arbitrary nonempty finite D.

## Connectedness and the precise limit of core persistence

Corelessness does not persist under arbitrary compatible finite
etale covers: take both endpoint covers equal to the original Z
and the new common source equal to Z. Both lifted legs can be
identities, so the new span has core Z. This uses the original
etale maps as the endpoint covering maps.

There is a valid sufficient condition for this particular root
construction. If the full normalized Z root cover is connected,
so are its endpoint root covers. The group mu_d acts on the common
function field M' and preserves both endpoint subfields K',L'.
For their intersection E, the group invariants satisfy

                    E^(mu_d)=K intersect L=k.

Every element of E is algebraic over E^(mu_d), by its finite orbit
polynomial. Since k is algebraically closed, E=k. Thus a connected
full common root cover does preserve corelessness.

Primitivity alone immediately gives a weaker statement. Let a_X,
a_Y,a_Z be the numbers of connected components of the respective
root covers. Kummer theory identifies a_C with the largest divisor
a of d for which s_C is an ath power of a rational pluriform of
weight d/a. Such a root is regular, by valuations. Then a_X and
a_Y divide a_Z, and gcd(a_X,a_Y)=1: a common prime divisor ell
would give endpoint ellth roots whose pullbacks differ by a
constant ellth root of unity, producing a common invariant in
degree d/ell and contradicting primitivity.

This does not show a_Z=1. If the common root cover is disconnected,
its full mu_d action permutes source components; it cannot simply
be used as an action on one chosen component. No general
corelessness assertion for that component is proved here. The
Cartier argument above deliberately avoids needing one.

## Scope of the gain

This gives a simultaneous exact/additive or logarithmic/multiplicative
normal form on an actual lifted etale span, conditional on the
existing generator. The exact alternative supplies finite etale
maps of BOTH punctured endpoint root curves to A^1 and compares
them on the actual common source. It is stronger than a standalone
Cartier-zero condition on either endpoint.

It neither aligns those two maps to A^1 nor bounds their degrees:
adding fifth powers permits arbitrarily large pole orders. It gives
no clump-existence theorem, no new restriction on endpoint p-ranks,
and no contradiction to a proposed genus pair by itself.

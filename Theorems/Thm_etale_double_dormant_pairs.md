# Canonical double covers turn admissible nilpotents into dormant pairs

Work over an algebraically closed field of characteristic five. Curves
are smooth, projective, connected and hyperbolic. Use the
[projective-connection conventions](../Definitions/Def_projective_connections.md).
All counts below count geometric points unless scheme length is specified.

## 1. The general canonical construction

Let r be an active admissible regular nilpotent connection on C, with
normalized quartic s=E(r)/3 and div(s)=2D. Its Hasse root class is

    L_s=O_C(D) tensor omega_C^(-2) in Pic(C)[2].

On the canonical etale double torsor pi:C_s→C trivializing L_s there
is a regular quadratic q with q²=pi^*s and simple zeros. The two regular
connections pi^*r+q and pi^*r−q are distinct and dormant, and deck
involution exchanges them. If L_s is trivial the torsor is split and
either component gives an unordered dormant pair on C itself.

Conversely, on an actual connected etale double pi:C'→C with involution
tau, a nonfixed dormant orbit {r',tau^*r'} whose half-difference has
simple zeros recovers exactly one such connection on C with L_s the
class of pi. These are inverse constructions. Compatible connections
under BOTH actual etale legs give compatible double torsors and dormant
pairs on a common etale refinement. No simultaneous Galois closure,
corelessness of the refined span, or ordinary pullback is asserted.

## 2. The exact tangent factorization

Let T_nil(r) and T_dorm(r) denote tangent spaces of the respective
curvature fibers. If s=q² on C itself, put q=a(dt)² and

    B(v)=(v''−r v)/a.

Then B is a regular involution on T_nil(r), and its two eigenspaces are
exactly T_dorm(r+q) and T_dorm(r−q). Thus

    T_nil(r)=T_dorm(r+q) direct-sum T_dorm(r−q).      (1)

If the canonical double is connected, instead

    T_nil(C,r) is isomorphic to T_dorm(C_s,pi^*r+q),
    dim T_nil(C_s,pi^*r)=2 dim T_nil(C,r).           (2)

In particular THIS canonical double preserves ordinary nilpotent status
in both directions. It does not repair a nonordinary object. These
statements follow from fourth-order scalar factorization, not lifting.

## 3. A sharp genus-two counting consequence

Let C have genus two, n distinct dormant connections, and A_L distinct
active nilpotent connections of Hasse root class L. For nontrivial
L in Pic(C)[2], let C_L be its connected etale double. Then

    A_O = n(n−1)/2,
    #Dorm(C_L) = n + 2 A_L.                         (3)

No simple-zero hypothesis needs to be added in genus two: every active
regular nilpotent connection is admissible. Each C_L has genus three
and its dormant scheme has length15. The dormant scheme of C has length5.

Consequently, if n=5 and C has85 distinct active nilpotent connections,
then A_O=10 and A_L=5 for each of the fifteen nontrivial L. Every C_L
has exactly15 dormant connections, ALL reduced. For every base dormant
connection r and EVERY L in Pic(C)[2], the twisted tangent space is zero:

    {q in H^0(C,omega_C² tensor L): q''−r q=0}=0.    (4)

Here derivatives use the canonical flat local frames of the order-two
line bundle. This is tangent-freeness for DORMANT opers. Separately,
(1)–(2) show that all85 active nilpotent connections on C are ordinary.
No analogous assertion for an arbitrary shared source is made.

## 4. An unbounded-degree, non-Galois preservation criterion

More generally, let N be prime to5 and fix a dormant r whose twisted
tangent kernel is zero for EVERY L in Pic(C)[N]. If an actual finite
etale cover T→C has Galois closure group G admitting

    1→P→G→B→1,

with P a5-group and B abelian of exponent dividing N, then the
pullback of r to T has zero dormant tangent space. No degree bound or
Galois hypothesis on T→C is imposed. The counting argument supplies N=2;
larger N require their additional twisted tests. Arbitrary nonlinear
prime-to5 simple monodromy is not covered.

The backup curve C_alpha meets the counting hypotheses by its saved
exact85+5 census. This does not produce compatible endpoint connections
or exclude all possible common covers. The active fixed pair is unchanged.

Version3,2026-09-08: exact tangent factorization and canonical-double
ordinary-status equivalence retained; the non-Galois criterion now uses
any prime-to5 torsion exponent N explicitly tested. Author proof; jet checks
PASS, no independent whole-theorem audit.
[Proof](../Solutions/Sol_etale_double_dormant_pairs.md).

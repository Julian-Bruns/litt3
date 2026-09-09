# Exact two-torsion tangent table and unbounded ordinary-source covers

Version1,2026-09-09. Author proof, not independently audited.
Let k=bar(F5), Y=Y_t: v²=F(u)=u(u-1)(u-2)(u-3)(u-t), and suppose
[F5(t):F5]>828. This includes the already selected parameter. Set eta=du/v.
The preceding critical-quartic theorem supplies exactly85 active
nilpotent connections, all ordinary on Y. For such a connection r let
B(r) be the nonzero two-torsion classes for which its twisted nilpotent
tangent space is nonzero.

For80 of the85 connections, B(r) is EMPTY. The exceptions are precisely
the following five four-Weierstrass-support data. R0 is the pair polynomial,
S0=F/R0, c0=[u^4]S0 R0², and the normalized quartic is c0 S0 eta^4.
Pairs label classes in Pic(Y)[2]; infinity is O.

| Pair defining R0 | The two elements of B(r) |
| --- | --- |
| {t,O} | {0,3}, {1,2} |
| {0,t} | {2,O}, {1,3} |
| {1,t} | {0,O}, {2,3} |
| {2,t} | {3,O}, {0,1} |
| {3,t} | {1,O}, {0,2} |

Every exceptional twisted tangent space has dimension exactly1. Thus
each named etale double has a NONORDINARY pulled-back connection,
although the connection on Y is ordinary. The two bad classes sum to
the Hasse root class; the canonical double itself is still ordinary.

## The explicit test, valid on any genus-two endpoint

For ANY smooth degree-five hyperelliptic F in characteristic5 and an
invariant active normalized quartic A(u)eta^4, take a nonzero two-torsion
class represented by R of degree1 or2 and write F=RS. Its twisted
nilpotent tangent kernel is the Cartier kernel of the following block
matrix (coefficient fifth roots do not change ranks):

    ([u^(5i+4-j)] A S²)_(0<=i,j<=1)  direct-sum  ([u^4] A R²).

In particular these tests involve only a2x2 determinant and one scalar.
Infinity and all Weierstrass fibers are included in the basis calculation.

## An actual-cover preservation theorem

Let q:W→Y be a connected finite etale GALOIS cover with group G and

    1→P→G→A2→1,  P a5-group, A2 an elementary abelian2-group.

Let H subset Pic(Y)[2] be the character subgroup of W/P→Y. Then

    q^*r is ordinary  iff  H intersects B(r) trivially.

There is no degree bound. For a NON-GALOIS cover dominated by such W,
the same disjointness is sufficient. The converse is not asserted from
the Galois closure alone. It is nonordinary if it itself trivializes a
class in B(r), because the corresponding double is an intermediate cover.

Consequently, for a fixed other endpoint and fixed partner genus, compatible
active spans satisfying this sufficient monodromy condition have only
finitely many partner curves, by ordinary-source partner finiteness.
Both maps remain the actual finite etale maps from the same source.

Scope: this is not an exclusion of arbitrary nonlinear monodromy or of
all nonordinary JOINT sources. The displayed bad doubles are one-leg
examples, not Hom-zero coreless counterexamples. No arbitrary simultaneous
lift is inferred from endpoint ordinariness.

[Proof](../Solutions/Sol_genus_two_active_twists.md) ·
[Exact certificate](../scripts/check_genus_two_active_twists.sage).

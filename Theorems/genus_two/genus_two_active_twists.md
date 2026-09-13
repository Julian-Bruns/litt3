# Exact two-torsion tangent table and unbounded ordinary-source covers

Version2,2026-09-13. Author proof; affine reduction has a bounded audit.
Let k=bar(F5), Y=Y_t: v²=F(u)=u(u-1)(u-2)(u-3)(u-t), and suppose
[F5(t):F5]>9. Set eta=du/v.
The preceding critical-quartic theorem supplies exactly85 active
nilpotent connections, all ordinary on Y. For such a connection r let
B(r) be the nonzero two-torsion classes for which its twisted nilpotent
tangent space is nonzero.

For80 of the85 connections, B(r) is empty. To describe the five
exceptions, use z=1/(u−4), a=1/(t−4), so the branch set is F5∪{a}.
For each b∈F5 the Hasse root class {a,b} has a unique active datum
supported on the other four Weierstrass points. Precisely for these,

    B(r) = { {b+c,b−c} : c∈F5×/{±1} }.

Pairs represent classes in Pic(Y)[2]. In the original u coordinate,
if R0 is the root-pair polynomial and S0=F/R0, the normalized quartic
is [u^4](S0 R0²) S0 eta^4. For example the root pair {t,O} has bad
twists {0,3} and {1,2}.

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

[Proof](../../Solutions/genus_two/genus_two_active_twists.md) ·
[Exact certificate](../../scripts/genus_two/check_genus_two_active_twists.py).

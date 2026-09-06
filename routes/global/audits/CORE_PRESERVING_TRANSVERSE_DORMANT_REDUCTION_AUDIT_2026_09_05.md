# Core-preserving transverse dormant reduction: independent audit

Date: 2026-09-05.
Auditor: `/root/core_preserving_transverse_reduction_audit`.
Verdict: **PASS for the stated conditional structural reduction. No breaking issue found.**

The audit read the complete
[reduction](../CORE_PRESERVING_TAME_REDUCTION_TO_TRANSVERSE_DORMANT_MIURA_DATA.md),
[explicit equation note](../EXPLICIT_SECOND_ORDER_EQUATION_FOR_CARTIER_ZERO_PLURIFORMS.md),
and [degree-four construction](../TAME_DOUBLE_REGULARIZATION_OF_SHARED_CARTIER_ZERO_EQUATIONS.md),
and checked the horizontal-line interpretation against the two horizontal
Borel notes. The theorem itself was not edited. This is an algebraic proof
audit, not a computational experiment or an audit of the external literature
or every theorem mentioned in those dependencies.

## 1. Composite ramification index and endpoint construction

Cartier zero forces `e/d != -1` in F5: the leading nonzero term of
`A^r` would otherwise have exponent four modulo five. Consequently the
required residue `d/(e+d)` is nonzero. If `N` is the prime-to-five part
of `ab`, the congruences modulo five and modulo `N` are compatible by
CRT. Increasing a solution by `5N` gives `n >= 2`; every such solution
is coprime to `5ab`. This works when `N=1` and when `n` is composite.

An exact-order-n element of `Pic^0(C)` exists because n is invertible
and the genus is positive. Its cyclic torsor is connected: for each
`0 < i < n`, the nontrivial degree-zero bundle `L^i` has no global
section, so the torsor has only constant global functions. Over the
degree-n etale cover T, the divisor D has degree `n|S|`. Divisibility
of `Pic^0(T)(k)` by n supplies the required root of `O(D)`.

The second cyclic cover has a field as its generic algebra: at any
point of the nonempty reduced D its equation is Eisenstein of degree
n. This argument does not assume that n is prime. The local equation
`w^n=tU` is regular, totally tamely ramified, and is etale wherever
the section does not vanish. Thus the degree-n-squared composite is
connected and has exactly the stated branching. The phrase
"cyclic n-squared cover" should not be used for the composite: only
its two successive degree-n stages are asserted to be cyclic.

The n conjugates of the cyclic extension over T suffice to form its
normal closure over C. Restriction injects the group over T into
`(C_n)^n`; the quotient group over C is `C_n`. Hence its order divides
`n^(n+1)`, while inclusion of the original composite forces divisibility
by `n^2`. In particular, taking this Galois closure introduces no prime
factor dividing `5ab`.

At a point of S the intermediate etale cover has trivial completed
local extension, and each cyclic conjugate has the same completed
extension `k((t^(1/n)))`. Units have n-th roots by Hensel's lemma,
and k contains the n-th roots of unity. Their local compositum has
index exactly n, rather than a larger power of n. Off S all the
completed extensions are trivial. Thus neither new branch points
nor larger inertia appear in the Galois closure. The stated
Riemann--Hurwitz expression follows, with `q_C/n` points above each
point of S.

## 2. Actual maps and preservation of corelessness

Equality of the original pluriforms and etaleness of the original
legs identify their reduced support divisors on Z. For a chosen
place of the field compositum `M'=MK'L'`, both ramified endpoint
completions are the unique index-n tame extension of the completion
of M. Their compositum is again that extension. Thus the completion
of W has relative degree one over either selected endpoint
completion. The same assertion holds off the support with the
trivial local extension. This proves etaleness for the actual
normalization of the chosen field compositum, not merely for an
unrelated common cover. All maps are finite, separable and surjective.

The coprimality hypothesis really supplies full linear disjointness.
For an alternative completely numerical verification, let
`D=[MK':K]`. The inclusions imply both `a | D` and `q_X | D`, while
`D <= a q_X`. Since the two degrees are coprime, `D=a q_X`.
The same argument applies at Y.

Both base-changed extensions over M are Galois, so their compositum
is Galois over M. Its finite group G preserves K' and L' by their
normality over K and L. Its restrictions are surjective by the
preceding linear disjointness and restriction in finite Galois
extensions. Therefore `(K')^G=K` and `(L')^G=L` exactly, including
the prescribed embeddings. It follows that

    (K' intersection L')^G = K intersection L = k.

The orbit polynomial of every element of the intersection has
coefficients in k. Algebraic closedness of k then gives
`K' intersection L'=k`. No finite-generation or faithfulness
hypothesis on the induced action on the intersection is missing.
This proof does not assume that the original legs are Galois.

## 3. Regularity, dormancy and absence of collisions

The tame pullback order is `e'=n(e+d)-d`, which is positive and
divisible by five. There are no other zeros. Cartier zero survives
rational separable pullback: in local parameters the extra Jacobian
factor in the Cartier input is a fifth power times the ordinary
one-form pullback. Its vanishing is therefore preserved even at
the ramified places.

Writing a local coefficient as `A=u^(5m)V`, with V a unit, gives
`ell=V'/(dV)` and a regular Q. Choose the positive representative
`j` with `2dj=-1 mod 5`. The horizontal solution `A^j` has jet

    (A^j, (A^j)') = u^(5mj) (V^j, (V^j)').

The derivative of the displayed power of u is zero. Consequently
the saturated horizontal line is generated by the regular vector
on the right after removing that factor. Its first coordinate is
a unit. In companion jet coordinates, projection modulo the oper
line is precisely this first coordinate, proving that the projection
is an isomorphism locally at every point. Thus there are no collisions;
mere regularity of Q alone would not have proved that conclusion.

The rational solution formulas in the equation note give a second
solution with Wronskian one. They therefore trivialize the connection
generically and give zero p-curvature. The regular oper extends this
identity globally. Riccati naturality identifies the distinguished
projective line under changes of parameter and under the actual
pullbacks, and the endpoint extensions agree on W by uniqueness of
saturation. The argument is independent of compatible choices of
theta characteristics on the endpoints.

Finally all orders in the pulled-back pluriform divisor are multiples
of five, so `5 | d(2g(R_C)-2)`. Since `2d` is invertible modulo five,
the asserted genus congruence follows. This is a consistency condition,
not an obstruction to existence of the resulting transverse oper.

## Actual issues, suggestions and scope

No actual mathematical defect requiring repair was found in the
conditional theorem or its proof. Two optional exposition improvements
would make its vulnerable points more explicit:

- Insert the degree-tower argument for coprime linear disjointness above;
  it makes the quantitative role of coprimality immediate.
- Display the two-coordinate jet factorization above, making clear
  that division by the fifth-power factor removes both coordinates'
  common vanishing and proves transversality after saturation.

The result is an all-degree conditional reduction to a coreless actual
etale span with a shared regular dormant oper and an everywhere-transverse
horizontal Borel. It neither proves nonexistence of those structures
nor constructs a counterexample. It changes the endpoints and gives no
uniform degree bound independent of the original degrees and zero
multiplicity. No external identification with a particular formulation
of the Miura/Tango correspondence is needed for the stated conclusion;
any later use of such a correspondence should state its precise
conventions and hypotheses separately.

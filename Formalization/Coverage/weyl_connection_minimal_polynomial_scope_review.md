# Actual Weyl connection minimal polynomials and nilpotency

All eight new solution modules below build. The focused build/axiom/hash
audit of the two terminal roots PASS:
`../../../litt3-computation-data/formalization-20261003/verification/20261003T104218Z/report.json`.
It checks 504 transitive Litt3 theorem declarations with only
`Classical.choice`, `Quot.sound` and `propext`, zero forbidden dependencies
and zero captured source changes. Exact checked hashes are in that report.
No canonical whole-source status is promoted by this
foundation. Its bounded independent mathematical readback remains
separate from compilation and transitive trust checking.

| Module | Literal proved scope |
| --- | --- |
| WeylPolynomialCommutators | Arbitrary ring power commutator and arbitrary central-coefficient polynomial commutator |
| WeylMinimalPolynomials | Weyl minimal polynomial has zero formal derivative; positive monic zero-derivative degree is at least the characteristic; actual integral Weyl degree bound |
| WeylCharacteristicDimension | Actual finite endomorphism in positive characteristic equal to its dimension has minpoly equal to its entire charpoly |
| ConnectionWeylRelation | Any actual normalized scalar connection and literal multiplication by its parameter obey the Weyl relation |
| RestrictedConnectionMinimalPolynomial | Literal full normalized Kp-connection minpoly X^p+curvature and exact degree p |
| OriginalConnectionMinimalPolynomial | Canonical rebasing of any actual original R-derivation gives the SAME pointwise connection and full minpoly |
| OneVariableConnectionMinimalPolynomial | Actual perfect-base FG/trdeg-one field derives its p-basis, scalar membership and full connection minpoly |
| RestrictedConnectionNilpotency | Every whole power below p is nonzero; curvature zero gives exact nilpotency exponent p |

## General symbolic Weyl argument

For arbitrary ring A and literal T,M in A satisfying TM−MT=1, induction
and distributivity prove [T^(n+1),M]=(n+1)T^n. The proof uses natural
additive multiples, so it requires neither characteristic zero nor
division. For a genuine central algebra map from a commutative ring R,
polynomial induction gives [F(T),M]=F'(T). Coefficient centrality is the
actual algebra commutation law, and no matrix representation is used.

Over a field K, apply that polynomial identity to the actual minpoly of
T. Its evaluation vanishes, so the derivative also evaluates to zero.
Actual minimal-polynomial divisibility and the strict derivative-degree
bound force that derivative to be the zero polynomial. This statement
does not presume T integral: for a nonintegral element its minpoly is
the default zero polynomial, and no positive-degree conclusion is drawn.

For a nonconstant monic polynomial with zero formal derivative, the
coefficient at degree n−1 gives the literal equality (n:K)=0. CharP then
gives p dividing n and consequently p≤n. This auxiliary theorem needs
no primality or perfectness. Applied to an actual integral Weyl element
in a nontrivial algebra, minpoly monicity and positive degree are derived,
and its degree is at least the characteristic.

For an actual finite-dimensional endomorphism with dimension equal to
the positive characteristic p, nontriviality follows from that positive
dimension and integrality follows from Cayley–Hamilton. Minpoly divides
charpoly, whose degree is p. The Weyl lower bound therefore forces equal
degrees, and genuine monicity forces equality of the two polynomials.
No scalar pth power, chosen eigenvalue, Jordan block, companion matrix,
cyclic vector or minpoly equality is supplied as a premise.

## Actual normalized connection specialization

The actual scalar connection L=D−f and actual multiplication operator
M_t obey LM_t−M_tL=id from the true Leibniz rule and D(t)=1. This identity
holds over arbitrary commutative coefficient and scalar rings, with no
basis, field, characteristic or finite-dimension premise.

For an arbitrary prime-characteristic field K with a FULL literal power
p-basis over its actual pth-power subfield Kp, the genuine dimension is p.
The normalized Kp-connection therefore has minpoly equal to charpoly.
The already proved actual restricted curvature and charpoly identities
identify it with X^p+curvature. The curvature is a literal Kp element,
with membership derived from the true derivative kernel. No perfectness
of K, function-field or splitting hypothesis is used here.

For any original constant ring R and actual R-derivation D, canonical
Frobenius rebasing keeps EXACTLY the same function on K. The original
wrapper consequently gives the full minimal polynomial without an
assumed Kp-linear derivation. The genuine one-variable wrapper assumes
only perfect constants, actual finite generation, transcendence degree
one, and the supplied actual derivation normalized at its original
parameter. Its full p-basis at that parameter and literal curvature
scalar are constructed from those hypotheses; no separating subfield,
basis, scalar membership or polynomial conclusion is supplied.

Finally, if a whole connection power n<p vanished, X^n would annihilate
the operator, forcing its full degree-p minpoly to divide a degree-n
polynomial. Thus every such power is nonzero, for ANY curvature. When
literal curvature vanishes the restricted identity gives L^p=0, hence
the exact nilpotency exponent is p. This asserts no global H0 filtration,
Picard/cohomological comparison or canonical common-cover conclusion.

The entire proof is symbolic and uniform in p; sampled matrices, prime
enumeration, numerical rank certificates and assumed p-curvature formulas
are unnecessary.

# Independent review: Cartier on genuine original differential H0

Reviewer: Cartier/spin owner, distinct from the SharedTensors author.
The entire new file `Solutions/SharedTensors/SchemeDifferentialGlobalCartier.lean`
was read. Reviewed SHA256:
`f94352162e0619d9d6458570bba8c3165660a661485cc87e1098c219e5397742`.

The mathematical scope is an integral original scheme, actually smooth
of relative dimension one over an algebraically closed perfect field
of prime characteristic. No properness, projectivity, finite H0,
supplied function-field degree, supplied differential coordinate,
Cartier preservation, or H0 realization is an input. The stated perfect
field instance is harmless with algebraic closedness. The genuine H0
module and its scalar action come from the original differential sheaf
and original coefficient morphism, by the separately reviewed chain.

`actualSmoothCurveSheafGlobalCartier` is the actual additive operator
obtained by the proved H0/regular-intersection linear equivalence,
the already proved intrinsic rational Cartier restriction preserving
all original stalk lattices, and the inverse actual gluing equivalence.
Thus it acts on real sheaf global sections. This construction uses
proved regularity and actual H0 recovery rather than assuming either.

The intertwining theorem is the genuine equivalence/inverse identity.
The semilinearity proof transports through its injective original
linear equivalence and proves `C(c^p a) = c C(a)` for the ORIGINAL
coefficient action. The final theorem transports the genuine rational
Cartier kernel and the actual generic realization: `C(a)=0` iff its
rational image is `d f` for an ACTUAL rational function `f`.
It correctly permits poles of the primitive and makes no assertion
that `f` is an original global regular function. Neither global
surjectivity, cohomological genus, nor any higher-dimensional Cartier
claim is asserted.

The exact scope and construction are accepted. Independent mathematical
readback adds no compilation replay. The author's focused kernel audit
`../litt3-computation-data/formalization-20261003/verification/20261003T085410Z/report.json`
checks 700 transitive Litt3 declarations, only `Classical.choice`,
`Quot.sound`, `propext`, zero forbidden dependencies and zero source
changes. The hash above fixes this review to the audited source.

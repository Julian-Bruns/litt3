# Full source-scope review: quartic scalar-graph recovery

The root reviewed the canonical statement and human proof on 3 October 2026,
then the explicit Lean specification, its assembled proof, and the actual
trace, denominator-free and Kummer boundary bridges.
Canonical statement SHA256:
`1361a0cb477a963a6552376b6716893f2e153c997c56ad5e26d968728466a573`.

`Solutions.CartierAndSpin.QuarticScalarGraph` proves
`Litt3.CartierAndSpin.quarticScalarGraphRecovery_of_char_ne_two` for an actual
separable field extension of degree four in every characteristic different
from two. The normalized trace, trace-zero subspace, nondegenerate pairing,
adjoint, and multiplication compression are actual constructed objects.
The specification proves the kernel-line assertion for every map with
nonzero skew, without assuming a scalar graph. For every actual graph it
recovers the field-element ratio from every nonzero skew-kernel vector and
proves independence from rescaling. The basis criterion includes the required
outside-base-field condition. The scalar-shift bridge and independence
criterion prove the stated denominator-free span tests, recovering both
constant shifts rather than omitting their role.

For the actual Kummer generator, the full power basis and trace-zero basis
are constructed from field generation and the relation t^4=m. Actual trace
and pairing computations yield the displayed kernel coordinates, their
vanishing exactly on the self-adjoint boundary, and the full boundary matrix,
including its nonzero direction and zero-coordinate cases. These clauses
hold throughout characteristic different from two, hence include the
source's characteristic-five specialization.

The endpoint-incidence paragraph records a condition still to be matched;
it asserts neither feasibility nor emptiness. The formal theorem makes no
such assertion. Thus every mathematical claim of this exact source is
covered; no claim about the unsolved unmarked common-cover problem follows.

Focused verification built the final module and audited its 136 transitive
Litt3 theorem declarations. Only `Classical.choice`, `Quot.sound` and
`propext` occur, with zero forbidden dependencies and zero source changes.
The complete reproducible evidence is
`../../../litt3-computation-data/formalization-20261003/verification/20261003T000813Z/report.json`.
No native decision procedure or finite coefficient enumeration is used.

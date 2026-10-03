# Critical square-pencil component mapping

Canonical Version3 statement SHA256:
`03d0babf4ec945f6d5e883efc82a6c3611e4038be0a714f10857adc6f062c8c6`.
Proof snapshot SHA256:
`5ba87b00ded84e67699db4d0446c534a1acd43fb8358885b393c07e1ccf79c72`.
Status is `partial_component`.

The general constant-parameter weighted square support now has a checked
literal NONZERO field proof in `CanonicalWeightedSquareSupport`: over
algebraically closed constants in odd prime characteristic, actual finite
generation and transcendence degree one construct the maximal root
q=r^(p^e), prove literal universal dr nonzero, and give finite support of
cardinality at most 1+factorization_2([L:k(r)]). The supplied q only needs
genuine nonconstancy. The weight need not be square, and the source's
parameter-minus-function sign is preserved. `FiniteFunctionDegree` constructs actual finite degree,
and `SquareClassTowers` constructs the actual multiquadratic subfield of
degree 2^(m-1), with no assumed degree or simultaneous Galois closure.
The constant-ratio alternative is proved separately and exactly: its
nonzero support is empty or the complement of one parameter.
`RationalMonomialDegree` proves the exact actual degree [k(r):k(r^n)]=n
from symbolic Eisenstein irreducibility in every characteristic.
`FunctionRootDepth` bounds every actual root depth, and
`PBasisDerivationKernel` proves actual D(a)=0 iff a is an actual p-th power
for a full p-basis and normalized derivation, without perfectness.
`PrimitiveFunctionRoots` uses constructed p-bases to establish dr nonzero.
Focused audit `verification/20261003T041041Z/report.json` passed 293
transitive declarations with only the standard three axioms, zero forbidden
dependencies and zero source changes. The canonical divisor-parity recipe,
actual m9 field/geometric bridges and specialized four-value bound remain
outside this reviewed algebraic aggregate.

New buildchecked `WeightedSquareValuationParity` proves the literal pole
condition Even(ord(g)+ord(r)) for every odd function exponent, and the
finite-point parity comparison uses genuine integer-valued valuations.
`WeightedSquareResidues` constructs the actual residue-map fiber at an
odd-order point with integral q: it contains all square parameters and is
finite of cardinality at most one. Two incompatible actual residue values
give empty support. Focused audit `verification/20261003T042250Z/report.json`
passed 360 transitive declarations, standard three axioms only and zero
forbidden dependencies/source changes, including both modules. Actual
closed-point/global-divisor specialization remains. Even divisor order is never
asserted sufficient for an actual square.

`criticalTraceContraction D n d` is the actual polynomial
∑_{j<d} n_j (D /ₘ T^{j+1}), the polynomial part of the source's Laurent
contraction. Actual monic division stays over the coefficient ring at
every degree drop. `critical_power_quotient_coeff` identifies all its
actual coefficients by shifts.

`critical_root_power_quotient_reciprocal` derives, at every nonzero
critical root, an exact expression for each quotient using only the
reciprocal root and the reflected remainder. It follows from actual
monic division and polynomial reversal; no assumption on a critical
leading coefficient or critical root multiplicity is made.

`critical_trace_contraction_root_integral` proves that the contraction
lies in an actual valuation integer ring at every critical root, in
arbitrary degree and characteristic. Zero roots are included. At
integral roots it evaluates the actual polynomial over the integer
ring; at poles it evaluates the reciprocal expression over the same
ring. `critical_quadratic_contraction_root_integral` proves the same
for a regular constant minus the contraction. The valuation-ring
specialization uses the canonical valuation of the actual fraction
field, without supplying an artificial integer-ring equivalence.

`critical_trace_contraction_cubic` proves its exact cubic expression,
and `critical_quadratic_eq_contraction` identifies the canonical
`criticalQuadraticFromMoments` with leading*rho² minus this contraction.
Thus `critical_quadratic_root_integral` gives the literal regularity
assertion for the source's explicit quadratic whenever its actual
coefficients and moments are in the local integer ring. The general
statement retains all degree and repeated-root boundaries.

Remaining clauses include the actual affine-curve/normalization and
moment descent inputs, the fixed rank-fourteen moment locus and its
actual source bridges, application of the proved constant-square-support
bound to the actual critical curve, divisor-parity and branch polynomial support,
the genus/pole/different bounds and Hom-disjoint correspondence bound,
the nonconstant ratio implications, all actual endpoint Laurent rows,
and the restricted rank-fourteen/rank-fifteen coefficient witnesses.
The checked local integrality component does not decide any source or
common-cover existence/exclusion question.

All listed Lean proofs are symbolic and build. No numerical computation
or external certificate is used for this integrality component.

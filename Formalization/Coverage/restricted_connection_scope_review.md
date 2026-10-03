# Actual restricted scalar connection identity

All thirteen NEW post-09:25 modules now build. The complete original
field formula, constant-ring extension, D^p=0, genuine one-variable
FG/trdeg-one specialization, kernel/bijection alternatives, pth curvature
scalar and unit-gauge invariance are proved. The terminal package
completed 3,363 jobs. Focused verification
`verification/20261003T100348Z/report.json` passed for the terminal root
and all thirteen imported modules: 448 transitive Litt3 theorem
declarations, only `Classical.choice`, `Quot.sound` and `propext`, zero
forbidden dependencies and zero source changes. Exact checked hashes
are in that report. Root has accepted the full thirteen-module argument
and its imported normalized-derivation comparison at the exact audited
hashes; independent readback is recorded in
`restricted_connection_independent_scope_review.md`.

The target is the literal identity on an arbitrary prime-characteristic
field K equipped with a FULL actual power p-basis over the literal
Frobenius-image subfield Kp and an actual Kp-derivation D normalized by
D(t)=1. For every f,a in K, the actual Kp-linear connection L=D-f obeys
L^p(a)=-(D^(p-1)(f)+f^p)a. K need not be perfect, finitely generated,
one-variable or algebraic over constants. The p-basis is a precise
literal premise, and no p-curvature or connection solution is assumed.

`ConnectionLeibniz` now builds. It defines the actual connection for any
commutative algebra, proves its full binomial iterate Leibniz formula,
and proves that in prime characteristic its pth iterate is algebra-
linear whenever the pth derivative is zero. This is a uniform symbolic
argument using divisibility of the middle prime binomial coefficients.

`TruncatedDerivativeNilpotence` proves polynomial derivative positive-
characteristic nilpotence over arbitrary commutative rings from factorial
divisibility. It then proves actual derivative nilpotence on EVERY
element of the entire AdjoinRoot(X^p), using genuine quotient surjectivity.

`TruncatedODEGauge` uses the literal lower coefficient recursion to
construct a true unit in K[epsilon]/epsilon^p for EVERY polynomial F.
Its exact last residual coefficient is F(0)^p-F_(p-1), derived from the
already proved logarithmic coefficient identity over arbitrary fields.
Multiplication by epsilon^(p-1) sees only the literal constant coefficient;
that lemma holds over every commutative ring. The unit gauges the
connection to just c epsilon^(p-1), c=F_(p-1)-F(0)^p.

`ConnectionUnitGauge` proves exact intertwining of the actual connections
and ALL their iterates under genuine multiplication by that unit.
`TruncatedTopConnection` proves the literal nilpotent derivative chain
on epsilon^(p-1). Its pth connection iterate is multiplication by c,
using Wilson's theorem uniformly in p and the proved pth derivative
nilpotence. `TruncatedRestrictedConnection` combines actual unit
intertwining and algebra-linearity, cancelling the true unit, to prove
the exact pth connection identity on the ENTIRE truncated algebra.

`RestrictedPBasisConnection` reuses the genuine p-basis Taylor algebra
map from the independently audited root modules. Literal epsilon=0
evaluation is a left inverse on its ENTIRE image. Actual derivative and
connection intertwining give exact iterate intertwining. Applying the
constant evaluation proves that the top Taylor coefficient equals
-D^(p-1)(f), again using uniform Wilson. Applying it to the full truncated
connection identity descends the original operator equality. No assumed
matrix singularity, flatness conclusion, p-curvature formula or target
operator identity enters this construction.

`RestrictedNormalizedDerivations` constructs the actual normalized
derivation over Kp and compares it with ANY normalized derivation over
ANY commutative constant ring. The full operator formula and D^p=0
follow with no supplied Kp-derivation or nilpotence hypothesis.
`OneVariableRestrictedConnection` constructs the full p-basis at ANY
actual t with D(t)=1 from genuine FG/trdeg one over perfect constants.
Thus the literal one-variable statement has no supplied basis,
separating-subfield, curvature or literature premise. Both modules build.

`RestrictedConnectionDichotomy` now builds the exact ORIGINAL-field
nonzero-kernel criterion: a nonzero solution of D(u)=fu exists iff
D^(p-1)(f)+f^p=0. Nonzero solutions and nilpotence are conclusions.
`RestrictedConnectionBijections` derives the complementary exact
bijection criterion with an explicit (p-1)st-iterate/division preimage.
`RestrictedCurvatureScalars` derives that the curvature lies in the
ACTUAL pth powers of the imperfect original field and is invariant
under every genuine unit gauge. Both modules build.

`OneVariableConnectionAlternatives` constructs the full p-basis at the
original normalized parameter from genuine FG/trdeg one. It then derives
ALL nilpotence, pth curvature scalar, exact kernel/bijection alternatives
and unit-gauge invariance in that actual original one-variable field,
without a supplied basis or separating-subfield premise. It builds and
imports the complete thirteen-module chain for the focused audit.

Canonical provenance for the widened Section 8 foundation:
`saturated_divisor_relations`, Version 3; statement SHA256
`1cdf26307c6dbd58ba2e37af4dba03074bb3b4f3874a279852ece059c2b3bf41`,
proof SHA256
`0172c7f7d390fb166aca7ab33ede3e3f3bdae06e172ba0dae096bc9915b6999b`.
The current statement and exact Section 8 proof were read through the
canonical workspace interface and named proof. The displayed restricted
identity and nonzero endpoint-field kernel are now obtained from genuine
proofs, including the original normalized derivation's nilpotence.

All computations are symbolic in arbitrary p; no sampled-prime matrix
oracle, numerical certificate or accepted literature premise is used.
This widens the Section 8 restricted-derivation foundation used in the
canonical saturated-divisor prose. It does not prove the remaining
Picard, genus/H0, clump-count, higher cohomological B_a or unmarked
common-cover statements.

Additional checked coefficient bridge, 3 October 2026 10:11 UTC:
`RestrictedCartierCoefficient` proves four literal statements on the
same arbitrary imperfect field and actual full p-basis. The actual
Cartier coefficient has pth power exactly `-D^(p-1)(f)`; hence its
fixedness is equivalent to zero literal restricted curvature, to a
nonzero original-field solution, and to vanishing of the ENTIRE actual
pth connection iterate. Any normalized derivation over any commutative
constant ring is supported. Frobenius injectivity supplies the converse
coefficient equality; no perfectness of the original field is used.

Focused build and transitive axiom audit PASS:
`../../../litt3-computation-data/formalization-20261003/verification/20261003T100907Z/report.json`.
This one-root snapshot checks 378 transitive theorem declarations,
with only `Classical.choice`, `Quot.sound`, and `propext`, zero forbidden
dependencies, and zero captured source changes. This additional root
was outside the earlier thirteen-module/448-declaration snapshot and
the 1,455-root stable aggregate. Root's full independent readback is
accepted at the exact audited source hash, recorded in
`restricted_cartier_coefficient_independent_review.md`.

The further `RestrictedConnectionKernelDimension` module proves
four exact whole solution-space statements over literal Kp. Actual
quotient differentiation and the derived derivative-kernel criterion
show that ANY nonzero solution spans the ENTIRE kernel. The curvature
criterion constructs such a solution in the zero-curvature case, so
the kernel's actual Kp-finrank is exactly one. Nonzero curvature
forces the full kernel to be bottom. Hence its exact finrank is one
for literal Cartier-fixed coefficients and zero otherwise, with
neither perfectness nor a finite-dimensional solution-space premise.

Focused build and transitive axiom audit PASS:
`../../../litt3-computation-data/formalization-20261003/verification/20261003T101136Z/report.json`.
This checks 389 transitive theorem declarations with only the standard
three logical axioms, zero forbidden dependencies and zero source
changes. Root's full independent mathematical readback of this
four-theorem extension and the following five-declaration parameter
module is accepted at the exact 403-snapshot hashes, recorded in
`restricted_connection_kernel_parameters_independent_review.md`.
It remains partial foundation coverage of the wider canonical
saturated-divisor statement.

`RestrictedConnectionKernelParameters` additionally constructs an
explicit linear equivalence from literal Kp to the ENTIRE connection
kernel, by multiplication by a genuine nonzero solution. Its apply
formula is exactly scalar multiplication. Actual Cartier fixedness
constructs such a solution and equivalence without supplying either.
The full basis derives ambient degree p over actual Kp; genuine
rank-nullity then gives exact original connection image finrank p-1
when Cartier fixes the coefficient, and p otherwise. All five
declarations build. Focused build and transitive axiom audit PASS:
`../../../litt3-computation-data/formalization-20261003/verification/20261003T101408Z/report.json`.
It checks 403 transitive theorem declarations, standard logical axioms
only, zero forbidden dependencies and zero source changes. The new
module was outside all earlier snapshots; its bounded independent
mathematical readback is accepted in the card linked above.

`IntrinsicCartierRestrictedConnections` now builds four literal
universal-differential statements. On the ORIGINAL Ω module and
actual intrinsic Cartier, fixedness is equivalent to zero original
restricted curvature, zero pth iterate of the entire original
connection, and a nonzero original-field solution. The complementary
connection is bijective exactly when the original form is not fixed.
The coordinate is the genuine universal differential equivalence,
normalized at the actual full p-basis parameter; the derivative is
literally its composition with universal D. The proof uses the true
intrinsic Cartier coordinate formula and the new operator identities;
no scalar-proxy identification or logarithmic converse is assumed.

The new `OneVariableIntrinsicConnections` terminal builds. It
constructs the actual p-basis, parameter, universal coordinate,
canonical intrinsic Cartier and derivative nilpotence from actual
FG and transcendence degree one over perfect constants. Its literal
existential theorem aggregates all four criteria for EVERY original
rational form. No basis, separating subfield, coordinate, Cartier
existence, nilpotence, curvature or solution is supplied as a premise.
Its focused build and transitive axiom/hash audit, covering both later
modules, PASS:
`../../../litt3-computation-data/formalization-20261003/verification/20261003T101641Z/report.json`.
It checks 447 transitive theorem declarations with standard logical
axioms only, zero forbidden dependencies and zero source changes.
Both later source hashes are recorded in that report. Their bounded
independent mathematical readback is accepted at those exact hashes in
`intrinsic_connection_independent_review.md`. No wider
canonical source status is promoted.

Further characteristic-polynomial widening:
`PrimePowerScalarCharpoly` builds the generic theorem over EVERY
prime-characteristic field: an actual p-dimensional endomorphism T
with T^p=c*id has literal characteristic polynomial X^p-c. A genuine
nilpotent scalar shift proves this when a root exists; actual
algebraic-closure tensor base change supplies a root, and injective
polynomial coefficient descent proves it over the original field.
No perfectness, eigenvalue multiplicity, matrix normal form or
characteristic polynomial is supplied as a premise.

`RestrictedConnectionCharpoly` builds the literal specialization to
the actual normalized connection over Kp. Original curvature's Kp
membership is proved from the actual derivative kernel. Ambient
degree p and finite-dimensionality are constructed from the full
basis. The actual characteristic polynomial is X^p+curvature,
the actual determinant is negative curvature, and actual trace is
zero, uniformly for ALL primes, including two. Numerical matrix
enumeration and sampled primes are unnecessary. The focused build and
transitive axiom/hash audit of these two later modules PASS:
`../../../litt3-computation-data/formalization-20261003/verification/20261003T102303Z/report.json`.
It checks 417 transitive theorem declarations with standard logical
axioms only, zero forbidden dependencies and zero captured source
changes. Their bounded independent mathematical readback is pending.

`FrobeniusLinearDerivations` proves that EVERY actual derivation on
the original prime-characteristic field kills its entire literal
pth-power subfield, without a basis, parameter, finite degree,
perfectness or normalization. It canonically constructs a derivation
over Kp with exactly the SAME original field function, and its
connection likewise has exactly the SAME pointwise operator.
`OriginalConnectionInvariants` uses that construction to derive the
actual original R-derivation's characteristic polynomial, literal
original-field determinant value and Kp-trace. No supplied Kp-linear
derivation or abstract scalar proxy remains. All eight new
declarations build; their focused transitive audit PASS:
`../../../litt3-computation-data/formalization-20261003/verification/20261003T102625Z/report.json`.
It checks 429 transitive theorem declarations with only standard logical
axioms, zero forbidden dependencies and zero source changes. Its bounded
independent mathematical readback remains separate.

# Cyclic mixed additive norm: exact scope

Canonical source: `Theorems/deformations/cyclic_descent/cyclic_power_additive_norm.md`,
Version3, SHA256 `661292a411cc6c032dc732d628bef78d694bc61a4ebfa7cb81599653f86f5dac`.
The full statement and its proof were read through the workspace statement
tool and the named proof path. This record is **complete** for the
entire canonical module theorem, including its actual perfect-field
truncated Witt application.

The coefficient ring is literally Z/p^(a+1), and K may have arbitrary
free rank. The canonical h≥1 is represented by n+1. The checked arithmetic
requires p>2h and h≤p^a, uniformly in every prime/exponent. No computation
table or bounded prime/rank is used. The theorem also applies to arbitrary
projective coefficient modules over a commutative ring with nilpotent p,
where the solvability condition is the actual top-scalar annihilator.

The module `PolynomialCyclicPresentation` is the literal mathlib
polynomial coefficient module modulo the range of multiplication by
F=(1+e)^q−1. Its norm operator is multiplication by the actual polynomial
F.divX. `PolynomialCyclicNorm` proves the division identity and equality
to the full integral binomial norm. `PolynomialCyclicCompletion` constructs
the original coefficient-inclusion equivalence to the full-series quotient;
its formula is proved on every original representative. No completion
equivalence is supplied as a hypothesis.

`FormalCyclicGeneration` derives actual finite augmentation-power generation
from full distinguished division. `FormalCyclicOperatorLift` then constructs
a finite polynomial coefficient lift for every original commuting A
congruent to e^h on constants. It uses projectivity of K and retains the
possibly noncommutative coefficient endomorphism algebra. The lift is an
existential conclusion, not an assumed preparation theorem or matrix form.

`PolynomialCoefficientEquivalences` is the literal coefficientwise action
of the given coefficient automorphism Phi on original polynomials. Its
descent to the original F quotient and commutation with original e are
proved. `MixedAdditiveOperators` derives Z/p^(a+1)-linearity of L solely
from additivity. `MixedComparisonCommutation` derives both the actual
commutation and mod-p congruence of A=L Phi^(-1) from the original identities.

`PolynomialMixedNormSolvability.polynomial_mixed_norm_solvable` proves the
original equation L y=N eta soluble exactly when eta lies in the actual
pK submodule, with no Witt-semilinearity hypothesis. The original L,
original coefficient automorphism, original norm and original polynomial
module all occur in its target. This covers the solvability equivalence
in clause1. `PolynomialMixedPrimitiveFiber.polynomial_mixed_primitive_fiber`
now proves the entire original solution reduction image: existence with
prescribed literal original reduction v is equivalent to eta in pK and
v being any final q−1 socle coefficient. Every actual relation witness
has its lower coordinates forced to zero using the free top-scalar
annihilator; conversely actual kernel primitives are constructed for
every socle coefficient and translated through the affine fiber.
The original coefficient automorphism is retained on the literal scalar
quotient and proved to preserve this exact socle image.

`PolynomialCommutingCokernel.polynomial_commuting_cyclic_cokernel` constructs
the full original cokernel of A as K times h−1 actual K/p^aK coordinates,
and proves the original norm class exactly (p^a eta,0,…,0). This covers
the unrestricted-rank cokernel and norm-class part of clause2. The finite
Smith-factor statement is not promoted merely from a cokernel isomorphism.

`SeriesCoefficientReduction` and `FormalCyclicReduction` retain actual
coefficient quotients and prove full prepared remainder reduction, full
F mod p=e^q and full N mod p=e^(q−1). The complete primitive-image and
terminal-carry proofs use these actual identities.

`PolynomialTerminalCarry.polynomial_terminal_carry` now proves the literal
original terminal carry from the actual original partial equation
A y−N eta=p^a r and the literal original leading coefficient pattern.
It constructs the finite representatives and full relation witness,
uses the free top-scalar annihilator on the actual prepared quotient,
and reduces the full logarithm through the actual coefficient quotient.
The sign is negative, C is the actual eta reduction, and the actual
finite shift discards exactly D_h. No representative or error term is
assumed to vanish.

`PolynomialFullSmith.polynomial_full_smith` constructs an actual two-basis
normal form and proves exactly f(q−h) unit factors, f(h−1) factors p^a,
and f zero factors. The finite coordinates of the original module are
derived from actual division and its coefficient basis. The generic
normal form itself is proved through an injective integral matrix lift,
mathlib's checked PID image Smith theorem, literal scalar extension of
both inverse bases, and actual prime-power-times-unit factorization.
No normal-form existence, factor count or original cokernel conclusion
is assumed. The original module theorem now has all three clauses proved.

`Theorems.Deformations.CyclicPowerNorm.CyclicPowerNormResult` states those
clauses as one explicit Prop structure, and
`Solutions.Deformations.CyclicPowerNorm.cyclic_power_norm` proves it.
`CyclicPowerNormInput` contains exactly the actual coefficient automorphism,
merely additive original L, original e commutation and original mod-p
congruence. The bundle needs only the canonical arithmetic assumptions;
the scalar top-power vanishing and h≤q are derived. Its carry uses the
original partial equation and literal original reduction pattern.

`CyclicPowerNormFive.cyclic_power_norm_five_carry` proves the exact original
p=5,h=2 expression −C−(2C+D1)e, uniformly in precision and arbitrary free
rank. The actual inverse of two is reduced on the actual coefficient
quotient, and the original comparison at Phi(x) is proved equal to L(x).

`TruncatedWittMaps` constructs the actual length-(a+1) Witt ring's
integer residue-module structure and its actual coefficient Frobenius
automorphism, with the literal formula on every coordinate.
`TruncatedWittResidue` constructs the actual zeroth-coordinate residue
ring map, proves its kernel is the actual p-multiple image, and proves
every nonterminal p-power annihilator is contained in that image.
These facts are proved using actual full Witt lifts and perfect-field
coordinate identities, rather than an assumed discrete-valuation model.

`NilpotentResidueBasis` constructs an arbitrary-rank basis from an actual
residue basis and these annihilator conditions. Both injectivity and
surjectivity follow by finite precision induction on actual finitely
supported coefficients; no dimension counting or finite residue degree
is assumed. `TruncatedWittBasis.truncated_witt_free` applies it to literal
Teichmüller lifts of any basis of k over F_p and proves that the actual
truncated Witt module is free over Z/p^(a+1).

`TruncatedWittCyclicNormOperator` contains exactly the original additive
L on the original polynomial quotient, original deck commutation and
mod-p e^h times actual Witt Frobenius leading term. Its `toInput` sets
Phi to the constructed literal Frobenius. The theorem
`TruncatedWittCyclicNorm.truncated_witt_cyclic_power_norm` proves the
whole original result bundle on this actual input, using the constructed
freeness. This supplies the canonical perfect-field Witt application,
without Witt-semilinearity of L or supplied module freeness. The source's
base conventions make k a field; no assertion for arbitrary perfect
coefficient rings is substituted for that field application.

No geometric Witt or BT comparison or nonlinear repair is asserted
complete here: the canonical statement explicitly separates those
applications from its module theorem.

Stable report 20261003T042935Z builds the original terminal carry,
merely-additive primitive fiber and polynomial cokernel package and
audits 583 transitive Litt3 declarations,
using only Classical.choice, Quot.sound and propext, with zero forbidden
dependencies and zero source changes. These are exact source components;
the three original abstract algebra clauses have subsequently been checked.

The stable 20261003T044900Z original Smith/carry/primitive aggregate
audits 712 declarations. The exact original bundle with its p=5,h=2
specialization passes 20261003T045604Z, auditing 736 declarations,
standard three logical axioms only, zero forbidden dependencies and
zero changed sources.

The actual Witt application aggregate passes 20261003T050618Z:
one root solution module, 799 transitive Litt3 declarations, only the
standard three logical axioms, zero forbidden dependencies and zero
source changes. Its report is
`../litt3-computation-data/formalization-20261003/verification/20261003T050618Z/report.json`.
Whole-source status is complete after independent final review of the
literal Witt application.

Independent reviewer `/root` accepted the entire abstract Version3
scope after reading the canonical statement and the exact input,
result bundle and two solution modules. This includes arbitrary free
rank, merely additive L, all original primitive reductions, original
cokernel/norm class, constructed finite Smith counts and the exact
logarithmic and p=5,h=2 carries, including y=Phi(x).

The same independent reviewer subsequently read the literal Witt input
and application, all six foundational solution files and this scope
review. The reviewer accepted genuine truncated Witt coefficients,
actual Frobenius, exact residue kernel and nonterminal annihilator
identities, and the arbitrary-rank Teichmüller basis construction as
the complete canonical perfect-field application. Combined with the
799-declaration audit, this accepts the entire Version3 source, including
finite Smith counts and the exact p=5,h=2 carry. The canonical SHA256
above is retained. The explicitly separate geometric oper/BT comparison
and nonlinear repair problem is not part of this complete module theorem.

## Current proof synchronization, 3 October2026

The current whole Version3 statement is unchanged. The full current human
proof was reread, SHA256
`a455fe95983da22832d1e90d0431b21543f9e82f8a8d8936b6c3d8b5eef31cb0`.
Its only tracked change relocates a historical receipt to the external
data store. No mathematical hypothesis, conclusion or free-rank scope
changed. The unchanged checked source hashes remain in stable report
`20261003T093716Z`. The [family sync review](deformations_source_sync_review_20261003.md)
archives current and tracked historical proof provenance separately.
Whole-source completion and the actual perfect-field Witt application
remain accepted; no numerical replay or geometric promotion follows.

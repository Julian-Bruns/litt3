# Critical quadratic incidence: exact partial scope

Canonical Version7 statement SHA256: `4dc368fad2f65e3a4aa52b1b914168fd7c0ebdc4fdb78774c795202e26b7a2d1`.
Proof SHA256: `b4a0792bc960b760d8a1500e1f72f4611e9c1513f5ae1caea7cd1dc9e92e6157`.
Status is `partial_component`; full curve, affine section and endpoint scope
is not inferred from the algebraic component.

`actual_source_quadratic_interpolator` proves the exact identity
U²−FQ=DV2 in every actual nonzero polynomial quotient over every field.
Its only value premise is the original numerator equation U(w)=uD(w).
Polynomial division constructs the unique reduced representative of u²D;
the actual quotient relation proves divisibility and constructs Q.
Its general degree bound is max(2deg U−deg F,deg D−1), with positive source
degree and the genuine reduced-degree condition. No critical coefficient
or discriminant is inverted; nonreduced sources are allowed here.

`separable_quotient_residue_trace_remainder` proves the complete formula
Tr(J(w)/F′(w))=[T^(N−1)](J mod F)/leadingCoeff(F), in the actual unsplit,
possibly disconnected separable quotient. The trace is transported through
actual field extension and actual quotient equivalences; splitting is
constructed rather than supplied. `actual_quadratic_interpolation_with_moments`
derives all quadratic moments from the exact V2 representative and
constructs both factor units from F′=phi D and actual separability.

`actual_degree_ten_critical_incidence` constructs the literal canonical
Q from actual rho=Tr(u w⁴/phi) and mu_j=Tr(u²w^j/phi), j=0,1,2. It proves
rho=U5/v and the exact polynomial identity with a reduced V2. Its hypotheses
are only the actual numerator equation, degree F=10, separability,
F′=phi D, degree U≤5 and degree D≤3. It works in every characteristic and
with arbitrary nonzero source leading coefficient. No trace formula or
desired critical incidence is an input.

The source polynomial's coefficients F9 and F8 are retained in the actual
remainder recurrence. In the raw canonical shape they can be nonzero.
The first three reduced moments absorb those correction terms, yielding
the exact displayed quadratic after symbolic cancellation. The independent
two-gap specialization is a separate lemma; it is not imposed on raw
source polynomials. Universal formal upper-product convolution works over
every commutative ring, including vanishing formal upper coefficients.

Focused audit [20261003T060705Z](../../../litt3-computation-data/formalization-20261003/verification/20261003T060705Z/report.json)
built both interpolation roots and audited 202 transitive declarations:
only Classical.choice, Quot.sound and propext, zero forbidden dependencies
and zero captured-source changes. The proofs use no numerical root or
rank computation.

The original actual primitive-field bridge now constructs the power basis
and raw quotient equivalence from K(w)=L, F(w)=0 and the matching actual
extension degree. `primitive_field_degree_ten_critical_incidence` transports
the exact V2 value and critical trace polynomial through that equivalence.
`smooth_curve_critical_quotient_is_integral` descends Q to the actual original
closed-point stalk when F,D,U,V2 are integral there and any coefficient of
F is a unit. Primitive Gauss divisibility applies to an arbitrary integral
numerator; neither source nor critical leading coefficient must be a unit.
Actual smoothness derives the DVR/GCD structure. These two bridges passed
focused audit `20261003T061217Z`, 313 declarations, standard3 and zero/zero.

`regular_weighted_interpolation_coefficient` proves coefficient integrality
from literal nodal products, actual root-content normalization and regular
weights. `full_interpolation_contact_bound` proves the exact selected-term
coefficient order 1+(s−1)k−kj when selected nodes have order at least k≥1,
selected weights have a simple zero, and the complementary cofactors are
regular. Nonselected terms contain all s selected nodal factors and retain
the same bound. All coefficients, repeated roots and coinciding residues
are retained. Their audit `20261003T061607Z` checked three roots and 367
declarations, standard3 only and zero forbidden/source changes. Actual
cover-to-completed-sheet and root-content/divisor bridges remain explicit;
the hypotheses are not manufactured from the desired endpoint conclusion.

`nonzero_reduced_polynomial_residue_moment` proves nondegeneracy of the
top-remainder pairing for every nonzero polynomial over every field,
including inseparable and nonreduced critical quotients. Its first N
moments uniquely determine the entire reduced polynomial.
`cubic_residue_reconstruction` derives the literal inverse cubic formula
from the three actual remainder moments, retaining the critical quadratic
and linear coefficients. It needs only degree D=3 and a reduced P;
critical roots need not be distinct.

The widened `universalQuotientResidueDuality` identifies the LITERAL
monic quotient with its linear dual over every commutative coefficient
ring, including zero divisors and nonreduced quotients. It is exactly
x ↦ (y ↦ top-remainder(xy)); the true reversed-power Gram matrix has
diagonal one and determinant one. No field dimensions or inverses are
used in that widening.
`critical_cubic_residue_representative_exists` constructs the actual F
denominator unit in K[T]/D and its reduced U²/F representative from true
coprimality. Its critical congruence is equivalent to the three actual
residue equations, with the nonzero infinity contribution retained in
the last equation. D may be repeated or inseparable. Focused audit
`20261003T063247Z` built three new roots and checked 88 transitive
declarations: standard three logical axioms, zero forbidden dependencies
and zero captured-source changes. These are complete algebraic
foundations; the whole original geometric source remains partial.

`actual_degree_ten_critical_cubic_residues` now constructs both actual
factor units and the reduced critical representative from the original
degree-ten source numerator equation. It derives the three critical
residue equations with the infinity term and all nonmonic corrections
retained. Their equivalence requires actual global degree D=3; repeated
critical roots remain allowed.

The new exact contact chain uses actual Laurent polynomials, without
assuming a quotient order, critical coefficient order or source primitive
content conclusion. The true source B times its selected nodal factor
has exact weight s*k from a regular cofactor with unit constant residue.
Signed selected interpolation orders -1 and +1 give the actual U and V2
weights. The literal derivative factorization F'=(T^5+q)D, with q of
order three, gives the D weight. That constant order itself follows from
the actual selected factor value and higher-order fifth power. The
annihilator/square weights follow from the actual numerator order two and
factor order three.

`laurent_weighted_polynomial_quotient_bound` proves weighted Gauss division
by actual rescaling into power-series polynomials and primitive-content
descent. The exact equation U²-FQ=DV2 therefore gives
ord Q_j >= (s-2)*k-2-k*j. At k=2, actual integrality and the source's exact
coefficient isolate a unique order-zero convolution term if Q_(s-3) were
a unit. The other side has strictly positive order, giving the extra
positive-order corner. `five_sheet_second_order_critical_jets` proves all
seven literal coefficient jets: four constant, two linear, one quadratic.
Q integrality in the nodal wrapper is derived from the integral U,D,V2
and the actual source unit coefficient, rather than assumed. These local
identities hold over every coefficient field; no graded-initial-form
conclusion, distinct residue, root enumeration or rank computation is
used. `primitive_unselected_cofactor_valuation_unit` separately derives
cofactor regularity and its unit constant from genuine primitive root
content normalization and the actual unselected pole/residue bounds.

Focused audit [20261003T065715Z](../../../litt3-computation-data/formalization-20261003/verification/20261003T065715Z/report.json)
built four new roots and checked 373 transitive declarations, with only
the standard three logical axioms, zero forbidden dependencies and zero
captured-source changes. The actual cover-to-full-completed-sheet,
root-content and original divisor-order bridges are still separate gaps;
the local algebra data are not presumed to arise from an arbitrary cover.

The actual finite-morphism trace bridge now proves: on any original
nonempty affine open U of a normal integral base, a source rational
function regular at EVERY original stalk of the full inverse image has
its literal original function-field trace in the actual base section
ring Γ(U). The true finite chart algebra and function-field finiteness
are derived from the actual finite surjective map. Source smoothness,
etaleness, separability, a supplied normalization and a field-degree
bound are unnecessary. Genuine smooth relative dimension one supplies
base chart normality in the curve specialization. The upstream all-stalk
condition gives an actual section by true sheaf gluing on arbitrary
opens; it is not a trace-regularity assumption. Focused audit
`20261003T070507Z` checked 129 declarations, standard3 only and zero/zero.
Applying it to the six original ξw^j still requires the explicit original
divisor-to-stalk membership construction.

Remaining literal Version7 scope: original affine curve integrality of
U,V2,Q and actual cover-to-sheet application of the finite contact jets;
infinity pole estimates; the full
polynomial-part/Laurent moment interpretation; six-moment gap constraints
and exact 45/15/33 parameter dimensions; fixed finite endpoint five-jet
certificates and their conditional boundary exclusions; and the separate
degree-eleven/twelve profiles. No realization of moment tuples, source
existence, trace-zero witness or common-cover exclusion is asserted.

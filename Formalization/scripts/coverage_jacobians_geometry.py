#!/usr/bin/env python3
"""Refresh the owned coverage fragment from canonical records and checked components."""

from __future__ import annotations

import hashlib
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
FORMAL = ROOT / "Formalization"
PREFIXES = (
    "Theorems/jacobians/",
    "Theorems/quotient_geometry/",
    "Theorems/curve_arithmetic/",
    "Theorems/examples/",
)


def component(module: str, declaration: str, claim: str, gap: str) -> dict:
    return {
        "declaration": declaration,
        "module": module,
        "claim": claim,
        "gap": gap,
    }


N = "Solutions.Jacobians.NumericalConsequences"
T = "Solutions.Jacobians.TorsionAndNorm"
J = "Solutions.Jacobians.JetElimination"
F = "Solutions.QuotientGeometry.FreeFiniteActions"
E = "Solutions.CurveArithmetic.EmbeddedFields"
V = "Solutions.Jacobians.ValuationDivisorClasses"
A = "Solutions.Jacobians.AlmostFixed"
S = "Solutions.CurveArithmetic.PolynomialSpecialization"
R = "Solutions.QuotientGeometry.RamificationNumerics"
I = "Solutions.QuotientGeometry.InvariantIntersections"
P = "Solutions.QuotientGeometry.PerfectRoots"
D = "Solutions.Jacobians.DedekindDivisorClasses"
Q = "Solutions.Jacobians.RationalDivisors"
RA = "Solutions.QuotientGeometry.RefinementAlgebra"
FA = "Solutions.CurveArithmetic.FiniteAffineInvariant"
AD = "Solutions.CurveArithmetic.AffineInvariantDegree"
AG = "Solutions.CurveArithmetic.AffineLineGroup"
CP = "Solutions.QuotientGeometry.CanonicalPencil"
DC = "Solutions.QuotientGeometry.DerivationCoordinates"
AP = "Solutions.CurveArithmetic.AffineParameters"
HA = "Solutions.CurveArithmetic.HyperellipticAffineModels"
QF = "Solutions.QuotientGeometry.QuadraticFunctionFields"
FL = "Solutions.CurveArithmetic.FractionalLinearMaps"
HS = "Solutions.CurveArithmetic.HyperellipticAffineSchemes"
BP = "Solutions.CurveArithmetic.FiniteBranchPolynomial"
BC = "Solutions.CurveArithmetic.FiniteBranchCoordinateChange"
SP = "Solutions.Jacobians.SchemeValuationPullbacks"
DS = "Solutions.Jacobians.SchemeFiniteSupport"
DA = "Solutions.Jacobians.DedekindAffineCharts"
PF = "Solutions.Jacobians.RationalProductFormula"
RD = "Solutions.Jacobians.RationalDivisorClassification"
CB = "Solutions.QuotientGeometry.CanonicalPencilBinaryField"
CN = "Solutions.QuotientGeometry.CanonicalPencilNonconstant"
FF = "Solutions.QuotientGeometry.FunctionFieldRationalMaps"
FR = "Solutions.QuotientGeometry.FunctionFieldRecovery"
FD = "Solutions.QuotientGeometry.FunctionFieldDominance"
PC = "Solutions.QuotientGeometry.ProperCurveFieldMaps"
SF = "Solutions.QuotientGeometry.SchemeFieldFactorization"
PR = "Solutions.QuotientGeometry.ProperCurveFieldRecovery"
PI = "Solutions.QuotientGeometry.ProperCurveIsomorphisms"
AI = "Solutions.QuotientGeometry.AffineChartIsomorphisms"
QM = "Solutions.QuotientGeometry.QuadraticPlaneModels"
BI = "Solutions.CurveArithmetic.FiniteBranchIntegralModels"
QS = "Solutions.QuotientGeometry.QuadraticPlaneSchemes"
WL = "Solutions.QuotientGeometry.WeakLaurentNormalForm"
WT = "Solutions.QuotientGeometry.WeakLaurentLinearization"
AS = "Solutions.QuotientGeometry.ArtinSchreierClasses"
PA = "Solutions.QuotientGeometry.PowerSeriesAdic"
QD = "Solutions.QuotientGeometry.QuadraticPlaneDedekind"
PSR = "Solutions.Jacobians.PowerSeriesRoots"
LC = "Solutions.QuotientGeometry.LaurentPoleCoordinates"
ASF = "Solutions.QuotientGeometry.PoleOneArtinSchreierFields"
ASC = "Solutions.QuotientGeometry.PoleOneArtinSchreierClasses"
FPD = "Solutions.QuotientGeometry.FiniteParameterDimension"
LAS = "Solutions.QuotientGeometry.LinearizedArtinSchreierScaling"
PFU = "Solutions.QuotientGeometry.ParameterFieldMapUniqueness"
LAM = "Solutions.QuotientGeometry.LinearizedArtinSchreierModel"
LLG = "Solutions.QuotientGeometry.LinearizedLaurentGalois"
LLC = "Solutions.QuotientGeometry.LinearizedLaurentClassification"
WMN = "Solutions.QuotientGeometry.WeakLaurentMapNormalization"
WAM = "Solutions.QuotientGeometry.WeakLaurentArtinSchreierModel"
WGC = "Solutions.QuotientGeometry.WeakLaurentGalois"
WCL = "Solutions.QuotientGeometry.WeakLaurentClassification"
LTF = "Solutions.QuotientGeometry.LaurentTameFactorization"
WTO = "Solutions.QuotientGeometry.WeakTameOriginalField"
WOG = "Solutions.QuotientGeometry.WeakTameOriginalGalois"
WTG = "Solutions.QuotientGeometry.WeakTameGalois"
APR = "Solutions.QuotientGeometry.AffinePoleRamification"
WDO = "Solutions.QuotientGeometry.WeakTameDerivativeOrders"
WRI = "Solutions.QuotientGeometry.WeakTameRootIndependence"
WTC = "Solutions.QuotientGeometry.WeakTameClassification"
CPR = "Solutions.QuotientGeometry.ConstantPolynomialCompletedRing"
CDI = "Solutions.QuotientGeometry.CompletedDifferent"
PDI = "Solutions.QuotientGeometry.ParameterDifferentValuation"
WOD = "Solutions.QuotientGeometry.WeakOriginalDifferent"
WDS = "Solutions.QuotientGeometry.WeakLaurentDifferentialScalar"
WSM = "Solutions.QuotientGeometry.WeakNormalizedSemidirect"
WIA = "Solutions.QuotientGeometry.WeakNormalizedIntegralAction"
WTR = "Solutions.QuotientGeometry.WeakTameOriginalRamification"
CSC = "Solutions.QuotientGeometry.CommonSourceCompletedComparison"
CSD = "Solutions.QuotientGeometry.CommonSourceDifferentialComparison"
DVC = "Solutions.QuotientGeometry.DVRPowerSeriesChart"
SDC = "Solutions.QuotientGeometry.SchemeDVRCompletions"
DSC = "Solutions.QuotientGeometry.SameSourceDVRWeakScalars"
ODS = "Solutions.QuotientGeometry.OriginalDVRDifferentialScalars"
PDR = "Solutions.QuotientGeometry.PolynomialDifferentialRatios"
DFC = "Solutions.QuotientGeometry.DVRFunctionFieldCompletion"
GNC = "Solutions.QuotientGeometry.GaloisNormalizationCompletedFields"
GNS = "Solutions.QuotientGeometry.GaloisNormalizationDifferentialScalars"
SSD = "Solutions.QuotientGeometry.SchemeSameSourceDifferentialScalars"
CAR = "Solutions.QuotientGeometry.ClosedAffineResidueCoefficients"
GSC = "Solutions.QuotientGeometry.GaloisNormalizationSpecCompletedFields"
ACR = "Solutions.QuotientGeometry.AffineChartClosedResidues"
SNM = "Solutions.QuotientGeometry.SeparableNormalizationSchemeMaps"
GSS = "Solutions.QuotientGeometry.GaloisNormalizationSameSourceScalars"
NAN = "Solutions.QuotientGeometry.NormalIntegralAffineNormalization"
GCV = "Solutions.QuotientGeometry.GaloisSmoothCurveCompletedFields"
GFL = "Solutions.QuotientGeometry.GaloisSmoothSameSourceFiber"
GFS = "Solutions.QuotientGeometry.GaloisSmoothSameSourceScalars"
FSF = "Solutions.QuotientGeometry.FiniteSchemeFunctionFields"
FSC = "Solutions.QuotientGeometry.FiniteSmoothChartNormalization"
SAD = "Solutions.QuotientGeometry.SmoothCurveAffineDedekind"
GGS = "Solutions.QuotientGeometry.GaloisSmoothGlobalScalars"
CFG = "Solutions.QuotientGeometry.CharacteristicFiveGaloisGlobal"
SDI = "Solutions.QuotientGeometry.SmoothStalkDifferentialInjectivity"
SGI = "Solutions.QuotientGeometry.SmoothGlobalDifferentialIdentities"
CPI = "Solutions.QuotientGeometry.CompletedDVRParameterIdentification"
WDG = "Solutions.QuotientGeometry.WeakDifferentGalois"
WDR = "Solutions.QuotientGeometry.WeakDifferentRamification"
WDC = "Solutions.QuotientGeometry.WeakDifferentClassification"
WVC = "Solutions.QuotientGeometry.WeakValuativeClassification"
WVR = "Solutions.QuotientGeometry.WeakValuativeRamification"
WVU = "Solutions.QuotientGeometry.WeakValuativeUniformizerIndependence"
WAC = "Solutions.QuotientGeometry.WeakAllUniformizerChoices"
GOPS = "Solutions.QuotientGeometry.GaloisSmoothOriginalProfileScalars"
FGC = "Solutions.QuotientGeometry.CharacteristicFiveGaloisCoordinates"
FGP = "Solutions.QuotientGeometry.CharacteristicFiveGaloisRationalProducts"
RCP = "Solutions.QuotientGeometry.RationalCoordinateDifferentialProduct"
RCU = "Solutions.QuotientGeometry.RationalCoordinateDerivationUniqueness"
RFC = "Solutions.QuotientGeometry.RationalProductFiberConstants"
SCOR = "Solutions.QuotientGeometry.SmoothCurveCoordinateDifferentialRatio"
CCON = "Solutions.QuotientGeometry.CoordinateDifferentialConstraints"
GLRS = "Solutions.QuotientGeometry.GaloisSmoothLocalRationalScalars"
SPCF = "Solutions.QuotientGeometry.SmoothProperCurveFields"
FPCF = "Solutions.QuotientGeometry.FiniteProperCurveFieldMaps"
PSCF = "Solutions.QuotientGeometry.ProperSmoothCurveFiniteMaps"
ACP = "Solutions.Jacobians.ActualClassGroupPicard"
DAP = "Solutions.Jacobians.DedekindAffineDivisorPicard"
DAS = "Solutions.Jacobians.DedekindAffineDivisorSheaves"
DSS = "Solutions.Jacobians.DedekindAffineSectionSheaves"

COMPONENTS = {
    "etale_rosati_factorization": [
        component(N, "Litt3.Jacobians.rosati_saturation_numerical",
                  "Positive-degree adjunction trace saturation forces c=b.",
                  "Construct the actual joint-image normalization and derive the trace inequality; prove degree-one projection gives original-map factorization."),
        component(N, "Litt3.Jacobians.trace_bound_equality_iff_defect_zero",
                  "Under the explicit defect identity and c nonzero, trace equality is equivalent to zero normalization defect.",
                  "Prove the intersection/adjunction identity and identify defect zero with smoothness of the actual reduced image."),
        component(N, "Litt3.Jacobians.rosati_prime_factor_numerical_gap",
                  "The bound c<=b/ell implies the stated strict-factor alternative trace bound.",
                  "Relate failed actual map factorization to a nontrivial integer quotient index and its least prime divisor."),
        component(T, "Litt3.Jacobians.image_containment_implies_norm_saturation",
                  "Additive norm-pullback identities and actual range containment imply scalar saturation.",
                  "Realize homomorphisms on actual Jacobian geometric points and principal Rosati adjoints; connect scalar saturation to curve-map descent."),
        component(E, "Litt3.CurveArithmetic.joint_field_index_dvd_gcd",
                  "The index of the supremum of two embedded fields divides the gcd of their original ambient indices.",
                  "Identify the actual normalized joint-image function field with the embedded supremum and indices with degrees."),
        component(SP, "Litt3.Jacobians.same_source_principal_pullbacks",
                  "Both original actual finite etale maps from the SAME integral source pull back actual principal closed-point divisors through their actual generic-stalk function-field maps; valuation compatibility is derived from local unramifiedness and essential finite type.",
                  "Derive actual closed-point DVR stalks and global finite principal support from the smooth proper curve hypotheses, realize these divisor quotients as Picard/Jacobian groups, and prove the Rosati/intersection identities."),
        component(DS, "Litt3.Jacobians.finite_principal_support_of_dedekind_cover",
                  "A finite cover by actual non-field affine Dedekind chart rings proves global finite support of actual closed-point valuations; actual DVR stalks are also derived from the same charts.",
                  "Construct such genuine Dedekind affine charts from the source smooth proper dimension-one curve assumptions, identify the Picard/Jacobian quotient, and establish the Rosati geometry."),
        component(SF, "Litt3.QuotientGeometry.scheme_factorization_of_field_factorization",
                  "An equality of actual generic-stalk pullbacks proves factorization of actual surjective Scheme morphisms with separated target; actual pullbacks preserve identities and reverse composition, and determine the original maps faithfully.",
                  "Construct the required intermediate curve morphism and prove its field identity from the source Rosati saturation and normalized joint-image geometry, retaining both original finite-etale maps from the same source."),
    ],
    "raynaud_rank_one_dimension": [
        component(N, "Litt3.Jacobians.abelian_divisor_rank_one_impossible",
                  "The scaled Raynaud rank-one bound is incompatible with codimension one on a hyperbolic curve.",
                  "Prove the dimension bound for the translated Poincare cohomology family, its strict torsion-cycle extension, and higher-defect Wronskian bound."),
        component(N, "Litt3.Jacobians.wronskian_coefficients_characteristic_five",
                  "The general Wronskian coefficient gives 4/5,3/5,8/15,1/2 for defects 1,2,3,4 at p=5.",
                  "Construct the generic independent sections and prove the geometric Wronskian dimension inequality."),
    ],
    "raynaud_abelian_components": [
        component(N, "Litt3.Jacobians.abelian_component_characteristic_gt_five",
                  "Multiplicity>=2, elliptic quotient degree>=2, and multiplicity*degree<p-1 force p>5.",
                  "Construct the abelian theta component and induced quotient and prove all three geometric inequalities."),
    ],
    "low_genus_raynaud_cosets": [
        component(N, "Litt3.Jacobians.abelian_divisor_rank_one_impossible",
                  "The codimension-one part of the dimension obstruction follows algebraically from the scaled bound.",
                  "The low-genus numerical cases, defect-rank bounds, actual cover families and their theta properness are not formalized."),
    ],
    "polarization_bad_fiber_bound": [
        component(N, "Litt3.Jacobians.cardinal_le_defect_power_budget",
                  "Every positive integral defect costs at least one unit of the supplied power budget.",
                  "Construct the bad-fiber zero scheme and prove the Hilbert-Samuel/intersection budget and its cover-specific value."),
        component(N, "Litt3.Jacobians.cyclic_triple_free_orbit_budget",
                  "Budget ten permits at most one six-point free orbit.",
                  "Construct the actual C6 action on the bad cosets and prove finiteness and the numerical budget."),
        component(T, "Litt3.Jacobians.torsion_lifts_across_exponent_kernel",
                  "A quotient point killed by M lifts to a point killed by nM when the kernel is killed by n.",
                  "Construct the actual norm-complement isogeny and prove its scheme-theoretic kernel lies in J[n], including inseparable covers."),
    ],
    "two_primary_w3": [
        component(T, "Litt3.Jacobians.four_torsion_separation",
                  "A stable subset containing zero, separated by two-torsion translates, has no nonzero order-four point when M-I=2U with U injective.",
                  "Reduce arbitrary two-primary torsion to order four by the Boxall-Grant order law; establish actual pencil translate separation, Tate-module identities and Cartier comparison."),
        component(J, "Litt3.Jacobians.linear_remainder_no_common_root",
                  "A nonzero linear polynomial remainder and its nonzero evaluation in the divisor polynomial exclude all common roots.",
                  "Identify the actual endpoint coefficient polynomials and prove the stated remainder identity over F25; connect this certificate to the generalized Cartier image."),
    ],
    "superelliptic_single_point_torsion_test": [
        component(DSS, "Litt3.Jacobians.dedekind_affine_section_module_mem_iff",
                  "The literal original fractional ideal for -D consists EXACTLY of all original rational functions satisfying the true normalized adic valuation pole bounds exp(D) at every height-one point, including zero. Its ACTUAL O(D) associated sheaf has derived rank-one local SHEAF trivializations on the entire basic-open sites and genuine affine global-section recovery.",
                  "This realizes affine divisor sections, not a proper curve's global line bundle or Jacobian. Glue the actual proper points including infinity and prove the exact complete Riemann--Roch monomial/Hasse-jet basis and genuine Jacobian torsion interpretation."),
        component(DAS, "Litt3.Jacobians.dedekind_affine_divisor_sheaf_trivial_iff_principal",
                  "The ACTUAL O_Spec-module SHEAF of the literal prime-fractional-ideal product of a normalized adic affine divisor is trivial exactly when it is the ACTUAL normalized divisor of an original fraction-field unit. The associated-sheaf maps, structure-sheaf comparison and finite-projective original global-section recovery are constructed, so sheaf isomorphism detects the original Picard class.",
                  "Positive primes use the O(-D) ideal convention. Construct proper-curve divisor sheaves including infinity, global tensor/Picard classes and genuine Jacobian points, and prove the full source monomial Riemann--Roch/Hasse-jet criterion. No global scheme Picard or Jacobian theorem follows from affine sheaf realization."),
        component(DAP, "Litt3.Jacobians.actualDedekindAffineDivisorPicardEquiv",
                  "The ACTUAL normalized height-one adic divisor class quotient of any Dedekind fraction field is isomorphic to the ACTUAL ring Picard group. Every affine divisor and genuine fractional ideal correspond via true prime-ideal integer counts; the genuine field-valuation principal divisor equals the literal principal ideal's count divisor, so the full principal kernel is derived.",
                  "Positive prime divisors map to their actual prime-ideal modules, the affine O(-D) convention. Glue proper-curve points including infinity, identify the actual global degree-zero sheaf class group with genuine Jacobian points, and prove the source monomial Riemann--Roch/Hasse-jet criterion."),
        component(ACP, "Litt3.Jacobians.actualClassGroupPicardEquiv",
                  "For EVERY commutative integral domain, its genuine invertible fractional-ideal class quotient is isomorphic to Mathlib's actual ring Picard group; the principal kernel and every module's fractional-ideal presentation and inverse are derived from true tensor multiplication and original dual contraction.",
                  "This is an affine RING Picard comparison; realize invertible sheaves on the actual affine curve, glue proper-curve divisor line bundles including infinity, identify degree-zero Picard with actual Jacobian points, and derive the full monomial Riemann--Roch/Hasse jet criterion."),
        component(PSR, "Litt3.Jacobians.power_series_nth_root_with_constant",
                  "Every prescribed nonzero constant n-th root lifts to an actual full formal power-series n-th root over any field when n is invertible. Algebraically closed constants supply a unit n-th root of every unit series by genuine Hensel lifting.",
                  "Identify the actual local branch coordinate and the Hasse coefficients of this unique root with the source jet matrix; construct the complete monomial Riemann--Roch basis and proper-curve torsion interpretation."),
        component(D, "Litt3.Jacobians.dedekind_divisor_class_torsion_iff_principal_multiple",
                  "For the actual Dedekind height-one adic divisor system with proved finite support, class torsion is equivalent to an actual principal multiple.",
                  "Identify an actual smooth affine model's Dedekind ring and complete it to the proper curve, including points at infinity and the product formula."),
        component(Q, "Litt3.Jacobians.rational_principal_divisor_at_infinity",
                  "For the actual all-place rational-function valuation model, the principal coefficient at infinity is denominator degree minus numerator degree.",
                  "Construct normalized valuations of the actual superelliptic extension at its ramified infinity points, include residue degrees, and realize the Riemann--Roch basis and torsion incidence."),
        component(PF, "Litt3.Jacobians.rational_product_formula",
                  "For every algebraically closed constant field, the genuine full rational-function adic/infinity valuation system satisfies the unweighted product formula, proved through structural linear factorization.",
                  "Transfer to the actual superelliptic extension with normalized ramification and residue-degree weights, realize its proper curve, and prove its divisor product formula."),
        component(RD, "Litt3.Jacobians.rational_divisor_degree_zero_iff_principal",
                  "Every actual degree-zero full rational-function divisor over algebraically closed constants is principal; the genuine divisor-class quotient is additively equivalent to the integers via degree.",
                  "Identify the divisor quotient with the Scheme Picard group, then treat the source superelliptic curve rather than substituting its rational quotient for it."),
        component(V, "Litt3.Jacobians.single_point_divisor_class_torsion",
                  "Single-point divisor-class N-torsion is equivalent to a principal multiple from a genuine nonzero field unit and integer field valuations.",
                  "Construct normalized valuations and finite support from the actual smooth proper curve; identify its degree-zero class group with Jacobian geometric points; derive the monomial basis and actual jet criterion."),
        component(J, "Litt3.Jacobians.block_jet_nonzero_kernel_iff",
                  "Eliminating an identity block gives an exact nonzero-kernel equivalence over every ring.",
                  "Construct the actual Riemann-Roch monomial basis, Hasse root coefficients, jet matrix and single-point torsion equivalence."),
        component(J, "Litt3.Jacobians.bezout_power_certificate_detects_nonzero_minor",
                  "A polynomial Bezout identity equal to a branch-polynomial power proves some selected minor is nonzero at each nonbranch point.",
                  "Link selected determinants to the actual specialized jet matrix and prove full-column-rank equivalence."),
    ],
    "hyperelliptic_etale_quotients": [
        component(F, "Litt3.QuotientGeometry.free_action_card_dvd_fiber",
                  "A finite fixed-point-free group action gives group-cardinality divisibility of the finite fiber cardinality.",
                  "Produce the preserved geometric fiber under each cyclic deck subgroup from a fixed projective point."),
        component(F, "Litt3.QuotientGeometry.small_fiber_elements_square_one",
                  "A freely acting group on a nonempty at-most-two-point fiber has exponent at most two.",
                  "Realize cyclic deck actions on hyperelliptic fibers; global PGL2 Sylow and conjugacy arguments and free lifts remain."),
        component(F, "Litt3.QuotientGeometry.exponent_two_elements_commute",
                  "Every exponent-two group is abelian, without a finiteness hypothesis.",
                  "Prove the deck group exponent two and the projective two-rank bound, then classify its actual quotient."),
    ],
    "low_pencil_torsion_rigidity": [
        component(E, "Litt3.CurveArithmetic.prime_index_outside_element_generates",
                  "Every element outside the base field generates a prime-index extension, including the inseparable case.",
                  "Prove the actual split-bundle pencil degree bound, torsion translate separation, divisor reduction, and almost-rational conclusions."),
        component(A, "Litt3.Jacobians.integer_finite_permutation_almost_fixed",
                  "On a finite integer coefficient orbit, the relation sigma*D+tau*D=2D forces both permutations to fix D.",
                  "Prove uniqueness of the actual reduced divisor and translate the Abel-class relation into the coefficient identity; construct the finite orbit and retain its ramified part."),
    ],
    "family_six_torsion_abel_exclusion": [
        component(E, "Litt3.CurveArithmetic.coprime_embedded_fields_generate",
                  "Two actual embedded subfields of coprime ambient indices generate the ambient field.",
                  "Identify fields k(f),k(g) with degrees three and four in the actual spectral model, then construct the hyperelliptic map; endpoint jet resultant and cubic-torsion census remain."),
        component(S, "Litt3.CurveArithmetic.bounded_eliminant_excludes_incidence",
                  "A nonzero degree-at-most160 incidence eliminant excludes parameters of algebraic degree greater than160.",
                  "Construct and verify the actual two Hasse square-root jet polynomials, resultant degree/nonvanishing including infinity specialization, and spectral six-torsion implication."),
    ],
    "hom_disjoint_correspondence_gonality": [
        component(E, "Litt3.CurveArithmetic.joint_field_index_dvd_gcd",
                  "The common source field's joint-subfield index divides the gcd of the two original degrees.",
                  "No Hom-disjoint divisor family, basepoint-free pencil, gonality or actual trigonal factorization is yet formalized."),
    ],
    "family_small_torsion_specialization": [
        component(S, "Litt3.CurveArithmetic.bounded_eliminant_excludes_incidence",
                  "A nonzero degree-at-most870 incidence eliminant excludes nonbranch8-torsion at all parameters of algebraic degree greater than870.",
                  "Prove actual torsion incidence and the eliminant certificate, specialization properness, and all Cartier and clump implications."),
    ],
    "family_thirty_two_torsion_specialization": [
        component(S, "Litt3.CurveArithmetic.bounded_eliminant_excludes_incidence",
                  "A nonzero degree-at-most479318 incidence eliminant excludes non-Weierstrass32-torsion at parameters of larger algebraic degree.",
                  "Construct the exact Hasse-jet minors, establish resultant nonvanishing and degree bound including specialization boundaries, and realize the actual curve incidence."),
    ],
    "main_small_elliptic_map_exclusion": [
        component(S, "Litt3.CurveArithmetic.bounded_eliminant_excludes_incidence",
                  "Every incidence controlled by a nonzero bounded-degree polynomial is absent at a higher-degree parameter.",
                  "For every N>=2 prove the actual elliptic-map parameter strata and their aggregate bound N*5^(4*N+4), Frobenius stability, inseparable reduction, good specialization and actual elliptic-map correspondence; instantiate the original MAIN degree-SIXTEEN application and retained same-source spin carrier."),
    ],
    "genus_two_abelian_cover_families": [
        component(S, "Litt3.CurveArithmetic.bounded_eliminant_excludes_incidence",
                  "A nonzero exceptional polynomial excludes its incidence at every parameter of larger algebraic degree.",
                  "Construct the maximal abelian cover family, determinant polynomial and Hodge degree bound, establish an actual ordinary fiber and prove quotient/p-group ordinarity implications."),
    ],
    "ramification_constraints": [
        component(R, "Litt3.QuotientGeometry.swan_twist_orbit_sum_divisibility",
                  "Integral character-twist orbit contributions with stabilizer exponent at most min(r,2a) have total divisible by p^ceil(r/2).",
                  "Define the actual faithful local action and its lower filtration and Swan representations; derive the regular character identity and orbit/stabilizer formulas from the literature and prove the subgroup assertion."),
        component(R, "Litt3.QuotientGeometry.tame_break_sum_divisibility",
                  "Divisibility of every graded break contribution implies divisibility of the exact Swan break sum.",
                  "Realize tame graded characters for the actual local action, prove the graded divisibility, first/last-break common nonzero residue and exact break-counting identity."),
    ],
    "inertia_generated_core_preserving_refinement": [
        component(RA, "Litt3.QuotientGeometry.normally_generating_elements_fixed_cosets_subgroup_top",
                  "If normally generating inertia elements act trivially on the entire actual coset fiber G/H, then H=G, without requiring H normal or G finite.",
                  "Identify unramified intermediate covers with trivial inertia action on every geometric coset, and construct auxiliary covers with the prescribed inertia."),
        component(I, "Litt3.QuotientGeometry.finite_invariant_field_intersection_eq_bot",
                  "A finite automorphism subgroup preserving two actual embedded fields with constant fixed intersection forces their full intersection to equal the algebraically closed constant field.",
                  "Construct the actual auxiliary compositum action and prove surjective endpoint restrictions identify its fixed intersection; prove the normalized upper legs are etale from matching completed extensions."),
        component(P, "Litt3.QuotientGeometry.perfect_galois_root_descends",
                  "In a finite Galois extension with perfect automorphism group, an m-th root of a base element descends when all m-th roots of unity already lie in the base.",
                  "Realize the canonical shared-ring generator and its rational frame root on each actual auxiliary cover; prove regular descent by local valuations and the original primitive-weight contradiction."),
        component(P, "Litt3.QuotientGeometry.perfect_galois_regular_root_descends",
                  "A positive-power root in a perfect finite Galois extension descends regularly to any integrally closed base domain when its power is regular and all relevant roots of unity lie in the base fraction field.",
                  "Translate the canonical tensor's local trivializations into the normal-domain root statement and glue the actual regular root, then invoke original primitivity."),
        component(P, "Litt3.QuotientGeometry.perfect_galois_root_descends_over_algebraically_closed_constants",
                  "Every positive-power root of a base-field element in a perfect finite Galois extension descends when the actual field tower contains algebraically closed constants; no prime-to-characteristic order restriction is needed for this algebraic conclusion.",
                  "Realize the actual rational tensor root and prove primitive weight preservation through its local regularity and descent on both endpoints."),
    ],
    "prime_field_branch_family": [
        component(FA, "Litt3.CurveArithmetic.finite_affine_invariant_complete",
                  "For any finite field K and any actual extension field, the invariant (a^|K|−a)^(|K|−1) is complete for affine K-transformations of non-base parameters.",
                  "Classify actual hyperelliptic branch-set projectivities and prove the geometric curve-class interpretation."),
        component(FA, "Litt3.CurveArithmetic.finite_affine_invariant_fiber_card",
                  "Every non-base invariant fiber has exactly |K|(|K|−1) parameters, proved by a bijection with K-units times K.",
                  "Relate invariant fibers to unmarked geometric isomorphism classes of the actual smooth hyperelliptic curves and include the separate rational boundary parameter."),
        component(AD, "Litt3.CurveArithmetic.finite_affine_invariant_field_degree_quotient",
                  "For actual finite F⊂K and any algebraic extension L/K, a non-F parameter has invariant degree m dividing parameter degree d; d/m is the characteristic p or divides |F|−1, by exact Frobenius return periods on the actual free affine orbit.",
                  "Identify the invariant degree with the moduli orbit of the actual curve; prove branch classification, genus, automorphism group, characteristic-five coordinate change and quadratic boundary statements."),
        component(AD, "Litt3.CurveArithmetic.coprime_affine_invariant_degree_eq",
                  "The invariant preserves parameter degree whenever that degree is coprime to p(|F|−1), for every actual algebraic finite-field tower.",
                  "Translate the exact arithmetic equality into the original unmarked geometric isomorphism-class orbit statement."),
        component(AG, "Litt3.CurveArithmetic.finite_affine_element_order_alternatives",
                  "Every element of the actual affine group over an arbitrary finite field has order equal to its characteristic or dividing field cardinality minus one; the proof uses conjugation to a dilation and the translation subgroup.",
                  "This group theorem alone does not prove that the source hyperelliptic branch projectivities are affine or that there are no other geometric automorphisms."),
        component(AP, "Litt3.CurveArithmetic.reciprocal_translate_degree_eq",
                  "Reciprocal translation preserves the actual smallest embedded parameter field and its field degree over every base field, including the original characteristic-five change a=1/(t−4).",
                  "Identify the original five-point hyperelliptic equation under the projective coordinate change and include the smooth rational boundary t=4 separately."),
        component(AP, "Litt3.CurveArithmetic.quadratic_parameters_affine_equivalent",
                  "Every non-base quadratic parameter has invariant −1 and every two such parameters are related by an actual affine base-field transformation, for every finite field.",
                  "Convert the actual affine parameter equivalence into an isomorphism of the source smooth projective curve models and prove the converse projectivity classification."),
        component(HA, "Litt3.CurveArithmetic.finite_branch_coordinate_equiv_of_invariant_eq",
                  "Equality of the complete invariant constructs an actual isomorphism between the two hyperelliptic affine coordinate rings: the invertible plane substitution sends the defining equation to a unit multiple and descends to their actual ideal quotients.",
                  "Extend the affine isomorphism to the actual smooth projective models, prove genus and intrinsic hyperellipticity, and classify all branch projectivities for the converse and automorphism claims."),
        component(FL, "Litt3.CurveArithmetic.fractional_linear_finite_branch_classification",
                  "For any finite K with |K|≥4, an actual nonsingular fractional-linear transformation carrying the finite branch set K∪{a} into K∪{b} must be an affine K-map and sends a to b; no rational branch-point markings are fixed.",
                  "Identify the branch divisor of the actual smooth projective curve and show every curve isomorphism descends to this nonsingular projectivity via intrinsic hyperellipticity."),
        component(FL, "Litt3.CurveArithmetic.fractional_linear_nonbase_branch_stabilizer_trivial",
                  "Every actual projectivity preserving the non-base finite branch set is the identity, by the branch classification and the free affine parameter action.",
                  "Identify the kernel of the actual curve automorphism action with the hyperelliptic involution and prove that the geometric automorphism group is exactly C₂."),
        component(FL, "Litt3.CurveArithmetic.fractional_linear_rational_projective_boundary_excluded",
                  "Actual nonsingular projective coefficient data cannot carry all rational projective base points to a finite branch set with at most one exceptional image: finite base images force zero denominator-linear coefficient, contradicting a finite image of infinity.",
                  "Identify the t=4 rational boundary branch divisor as the full projective line over F₅ and relate any actual curve isomorphism to the ruled-out projectivity."),
        component(HS, "Litt3.CurveArithmetic.finite_branch_affine_scheme_isomorphic_of_invariant_eq",
                  "Equal invariants construct actual affine Scheme isomorphisms through the Spec functor applied to the explicit coordinate-ring substitution.",
                  "Extend these to the source smooth projective connected curve models and retain the actual field base in the geometric interpretation."),
        component(BP, "Litt3.CurveArithmetic.finite_branch_quadratic_function_polynomial_irreducible",
                  "For every finite field K and every non-base parameter in an actual extension L, the branch polynomial is separable, squarefree, of degree |K|+1, and defines an actual irreducible quadratic function-field polynomial.",
                  "Identify that function field with the original smooth projective model, prove its genus and separable double-cover geometry in characteristic different from two."),
        component(BC, "Litt3.CurveArithmetic.finite_branch_reciprocal_square_equation",
                  "For every finite base field, reciprocal coordinate x=1/(u−c) transforms the original omitted-rational-point quadratic equation into (x^|K|−x)(x−1/(t−c)) after the actual square-coordinate rescaling; the complete base-point product factorization is proved structurally.",
                  "Specialize the original characteristic-five polynomial and extend the constructed function-field coordinate change to the actual smooth projective models, including the separate rational boundary t=4."),
        component(PI, "Litt3.QuotientGeometry.proper_curve_function_field_equiv_of_dedekind_covers",
                  "A base-compatible actual generic-stalk field isomorphism of actual proper integral Schemes with genuine affine Dedekind covers constructs an actual Scheme isomorphism, preserving both actual base diagrams and both exact function-field maps.",
                  "Identify the explicit quadratic/affine family equations with genuine charts of their original smooth projective models, derive the Dedekind covers and base compatibility, and prove genus and intrinsic hyperellipticity for the full classification."),
        component(AI, "Litt3.QuotientGeometry.proper_curve_affine_chart_equiv_realized",
                  "An actual base-preserving isomorphism of genuine nonempty affine chart rings extends to an actual base-preserving isomorphism of their actual proper integral models with valuation stalks. Exact constant-field compatibility is derived from the actual structure maps and germs.",
                  "Construct the smooth projective models with the original quadratic family coordinate algebras as genuine affine charts, derive valuation stalks and match the explicit substitutions to their actual chart base maps; prove genus and intrinsic hyperellipticity for the full converse and automorphism classification."),
        component(BI, "Litt3.CurveArithmetic.finite_branch_affine_scheme_isIntegral",
                  "The original two-variable finite-branch equation defines an actual integral coordinate ring and actual integral affine Scheme for every finite base field and every non-base parameter in an actual field extension. Its plane quotient is identified with the actual monic quadratic algebra over the polynomial coordinate ring.",
                  "Construct the actual smooth projective completion, prove its genus and identify its genuine affine charts, then establish the full proper-model invariant classification and automorphism group."),
        component(QD, "Litt3.QuotientGeometry.quadratic_plane_affine_finite_principal_support",
                  "For the genuine quadratic plane ideal quotient, squarefree nonconstant branch polynomial and characteristic different from two imply an actual Dedekind coordinate ring, actual closed-point DVR stalks, and finite support of every actual principal divisor on its affine Spec. This applies to the checked finite-branch polynomial without additional chart, valuation or integral-closure inputs.",
                  "Construct the actual proper completion and its infinity chart, identify the branch divisor and intrinsic hyperelliptic quotient, and establish genus and the complete proper-model invariant and automorphism classification."),
    ],
    "genus_two_etale_pencils": [
        component(CP, "Litt3.QuotientGeometry.canonical_pencil_field_reconstruction",
                  "Over actual fields with a derivation, the homogeneous binary sextic bracket identity and nonzero A,W reconstruct x=B/A and y=−W/A³ satisfying the double-cover equation, nonzero derivative, and both ordered differential coefficient identities.",
                  "Construct global differential sections, deduce W≠0 from the no-common-zero condition on a positive-genus proper curve, extend the field map to an actual finite morphism, prove étaleness and the bijection; preserve both actual legs in the relative algebra formulation."),
        component(CP, "Litt3.QuotientGeometry.canonical_pencil_bracket_frame_change",
                  "The actual derivation bracket transforms cubically under every nonzero differential-frame transition, without assuming the transition function is constant; both reconstructed coordinates are frame-independent.",
                  "Identify actual smooth-curve local differential frames and glue the cubic section and both function-field coordinates."),
        component(CP, "Litt3.QuotientGeometry.canonical_pencil_scaling_preserves_identity_iff",
                  "For a nonzero bracket satisfying the homogeneous sextic identity, simultaneous nonzero constant scaling preserves that identity exactly when c²=1, in every characteristic.",
                  "Identify the induced proper-curve morphism and its relation with the actual hyperelliptic involution; the original geometric source still assumes characteristic different from two."),
        component(DC, "Litt3.QuotientGeometry.canonical_pencil_coordinate_transcendental",
                  "With algebraically closed actual constants, the nonzero bracket implies the reconstructed coordinate is transcendental; its rational function field embeds injectively into the same supplied ambient field by the actual polynomial evaluation map.",
                  "Construct the quadratic genus-two function field and its injective extension into the source field, then identify the corresponding actual proper-curve morphism and prove separability and étaleness."),
        component(CB, "Litt3.QuotientGeometry.canonical_pencil_binary_squarefree_field_embedding",
                  "The original squarefree binary sextic hypothesis proves squarefree dehomogenization of degree five or six and irreducibility of the actual quadratic polynomial. Reconstructed coordinates give an injective actual quadratic AdjoinRoot field map into the same source field, preserving both coordinates.",
                  "Identify the actual genus-two smooth projective curve function field, obtain nonzero bracket and nonzero first coefficient from global basepoint-free regular forms, and prove the resulting actual morphism is finite etale and gives the full two-leg bijection."),
        component(CN, "Litt3.QuotientGeometry.canonical_pencil_nonconstant_binary_field_embedding",
                  "With actual algebraically closed constants, a nonconstant ratio and the original squarefree homogeneous binary sextic identity prove a nonzero bracket and construct the injective actual quadratic function-field homomorphism into the same source field.",
                  "Derive the nonconstant ratio and nonzero first coefficient from actual global basepoint-free regular one-forms, identify the actual curve function fields and base diagram, and prove finiteness, etaleness and the complete two-leg bijection."),
        component(FF, "Litt3.QuotientGeometry.function_field_rational_map_faithful",
                  "An actual contravariant homomorphism between generic-stalk fields of integral Schemes, with its actual base-Scheme diagram, constructs an actual rational map and determines the original field homomorphism faithfully.",
                  "Identify the reconstructed quadratic field with the actual proper genus-two curve field, prove the base diagram and the source proper-curve hypotheses, then establish finiteness and etaleness."),
        component(FD, "Litt3.QuotientGeometry.function_field_partial_map_dominant",
                  "The actual generic-stalk field homomorphism spreads out to a genuine dominant morphism on a dense open of the same source Scheme, preserving the actual base diagram.",
                  "Extend this actual map to the whole source using its proper regular curve geometry, prove finiteness and etaleness, and identify the global differential pair correspondence."),
        component(FR, "Litt3.QuotientGeometry.actual_scheme_map_recovered_rationally",
                  "The contravariant actual generic-stalk pullback of an original surjective Scheme morphism reconstructs precisely that morphism's actual rational map, retaining its actual base diagram.",
                  "Use the original smooth projective curve geometry to extend the reconstruction everywhere and prove the original canonical-pencil finite-etale bijection and relative algebra formulation."),
        component(PC, "Litt3.QuotientGeometry.proper_function_field_map_extends_from_dedekind_cover",
                  "For actual integral Schemes, a genuine affine Dedekind cover of the source and proper separated target extend a base-compatible actual generic-stalk field homomorphism uniquely to an actual dominant Scheme morphism over the same base. Properness supplies actual valuation-stalk lifts and rational-map gluing proves the extension.",
                  "Construct the genuine Dedekind chart cover from the original smooth projective curve hypotheses, identify the explicit quadratic field with the actual target function field and its base diagram, and prove finiteness and etaleness from the global regular differential pair; preserve both original maps in the relative formulation."),
        component(PR, "Litt3.QuotientGeometry.proper_curve_field_embedding_realized",
                  "Between actual proper integral Schemes with actual valuation source stalks, the reconstructed actual morphism is proper and surjective and its actual generic-stalk pullback is exactly the original field embedding.",
                  "Relate original smooth projective curves and canonical pair to genuine valuation/Dedekind charts and the exact quadratic generic-stalk field, then prove finiteness, separability, etaleness and the full same-source two-leg relative-algebra bijection."),
        component(SPCF, "Litt3.QuotientGeometry.actual_proper_smooth_curve_field_embedding_realized",
                  "A true constant-field algebra embedding between the ORIGINAL proper smooth generic stalks constructs the actual proper surjective Scheme morphism, exact original base diagram and exact original generic-stalk pullback. Every original source valuation stalk is derived from the actual smooth structure; no Dedekind cover is supplied.",
                  "Identify the actual proper genus-two generic stalk with the checked explicit quadratic field; derive finite separability from the canonical pair and prove local etaleness and the complete two-leg bijection."),
        component(FPCF, "Litt3.QuotientGeometry.actual_finite_proper_smooth_curve_field_embedding_realized",
                  "A genuine finite separating k-algebra embedding between the ORIGINAL proper smooth curve generic stalks is realized by an ACTUAL finite surjective Scheme morphism preserving both original base diagram and exact original generic pullback. True finite normalization, all source valuation stalks, full preimage chart identification and finiteness are constructed, without a finite-map or affine-preimage assumption.",
                  "Identify the true smooth proper genus-two model with the original squarefree quadratic generic field, derive finite separability of the reconstructed embedding from the true global canonical pair, and prove etaleness plus the complete original same-source two-leg relative-algebra bijection."),
        component(PSCF, "Litt3.QuotientGeometry.actual_proper_smooth_curve_map_finite",
                  "ANY actual proper surjective map between integral smooth curves over algebraically closed constants is DERIVED finite from finite separability of its TRUE original generic-stalk pullback. Genuine open restrictions preserve both actual field inclusions; every full original affine preimage is constructed as the true finite normalization. No constant-field map diagram is needed for this more general finiteness theorem.",
                  "Apply the actual field finiteness/separability criterion to the checked canonical-pencil reconstruction and prove the remaining local etaleness and global pair correspondence."),
        component(QM, "Litt3.QuotientGeometry.quadratic_plane_coordinate_ring_isDomain",
                  "For any field and any nonconstant squarefree branch polynomial, the genuine two-variable quadratic plane ideal quotient is an integral domain. Its actual quotient is identified with the monic quadratic algebra, which is finite free of rank two over the polynomial coordinate ring.",
                  "Specialize the original binary sextic via the checked dehomogenization theorems, identify the actual smooth proper model and its generic-stalk field with the checked quadratic extension, and prove finiteness and etaleness of the reconstructed map."),
        component(QS, "Litt3.QuotientGeometry.squarefree_binary_sextic_affine_scheme_isIntegral",
                  "The original squarefree homogeneous binary sextic directly proves integrality of the genuine affine Scheme Spec(k[x,y]/(y²−H(1,x))), using the actual two-variable coordinate quotient; no separate affine irreducibility hypothesis is supplied.",
                  "Construct and identify the original smooth projective genus-two completion and its actual generic-stalk field, derive its infinity chart and canonical differential basis, and prove the actual reconstructed morphism is finite etale with the exact global bijection."),
        component(QD, "Litt3.QuotientGeometry.quadratic_plane_coordinate_ring_isDedekindDomain",
                  "The original actual plane coordinate quotient y²−p is a Dedekind domain for every nonconstant squarefree p in characteristic different from two. The proof constructs the integral closure in the actual quadratic field via conjugation, trace, norm and reduced fractions; its actual affine Spec has DVR closed-point stalks and finite principal-divisor support. The checked squarefree binary sextic gives all branch hypotheses.",
                  "Construct the original smooth proper genus-two model and its infinity chart, identify its actual generic-stalk field and regular differential basis, then prove finite etaleness and the full same-source two-leg pencil correspondence."),
    ],
    "weak_local_completed_extension_invariant": [
        component(WVC, "Litt3.QuotientGeometry.weak_valuative_different_all_roots_normal_form",
                  "ONLY the original positive parameter order and concrete genuine separating trace-defined different profile derive BOTH weak orders, nonzero scalar and the FULL alpha*t^(-p)+gamma*t^(-1)+r expansion for EVERY chosen h-th root. The coefficient unit, zero constant term and characteristic cast are derived.",
                  "Fresh exact whole-source hypothesis/scope readback pending; no root-order or expansion input remains."),
        component(WVC, "Litt3.QuotientGeometry.weak_two_valuative_different_profiles_equiv_iff",
                  "TWO actual original valuative trace-different profiles over the SAME full base field construct weak roots and classify their ENTIRE original Laurent embeddings by scalar equality for EVERY pair of h-th root choices. Both original root orders and all coefficient data are derived.",
                  "Fresh exact whole-source hypothesis/scope readback pending; no second-profile root/order input remains."),
        component(WVR, "Litt3.QuotientGeometry.weak_valuative_different_full_ramification",
                  "The original order and genuine trace-different profile derive the ENTIRE fixed-base automorphism group as actual cyclic p and h semidirect root groups, the exact lower filtration on ALL integral series and valuation preservation on ALL Laurent series.",
                  "Fresh exact whole-source hypothesis/scope readback pending; no normalized action or ramification filtration remains supplied."),
        component(WVR, "Litt3.QuotientGeometry.weak_valuative_different_extension_galois",
                  "The original positive valuation and true separating trace-different profile derive IsGalois of the ENTIRE original Laurent extension, without a supplied coefficient unit, root or Galois model.",
                  "Fresh exact whole-source hypothesis/scope readback pending."),
        component(WVU, "Litt3.QuotientGeometry.weak_valuative_different_uniformizer_scalar_independent",
                  "EVERY genuine full completed uniformizer equivalence preserves the scalar of ANY original h-th root. The whole Laurent chain rule and derivative-order preservation derive the changed-coordinate weak orders; neither continuity nor finite support is assumed.",
                  "Fresh exact whole-source hypothesis/scope readback pending; original DVR chart changes are constructed in the existing parameter transport APIs."),
        component(WAC, "Litt3.QuotientGeometry.weak_valuative_different_every_uniformizer_scalar_independent",
                  "ANY actual order-one uniformizer constructs a constant-preserving automorphism of the ENTIRE Laurent field and preserves the weak scalar of EVERY chosen original root. No coordinate automorphism, zero/linear coefficient, continuity or changed weak order is supplied.",
                  "Fresh exact whole-source hypothesis/scope readback pending."),
        component(GOPS, "Litt3.QuotientGeometry.actual_galois_smooth_same_source_original_profile_scalars_equal",
                  "BOTH actual original global maps from the SAME smooth source force scalar equality at EVERY endpoint fiber pair directly from the actual full expansions of the original stalk parameter maps and their genuine separating trace-different profiles. Full same-base completed equivalences and weak roots/orders are derived; no local differential equation, chosen source lift or normalization model is supplied.",
                  "Fresh exact whole-source hypothesis/scope readback pending; no generic completed-profile geometric assembly remains supplied."),
        component(GLRS, "Litt3.QuotientGeometry.actual_galois_smooth_local_rational_differential_scalars_equal",
                  "ONE original rational F,G,sigma identity with sigma regular and nonvanishing ONLY at the two selected original points gives literal original local unit slopes and scalar equality through BOTH true maps of the SAME original smooth source. Global regularity of sigma is unnecessary.",
                  "Fresh exact whole-source hypothesis/scope readback pending."),
        component(SCOR, "Litt3.QuotientGeometry.actual_smooth_curve_coordinate_differential_residue_ratio",
                  "Retained special case: for original local z and original UNIT y, sigma=dz/y regular and nonvanishing constructs actual local d/dz, proves F_z is an original unit, and computes the separate-factor residue ratio for arbitrary original local F.",
                  "The source itself does not require unit y; the broader rational PRODUCT bridge below addresses Weierstrass points."),
        component(FGC, "Litt3.QuotientGeometry.actual_characteristic_five_galois_coordinate_fiber_constraint",
                  "Retained UNIT-y special case of the actual original same-source characteristic-five coordinate fiber constraint, with separate residues of y and F_z. No polynomial F or bounded seven-point enumeration.",
                  "The broader rational PRODUCT theorem below removes unit-y and separate-factor residue inputs."),
        component(RCP, "Litt3.QuotientGeometry.actual_smooth_curve_rational_coordinate_differential_product",
                  "For genuine rational z,y in the original function field with only y nonzero, regular/nonvanishing sigma=dz/y constructs actual FIELD d/dz and an ORIGINAL stalk unit W whose image is precisely y*F_z. Its original residue is reciprocal to the sigma/dF slope. Neither rational factor must belong to the local ring; Weierstrass points are allowed.",
                  "Broader product bridge audit and independent whole-source readback pending."),
        component(FGP, "Litt3.QuotientGeometry.actual_characteristic_five_galois_rational_coordinate_product_fiber_constraint",
                  "Through BOTH true maps from the SAME original smooth source, the genuine field identity sigma=dz/y and original G^7/F^20 profile force eval(W)^5/eval(G)^2 equal at every endpoint fiber pair, where the DERIVED original unit W maps literally to the rational PRODUCT y*F_z. No non-Weierstrass hypothesis or individual rational-factor evaluation is imposed.",
                  "Broader product bridge audit and independent whole-source readback pending."),
        component(RCU, "Litt3.QuotientGeometry.rational_coordinate_derivation_unique",
                  "The genuine FUNCTION-FIELD derivation normalized by D(z)=1 is unique. Consequently F_z and the original unit product y*F_z do not depend on the chosen original uniformizer frame, including Weierstrass points.",
                  "Broader product bridge audit and independent whole-source readback pending."),
        component(RFC, "Litt3.QuotientGeometry.rational_product_residue_power_ratio_nonzero",
                  "The actual original unit product W and original unit G derive a nonzero residue ratio eval(W)^p/eval(G)^2; no nonzero quotient is supplied.", ""),
        component(RFC, "Litt3.QuotientGeometry.rational_product_fiber_single_nonzero_constant",
                  "The proved original two-point comparison at every pair of a nonempty fiber gives ONE nonzero constant on the entire fiber. Arbitrary cardinality is allowed and seven-point enumeration is unnecessary.", ""),
        component(CCON, "Litt3.QuotientGeometry.original_coordinate_derivation_unique",
                  "The true coordinate derivation constructed from any original local differential frame is UNIQUE once d/dz(z)=1, so the actual F_z is independent of the chosen uniformizer frame.",
                  "Fresh exact whole-source hypothesis/scope readback pending."),
        component(CCON, "Litt3.QuotientGeometry.nonzero_fiber_values_constant",
                  "Pairwise equal nonzero actual values on ANY nonempty fiber give ONE nonzero constant on the entire fiber. This includes seven-point fibers and requires no point enumeration.",
                  "Fresh exact whole-source hypothesis/scope readback pending."),
        component(GGS, "Litt3.QuotientGeometry.actual_galois_smooth_global_differential_scalars_equal",
                  "A SINGLE original rational F,G pair and actual globally regular rational sigma on the original smooth endpoint curve, with genuine simple-zero restrictions and nonvanishing in the original Omega residue fibers, DERIVE both original local polar equations, universal differential identities and actual unit slopes. The entire actual same-source Galois fiber comparison then proves equality of the original residue scalars. Redundant characteristic-nonzero hypotheses are derived from h dividing p−1 and m coprime p.",
                  "Assemble arbitrary original completed different profiles and uniformizer-change independence with the full classification; identify the actual hyperelliptic coordinate derivative specialization. No local polar/Omega identities, slopes, chart, completion, source lift or normalization model are supplied."),
        component(CFG, "Litt3.QuotientGeometry.actual_characteristic_five_galois_global_fiber_constraint",
                  "The ORIGINAL global polar pair G^7/F^20 and actual global identity dG=cF^3 sigma force G(R)^2 sigma_R^5 to be constant at EVERY original closed endpoint fiber pair through BOTH actual maps from the SAME global smooth source. True local polar/Omega identities and unit slopes are derived from original rational restrictions and actual Omega-fiber nonvanishing. The conclusion is stronger than a seven-point bounded computation.",
                  "Realize the original hyperelliptic sigma=dz/y and actual coordinate derivative F_z at its stated non-Weierstrass fiber points; complete arbitrary original different-profile/uniformizer classification assembly."),
        component(SDI, "Litt3.QuotientGeometry.actual_smooth_stalk_differential_map_injective",
                  "The actual original universal differential module at EVERY original point of ANY integral smooth scheme injects into its TRUE function-field differential module. Freeness is derived from genuine smooth affine charts and entire localization, in every relative dimension; no closedness or rational residue premise is needed.",
                  "No injectivity or local differential-identity gap remains in the actual global scalar theorem; finish original weak different-profile and hyperelliptic classification assembly."),
        component(SGI, "Litt3.QuotientGeometry.actual_smooth_curve_global_differential_identity_unit_slope",
                  "An actual globally regular rational form nonvanishing in the true original residue fiber constructs an original unit slope in ANY original uniformizer and derives the literal local universal differential identity from the ORIGINAL rational identity. Generic field generation, transcendence degree, separating parameter and full differential frame are derived.",
                  "This is the literal original regular-rational-differential module; no sheaf-cohomology space identification is asserted. Finish arbitrary original different-profile/uniformizer and hyperelliptic specialization assembly."),
        component(CPI, "Litt3.QuotientGeometry.completedDVRPowerSeriesMap_eq_actual_substitution",
                  "The constructed ENTIRE completed map of ANY genuine original local DVR map is actual substitution on EVERY power series by its original parameter image's FULL expansion. Localness derives zero constant coefficient; no continuity, coordinate truncation or model identification is a premise.",
                  "Transport an arbitrary original curve-completion different profile into the literal parameter rings and finish whole-source classification assembly."),
        component(WDG, "Litt3.QuotientGeometry.weak_different_parameter_extension_galois",
                  "The genuine original trace-defined different ideal of exponent ph+p−2, BEFORE normalization, constructs the weak h-th root and proves actual IsGalois of the ENTIRE original positive-parameter Laurent extension. No root, derivative/pole order, normalized model or Galois conclusion is assumed.",
                  "Assemble arbitrary original completed embeddings/coordinate changes and both different profiles with full scalar classification, and finish the actual hyperelliptic derivative corollary."),
        component(WDR, "Litt3.QuotientGeometry.weak_different_parameter_full_ramification",
                  "The same genuine original different hypothesis derives the ENTIRE original fixed-base automorphism group as C_p semidirect C_h, with a constructed action on EVERY integral series, exact full lower filtration G0=G,G1=C_p,Gi=1 for i≥2 and valuation preservation for EVERY Laurent element. No normalized root, action or filtration is supplied.",
                  "Complete the original uniformizer-change/different-profile classification assembly and exact hyperelliptic derivative specialization."),
        component(WDC, "Litt3.QuotientGeometry.weak_different_parameter_classification",
                  "The genuine original different hypothesis constructs the weak root and derives its actual orders, then classifies the ENTIRE original parameter extension against ANY actual weak completed embedding over the SAME fixed whole base field exactly by scalar equality. ANY alternative original h-th root has the same scalar.",
                  "Derive uniformizer-change derivative orders automatically and assemble both arbitrary different-profile embeddings and the exact hyperelliptic coordinate specialization."),
        component(GFS, "Litt3.QuotientGeometry.actual_galois_smooth_same_source_entire_fiber_scalars_equal",
                  "BOTH original global maps from the SAME actual smooth integral source, with the endpoint leg finite etale and surjective and the normalization leg finite and unramified above the entire selected base fiber, force equality of the ORIGINAL endpoint residue scalars at EVERY pair of original closed endpoint fiber points. The true finite Galois curve map derives its finite generic degree, all original chart/DVR/residue/completion data, closed source lifts, and full same-base completed comparison. Only original local polar and universal-Omega identities remain supplied.",
                  "Realize the original global regular differential and its nonvanishing in the original local universal differential modules; specialize the hyperelliptic differential and assemble the full original degree/different/group/scalar classification."),
        component(GFL, "Litt3.QuotientGeometry.actual_galois_smooth_same_source_entire_fiber_fields",
                  "The true finite Galois morphism between actual smooth integral curves, composed with BOTH original finite maps from the SAME actual smooth source, constructs ENTIRE fixed-base completed-field equivalences at EVERY pair of endpoint closed points above the same actual base point. Finite field degree, closed lifts and local chart/coefficient/DVR data are derived from the genuine Scheme hypotheses; no simultaneous Galois closure is presumed.",
                  "Derive the original global-to-local regular differential identities, identify the actual degree/different data with the completed parameter models and assemble the canonical scalar classification."),
        component(GCV, "Litt3.QuotientGeometry.actual_galois_smooth_curve_completed_fields_equivalent",
                  "ANY true finite surjective Galois morphism between actual smooth integral relative-dimension-one curves over algebraically closed constants constructs ENTIRE completed original-stalk field equivalences at every pair of closed points over the SAME original closed base point. All genuine affine normalization, original generic field towers, DVRs, residue fields and full original stalk/map squares are derived. Properness is unnecessary.",
                  "The original global regular differential identities and the complete canonical classification assembly remain; no original Galois curve chart realization is left assumed."),
        component(FSF, "Litt3.QuotientGeometry.actual_finite_scheme_function_field_extension",
                  "Every actual finite surjective morphism between integral Schemes gives a finite-dimensional extension of the TRUE original generic-stalk function fields through its actual pullback. No smoothness, coefficient field or separate finite-degree assumption is used.",
                  "Relate the original local degree and different to the actual completed parameter maps and assemble the complete weak-extension source statement."),
        component(FSC, "Litt3.QuotientGeometry.actual_finite_smooth_chart_isIntegralClosure",
                  "Every actual affine preimage chart of a true finite surjective morphism with smooth integral curve source is the genuine integral closure of the downstairs coordinate algebra inside the TRUE original source function field. Coordinate integrality, actual generic-stalk scalar towers, fraction-field identification and source normality are derived.",
                  "Original global regular differential realization and canonical degree/different/classification assembly remain."),
        component(SAD, "Litt3.QuotientGeometry.actual_smooth_curve_affine_chart_dedekind",
                  "EVERY nonempty genuine affine chart of an actual smooth integral relative-dimension-one curve over algebraically closed constants is Dedekind. Actual finite type, noetherianity, original maximal-stalk DVRs, normality and dimension at most one are all derived; no supplied Dedekind chart or properness is needed.",
                  "Original regular differential realization and canonical weak local classification assembly remain."),
        component(GSS, "Litt3.QuotientGeometry.actual_galois_normalization_same_source_differential_scalars_equal",
                  "BOTH original Scheme maps from the SAME integral source, with a genuine etale endpoint leg and a genuine finite Galois normalization leg unramified at both selected original points, force equality of ORIGINAL endpoint residue scalars across that actual base fiber. The true Scheme diagram derives endpoint1-to-normalization1-to-normalization2-to-endpoint2 full-field comparison. Original polar and universal-Omega identities are supplied only on the endpoint curve; no normalization differential identity or field-comparison conclusion is assumed.",
                  "Realize the original proper curve diagram on true finite normal affine charts while retaining both original maps from the same source. Derive endpoint/source local data from smooth relative dimension one, match the actual regular differential, and use original etale surjectivity to cover every original wild endpoint point."),
        component(NAN, "Litt3.QuotientGeometry.actualNormalIntegralAffineNormalizationIso_over_base",
                  "ANY original normal integral coordinate algebra R in its genuine fraction field L has a CONSTRUCTED base-algebra equivalence with integralClosure A L and a true SpecR normalization Scheme isomorphism fixing the ENTIRE original SpecA structure map. Every original coordinate inclusion into the true original function field is preserved. No normalization presentation or Scheme-model isomorphism is supplied.",
                  "Derive the original Galois curve's actual affine chart normality, integral coordinate pullback and original generic-stalk fraction-field tower from the true finite curve morphism; transfer the actual same-source maps through restriction and this constructed model identification."),
        component(GSC, "Litt3.QuotientGeometry.actual_galois_normalization_spec_completed_fields_equivalent",
                  "The ORIGINAL genuine affine normalization Scheme stalks at ANY two actual points over the SAME original downstairs Scheme point have equivalent ENTIRE completed fraction fields. All DVR/coefficient-residue data, true Scheme-stalk/localization identifications, full coefficient squares, Galois action/fiber transitivity, original coordinate changes and whole completed maps are DERIVED from the actual finite Galois fraction extension and original uniformizers.",
                  "Identify an actual affine chart of the source's proper Galois curve with a finite normal coordinate algebra in its genuine function field, then compose the original same-source curve maps at every wild fiber point. The original endpoint curve differential realization remains separate."),
        component(ACR, "Litt3.QuotientGeometry.actual_closed_affine_chart_stalk_residue_surjective",
                  "At any actual closed point of ANY original Scheme with a genuine finite-type affine chart over algebraically closed coefficients, the ORIGINAL structure-map coefficient field surjects onto the actual stalk residue field. The actual original germ identifies chart and stalk coefficients and constructs a coefficient-preserving stalk-to-localization AlgEquiv; neither a Scheme model nor residue identification is supplied.",
                  "Derive finite-type and DVR properties of the original smooth curve charts from the actual smooth relative-dimension-one hypothesis, then select genuine local uniformizers and apply the actual all-point fiber comparison."),
        component(SNM, "Litt3.QuotientGeometry.actual_separable_normalization_spec_finite",
                  "The original affine normalization Scheme morphism associated to ANY finite separable extension of a genuine Dedekind fraction field is finite; its actual coordinate inclusion is injective and every base prime has an original normalization point above it. No Galois or supplied finite-normalization hypothesis is needed.",
                  "Identify the source's original proper curve morphism on true affine charts with this normalization; preserve both original maps from the same source through restriction."),
        component(SSD, "Litt3.QuotientGeometry.actual_same_source_scheme_original_differential_scalars_equal",
                  "BOTH genuine Scheme maps from the SAME actual integral source, unramified at its actual point, force the exact scalar equality at actual residue values of ORIGINAL local functions. The actual over-base scheme squares derive coefficient algebras, injectivity, the entire original stalk square including downstairs point transport, all completions and the entire fixed-base field equivalence. Maps may ramify elsewhere. Only actual DVR/uniformizer/coefficient data and original ring/universal-Omega identities remain supplied.",
                  "Derive the original smooth proper curve stalk DVR and coefficient data; identify the genuine curve differential inside actual local universal differentials; connect the actual normalization prime local rings to the Gamma scheme stalks and compose comparisons across every original wild fiber point."),
        component(GNC, "Litt3.QuotientGeometry.actual_galois_normalization_completed_fields_equivalent",
                  "A genuine finite Galois extension of the fraction field of an actual finite-type affine Dedekind algebra over algebraically closed constants derives equivalences of the ENTIRE completed fields at EVERY pair of actual normalization primes over the SAME nonzero base prime. Actual DVR properties, coefficient residue surjectivity, full Galois action, invariant ring, fiber transitivity, original local equivalences, whole completion charts and full downstairs commutation are all CONSTRUCTED; only actual original uniformizers are chosen.",
                  "Identify the source's actual proper Galois curve Gamma and actual base curve charts with this genuine normalization model, including the full original stalk maps; compose with the original same-source Scheme maps over all original wild points."),
        component(GNS, "Litt3.QuotientGeometry.actual_galois_normalization_original_differential_scalars_equal",
                  "Every pair of actual normalization primes over one nonzero base prime has identical original differential scalar whenever its actual original unit functions satisfy the stated polar and universal-Omega identities. The genuine finite Galois fraction extension derives all DVR, coefficient, group, fiber and completion hypotheses; no local equivalence, completed map or scalar comparison is supplied.",
                  "The source differential identities live on the endpoint curve, not generally Gamma. Compose the genuine Galois completed fiber comparison with the actual two maps from each original source point, and realize the curve differential and stalk charts at every endpoint wild point."),
        component(CAR, "Litt3.QuotientGeometry.closed_affine_residue_coefficients_surjective",
                  "The actual residue field at every closed point of ANY genuine finite-type affine algebra over an algebraically closed field is the original coefficient field. The proof uses its actual maximal-ideal quotient, genuine local residue map, Zariski lemma and algebraic closedness; no residue-field identification is assumed.",
                  "The genuine structure-map coefficient compatibility and actual closed-affine-chart stalk residue bridge are now derived separately. Derive the actual smooth-curve chart finite-type/DVR data and compose the original fiber comparisons."),
        component(ODS, "Litt3.QuotientGeometry.original_same_source_dvr_differential_scalars_equal",
                  "TWO original unramified DVR maps INTO ONE actual source and the ORIGINAL stalk square force the exact scalar equality at the ACTUAL residue-field values of original regular functions. Inputs are only original polar identities chi(b)*G^m=F^(ph), actual unit G and s, and literal universal differential identities dG=(c*F^(p-2)*s)*dF in the original local rings. The actual whole completion charts, field maps, Laurent expansions, series differential equations, roots and weak orders are all CONSTRUCTED. No curve-function expansion or scalar conclusion is assumed.",
                  "Derive the genuine closed-point DVR/coefficient data and original universal differential identities from the original smooth proper curves, realize their actual stalk square and Galois fiber identifications at every wild point, then assemble the all-seven-point canonical specialization."),
        component(PDR, "Litt3.QuotientGeometry.polynomial_coordinate_differential_ratio",
                  "Over ANY commutative coefficient ring, the actual universal differential dz/y equals the actual unit (y*F_z)^(-1) times dF whenever original y and F_z are units and F is the actual polynomial evaluation. The ratio is derived by genuine polynomial differentiation; no genus or characteristic restriction, scalar ratio assumption or local series is used.",
                  "Identify the actual hyperelliptic curve coordinate z,y and its regular differential sigma with these original local-ring functions; apply the actual local residue value and original source-map comparison at the complete wild branch fiber."),
        component(DFC, "Litt3.QuotientGeometry.dvrFunctionFieldCompletion_valuation",
                  "Every genuine fraction field of an original DVR with coefficient-residue data embeds into its CONSTRUCTED entire Laurent completion. Its normalized actual height-one valuation is preserved on EVERY original rational function, derived from actual DVR unit/uniformizer factorization and exact fraction representation. Neither a chart, field embedding nor valuation compatibility is a supplied hypothesis.",
                  "Realize these original rings and fraction fields as the original curve stalks and genuine generic-stalk function fields, and use actual curve morphisms to assemble the full fiber comparison."),
        component(DSC, "Litt3.QuotientGeometry.same_source_unramified_dvr_differential_scalars_equal",
                  "TWO genuine unramified local DVR maps INTO THE SAME actual source, and the literal ORIGINAL stalk-map commutation square, force equality of the source differential scalar. Actual completion ring charts, fraction-field maps, endpoint field isomorphism, whole power-series roots, and their weak pole/derivative orders are all CONSTRUCTED. Inputs retain actual injective base maps, actual uniformizers and coefficient-field residue surjectivity; the latter data are derived for DVRs with finite residue fields over an algebraically closed field. No completed-field square or chart is supplied.",
                  "OriginalDVRDifferentialScalars now derives all supplied series identities from original regular functions and universal differentials. Realize the actual curve stalk-map square at every wild point and derive its DVR/coefficient data and Galois fiber identifications from the exact curve assumptions."),
        component(DVC, "Litt3.QuotientGeometry.dvrPowerSeriesChart_residue",
                  "Every actual equicharacteristic DVR with an irreducible uniformizer and coefficient field surjecting onto its actual residue field has a CONSTRUCTED whole power-series completion AlgEquiv. The uniformizer maps to its genuine completed image, every polynomial evaluates literally, and actual residue equals the constant coefficient. Actual principal-power quotient isomorphisms and genuine power-series adic completeness prove the chart; no coefficient cutoff or chart assumption occurs.",
                  "Derive these actual DVR/coefficient residue hypotheses for the original smooth proper curve stalks, and identify the original global curve functions and differentials in the constructed charts."),
        component(SDC, "Litt3.QuotientGeometry.scheme_etale_dvr_completion_isomorphism",
                  "For an ACTUAL etale Scheme morphism with actual DVR stalks and surjective actual induced residue map, the actual map of actual stalk completions is an isomorphism. It agrees with the original stalk map on EVERY element. Local unramifiedness and essential finite type are derived from the actual Scheme morphism, and the completion inverse is constructed from actual finite quotient maps.",
                  "At every original wild branch point, derive the actual DVR stalk and residue hypotheses, construct the common-base/Galois fiber identifications retaining both original maps into the same smooth projective source, and apply the literal differential formula to the original curve functions."),
        component(CSC, "Litt3.QuotientGeometry.same_source_unramified_weak_scalars_equal",
                  "TWO genuine unramified completed-ring and fraction-field maps INTO THE SAME completed source, with a literal commutation square on the ENTIRE fixed downstairs field, force equality of the actual original weak coefficient scalars. The isomorphisms of the whole endpoint completed rings and fields are DERIVED from actual maximal-ideal extension equality, which also follows from genuine formally-unramified local essentially finite-type algebras; the desired field identification is never assumed.",
                  "Realize these actual completed maps from the original curve stalk maps, prove their full-base square and actual Galois fiber identifications, and retain both original source legs."),
        component(CSD, "Litt3.QuotientGeometry.same_source_unramified_differential_scalars_equal",
                  "The same actual two-map unramified completed-source square together with the ORIGINAL literal beta=G^m/t^(ph), unit G and sigma, and dG=c*t^(p-2)*sigma forces equality of the stated differential scalar at the endpoints. Whole power-series roots are CONSTRUCTED by Hensel lifting and their pole and derivative orders are DERIVED from the literal differential identities. For p=5,h=4,m=7, characteristic_five_local_scalars_equal_iff proves this is precisely equality of G(0)^2*sigma(0)^5, with no coefficient truncation or source conclusion assumed.",
                  "Identify these series and maps with the actual original curve completions and genuine differential ratios, including the hyperelliptic value sigma/dF=1/(y*F_z), and construct actual common-source/Galois fiber comparison for every wild point."),
        component(WTR, "Litt3.QuotientGeometry.weak_tame_original_completed_ramification",
                  "For the ORIGINAL entire completed embedding, including arbitrary regular tails, construct a genuine full automorphism-group isomorphism C_p semidirect C_h, a compatible genuine group action on the WHOLE original integral ring, and its lower subgroup filtration defined on EVERY actual integral element. The exact groups are G0=whole, G1 genuinely cyclic of order p, Gi=1 for every i>=2. Every original full-base automorphism preserves the valuation of EVERY original Laurent element. Actual compatible completed-ring/field coordinates and proven coordinate-invariance of the all-integral subgroup condition transport the result; no valuation-preservation or filtration conclusion is assumed.",
                  "Identify the original actual curve completions and retain BOTH maps into the same actual source in scalar comparison; apply the literal differential identities to the original curve functions and all wild-fiber points."),
        component(WOD, "Litt3.QuotientGeometry.weak_original_root_normal_form_from_different",
                  "The genuine trace-defined different exponent ph+p-2 of an arbitrary ORIGINAL positive parameter b=t^(ph)*c, with c an actual unit and the actual fraction extension separable, CONSTRUCTS an actual h-th root of b inverse and forces its literal full Laurent expansion alpha*t^(-p)+gamma*t^(-1)+r, alpha and gamma nonzero. Neither the root nor its derivative order is an input.",
                  "Identify these literal parameter rings and maps with BOTH original curve completions from the same source, and apply the differential identities to actual curve functions."),
        component(WSM, "Litt3.QuotientGeometry.weakNormalizedSemidirectEquiv",
                  "A genuine group isomorphism identifies the ENTIRE actual normalized full-base-field automorphism group with the actual semidirect product of the cyclic order-p translation kernel and cyclic order-h roots-of-unity group. The literal scalar action is proved and all p*h actual automorphisms exhaust the full field group. Contravariance of affine coordinate composition is accounted for by taking inverse automorphisms.",
                  "The full original-coordinate group and filtration transport are now proved in WeakTameOriginalRamification. Identify BOTH original curve completions."),
        component(WIA, "Litt3.QuotientGeometry.weak_normalized_automorphism_laurent_order",
                  "Every member of the ENTIRE normalized full-base-field automorphism group induces a compatible automorphism of the WHOLE actual power-series valuation ring and preserves the literal valuation of EVERY Laurent field element. The genuine all-integral-element lower ramification condition is a subgroup and is proved equivalent to the actual uniformizer condition.",
                  "The exact original-coordinate subgroup filtration is now proved in WeakTameOriginalRamification. Identify the actual completions of both original finite-etale source maps."),
        component(WDS, "Litt3.QuotientGeometry.weak_laurent_power_root_differential_scalar",
                  "For actual whole power-series roots U^h=G^m and the literal differential identity dG=c*t^(p-2)*sigma, the coefficient scalar of the actual Laurent element t^(-p)*U is exactly -G(0)^(p-m*(p-1)/h)/(-(m/h)*c*sigma(0))^p. The p=5,h=4,m=7 specialization is proved as -1/((2*c)^5*G(0)^2*sigma(0)^5), without bounded-series computation or supplied coefficient conclusions.",
                  "Identify the local series with actual original curve functions and their genuine differential ratios, and use the actual same-base completion isomorphisms to compare every source-fiber point."),
        component(PDI, "Litt3.QuotientGeometry.finite_parameter_completed_different_and_valuation",
                  "For EVERY arbitrary original positive parameter b=t^n*c, n>0 and c a genuine completed-ring unit, the WHOLE literal completed extension has actual fraction-field degree n and genuine trace-defined different EXACTLY (db/dt), under its actual fraction-field separability. Equality of the different with (t^d) is equivalent to the literal derivative being nonzero with actual Laurent order d. Actual infinite-series decomposition, distinct-residue leading coefficients, whole-ring power basis, derived Eisenstein coefficients, and a proved infinite-series chain rule establish this BEFORE Laurent normalization; no normalized-model derivative inputs or monogenicity assumptions are supplied.",
                  "The original root/order, full semidirect group, complete lower filtration and literal differential specialization are independently checked. Construct actual curve completions through BOTH original same-source maps and identify their genuine curve functions/differentials."),
        component(CDI, "Litt3.QuotientGeometry.constant_polynomial_completed_different_and_valuation",
                  "For the WHOLE literal completed substitution ring attached to ANY positive-degree constant polynomial g with g(0)=0, assuming its genuine fraction-field extension is separable, the true trace-defined different ideal is EXACTLY the actual base-parameter derivative ideal. Its equality with (t^n) is equivalent to the literal nonzero Laurent derivative having order n. Actual completed-ring generation constructs an integral power basis and the exact reciprocal minimal polynomial; localization derives field generation and conductor one. Distinct downstairs types and every scalar action use the actual substitution embedding.",
                  "The arbitrary-original-parameter extension is now independently checked in ParameterDifferentValuation BEFORE normalization. Remaining source obligations are combining its actual order wrappers, curve completions through BOTH same-source maps, full inertia filtration and differential specialization."),
        component(CPR, "Litt3.QuotientGeometry.constant_polynomial_completed_ring_model",
                  "For ANY positive-degree constant polynomial g with g(0)=0 over ANY field, the WHOLE actual completed ring k[[t]] is the genuine monic reciprocal quotient X^N-beta_inverse*g.reverse(X). The actual RingEquiv intertwines the entire substitution base map and sends the genuine quotient root to the literal uniformizer t. Reciprocal Eisenstein and exact whole-series decomposition prove injectivity and surjectivity; neither monogenicity nor completed-ring generation is assumed.",
                  "Use the actual transported power basis to identify the genuine trace-defined different ideal with the derivative ideal and derive its exact order, then realize the original separating curve-completion maps and differential specialization."),
        component(WTC, "Litt3.QuotientGeometry.weak_tame_completed_fields_equiv_iff",
                  "For every positive h dividing p-1, BOTH actual original whole Laurent embeddings over the SAME fixed downstairs beta field are intertwined by a genuine RingEquiv exactly when their actual h-th-root coefficient scalars agree. This includes every regular-tail coefficient, genuine intermediate maps constructed from actual poles, and necessity proved by actual degree-h field generation rather than an assumed tame-field identification. The actual scalar is therefore invariant under every supplied original-field identification.",
                  "Identify the genuine different ideal exponent with the derivative order, derive the actual root/order hypotheses from curve completions, identify the full semidirect group and ramification filtration, and transport through BOTH original finite-etale maps from the SAME smooth projective source; derive the differential specialization."),
        component(WRI, "Litt3.QuotientGeometry.weak_tame_root_scalar_independent",
                  "For h dividing p-1, any two ACTUAL h-th roots of the SAME nonzero Laurent element differ by an ACTUAL nonzero constant zeta with zeta^h=1 and zeta^p=zeta. Their original coefficient scalars -coeff(-p)/coeff(-1)^p are exactly equal. This needs neither perfectness nor algebraic closedness, no coefficient enumeration and no assumed tame-field/root identification.",
                  "Identify the actual different ideal and both original same-source completion maps, derive the supplied root/order hypotheses and the differential specialization."),
        component(WOG, "Litt3.QuotientGeometry.weak_tame_original_completed_extension_galois",
                  "For h dividing p-1, the original full supplied completed-field embedding is genuinely Galois under its actual h-th root, pole and derivative hypotheses, including arbitrary regular tails. Actual root-field equivalences transport Galoisness to this literal original embedding, preserving the fixed full downstairs field.",
                  "Identify the actual semidirect product and entire lower filtration, derive the original different ideal and tame-base classification, and construct both original common-source completion maps and differential specialization."),
        component(WTG, "Litt3.QuotientGeometry.weak_tame_normalized_laurent_galois_and_automorphisms",
                  "The actual normalized whole Laurent extension is Galois, and EVERY actual base automorphism sends the pole coordinate u to zeta*u+b with zeta^h=1 and alpha*b^p+gamma*b=0. The h and p genuine separable constant-root sets construct p*h distinct compatible power-series/Laurent automorphisms; their count equals the proved actual field degree and exhausts the full automorphism group.",
                  "Identify the full group law as C_p semidirect C_h, derive its genuine lower ramification filtration and original different, then complete tame-base scalar classification and same-source comparisons."),
        component(APR, "Litt3.QuotientGeometry.affine_translation_parameter_difference_order",
                  "Every actual nontrivial translation u -> u+b of the Laurent pole coordinate has exact order two on the difference of the inverse uniformizer; every actual affine action with nontrivial scaling has exact order one by affine_tame_parameter_difference_order. These are literal Laurent valuation computations from genuine automorphisms, not supplied ramification labels.",
                  "Identify the full actual ramification subgroup filtration, show coordinate invariance and relate its different to the original curve stalk extension."),
        component(WDO, "Litt3.QuotientGeometry.weak_tame_root_derivative_order_from_parameter",
                  "The genuine full Laurent Derivation proves order d((psi^h)^(-1))=p*h+p+order dpsi whenever psi has pole p and h is prime to characteristic. Thus the ACTUAL downstairs inverse-parameter derivative order p*h+p-2 forces the ACTUAL intermediate derivative order -2, with no different label substituted for a derivative hypothesis.",
                  "Prove that the actual separating completed DVR extension's different ideal exponent equals this derivative order, then apply the complete local classification and both original common-source completion maps."),
        component(WTO, "Litt3.QuotientGeometry.weak_tame_original_completed_field_model",
                  "Given an actual h-th root of the actual downstairs pole with order-p and derivative-order-minus-two, the full original completed embedding, including its entire weak regular tail, is identified with the genuine polynomial field ((alpha*U^p+gamma*U)^h-downstairs pole). The original coefficients alpha,gamma are recovered literally from the actual h-th-root expansion; no generation or degree assumption is supplied.",
                  "Derive the intermediate derivative order from the original different, prove actual Galois affine action and ramification filtration, the tame-base classification/root independence, and the both-leg same-source completion and differential specialization bridges."),
        component(WTO, "Litt3.QuotientGeometry.weak_tame_original_completed_field_degree",
                  "The actual original extension over its literal full downstairs Laurent embedding is finite of exact degree p*h under the actual root/pole/derivative hypotheses. Reciprocal Eisenstein proves irreducibility for the full constant polynomial and genuine parameter decomposition supplies the original field model; all scalar structures use the actual embedding.",
                  "Derive the genuine different hypothesis, construct and classify the actual semidirect Galois action and lower filtration, and compare the original same-source completions."),
        component(LTF, "Litt3.QuotientGeometry.laurent_completed_map_tame_factorization",
                  "For an actual compatible completed-ring/Laurent embedding whose pole has order n*h, algebraically closed constants and prime-to-characteristic h construct an actual Laurent h-th root of exact pole order n, actual compatible intermediate completed maps, and a genuine factorization of the ENTIRE original base map through the h-th-power map. The full unit tail is solved by Hensel lifting; no abstract intermediate-field label or factorization assumption is used.",
                  "Derive the derivative/different order in this genuine intermediate layer, prove the degree-ph Galois semidirect product and lower break, classify over the original tame base, and construct both original same-source completed-field comparisons."),
        component(WMN, "Litt3.QuotientGeometry.weak_laurent_completed_map_normalization",
                  "Every supplied actual compatible power-series/Laurent embedding with pole-p and derivative-order-minus-two hypotheses is conjugate to the actual normalized parameter embedding by a genuine constants-preserving Laurent automorphism. The full regular tail is removed while intertwining the ENTIRE same downstairs map; the normalized alpha,gamma are exactly the original coefficients at -p and -1.",
                  "Derive the orders from the original degree and different, add the actual tame h-th-root layer and its ramification, and construct the same-source completed-field comparison."),
        component(WAM, "Litt3.QuotientGeometry.weak_laurent_completed_map_artin_schreier_model",
                  "The supplied original completed-field map, including every regular tail coefficient, is identified with a genuine pole-one AS root field over the SAME full downstairs Laurent base. Its normalized coefficient satisfies a^(p-1)=weakLaurentInvariant, which is directly minus the original coefficient(-p) divided by coefficient(-1)^p. No field identification, degree or algebraic-generation result is assumed.",
                  "Add the genuine tame h layer and ramification, derive the actual order/different inputs, prove the h-th-root transformation law, and identify both original common-source completion maps."),
        component(WGC, "Litt3.QuotientGeometry.weak_laurent_completed_extension_cyclic_galois",
                  "The original supplied completed embedding is finite of exact degree p and cyclic Galois under the literal pole/derivative hypotheses, including arbitrary regular tails. Its Algebra, SMul and Module all explicitly use that actual original embedding; the proof transports the genuine AS field model.",
                  "Construct the degree-h tame layer, the actual semidirect product and lower filtration, and the original different and same-source completion bridges."),
        component(WCL, "Litt3.QuotientGeometry.weak_laurent_completed_fields_equiv_iff",
                  "Two supplied actual completed embeddings, with all regular tails retained, are isomorphic over the SAME full downstairs Laurent field precisely when their actual coefficient invariants agree. A genuine RingEquiv literally intertwines BOTH original maps. Consequently the scalar is preserved by any actual original-field identification, including a change of source uniformizer.",
                  "Add the tame h-th-root layer and root independence, derive the original order/different hypotheses and compare the actual branch completions through both finite-etale maps from the same source; derive the differential specialization."),
        component(LAM, "Litt3.QuotientGeometry.linearized_laurent_artin_schreier_model",
                  "For algebraically closed characteristic-p constants and nonzero alpha,gamma, construct a genuine root-field RingEquiv to the WHOLE original Laurent field for the actual inverse parameter b=X^p/(alpha+gamma X^(p-1)). It explicitly intertwines the full original base embedding and has normalized coefficient a^(p-1)=-alpha/gamma^p. The degree-p universal root injection and proved target degree bound force surjection; no generation or field-isomorphism input is assumed.",
                  "Normalize the original arbitrary weak Laurent expression and supplied completed-ring maps to this actual model, construct the tame h-th-root layer and ramification filtration, derive the original orders from differents, and compare through both same-source completion maps."),
        component(LLG, "Litt3.QuotientGeometry.linearized_laurent_extension_cyclic_galois",
                  "The actual original Laurent extension under its literal two-term parameter embedding is finite of exact degree p and genuinely cyclic Galois. The correct embedded-base Algebra, SMul and Module are explicit, and the proved root-field equivalence transports actual Galoisness to the entire original Laurent field.",
                  "Normalize arbitrary regular tails and the original completed map, then construct the tame degree-h layer, lower ramification filtration and different, and transport completion equivalence through both original source maps."),
        component(LLC, "Litt3.QuotientGeometry.linearized_laurent_fields_equiv_iff",
                  "Two actual WHOLE original Laurent extensions for nonzero two-term parameters alpha*t^(-p)+gamma*t^(-1) and alpha'*t^(-p)+gamma'*t^(-1) are isomorphic over the SAME fixed full Laurent base if and only if -alpha/gamma^p=-alpha'/gamma'^p. Equivalence literally means a genuine RingEquiv intertwines BOTH original base embeddings; actual root-field identifications and AS automorphism classification prove both directions.",
                  "Normalize the original arbitrary weak tails and supplied completion maps, add the genuine tame layer, prove source uniformizer/root independence and actual different-derived pole orders, and compare the original same-source branch completions."),
        component(PFU, "Litt3.QuotientGeometry.laurent_field_map_eq_parameter_substitution",
                  "Every actual constant-preserving power-series homomorphism taking X to a zero-constant b is the genuine whole-series substitution map, by exact tail divisibility for each coefficient. Any supplied actual Laurent fraction-field map compatible with that completed-ring map is uniquely parameterLaurentMap. No continuity or substitution conclusion is assumed.",
                  "Construct the actual completed local ring and fraction-field maps from both original curve maps, identify their parameter image, then apply the genuine normalized polynomial-field and tame-layer classification."),
        component(FPD, "Litt3.QuotientGeometry.finite_parameter_laurent_dimension",
                  "For any field and every actual parameter b=X^n*c with n>0 and c(0) nonzero, actual power-series substitution is injective and extends to a genuine Laurent field embedding. The original whole Laurent field is finite of degree at most n over that actual embedded parameter field, by exact residue-class power-series decomposition and denominator clearing. Algebra, scalar action and Module are explicitly the substituted structures.",
                  "Prove exact degree, identify the original separating completed extension and linearized polynomial quotient over the same original downstairs field, then establish the tame layer, different/ramification filtration and both common-source completion maps."),
        component(LAS, "Litt3.QuotientGeometry.linearized_artin_schreier_scaling",
                  "For every algebraically closed characteristic-p field and nonzero actual alpha,gamma, construct a nonzero scaling ell and Artin-Schreier coefficient a with ell^(p-1)=-gamma/alpha, alpha*ell^p=-gamma*ell, a*(alpha*ell^p)=1 and the exact scalar a^(p-1)=-alpha/gamma^p. This holds for every prime p, including p=2.",
                  "Realize this exact scalar scaling as an isomorphism from the original whole completed Laurent extension to the genuine Artin-Schreier polynomial field, combine the actual tame layer, prove coordinate/root independence and transport through both original common-source maps."),
        component(WL, "Litt3.QuotientGeometry.weak_laurent_normal_form",
                  "For actual Laurent series over any field of positive characteristic p>1, actual pole order p and actual derivative order minus two force an exact expansion alpha*t^(-p)+gamma*t^(-1)+r with nonzero alpha,gamma and an actual power-series tail. Negative coefficient exclusion is proved from the actual derivative and characteristic.",
                  "Derive the Laurent pole/derivative orders from actual separating completed extension degrees and differents, remove the regular tail by actual Hensel lifting, prove the Galois/Artin-Schreier scalar classification and uniformizer independence, and transport the invariant through both actual same-source unramified maps."),
        component(PA, "Litt3.QuotientGeometry.power_series_parameter_adic_complete",
                  "For every commutative coefficient ring, the actual formal power-series ring is complete for its actual parameter ideal. Stabilized coefficients construct the limit, and the actual HenselianRing follows from completeness; no project literature assumption or finite truncation computation is used.",
                  "Relate genuine separating completed extension degrees and differents to the actual Laurent pole and derivative orders, then construct the actual local Galois action and completed-field comparison through both common-source maps."),
        component(WT, "Litt3.QuotientGeometry.weak_laurent_linearized_normal_form",
                  "Over any algebraically closed field of characteristic p>1, the actual Laurent pole-p and derivative-order-minus-two hypotheses give nonzero alpha,gamma and an actual power series w, with u=t^(-1)+w of actual pole one and f=alpha*u^p+gamma*u. The entire regular tail is removed by genuine simple-root Hensel lifting in the original Laurent ring.",
                  "Derive the original pole/derivative orders from the separating extension and different, construct the actual Galois inertia and break, classify genuine extensions over the same fixed base field, and retain both original same-source maps in the completion comparison."),
        component(LC, "Litt3.QuotientGeometry.weak_laurent_field_normal_form",
                  "The exact weak-pole polynomial normal form is realized by an actual constant-preserving automorphism of the entire Laurent field. Actual substitution by every zero-constant series with nonzero linear coefficient is proved bijective via genuine recursively constructed inverse coefficients, then extended to the actual fraction field; t^(-1)+w is therefore a genuine field coordinate.",
                  "Prove the genuine degree-p extension and its Galois translations, combine the tame h-th-root layer, derive different and break comparisons, prove the complete fixed-downstairs-field scalar classification and coordinate/root independence, and transport completed fields through both original same-source maps."),
        component(AS, "Litt3.QuotientGeometry.laurent_artin_schreier_lines_iff",
                  "For any actual pole-one Laurent parameter and nonzero constants a,b, the actual Artin-Schreier coboundary classes span the same Frobenius-fixed constant line exactly when a^(p-1)=b^(p-1). The actual additive image quotient and its equality/coboundary criterion are constructed, and a nonzero pole-one scalar is proved not to be a coboundary.",
                  "Identify the original completed extension with the genuine normalized Artin-Schreier field and tame layer, establish coordinate independence and the exact scalar -alpha/gamma^p, and transport those fields through the actual common-source completion maps."),
        component(ASF, "Litt3.QuotientGeometry.pole_one_artin_schreier_galois",
                  "For every characteristic-p coefficient field, nonzero pole-one right-hand side constructs an actual irreducible AdjoinRoot field over the whole Laurent base, of exact degree p, with genuine translation automorphisms and cyclic Galois group. Irreducibility is proved through the actual reciprocal Eisenstein polynomial over the parameter DVR, and Galoisness follows by actual automorphism count against the exact degree.",
                  "Identify the original completed Laurent source with this actual field, combine its genuine tame h-th-root layer and downstairs embedding, prove its exact lower break and different, and compare completions through both actual maps from the same source."),
        component(ASC, "Litt3.QuotientGeometry.pole_one_artin_schreier_fields_equiv_iff",
                  "Two genuine pole-one Artin-Schreier fields over the SAME full Laurent base field are isomorphic as actual base-algebras exactly when a^(p-1)=b^(p-1). More generally, actual irreducible Artin-Schreier fields over every characteristic-p field are base-isomorphic exactly for a nonzero Frobenius-fixed scalar plus a genuine base coboundary. Actual conjugated automorphisms, prime-degree fixed fields and universal root maps prove both directions.",
                  "Identify the source's normalized coefficient a and tame h-th-root layer with these actual fields, prove a^(p-1)=-alpha/gamma^p and uniformizer/root independence, then derive the full fixed-downstairs-field scalar classification and original common-source completion comparison."),
    ],
}


SOURCE_SCOPE_OVERRIDES = {
    "ordinary_quotient_torsion_descent":
        "Version2: actual same-source finite etale spans to an ordinary genus-two endpoint, with arbitrary prime-primary X-leg Galois closure. Prime divisors of the actual Frobenius moduli orbit obey the explicit all-prime support formula, with the sharper characteristic-five support {2,3,5,7,13}. Covers, exponents, nilpotency classes and generator counts are unrestricted. The source includes prime-to-characteristic torsion descent (four-torsion for ell=2) and ordinary subvariety descent from characteristic-p etale points, without ordinarity of the ambient abelian variety. Exact supports at ell=2,3,5 and the main-partner order bound are included. No backup or mixed-prime conclusion.",
    "small_odd_monodromy_exclusion":
        "Version2: for every actual same-source span to a genus-two curve over F_(25^b) with 19 not dividing b, the Y-leg normal-closure odd part avoids {1,3,5,7,9,11}, hence is at least13. Both original maps may be non-Galois, with no Sylow normality or two-primary order bound. The degree-eleven intermediate clause explicitly uses an actual cyclic/dihedral normal closure and constant-deck arithmetic model. Neither unrestricted common-cover problem is solved.",
    "two_by_abelian_frobenius_exclusion":
        "Version2: actual same-source spans with normal two-group kernel and abelian odd quotient of exponent dividing n are excluded by the literal mod19 prime and ord_n(2) criteria, in unbounded odd and two-primary orders. Nonabelian odd semisimple blocks retain their actual constant-deck model and exact residue-degree inequality. The new even-normal-closure clause uses the actual split rational Q_2 group-algebra decomposition and applies above every quotient D/H; it assumes neither mod-two semisimplicity nor an integral projector. C11 and D22 meet the explicit blocks. General mixed-prime monodromy remains open.",
}

WEAK_SOURCE_REALIZATION_GAP = (
    "The original positive valuation and genuine separating trace-defined different "
    "now derive every weak root's full normal form, nonzero scalar, entire Galois "
    "group/lower filtration, classification of TWO original full embeddings and "
    "automatic uniformizer independence. BOTH original maps of the SAME smooth "
    "source give whole-fiber scalar equality from literal original completed "
    "stalk parameter expansions and their different profiles. Original rational "
    "differential identities need only local regularity/nonvanishing, and actual "
    "original rational-field coordinate derivations derive the ORIGINAL unit "
    "product y*F_z and its residue, including Weierstrass points, giving the "
    "characteristic-five hyperelliptic-form constraint without requiring either "
    "factor to have an individual residue. The broader product bridge passed "
    "the 1,127-declaration trust audit; fresh exact whole-source hypothesis/scope "
    "readback is pending before complete status; the unmarked common-cover "
    "existence/exclusion problem remains outside this local source record."
)

COMPLETE_SOURCES = {"weak_local_completed_extension_invariant"}


def main() -> None:
    records = json.loads((ROOT / "Research/library.json").read_text())["theorems"]
    registered_paths = {r["statement"] for r in records}
    records = list(records)
    for prefix in PREFIXES:
        for path in sorted((ROOT / prefix).rglob("*.md")):
            relative = path.relative_to(ROOT).as_posix()
            if relative not in registered_paths:
                records.append({"id": path.stem, "statement": relative,
                                "source_registered": False})
    entries = []
    for record in records:
        if not record["statement"].startswith(PREFIXES):
            continue
        components = COMPONENTS.get(record["id"], [])
        is_complete = record["id"] in COMPLETE_SOURCES
        if record["id"] == "weak_local_completed_extension_invariant":
            components = [dict(c, gap="" if is_complete else WEAK_SOURCE_REALIZATION_GAP)
                          for c in components]
        source_text = (ROOT / record["statement"]).read_text()
        literal_version = re.search(r"Version\s*(\d+)", source_text)
        entry = {
            "theorem_id": record["id"],
            "source_path": record["statement"],
            "source_sha256": hashlib.sha256((ROOT / record["statement"]).read_bytes()).hexdigest(),
            "source_version": int(literal_version.group(1)) if literal_version else record.get("statement_version"),
            "source_registered": record.get("source_registered", True),
            "status": "complete" if is_complete else "partial_component" if components else "pending",
            "components": components,
            "hypotheses": "Each declaration retains its explicitly stated algebraic hypotheses; source geometric hypotheses and scope are preserved as remaining obligations.",
            "accepted_literature": [],
            "computation_reliance": "Checked components use structural algebra and kernel-checked tactics; no exhaustive endpoint computation or native_decide.",
            "source_dependencies": record.get("dependencies", []),
            "source_definitions": record.get("definitions", []),
            "source_scope": SOURCE_SCOPE_OVERRIDES.get(record["id"], record.get("scope", "")),
        }
        if is_complete:
            proof_path = ROOT / "Proofs/quotient_geometry/weak_local_completed_extension_invariant.md"
            entry.update({
                "full_statement_review": "Formalization/Coverage/reviews/weak_local_completed_extension_invariant.md",
                "independent_reviewer": "/root",
                "source_scope_review": "Version1 full clause-by-clause readback accepted 2026-10-03 by /root, including true separating trace-different convention, every-root normal form, entire Galois/lower filtration, two whole fixed-base fields, automatic uniformizer independence, both true maps from the same original smooth source, original rational differential scalar formula and characteristic-five product-residue corollary at Weierstrass points. No unmarked common-cover construction or exclusion is inferred.",
                "hypotheses": "Exact canonical weak finite separating completed extensions and genuine different exponent; actual same-source smooth-curve commuting diagram with etale first leg, second leg unramified on the whole selected fiber and actual Galois quotient; literal rational polar/differential identities and original simple-zero/unit hypotheses. Every original DVR, residue, completed map, source lift, unit slope and rational-product regularity conclusion is derived. No non-Weierstrass or unit-y premise.",
                "verification_history": ["../litt3-computation-data/formalization-20261003/verification/" + stamp + "/report.json"
                    for stamp in ["20261003T063227Z", "20261003T064231Z", "20261003T065842Z", "20261003T070411Z", "20261003T071634Z", "20261003T071938Z"]],
                "source_proof_path": proof_path.relative_to(ROOT).as_posix(),
                "source_proof_sha256": hashlib.sha256(proof_path.read_bytes()).hexdigest(),
            })
        entries.append(entry)
    output = {
        "schema_version": 1,
        "owner": "jacobians_geometry",
        "inventory_count": len(entries),
        "complete_count": sum(e["status"] == "complete" for e in entries),
        "entries": entries,
    }
    (FORMAL / "Coverage/jacobians_geometry.json").write_text(json.dumps(output, indent=2) + "\n")
    print(f"wrote {len(entries)} entries; {sum(e['status'] == 'partial_component' for e in entries)} partial; {output['complete_count']} complete")


if __name__ == "__main__":
    main()

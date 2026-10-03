import Solutions.SharedTensors.SmoothSchemeDifferentials
import Solutions.SharedTensors.SchemeFieldTowers
import Solutions.SharedTensors.SchemeCoefficientPoleBounds
import Solutions.SharedTensors.SeparableKaehlerCoordinates
import Mathlib.Algebra.CharP.Algebra

open CategoryTheory AlgebraicGeometry
open scoped WithZero

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.QuotientGeometry
universe u v

/-- The original affine-character implication on an ACTUAL étale cover,
with the literal completed-sheet existence input exposed. Rank one,
separability, integrality and differential compatibility are all proved
from the actual curve and map; no Galois hypothesis is added. -/
theorem actual_etale_cover_character_degree_bound
    {k : Type u} [Field k] {Z X : Scheme.{u}} [IsIntegral Z] [IsIntegral X]
    [ClosedPointDVRStalks Z] [ClosedPointDVRStalks X] [FinitePrincipalSupport X]
    (f : Z ⟶ X) [IsFinite f] [IsEtale f] [Surjective f]
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (sZ : Z ⟶ Spec (.of k)) (hbase : f ≫ sX = sZ)
    (p : ℕ) [CharP k p] (hp : 0 < p)
    (Ω : ClosedPoint X → Type v) [∀ x, Field (Ω x)] :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sZ).toAlgebra
    letI := (schemeFunctionFieldPullback f).toAlgebra
    letI := actualFunctionFieldBaseTower f sX sZ hbase
    ∀ (eta beta : KaehlerDifferential k X.functionField) (chi : Z.functionField)
      (G : Divisor (ClosedPoint Z)), EffectiveDivisor G →
      (∀ x, SchemeLocalSheetFactorization f x chi (minpoly X.functionField chi) (Ω x)) →
      (∀ z, closedPointValuation Z z chi ≤ WithZero.exp ((p : ℤ) * G z)) →
      NoKaehlerHomogeneousCharacters beta
        (schemeDivisorSectionSpace sX (p • schemeDivisorPushforward f G)) p →
      NoNonconstantKaehlerConstants
        (schemeDivisorSectionSpace sX (p • schemeDivisorPushforward f G)) →
      KaehlerDifferential.D k Z.functionField chi =
        KaehlerDifferential.map k k X.functionField Z.functionField eta +
          chi • KaehlerDifferential.map k k X.functionField Z.functionField beta →
      IntermediateField.adjoin X.functionField {chi} = ⊤ → schemeGenericDegree f < p := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sZ).toAlgebra
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI := actualFunctionFieldBaseTower f sX sZ hbase
  intro eta beta chi G hG sheets hpoles characters constants affine generates
  letI : CharP X.functionField p :=
    charP_of_injective_algebraMap (algebraMap k X.functionField).injective p
  letI : Algebra.IsSeparable X.functionField Z.functionField :=
    (actual_unramified_function_field_finite_separable f).2
  have integral := actual_unramified_function_field_elements_integral f chi
  have coefficients := actual_scheme_polynomial_coefficients_in_pushed_pole_space
    f sX chi (minpoly X.functionField chi) Ω sheets p G hG hpoles
  exact actual_kaehler_affine_source_field_degree_bound p hp
    (actualSmoothCurveKaehlerCoordinate sX) eta beta
    (schemeDivisorSectionSpace sX (p • schemeDivisorPushforward f G))
    characters constants chi integral coefficients affine generates

end Litt3.SharedTensors

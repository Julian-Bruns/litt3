import Solutions.SharedTensors.SchemeRegularDifferentials
import Solutions.SharedTensors.SchemeFunctionFieldGeneration
import Solutions.SharedTensors.OneVariableCartier

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

set_option synthInstance.maxHeartbeats 200000

open Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [PerfectField k]
  {X : Scheme.{u}} [IsIntegral X] {p : ℕ} [Fact p.Prime] [CharP k p]

include p

/-- Actual rational Cartier on the actual smooth curve, constructed
from its structure morphism. Generic finite generation, transcendence
degree, separating parameter and full p-basis are all derived. -/
noncomputable def actualSmoothCurveRationalCartier
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI : CharP X.functionField p :=
      charP_of_injective_algebraMap (algebraMap k X.functionField).injective p
    RationalCartierOperator k X.functionField p := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : CharP X.functionField p :=
    charP_of_injective_algebraMap (algebraMap k X.functionField).injective p
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  exact oneVariableRationalCartier
    (actual_locally_finite_type_function_field_finitely_generated sX)
    (actual_smooth_function_field_transcendence_degree sX 1)

/-- The constructed actual operator has the unique standard intrinsic
characterization on the original generic universal differential module. -/
theorem actual_smooth_curve_rational_cartier_unique
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI : CharP X.functionField p :=
      charP_of_injective_algebraMap (algebraMap k X.functionField).injective p
    ∀ C : RationalCartierOperator k X.functionField p,
      C.toAddHom = (actualSmoothCurveRationalCartier (p := p) sX).toAddHom := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : CharP X.functionField p :=
    charP_of_injective_algebraMap (algebraMap k X.functionField).injective p
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  intro C
  exact one_variable_rational_cartier_unique
    (actual_locally_finite_type_function_field_finitely_generated sX)
    (actual_smooth_function_field_transcendence_degree sX 1) C _

variable [IsAlgClosed k]

/-- The intrinsic standard Cartier characterization alone forces actual
global regularity on the original smooth integral curve. There are no
generic-field, DVR, coordinate, completion or stability premises. -/
theorem actual_smooth_curve_intrinsic_cartier_preserves_global_regularity
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI : CharP X.functionField p :=
      charP_of_injective_algebraMap (algebraMap k X.functionField).injective p
    ∀ (C : RationalCartierOperator k X.functionField p)
      (omega : KaehlerDifferential k X.functionField),
      omega ∈ schemeGlobalRegularDifferentials sX →
      C.toAddHom omega ∈ schemeGlobalRegularDifferentials sX := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : CharP X.functionField p :=
    charP_of_injective_algebraMap (algebraMap k X.functionField).injective p
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  exact actual_smooth_curve_cartier_preserves_global_regular_differentials sX
    (actual_locally_finite_type_function_field_finitely_generated sX)
    (actual_smooth_function_field_transcendence_degree sX 1)

/-- The actual additive Cartier operator on rational forms regular at
every original closed point. This construction asserts no identification
with a sheaf's global section space and no global surjectivity. -/
noncomputable def actualSmoothCurveGlobalCartier
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    schemeGlobalRegularDifferentials sX →+ schemeGlobalRegularDifferentials sX := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : CharP X.functionField p :=
    charP_of_injective_algebraMap (algebraMap k X.functionField).injective p
  let C := actualSmoothCurveRationalCartier (p := p) sX
  exact {
    toFun := fun omega => ⟨C.toAddHom omega.val,
      actual_smooth_curve_intrinsic_cartier_preserves_global_regularity
        sX C omega.val omega.property⟩
    map_zero' := by apply Subtype.ext; exact map_zero C.toAddHom
    map_add' := by intro omega eta; apply Subtype.ext; exact map_add C.toAddHom _ _ }

/-- The global operator is the literal restriction of the constructed
rational Cartier operator. -/
theorem actualSmoothCurveGlobalCartier_val
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI : CharP X.functionField p :=
      charP_of_injective_algebraMap (algebraMap k X.functionField).injective p
    ∀ omega : schemeGlobalRegularDifferentials sX,
      (actualSmoothCurveGlobalCartier (p := p) sX omega).val =
      (actualSmoothCurveRationalCartier (p := p) sX).toAddHom omega.val := by
  intros
  rfl

/-- The actual global restriction is p-th inverse semilinear for the
literal constant-field module action. -/
theorem actualSmoothCurveGlobalCartier_pth_semilinear
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (a : k) (omega : schemeGlobalRegularDifferentials sX),
      actualSmoothCurveGlobalCartier (p := p) sX (a ^ p • omega) =
      a • actualSmoothCurveGlobalCartier (p := p) sX omega := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : CharP X.functionField p :=
    charP_of_injective_algebraMap (algebraMap k X.functionField).injective p
  intro a omega
  apply Subtype.ext
  change (actualSmoothCurveRationalCartier (p := p) sX).toAddHom
    (a ^ p • omega.val) = a •
    (actualSmoothCurveRationalCartier (p := p) sX).toAddHom omega.val
  rw [← IsScalarTower.algebraMap_smul X.functionField (a ^ p),
    ← IsScalarTower.algebraMap_smul X.functionField a, map_pow]
  exact (actualSmoothCurveRationalCartier (p := p) sX).pth_semilinear _ _

/-- A globally regular rational form is killed exactly when it is the
universal differential of an actual rational function. The primitive
need not be a global regular function. -/
theorem actualSmoothCurveGlobalCartier_zero_iff_rational_exact
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ omega : schemeGlobalRegularDifferentials sX,
      actualSmoothCurveGlobalCartier (p := p) sX omega = 0 ↔
      ∃ f : X.functionField, KaehlerDifferential.D k X.functionField f = omega.val := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : CharP X.functionField p :=
    charP_of_injective_algebraMap (algebraMap k X.functionField).injective p
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  intro omega
  rw [Subtype.ext_iff]
  change (actualSmoothCurveRationalCartier (p := p) sX).toAddHom omega.val = 0 ↔ _
  exact one_variable_rational_cartier_zero_iff_exact
    (actual_locally_finite_type_function_field_finitely_generated sX)
    (actual_smooth_function_field_transcendence_degree sX 1) _ _

end Litt3.SharedTensors

import Solutions.SharedTensors.SchemeDifferentialGlobalCartier
import Solutions.SharedTensors.OneVariableCartierBaseChange
import Solutions.CartierAndSpin.SmoothEtaleGlobalDifferentialPullbacks

open CategoryTheory AlgebraicGeometry

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 200000

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry Litt3.CartierAndSpin

universe u

variable {k : Type u} [Field k] [PerfectField k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  {p : ℕ} [Fact p.Prime] [CharP k p]

/-- The Cartier operator on the ORIGINAL differential sheaf H0 realizes
exactly the constructed intrinsic rational Cartier operator. -/
theorem actualSmoothCurveSheafGlobalCartier_rational
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI : CharP X.functionField p :=
      charP_of_injective_algebraMap (algebraMap k X.functionField).injective p
    ∀ a : schemeDifferentialGlobalSections sX,
      schemeDifferentialGlobalSectionsToFunctionField sX
          (actualSmoothCurveSheafGlobalCartier (p := p) sX a) =
        (actualSmoothCurveRationalCartier (p := p) sX).toAddHom
          (schemeDifferentialGlobalSectionsToFunctionField sX a) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : CharP X.functionField p :=
    charP_of_injective_algebraMap (algebraMap k X.functionField).injective p
  letI : Nonempty (⊤ : X.Opens) := ⟨⟨genericPoint X, trivial⟩⟩
  intro a
  have h := congrArg Subtype.val
    (actualSmoothCurveSheafGlobalCartier_intertwines (p := p) sX a)
  simpa only [schemeDifferentialGlobalSectionsRegularEquiv_apply,
    actualSmoothCurveGlobalCartier_val] using h

/-- Cartier commutes with the genuine k-linear global differential
pullback of an ORIGINAL finite étale map. All rational separability,
field generation and H0 identification inputs are derived. No properness,
genus, finite H0 or supplied Cartier-commutation premise is needed. -/
theorem actualSmoothEtaleSheafGlobalCartier_pullback
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
    (f : X ⟶ Y) [IsFinite f] [IsEtale f] [Surjective f]
    (hover : f ≫ sY = sX) (a : schemeDifferentialGlobalSections sY) :
    actualSmoothCurveSheafGlobalCartier (p := p) sX
        (actualSmoothEtaleGlobalDifferentialPullback sX sY f hover a) =
      actualSmoothEtaleGlobalDifferentialPullback sX sY f hover
        (actualSmoothCurveSheafGlobalCartier (p := p) sY a) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI := actualFunctionFieldBaseTower f sY sX hover
  letI : CharP X.functionField p :=
    charP_of_injective_algebraMap (algebraMap k X.functionField).injective p
  letI : CharP Y.functionField p :=
    charP_of_injective_algebraMap (algebraMap k Y.functionField).injective p
  letI : IsSmooth sY := IsSmoothOfRelativeDimension.isSmooth 1 sY
  letI : Algebra.IsSeparable Y.functionField X.functionField :=
    (actual_unramified_function_field_finite_separable f).2
  letI : Nonempty (⊤ : X.Opens) := ⟨⟨genericPoint X, trivial⟩⟩
  apply schemeDifferentialSheafOpenToFunctionField_injective sX 1 ⊤
  change schemeDifferentialGlobalSectionsToFunctionField sX
      (actualSmoothCurveSheafGlobalCartier (p := p) sX
        (actualSmoothEtaleGlobalDifferentialPullback sX sY f hover a)) =
    schemeDifferentialGlobalSectionsToFunctionField sX
      (actualSmoothEtaleGlobalDifferentialPullback sX sY f hover
        (actualSmoothCurveSheafGlobalCartier (p := p) sY a))
  rw [actualSmoothCurveSheafGlobalCartier_rational,
    actualSmoothEtaleGlobalDifferentialPullback_rational,
    actualSmoothEtaleGlobalDifferentialPullback_rational,
    actualSmoothCurveSheafGlobalCartier_rational]
  exact one_variable_rational_cartier_separable_base_change
    (actual_locally_finite_type_function_field_finitely_generated sY)
    (actual_smooth_function_field_transcendence_degree sY 1)
    (actualSmoothCurveRationalCartier (p := p) sY)
    (actualSmoothCurveRationalCartier (p := p) sX) _

end Litt3.SharedTensors

import Definitions.SharedTensors.SchemeRegularDifferentials
import Solutions.SharedTensors.SmoothCurveCompletions
import Solutions.SharedTensors.DVRCartierDifferentials

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]

theorem mem_schemeLocalRegularDifferentials_iff
    (sX : X ⟶ Spec (.of k)) (x : X) :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (stalkBaseFieldHom sX x).toAlgebra
    letI : IsScalarTower k (X.presheaf.stalk x) X.functionField :=
      IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sX x).symm
    ∀ omega : KaehlerDifferential k X.functionField,
      omega ∈ schemeLocalRegularDifferentials sX x ↔
      ∃ omegaR : KaehlerDifferential k (X.presheaf.stalk x),
        KaehlerDifferential.map k k (X.presheaf.stalk x) X.functionField omegaR = omega := by
  intros
  rfl

theorem mem_schemeGlobalRegularDifferentials_iff
    (sX : X ⟶ Spec (.of k)) :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ omega : KaehlerDifferential k X.functionField,
      omega ∈ schemeGlobalRegularDifferentials sX ↔
      ∀ x : ClosedPoint X, omega ∈ schemeLocalRegularDifferentials sX x.val := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega
  change omega ∈ (⨅ x : ClosedPoint X, schemeLocalRegularDifferentials sX x.val) ↔ _
  rw [Submodule.mem_iInf]

variable [IsAlgClosed k] {p : ℕ} [Fact p.Prime] [CharP k p]

/-- On the actual smooth integral curve, intrinsic Cartier preserves
the image of each original stalk's universal differential module. DVR,
residue coefficients and local parameter are derived from smoothness. -/
theorem actual_smooth_curve_cartier_preserves_local_regular_differentials
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI : CharP X.functionField p :=
      charP_of_injective_algebraMap (algebraMap k X.functionField).injective p
    ∀ (hfg : IntermediateField.FG (F := k) (E := X.functionField) ⊤)
      (htrdeg : Algebra.trdeg k X.functionField = 1)
      (C : RationalCartierOperator k X.functionField p) (x : ClosedPoint X)
      (omega : KaehlerDifferential k X.functionField),
      omega ∈ schemeLocalRegularDifferentials sX x.val →
      C.toAddHom omega ∈ schemeLocalRegularDifferentials sX x.val := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : CharP X.functionField p :=
    charP_of_injective_algebraMap (algebraMap k X.functionField).injective p
  intro hfg htrdeg C x omega hregular
  letI := (stalkBaseFieldHom sX x.val).toAlgebra
  letI : IsScalarTower k (X.presheaf.stalk x.val) X.functionField :=
    IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sX x.val).symm
  letI := actual_smooth_curve_closed_point_dvr sX x
  apply (mem_schemeLocalRegularDifferentials_iff sX x.val _).mpr
  apply actual_dvr_cartier_preserves_universal_differential_image
    (actualSmoothCurveCompletionParameters sX x) hfg htrdeg C omega
  exact (mem_schemeLocalRegularDifferentials_iff sX x.val _).mp hregular

/-- Cartier preserves the intersection of the actual original regular
local modules over every closed point of the same smooth integral curve.
No properness or supplied Cartier-stable lattice is needed. -/
theorem actual_smooth_curve_cartier_preserves_global_regular_differentials
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI : CharP X.functionField p :=
      charP_of_injective_algebraMap (algebraMap k X.functionField).injective p
    ∀ (hfg : IntermediateField.FG (F := k) (E := X.functionField) ⊤)
      (htrdeg : Algebra.trdeg k X.functionField = 1)
      (C : RationalCartierOperator k X.functionField p)
      (omega : KaehlerDifferential k X.functionField),
      omega ∈ schemeGlobalRegularDifferentials sX →
      C.toAddHom omega ∈ schemeGlobalRegularDifferentials sX := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : CharP X.functionField p :=
    charP_of_injective_algebraMap (algebraMap k X.functionField).injective p
  intro hfg htrdeg C omega hregular
  apply (mem_schemeGlobalRegularDifferentials_iff sX _).mpr
  intro x
  exact actual_smooth_curve_cartier_preserves_local_regular_differentials
    sX hfg htrdeg C x omega ((mem_schemeGlobalRegularDifferentials_iff sX _).mp hregular x)

end Litt3.SharedTensors

import Solutions.SharedTensors.IntegralSchemeGlobalFunctions
import Solutions.QuotientGeometry.SchemeBaseFields
import Mathlib.AlgebraicGeometry.Morphisms.Proper
import Mathlib.FieldTheory.IsAlgClosed.Basic

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [UniversallyClosed sX]

noncomputable local instance properSchemeGlobalConstantsTopNonempty :
    Nonempty (⊤ : X.Opens) := ⟨⟨genericPoint X, trivial⟩⟩

/-- On ANY actual integral Scheme universally closed over an
algebraically closed field, EVERY global structure-sheaf section is a
constant through the actual structure morphism. No smoothness or finite
type is required for this conclusion. -/
theorem actual_universally_closed_global_sections_constant :
    Function.Surjective (chartBaseFieldHom sX ⊤) := by
  let F : k →+* Γ(X, ⊤) := ((Scheme.ΓSpecIso (.of k)).inv ≫ sX.appTop).hom
  have hint : F.IsIntegral := by
    apply RingHom.isIntegral_respectsIso.2
      (e := (Scheme.ΓSpecIso (.of k)).symm.commRingCatIsoToRingEquiv)
    exact isIntegral_appTop_of_universallyClosed sX
  have htop : chartBaseFieldHom sX ⊤ = F := by
    simp [chartBaseFieldHom, F]
  rw [htop]
  exact (IsAlgClosed.ringHom_bijective_of_isIntegral F hint).2

/-- A rational function belonging to EVERY actual stalk of a
universally closed integral Scheme is a literal constant in its true
function field. This conclusion is proved by actual sheaf gluing and
the genuine integral global-section theorem. -/
theorem actual_universally_closed_regular_rational_function_constant
    (f : X.functionField)
    (hregular : ∀ x : X, ∃ r : X.presheaf.stalk x,
      algebraMap (X.presheaf.stalk x) X.functionField r = f) :
    ∃ c : k, genericBaseFieldHom sX c = f := by
  obtain ⟨a, ha⟩ := (actual_function_field_regular_everywhere_iff_global_section f).mp hregular
  obtain ⟨c, hc⟩ := actual_universally_closed_global_sections_constant sX a
  refine ⟨c, ?_⟩
  have hcompat := RingHom.congr_fun (chart_base_field_hom_generic_compatibility sX ⊤) c
  change algebraMap Γ(X, ⊤) X.functionField (chartBaseFieldHom sX ⊤ c) =
    genericBaseFieldHom sX c at hcompat
  rw [hc, ha] at hcompat
  exact hcompat.symm

end Litt3.SharedTensors

import Solutions.QuotientGeometry.GaloisSmoothCurveParameterFields
import Solutions.QuotientGeometry.SchemeFixedSameSourceCompletedFields
import Solutions.QuotientGeometry.ParameterFieldEquivalenceRelation
import Mathlib.AlgebraicGeometry.Morphisms.Etale

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- BOTH original maps of the SAME original smooth integral source
identify endpoint completions across the ENTIRE original Galois
fiber. The endpoint map is actually finite etale. The second map
needs to be unramified only at the selected source points. Every
local DVR, residue, chart normalization, group action, completion
and map square follows from the original curve diagram. -/
theorem actual_galois_smooth_same_source_fields_equivalent
    {k : Type u} [Field k] [IsAlgClosed k]
    {T Y G B : Scheme.{u}} [IsIntegral T] [IsIntegral Y] [IsIntegral G] [IsIntegral B]
    (sT : T ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
    (sG : G ⟶ Spec (.of k)) (sB : B ⟶ Spec (.of k))
    [IsSmoothOfRelativeDimension 1 sT] [IsSmoothOfRelativeDimension 1 sY]
    [IsSmoothOfRelativeDimension 1 sG] [IsSmoothOfRelativeDimension 1 sB]
    (f : T ⟶ Y) (g : T ⟶ G) (χ : Y ⟶ B) (ν : G ⟶ B)
    [IsFinite f] [IsEtale f] [IsFinite g] [Surjective χ] [IsFinite ν] [Surjective ν]
    (hf : f ≫ sY = sT) (hg : g ≫ sG = sT)
    (hχ : χ ≫ sB = sY) (hν : ν ≫ sB = sG)
    (hcomm : f ≫ χ = g ≫ ν)
    (t₁ t₂ : Litt3.SharedTensors.ClosedPoint T) (b : Litt3.SharedTensors.ClosedPoint B)
    (hbG₁ : b.val = ν (g t₁.val)) (hbG₂ : b.val = ν (g t₂.val))
    (hug₁ : (g.stalkMap t₁.val).hom.FormallyUnramified)
    (hug₂ : (g.stalkMap t₂.val).hom.FormallyUnramified) :
    letI := (Litt3.SharedTensors.schemeFunctionFieldPullback ν).toAlgebra
    FiniteDimensional B.functionField G.functionField → IsGalois B.functionField G.functionField →
    let y₁ := Litt3.SharedTensors.mapClosedPoint f t₁
    let y₂ := Litt3.SharedTensors.mapClosedPoint f t₂
    letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sB b
    letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sY y₁
    letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sY y₂
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sB b.val).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY y₁.val).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY y₂.val).toAlgebra
    let hbY₁ : b.val = χ y₁.val := hbG₁.trans
      (congrArg (fun a : T ⟶ B => a t₁.val) hcomm).symm
    let hbY₂ : b.val = χ y₂.val := hbG₂.trans
      (congrArg (fun a : T ⟶ B => a t₂.val) hcomm).symm
    ∀ (dB : DVRCompletionParameters k (B.presheaf.stalk b.val))
      (d₁ : DVRCompletionParameters k (Y.presheaf.stalk y₁.val))
      (d₂ : DVRCompletionParameters k (Y.presheaf.stalk y₂.val)),
    ParameterFieldsEquivalent
      (completedDVRLaurentMap dB d₁ (actualSchemeFixedBaseStalkMap χ sY sB hχ b.val y₁.val hbY₁)
        (actual_integral_fixed_base_scheme_stalk_injective χ sY sB hχ b.val y₁.val hbY₁))
      (completedDVRLaurentMap dB d₂ (actualSchemeFixedBaseStalkMap χ sY sB hχ b.val y₂.val hbY₂)
        (actual_integral_fixed_base_scheme_stalk_injective χ sY sB hχ b.val y₂.val hbY₂)) := by
  letI := (Litt3.SharedTensors.schemeFunctionFieldPullback ν).toAlgebra
  intro hfinite hgalois
  letI := hfinite
  letI := hgalois
  let y₁ := Litt3.SharedTensors.mapClosedPoint f t₁
  let y₂ := Litt3.SharedTensors.mapClosedPoint f t₂
  let z₁ := Litt3.SharedTensors.mapClosedPoint g t₁
  let z₂ := Litt3.SharedTensors.mapClosedPoint g t₂
  letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sB b
  letI : IsDiscreteValuationRing (Y.presheaf.stalk (f t₁.val)) :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sY y₁
  letI : IsDiscreteValuationRing (Y.presheaf.stalk (f t₂.val)) :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sY y₂
  letI : IsDiscreteValuationRing (G.presheaf.stalk (g t₁.val)) :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sG z₁
  letI : IsDiscreteValuationRing (G.presheaf.stalk (g t₂.val)) :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sG z₂
  letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sT t₁
  letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sT t₂
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sB b.val).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY y₁.val).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY y₂.val).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sG z₁.val).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sG z₂.val).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sT t₁.val).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sT t₂.val).toAlgebra
  let hbY₁ : b.val = χ y₁.val := hbG₁.trans
    (congrArg (fun a : T ⟶ B => a t₁.val) hcomm).symm
  let hbY₂ : b.val = χ y₂.val := hbG₂.trans
    (congrArg (fun a : T ⟶ B => a t₂.val) hcomm).symm
  let dG₁ := Litt3.SharedTensors.actualSmoothCurveCompletionParameters sG z₁
  let dG₂ := Litt3.SharedTensors.actualSmoothCurveCompletionParameters sG z₂
  let dT₁ := Litt3.SharedTensors.actualSmoothCurveCompletionParameters sT t₁
  let dT₂ := Litt3.SharedTensors.actualSmoothCurveCompletionParameters sT t₂
  dsimp only
  intro dB d₁ d₂
  have h₁ := actual_fixed_same_source_scheme_completed_fields_equivalent
    f g χ ν sT sY sG sB hf hg hχ hν hcomm t₁.val b.val hbY₁ hbG₁
    (Litt3.Jacobians.scheme_stalk_map_formallyUnramified f t₁.val) hug₁ dB d₁ dG₁ dT₁
  have h₂ := actual_fixed_same_source_scheme_completed_fields_equivalent
    f g χ ν sT sY sG sB hf hg hχ hν hcomm t₂.val b.val hbY₂ hbG₂
    (Litt3.Jacobians.scheme_stalk_map_formallyUnramified f t₂.val) hug₂ dB d₂ dG₂ dT₂
  have hG := actual_galois_smooth_curve_arbitrary_parameters sG sB ν hν b z₁ z₂
    hbG₁ hbG₂ hfinite hgalois dB dG₁ dG₂
  exact (h₁.trans hG).trans h₂.symm

end Litt3.QuotientGeometry

import Solutions.QuotientGeometry.GaloisSmoothSameSourceFields
import Solutions.QuotientGeometry.FiniteClosedPointLifts
import Solutions.QuotientGeometry.FiniteSchemeFunctionFields

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- EVERY pair of original endpoint points in the same original
fiber has equivalent entire completed fields through BOTH actual
maps of the SAME smooth integral source. Actual finite etale
surjectivity constructs the original closed source lifts. The
second map is required unramified only above that full base fiber.
No finite-degree hypothesis, normalization model, local charts,
completed identification or chosen source lifts are supplied. -/
theorem actual_galois_smooth_same_source_entire_fiber_fields
    {k : Type u} [Field k] [IsAlgClosed k]
    {T Y G B : Scheme.{u}} [IsIntegral T] [IsIntegral Y] [IsIntegral G] [IsIntegral B]
    (sT : T ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
    (sG : G ⟶ Spec (.of k)) (sB : B ⟶ Spec (.of k))
    [IsSmoothOfRelativeDimension 1 sT] [IsSmoothOfRelativeDimension 1 sY]
    [IsSmoothOfRelativeDimension 1 sG] [IsSmoothOfRelativeDimension 1 sB]
    (f : T ⟶ Y) (g : T ⟶ G) (χ : Y ⟶ B) (ν : G ⟶ B)
    [IsFinite f] [IsEtale f] [Surjective f] [IsFinite g]
    [Surjective χ] [IsFinite ν] [Surjective ν]
    (hf : f ≫ sY = sT) (hg : g ≫ sG = sT)
    (hχ : χ ≫ sB = sY) (hν : ν ≫ sB = sG)
    (hcomm : f ≫ χ = g ≫ ν)
    (b : Litt3.SharedTensors.ClosedPoint B)
    (hug : ∀ t : Litt3.SharedTensors.ClosedPoint T,
      b.val = ν (g t.val) → (g.stalkMap t.val).hom.FormallyUnramified)
    (y₁ y₂ : Litt3.SharedTensors.ClosedPoint Y)
    (hb₁ : b.val = χ y₁.val) (hb₂ : b.val = χ y₂.val) :
    letI := (Litt3.SharedTensors.schemeFunctionFieldPullback ν).toAlgebra
    IsGalois B.functionField G.functionField →
    letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sB b
    letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sY y₁
    letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sY y₂
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sB b.val).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY y₁.val).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY y₂.val).toAlgebra
    ∀ (dB : DVRCompletionParameters k (B.presheaf.stalk b.val))
      (d₁ : DVRCompletionParameters k (Y.presheaf.stalk y₁.val))
      (d₂ : DVRCompletionParameters k (Y.presheaf.stalk y₂.val)),
    ParameterFieldsEquivalent
      (completedDVRLaurentMap dB d₁ (actualSchemeFixedBaseStalkMap χ sY sB hχ b.val y₁.val hb₁)
        (actual_integral_fixed_base_scheme_stalk_injective χ sY sB hχ b.val y₁.val hb₁))
      (completedDVRLaurentMap dB d₂ (actualSchemeFixedBaseStalkMap χ sY sB hχ b.val y₂.val hb₂)
        (actual_integral_fixed_base_scheme_stalk_injective χ sY sB hχ b.val y₂.val hb₂)) := by
  letI := (Litt3.SharedTensors.schemeFunctionFieldPullback ν).toAlgebra
  intro hgalois
  letI := hgalois
  letI : IsSmooth sT := IsSmoothOfRelativeDimension.isSmooth 1 sT
  letI : JacobsonSpace T := LocallyOfFiniteType.jacobsonSpace sT
  obtain ⟨t₁, ht₁⟩ := actual_finite_map_closed_points_surjective f y₁
  obtain ⟨t₂, ht₂⟩ := actual_finite_map_closed_points_surjective f y₂
  subst y₁
  subst y₂
  let hbG₁ : b.val = ν (g t₁.val) := hb₁.trans
    (congrArg (fun a : T ⟶ B => a t₁.val) hcomm)
  let hbG₂ : b.val = ν (g t₂.val) := hb₂.trans
    (congrArg (fun a : T ⟶ B => a t₂.val) hcomm)
  exact actual_galois_smooth_same_source_fields_equivalent sT sY sG sB
    f g χ ν hf hg hχ hν hcomm t₁ t₂ b hbG₁ hbG₂ (hug t₁ hbG₁) (hug t₂ hbG₂)
    (actual_finite_scheme_function_field_extension ν) hgalois

end Litt3.QuotientGeometry

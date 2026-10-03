import Solutions.QuotientGeometry.SchemeFixedSameSourceSquare
import Solutions.QuotientGeometry.SameSourceDVRWeakScalars

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- BOTH true maps out of the SAME integral Scheme compare the
whole completed endpoint fields over one fixed original base point.
Only unramifiedness at the selected actual source point is required. -/
theorem actual_fixed_same_source_scheme_completed_fields_equivalent
    {k : Type u} [Field k] {T X Y B : Scheme.{u}}
    [IsIntegral T] [IsIntegral X] [IsIntegral Y] [IsIntegral B]
    (f₁ : T ⟶ X) (f₂ : T ⟶ Y) (χ₁ : X ⟶ B) (χ₂ : Y ⟶ B)
    [LocallyOfFiniteType f₁] [LocallyOfFiniteType f₂]
    [Surjective χ₁] [Surjective χ₂]
    (sT : T ⟶ Spec (.of k)) (sX : X ⟶ Spec (.of k))
    (sY : Y ⟶ Spec (.of k)) (sB : B ⟶ Spec (.of k))
    (hf₁ : f₁ ≫ sX = sT) (hf₂ : f₂ ≫ sY = sT)
    (hχ₁ : χ₁ ≫ sB = sX) (hχ₂ : χ₂ ≫ sB = sY)
    (hcomm : f₁ ≫ χ₁ = f₂ ≫ χ₂) (t : T) (b : B)
    (hb₁ : b = χ₁ (f₁ t)) (hb₂ : b = χ₂ (f₂ t))
    (hu₁ : (f₁.stalkMap t).hom.FormallyUnramified)
    (hu₂ : (f₂.stalkMap t).hom.FormallyUnramified)
    [IsDiscreteValuationRing (B.presheaf.stalk b)]
    [IsDiscreteValuationRing (X.presheaf.stalk (f₁ t))]
    [IsDiscreteValuationRing (Y.presheaf.stalk (f₂ t))]
    [IsDiscreteValuationRing (T.presheaf.stalk t)] :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sB b).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX (f₁ t)).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f₂ t)).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sT t).toAlgebra
    ∀ (dB : DVRCompletionParameters k (B.presheaf.stalk b))
      (d₁ : DVRCompletionParameters k (X.presheaf.stalk (f₁ t)))
      (d₂ : DVRCompletionParameters k (Y.presheaf.stalk (f₂ t)))
      (dT : DVRCompletionParameters k (T.presheaf.stalk t)),
    ParameterFieldsEquivalent
      (completedDVRLaurentMap dB d₁
        (actualSchemeFixedBaseStalkMap χ₁ sX sB hχ₁ b (f₁ t) hb₁)
        (actual_integral_fixed_base_scheme_stalk_injective χ₁ sX sB hχ₁ b (f₁ t) hb₁))
      (completedDVRLaurentMap dB d₂
        (actualSchemeFixedBaseStalkMap χ₂ sY sB hχ₂ b (f₂ t) hb₂)
        (actual_integral_fixed_base_scheme_stalk_injective χ₂ sY sB hχ₂ b (f₂ t) hb₂)) := by
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sB b).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX (f₁ t)).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f₂ t)).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sT t).toAlgebra
  dsimp only
  intro dB d₁ d₂ dT
  exact same_source_unramified_dvr_laurent_fields_equivalent dB d₁ d₂ dT
    (actualSchemeFixedBaseStalkMap χ₁ sX sB hχ₁ b (f₁ t) hb₁)
    (actualSchemeFixedBaseStalkMap χ₂ sY sB hχ₂ b (f₂ t) hb₂)
    (actualSchemeStalkAlgHom f₁ sT sX hf₁ t) (actualSchemeStalkAlgHom f₂ sT sY hf₂ t)
    (actual_integral_fixed_base_scheme_stalk_injective χ₁ sX sB hχ₁ b (f₁ t) hb₁)
    (actual_integral_fixed_base_scheme_stalk_injective χ₂ sY sB hχ₂ b (f₂ t) hb₂)
    hu₁ (Litt3.Jacobians.scheme_stalk_map_essFiniteType f₁ t)
    hu₂ (Litt3.Jacobians.scheme_stalk_map_essFiniteType f₂ t)
    (actual_fixed_same_source_scheme_stalk_square f₁ f₂ χ₁ χ₂ sT sX sY sB
      hf₁ hf₂ hχ₁ hχ₂ hcomm t b hb₁ hb₂)

end Litt3.QuotientGeometry

import Solutions.QuotientGeometry.SchemeSameSourceCoefficientSquare
import Solutions.QuotientGeometry.SchemeSecondBaseStalkInjectivity
import Solutions.QuotientGeometry.SameSourceDVRWeakScalars

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- BOTH actual unramified maps out of the SAME integral scheme force
equivalence of the whole completed fields at their two images over
the SAME entire downstairs completed field. Coefficient maps, the
stalk square and all completed maps are constructed from the genuine
scheme diagram. The actual local DVR parameter/residue data remain
explicit. -/
theorem actual_same_source_scheme_completed_fields_equivalent
    {k : Type u} [Field k] {T X Y B : Scheme.{u}}
    [IsIntegral T] [IsIntegral X] [IsIntegral Y] [IsIntegral B]
    (f₁ : T ⟶ X) (f₂ : T ⟶ Y) (χ₁ : X ⟶ B) (χ₂ : Y ⟶ B)
    [LocallyOfFiniteType f₁] [LocallyOfFiniteType f₂]
    [Surjective χ₁] [Surjective χ₂]
    (sT : T ⟶ Spec (.of k)) (sX : X ⟶ Spec (.of k))
    (sY : Y ⟶ Spec (.of k)) (sB : B ⟶ Spec (.of k))
    (hf₁ : f₁ ≫ sX = sT) (hf₂ : f₂ ≫ sY = sT)
    (hχ₁ : χ₁ ≫ sB = sX) (hχ₂ : χ₂ ≫ sB = sY)
    (hcomm : f₁ ≫ χ₁ = f₂ ≫ χ₂) (t : T)
    (hu₁ : (f₁.stalkMap t).hom.FormallyUnramified)
    (hu₂ : (f₂.stalkMap t).hom.FormallyUnramified)
    [IsDiscreteValuationRing (B.presheaf.stalk (χ₁ (f₁ t)))]
    [IsDiscreteValuationRing (X.presheaf.stalk (f₁ t))]
    [IsDiscreteValuationRing (Y.presheaf.stalk (f₂ t))]
    [IsDiscreteValuationRing (T.presheaf.stalk t)] :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sB (χ₁ (f₁ t))).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX (f₁ t)).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f₂ t)).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sT t).toAlgebra
    ∀ (dB : DVRCompletionParameters k (B.presheaf.stalk (χ₁ (f₁ t))))
      (d₁ : DVRCompletionParameters k (X.presheaf.stalk (f₁ t)))
      (d₂ : DVRCompletionParameters k (Y.presheaf.stalk (f₂ t)))
      (dT : DVRCompletionParameters k (T.presheaf.stalk t)),
    ParameterFieldsEquivalent
      (completedDVRLaurentMap dB d₁ (actualSchemeStalkAlgHom χ₁ sX sB hχ₁ (f₁ t))
        (actual_integral_surjective_scheme_stalk_injective χ₁ (f₁ t)))
      (completedDVRLaurentMap dB d₂
        (actualSchemeSecondBaseStalkMap f₁ f₂ χ₁ χ₂ sY sB hχ₂ hcomm t)
        (actualSchemeSecondBaseStalkMap_injective f₁ f₂ χ₁ χ₂ sY sB hχ₂ hcomm t)) := by
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sB (χ₁ (f₁ t))).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX (f₁ t)).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f₂ t)).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sT t).toAlgebra
  dsimp only
  intro dB d₁ d₂ dT
  exact same_source_unramified_dvr_laurent_fields_equivalent dB d₁ d₂ dT
    (actualSchemeStalkAlgHom χ₁ sX sB hχ₁ (f₁ t))
    (actualSchemeSecondBaseStalkMap f₁ f₂ χ₁ χ₂ sY sB hχ₂ hcomm t)
    (actualSchemeStalkAlgHom f₁ sT sX hf₁ t) (actualSchemeStalkAlgHom f₂ sT sY hf₂ t)
    (actual_integral_surjective_scheme_stalk_injective χ₁ (f₁ t))
    (actualSchemeSecondBaseStalkMap_injective f₁ f₂ χ₁ χ₂ sY sB hχ₂ hcomm t)
    hu₁
    (Litt3.Jacobians.scheme_stalk_map_essFiniteType f₁ t)
    hu₂
    (Litt3.Jacobians.scheme_stalk_map_essFiniteType f₂ t)
    (actual_same_source_scheme_stalk_coefficient_square f₁ f₂ χ₁ χ₂
      sT sX sY sB hf₁ hf₂ hχ₁ hχ₂ hcomm t)

end Litt3.QuotientGeometry

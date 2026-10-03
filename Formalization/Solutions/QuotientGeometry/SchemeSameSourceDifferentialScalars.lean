import Solutions.QuotientGeometry.SchemeSameSourceCompletedFields
import Solutions.QuotientGeometry.DVRFieldEquivDifferentialScalars

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- BOTH actual scheme maps out of the SAME source, unramified at the
actual source point, force the exact scalar equality at the two
endpoint points. The maps may ramify elsewhere. The original scheme
diagram constructs all coefficient maps, the entire stalk square and
the completed comparison. Only genuine original function and Ω
identities and actual local parameter/residue data are supplied. -/
theorem actual_same_source_scheme_original_differential_scalars_equal
    {k : Type u} [Field k] [IsAlgClosed k] (p h m : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hm : 0 < m) (hdiv : h ∣ p - 1)
    (hchar : (h : k) ≠ 0) (hmchar : (m : k) ≠ 0)
    {T X Y B : Scheme.{u}}
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
      (dT : DVRCompletionParameters k (T.presheaf.stalk t))
      (g₁ s₁ : X.presheaf.stalk (f₁ t)) (g₂ s₂ : Y.presheaf.stalk (f₂ t))
      (c : k) (_hc : c ≠ 0)
      (_hg₁ : IsUnit g₁) (_hg₂ : IsUnit g₂) (_hs₁ : IsUnit s₁) (_hs₂ : IsUnit s₂),
    actualSchemeStalkAlgHom χ₁ sX sB hχ₁ (f₁ t) dB.parameter * g₁ ^ m =
      d₁.parameter ^ (p * h) →
    actualSchemeSecondBaseStalkMap f₁ f₂ χ₁ χ₂ sY sB hχ₂ hcomm t dB.parameter * g₂ ^ m =
      d₂.parameter ^ (p * h) →
    KaehlerDifferential.D k (X.presheaf.stalk (f₁ t)) g₁ =
      (algebraMap k (X.presheaf.stalk (f₁ t)) c * d₁.parameter ^ (p - 2) * s₁) •
        KaehlerDifferential.D k (X.presheaf.stalk (f₁ t)) d₁.parameter →
    KaehlerDifferential.D k (Y.presheaf.stalk (f₂ t)) g₂ =
      (algebraMap k (Y.presheaf.stalk (f₂ t)) c * d₂.parameter ^ (p - 2) * s₂) •
        KaehlerDifferential.D k (Y.presheaf.stalk (f₂ t)) d₂.parameter →
    localDifferentialScalar p h m c (dvrResidueValue d₁ g₁) (dvrResidueValue d₁ s₁) =
      localDifferentialScalar p h m c (dvrResidueValue d₂ g₂) (dvrResidueValue d₂ s₂) := by
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sB (χ₁ (f₁ t))).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX (f₁ t)).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f₂ t)).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sT t).toAlgebra
  dsimp only
  intro dB d₁ d₂ dT g₁ s₁ g₂ s₂ c hc hg₁ hg₂ hs₁ hs₂ hpolar₁ hpolar₂ hdg₁ hdg₂
  exact original_dvr_completed_fields_differential_scalars_equal p h m hh hm hdiv hchar hmchar
    dB d₁ d₂ (actualSchemeStalkAlgHom χ₁ sX sB hχ₁ (f₁ t))
    (actualSchemeSecondBaseStalkMap f₁ f₂ χ₁ χ₂ sY sB hχ₂ hcomm t)
    (actual_integral_surjective_scheme_stalk_injective χ₁ (f₁ t))
    (actualSchemeSecondBaseStalkMap_injective f₁ f₂ χ₁ χ₂ sY sB hχ₂ hcomm t)
    (actual_same_source_scheme_completed_fields_equivalent f₁ f₂ χ₁ χ₂
      sT sX sY sB hf₁ hf₂ hχ₁ hχ₂ hcomm t hu₁ hu₂ dB d₁ d₂ dT)
    g₁ s₁ g₂ s₂ c hc hg₁ hg₂ hs₁ hs₂ hpolar₁ hpolar₂ hdg₁ hdg₂

end Litt3.QuotientGeometry

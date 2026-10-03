import Solutions.QuotientGeometry.GaloisSmoothSameSourceFiber
import Solutions.QuotientGeometry.DVRFieldEquivDifferentialScalars

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- The exact original residue differential scalar is constant on
the ENTIRE original endpoint fiber in a true same-source smooth
curve diagram. The original endpoint leg is finite etale and
surjective; the second original source leg is unramified above
that fiber. All original stalks, source lifts, Galois fiber actions,
completed-field comparisons and expansions are derived. The only
function inputs are the ORIGINAL polar and universal differential
identities, with actual original local units. -/
theorem actual_galois_smooth_same_source_entire_fiber_scalars_equal
    {k : Type u} [Field k] [IsAlgClosed k]
    (p h m : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hm : 0 < m) (hdiv : h ∣ p - 1)
    (hchar : (h : k) ≠ 0) (hmchar : (m : k) ≠ 0)
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
      (d₂ : DVRCompletionParameters k (Y.presheaf.stalk y₂.val))
      (G₁ S₁ : Y.presheaf.stalk y₁.val) (G₂ S₂ : Y.presheaf.stalk y₂.val)
      (c : k) (_hc : c ≠ 0)
      (_hG₁ : IsUnit G₁) (_hG₂ : IsUnit G₂) (_hS₁ : IsUnit S₁) (_hS₂ : IsUnit S₂),
    actualSchemeFixedBaseStalkMap χ sY sB hχ b.val y₁.val hb₁ dB.parameter * G₁ ^ m =
      d₁.parameter ^ (p * h) →
    actualSchemeFixedBaseStalkMap χ sY sB hχ b.val y₂.val hb₂ dB.parameter * G₂ ^ m =
      d₂.parameter ^ (p * h) →
    KaehlerDifferential.D k (Y.presheaf.stalk y₁.val) G₁ =
      (algebraMap k (Y.presheaf.stalk y₁.val) c * d₁.parameter ^ (p - 2) * S₁) •
        KaehlerDifferential.D k (Y.presheaf.stalk y₁.val) d₁.parameter →
    KaehlerDifferential.D k (Y.presheaf.stalk y₂.val) G₂ =
      (algebraMap k (Y.presheaf.stalk y₂.val) c * d₂.parameter ^ (p - 2) * S₂) •
        KaehlerDifferential.D k (Y.presheaf.stalk y₂.val) d₂.parameter →
    localDifferentialScalar p h m c (dvrResidueValue d₁ G₁) (dvrResidueValue d₁ S₁) =
      localDifferentialScalar p h m c (dvrResidueValue d₂ G₂) (dvrResidueValue d₂ S₂) := by
  letI := (Litt3.SharedTensors.schemeFunctionFieldPullback ν).toAlgebra
  intro hgalois
  letI := hgalois
  letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sB b
  letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sY y₁
  letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sY y₂
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sB b.val).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY y₁.val).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY y₂.val).toAlgebra
  intro dB d₁ d₂ G₁ S₁ G₂ S₂ c hc hG₁ hG₂ hS₁ hS₂ hpolar₁ hpolar₂ hdiff₁ hdiff₂
  have heq := actual_galois_smooth_same_source_entire_fiber_fields sT sY sG sB
    f g χ ν hf hg hχ hν hcomm b hug y₁ y₂ hb₁ hb₂ hgalois dB d₁ d₂
  exact original_dvr_completed_fields_differential_scalars_equal p h m hh hm hdiv hchar hmchar
    dB d₁ d₂ (actualSchemeFixedBaseStalkMap χ sY sB hχ b.val y₁.val hb₁)
    (actualSchemeFixedBaseStalkMap χ sY sB hχ b.val y₂.val hb₂)
    (actual_integral_fixed_base_scheme_stalk_injective χ sY sB hχ b.val y₁.val hb₁)
    (actual_integral_fixed_base_scheme_stalk_injective χ sY sB hχ b.val y₂.val hb₂)
    heq G₁ S₁ G₂ S₂ c hc hG₁ hG₂ hS₁ hS₂ hpolar₁ hpolar₂ hdiff₁ hdiff₂

end Litt3.QuotientGeometry

import Solutions.QuotientGeometry.GaloisSmoothLocalRationalScalars
import Solutions.QuotientGeometry.CommonSourceDifferentialComparison

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

open Litt3.SharedTensors

universe u

/-- In characteristic five, the ORIGINAL global polar pair G^7/F^20
and identity dG=c F^3 sigma, with sigma regular and nonvanishing
ONLY at the selected two original points, force G(R)^2 sigma_R^5 to be equal at
EVERY original fiber pair through BOTH actual maps from the SAME
smooth source. All original local Ω identities and slopes are derived. -/
theorem actual_characteristic_five_galois_local_rational_fiber_constraint
    {k : Type u} [Field k] [IsAlgClosed k]
    [CharP k 5]
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
    (b : ClosedPoint B)
    (hug : ∀ t : ClosedPoint T,
      b.val = ν (g t.val) → (g.stalkMap t.val).hom.FormallyUnramified)
    (y₁ y₂ : ClosedPoint Y)
    (hb₁ : b.val = χ y₁.val) (hb₂ : b.val = χ y₂.val) :
    letI := (schemeFunctionFieldPullback ν).toAlgebra
    IsGalois B.functionField G.functionField →
    letI := actual_smooth_curve_closed_point_dvr sB b
    letI := actual_smooth_curve_closed_point_dvr sY y₁
    letI := actual_smooth_curve_closed_point_dvr sY y₂
    letI := (stalkBaseFieldHom sB b.val).toAlgebra
    letI := (stalkBaseFieldHom sY y₁.val).toAlgebra
    letI := (stalkBaseFieldHom sY y₂.val).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI : IsScalarTower k (Y.presheaf.stalk y₁.val) Y.functionField :=
      IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sY y₁.val).symm
    letI : IsScalarTower k (Y.presheaf.stalk y₂.val) Y.functionField :=
      IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sY y₂.val).symm
    ∀ (dB : DVRCompletionParameters k (B.presheaf.stalk b.val))
      (d₁ : DVRCompletionParameters k (Y.presheaf.stalk y₁.val))
      (d₂ : DVRCompletionParameters k (Y.presheaf.stalk y₂.val))
      (G₁ : Y.presheaf.stalk y₁.val) (G₂ : Y.presheaf.stalk y₂.val)
      (Fr Gr : Y.functionField) (c : k) (sigma : KaehlerDifferential k Y.functionField),
      c ≠ 0 → IsUnit G₁ → IsUnit G₂ →
      algebraMap (Y.presheaf.stalk y₁.val) Y.functionField d₁.parameter = Fr →
      algebraMap (Y.presheaf.stalk y₂.val) Y.functionField d₂.parameter = Fr →
      algebraMap (Y.presheaf.stalk y₁.val) Y.functionField G₁ = Gr →
      algebraMap (Y.presheaf.stalk y₂.val) Y.functionField G₂ = Gr →
      schemeFunctionFieldPullback χ
          (algebraMap (B.presheaf.stalk b.val) B.functionField dB.parameter) * Gr ^ 7 =
        Fr ^ (5 * 4) →
      sigma ∈ schemeLocalRegularDifferentials sY y₁.val →
      sigma ∈ schemeLocalRegularDifferentials sY y₂.val →
      (∀ omega : KaehlerDifferential k (Y.presheaf.stalk y₁.val),
        KaehlerDifferential.map k k (Y.presheaf.stalk y₁.val) Y.functionField omega = sigma →
        omega ∉ IsLocalRing.maximalIdeal (Y.presheaf.stalk y₁.val) •
          (⊤ : Submodule (Y.presheaf.stalk y₁.val)
            (KaehlerDifferential k (Y.presheaf.stalk y₁.val)))) →
      (∀ omega : KaehlerDifferential k (Y.presheaf.stalk y₂.val),
        KaehlerDifferential.map k k (Y.presheaf.stalk y₂.val) Y.functionField omega = sigma →
        omega ∉ IsLocalRing.maximalIdeal (Y.presheaf.stalk y₂.val) •
          (⊤ : Submodule (Y.presheaf.stalk y₂.val)
            (KaehlerDifferential k (Y.presheaf.stalk y₂.val)))) →
      KaehlerDifferential.D k Y.functionField Gr =
        (algebraMap k Y.functionField c * Fr ^ (5 - 2)) • sigma →
      ∃ (S₁ : Y.presheaf.stalk y₁.val) (S₂ : Y.presheaf.stalk y₂.val),
        IsUnit S₁ ∧ IsUnit S₂ ∧
        KaehlerDifferential.map k k (Y.presheaf.stalk y₁.val) Y.functionField
          (S₁ • KaehlerDifferential.D k (Y.presheaf.stalk y₁.val) d₁.parameter) = sigma ∧
        KaehlerDifferential.map k k (Y.presheaf.stalk y₂.val) Y.functionField
          (S₂ • KaehlerDifferential.D k (Y.presheaf.stalk y₂.val) d₂.parameter) = sigma ∧
        (dvrResidueValue d₁ G₁) ^ 2 * (dvrResidueValue d₁ S₁) ^ 5 =
          (dvrResidueValue d₂ G₂) ^ 2 * (dvrResidueValue d₂ S₂) ^ 5 := by
  letI : Fact (Nat.Prime 5) := ⟨by decide⟩
  letI := (schemeFunctionFieldPullback ν).toAlgebra
  intro hgalois
  letI := hgalois
  letI := actual_smooth_curve_closed_point_dvr sB b
  letI := actual_smooth_curve_closed_point_dvr sY y₁
  letI := actual_smooth_curve_closed_point_dvr sY y₂
  letI := (stalkBaseFieldHom sB b.val).toAlgebra
  letI := (stalkBaseFieldHom sY y₁.val).toAlgebra
  letI := (stalkBaseFieldHom sY y₂.val).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI : IsScalarTower k (Y.presheaf.stalk y₁.val) Y.functionField :=
    IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sY y₁.val).symm
  letI : IsScalarTower k (Y.presheaf.stalk y₂.val) Y.functionField :=
    IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sY y₂.val).symm
  intro dB d₁ d₂ G₁ G₂ Fr Gr c sigma hc hG₁ hG₂ hF₁ hF₂ hrG₁ hrG₂
    hpolar hregular₁ hregular₂ hnonzero₁ hnonzero₂ hdiff
  obtain ⟨S₁, S₂, hS₁, hS₂, hmap₁, hmap₂, heq⟩ :=
    actual_galois_smooth_local_rational_differential_scalars_equal 5 4 7 (by decide) (by decide)
      (by decide) (by decide) sT sY sG sB f g χ ν hf hg hχ hν hcomm b hug y₁ y₂ hb₁ hb₂
      hgalois dB d₁ d₂ G₁ G₂ Fr Gr c sigma hc hG₁ hG₂ hF₁ hF₂ hrG₁ hrG₂ hpolar
      hregular₁ hregular₂ hnonzero₁ hnonzero₂ hdiff
  refine ⟨S₁, S₂, hS₁, hS₂, hmap₁, hmap₂, ?_⟩
  exact (characteristic_five_local_scalars_equal_iff c
    (dvrResidueValue d₁ G₁) (dvrResidueValue d₂ G₂)
    (dvrResidueValue d₁ S₁) (dvrResidueValue d₂ S₂) hc
    (dvrResidueValue_unit_nonzero d₁ G₁ hG₁)
    (dvrResidueValue_unit_nonzero d₂ G₂ hG₂)
    (dvrResidueValue_unit_nonzero d₁ S₁ hS₁)
    (dvrResidueValue_unit_nonzero d₂ S₂ hS₂)).mp heq

end Litt3.QuotientGeometry

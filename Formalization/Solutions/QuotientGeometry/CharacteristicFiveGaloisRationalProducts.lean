import Solutions.QuotientGeometry.CharacteristicFiveGaloisLocalRational
import Solutions.QuotientGeometry.RationalCoordinateDifferentialProduct
import Solutions.QuotientGeometry.CoordinateDifferentialConstraints
import Solutions.QuotientGeometry.CommonSourceDifferentialComparison

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

open Litt3.SharedTensors

universe u

/-- In characteristic five, the ORIGINAL global polar pair G^7/F^20
and identity dG=c F^3 sigma, with sigma regular and nonvanishing
ONLY at the selected two original points, force G(R)^2 sigma_R^5 to be equal at
EVERY original fiber pair through BOTH actual maps from the SAME
smooth source. The genuine rational field coordinate derivations and original unit
products y F_z are DERIVED. Neither rational factor is individually
evaluated; Weierstrass points are allowed and F is arbitrary. -/
theorem actual_characteristic_five_galois_rational_coordinate_product_fiber_constraint
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
      (z₁ z₂ a₁ a₂ : Y.functionField)
      (Fr Gr : Y.functionField) (c : k) (sigma : KaehlerDifferential k Y.functionField),
      a₁ ≠ 0 → a₂ ≠ 0 → c ≠ 0 → IsUnit G₁ → IsUnit G₂ →
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
      sigma = a₁⁻¹ • KaehlerDifferential.D k Y.functionField z₁ →
      sigma = a₂⁻¹ • KaehlerDifferential.D k Y.functionField z₂ →
      ∃ (W₁ : (Y.presheaf.stalk y₁.val)ˣ) (W₂ : (Y.presheaf.stalk y₂.val)ˣ)
        (D₁ D₂ : Derivation k Y.functionField Y.functionField),
        D₁ z₁ = 1 ∧ D₂ z₂ = 1 ∧
        algebraMap (Y.presheaf.stalk y₁.val) Y.functionField W₁.val = a₁ * D₁ Fr ∧
        algebraMap (Y.presheaf.stalk y₂.val) Y.functionField W₂.val = a₂ * D₂ Fr ∧
        (dvrResidueValue d₁ W₁.val) ^ 5 / (dvrResidueValue d₁ G₁) ^ 2 =
          (dvrResidueValue d₂ W₂.val) ^ 5 / (dvrResidueValue d₂ G₂) ^ 2 := by
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
  intro dB d₁ d₂ G₁ G₂ z₁ z₂ a₁ a₂ Fr Gr c sigma ha₁ ha₂ hc hG₁ hG₂ hF₁ hF₂ hrG₁ hrG₂
    hpolar hregular₁ hregular₂ hnonzero₁ hnonzero₂ hdiff hcoordinate₁ hcoordinate₂
  obtain ⟨S₁, S₂, hS₁, hS₂, hmap₁, hmap₂, heq⟩ :=
    actual_characteristic_five_galois_local_rational_fiber_constraint
      sT sY sG sB f g χ ν hf hg hχ hν hcomm b hug y₁ y₂ hb₁ hb₂
      hgalois dB d₁ d₂ G₁ G₂ Fr Gr c sigma hc hG₁ hG₂ hF₁ hF₂ hrG₁ hrG₂ hpolar
      hregular₁ hregular₂ hnonzero₁ hnonzero₂ hdiff
  obtain ⟨r₁, W₁, D₁, hDz₁, hprod₁, hmapr₁, hratio₁⟩ :=
    actual_smooth_curve_rational_coordinate_differential_product (p := 5) sY y₁
      d₁ z₁ a₁ sigma ha₁ hregular₁ hnonzero₁ hcoordinate₁
  obtain ⟨r₂, W₂, D₂, hDz₂, hprod₂, hmapr₂, hratio₂⟩ :=
    actual_smooth_curve_rational_coordinate_differential_product (p := 5) sY y₂
      d₂ z₂ a₂ sigma ha₂ hregular₂ hnonzero₂ hcoordinate₂
  obtain ⟨e₁, he₁⟩ := actual_smooth_curve_original_parameter_differential_frame (p := 5) sY y₁ d₁
  obtain ⟨e₂, he₂⟩ := actual_smooth_curve_original_parameter_differential_frame (p := 5) sY y₂ d₂
  have hSr₁ : S₁ = r₁.val :=
    original_differential_frame_coefficient_injective d₁.parameter e₁ he₁
      (actual_smooth_stalk_differential_map_injective sY 1 y₁.val (hmap₁.trans hmapr₁.symm))
  have hSr₂ : S₂ = r₂.val :=
    original_differential_frame_coefficient_injective d₂.parameter e₂ he₂
      (actual_smooth_stalk_differential_map_injective sY 1 y₂.val (hmap₂.trans hmapr₂.symm))
  refine ⟨W₁, W₂, D₁, D₂, hDz₁, hDz₂, ?_, ?_, ?_⟩
  · simpa only [hF₁] using hprod₁
  · simpa only [hF₂] using hprod₂
  · have h := (coordinate_power_fiber_constraint_iff 5
      (dvrResidueValue d₁ G₁) (dvrResidueValue d₂ G₂)
      (dvrResidueValue d₁ S₁) (dvrResidueValue d₂ S₂)
      (dvrResidueValue d₁ W₁.val) (dvrResidueValue d₂ W₂.val) 1 1
      (dvrResidueValue_unit_nonzero d₁ G₁ hG₁)
      (dvrResidueValue_unit_nonzero d₂ G₂ hG₂)
      (dvrResidueValue_unit_nonzero d₁ W₁.val W₁.isUnit)
      (dvrResidueValue_unit_nonzero d₂ W₂.val W₂.isUnit)
      one_ne_zero one_ne_zero
      (by rw [hSr₁]; simpa using hratio₁)
      (by rw [hSr₂]; simpa using hratio₂)).mp heq
    simpa only [mul_one] using h

end Litt3.QuotientGeometry

import Solutions.QuotientGeometry.GaloisSmoothSameSourceScalars
import Solutions.QuotientGeometry.SmoothGlobalDifferentialIdentities
import Solutions.QuotientGeometry.RationalPolarStalkIdentities

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

open Litt3.SharedTensors

universe u

/-- The ORIGINAL global rational F,G,sigma data force equality of the
actual weak scalar throughout an original fiber of a genuine same-source
smooth-curve diagram. The original local polar and Ω identities and unit
slopes are DERIVED. Only the true rational restrictions, simple-zero
uniformizers and actual residue-fiber nonvanishing represent local data. -/
theorem actual_galois_smooth_global_differential_scalars_equal
    {k : Type u} [Field k] [IsAlgClosed k]
    (p h m : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hm : 0 < m) (hdiv : h ∣ p - 1) (hmp : Nat.Coprime m p)
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
          (algebraMap (B.presheaf.stalk b.val) B.functionField dB.parameter) * Gr ^ m =
        Fr ^ (p * h) →
      sigma ∈ schemeGlobalRegularDifferentials sY →
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
        (algebraMap k Y.functionField c * Fr ^ (p - 2)) • sigma →
      ∃ (S₁ : Y.presheaf.stalk y₁.val) (S₂ : Y.presheaf.stalk y₂.val),
        IsUnit S₁ ∧ IsUnit S₂ ∧
        KaehlerDifferential.map k k (Y.presheaf.stalk y₁.val) Y.functionField
          (S₁ • KaehlerDifferential.D k (Y.presheaf.stalk y₁.val) d₁.parameter) = sigma ∧
        KaehlerDifferential.map k k (Y.presheaf.stalk y₂.val) Y.functionField
          (S₂ • KaehlerDifferential.D k (Y.presheaf.stalk y₂.val) d₂.parameter) = sigma ∧
        localDifferentialScalar p h m c (dvrResidueValue d₁ G₁) (dvrResidueValue d₁ S₁) =
          localDifferentialScalar p h m c (dvrResidueValue d₂ G₂) (dvrResidueValue d₂ S₂) := by
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
    hpolar hregular hnonzero₁ hnonzero₂ hdiff
  obtain ⟨S₁, hS₁, hmap₁, hdiff₁⟩ :=
    actual_smooth_curve_global_differential_identity_unit_slope (p := p) sY y₁
      d₁ G₁ c sigma hregular hnonzero₁ (by rw [hrG₁, hF₁]; exact hdiff)
  obtain ⟨S₂, hS₂, hmap₂, hdiff₂⟩ :=
    actual_smooth_curve_global_differential_identity_unit_slope (p := p) sY y₂
      d₂ G₂ c sigma hregular hnonzero₂ (by rw [hrG₂, hF₂]; exact hdiff)
  have hpolar₁ := actual_global_polar_pair_identity_descends χ sY sB hχ b.val y₁.val hb₁
    dB.parameter G₁ d₁.parameter m (p * h) Gr Fr hrG₁ hF₁ hpolar
  have hpolar₂ := actual_global_polar_pair_identity_descends χ sY sB hχ b.val y₂.val hb₂
    dB.parameter G₂ d₂.parameter m (p * h) Gr Fr hrG₂ hF₂ hpolar
  have hp : p.Prime := Fact.out
  have hp1 : 1 < p := hp.one_lt
  have hchar : (h : k) ≠ 0 := by
    apply (CharP.cast_eq_zero_iff k p h).not.mpr
    apply Nat.not_dvd_of_pos_of_lt hh
    have hle := Nat.le_of_dvd (by omega : 0 < p - 1) hdiv
    omega
  have hmchar : (m : k) ≠ 0 :=
    (CharP.cast_eq_zero_iff k p m).not.mpr (hp.coprime_iff_not_dvd.mp hmp.symm)
  refine ⟨S₁, S₂, hS₁, hS₂, hmap₁, hmap₂, ?_⟩
  exact actual_galois_smooth_same_source_entire_fiber_scalars_equal p h m hh hm hdiv hchar
    hmchar sT sY sG sB f g χ ν hf hg hχ hν hcomm b hug y₁ y₂ hb₁ hb₂ hgalois
    dB d₁ d₂ G₁ S₁ G₂ S₂ c hc hG₁ hG₂ hS₁ hS₂ hpolar₁ hpolar₂ hdiff₁ hdiff₂

end Litt3.QuotientGeometry

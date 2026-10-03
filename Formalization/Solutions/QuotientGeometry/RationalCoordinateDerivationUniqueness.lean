import Solutions.QuotientGeometry.RationalCoordinateDifferentialProduct
import Solutions.QuotientGeometry.CoordinateDifferentialConstraints

namespace Litt3.QuotientGeometry

/-- The field derivation d/dz is unique. In particular the rational
product y F_z constructed from any original parameter is intrinsic;
neither rational factor must belong to the original local ring. -/
theorem rational_coordinate_derivation_unique
    {k K : Type*} [Field k] [Field K] [Algebra k K]
    (t z : K) (eK : KaehlerDifferential k K ≃ₗ[K] K)
    (heK : eK (KaehlerDifferential.D k K t) = 1)
    (D₁ D₂ : Derivation k K K) (hD₁ : D₁ z = 1) (hD₂ : D₂ z = 1) :
    D₁ = D₂ := by
  have he : ∀ r : K, eK.symm r = r • KaehlerDifferential.D k K t := by
    intro r
    apply eK.injective
    simp [heK]
  have hz : KaehlerDifferential.D k K z =
      eK (KaehlerDifferential.D k K z) • KaehlerDifferential.D k K t := by
    apply eK.injective
    simp [heK]
  have hq : eK (KaehlerDifferential.D k K z) ≠ 0 := by
    intro hzero
    have hd := congrArg D₁.liftKaehlerDifferential hz
    simp only [Derivation.liftKaehlerDifferential_comp_D, map_smul,
      hD₁, hzero, zero_smul] at hd
    exact one_ne_zero hd
  exact original_coordinate_derivation_unique t z eK.symm he
    (Units.mk0 _ hq) hz D₁ D₂ hD₁ hD₂

end Litt3.QuotientGeometry

import Solutions.SharedTensors.PBasisDerivation
import Mathlib.RingTheory.Kaehler.Basic

namespace Litt3.SharedTensors

variable {k K M : Type*} [CommRing k] [Field K] [Algebra k K]
variable [AddCommGroup M] [Module K M] [Module k M]
variable {p : ℕ} [Fact p.Prime] [CharP K p]

/-- Every derivation into any actual module is determined by dt through
the entire literal p-basis expansion. -/
theorem derivation_p_basis_module_expansion
    (b : PowerPBasis K p) (D : Derivation k K M) (a : K) :
    D a = (∑ i : Fin p,
      pRootCoefficient K p b a i ^ p * (i.val : K) * b.parameter ^ (i.val - 1)) •
      D b.parameter := by
  conv_lhs => rw [← p_basis_actual_expansion b a]
  rw [map_sum, Finset.sum_smul]
  apply Finset.sum_congr rfl
  intro i _
  have hpzero : D (pRootCoefficient K p b a i ^ p) = 0 := by
    rw [D.leibniz_pow, ← Nat.cast_smul_eq_nsmul K, CharP.cast_eq_zero K p, zero_smul]
  rw [D.leibniz, hpzero, smul_zero, add_zero, D.leibniz_pow,
    ← Nat.cast_smul_eq_nsmul K, smul_smul, smul_smul]

/-- A genuine full p-basis constructs the coordinate of the actual
universal differential module over the actual p-th powers. Rank one is
a conclusion, rather than an assumed replacement for this module. -/
theorem normalized_p_basis_kaehler_coordinate_exists
    (b : PowerPBasis K p) (D : Derivation k K K) (ht : D b.parameter = 1) :
    ∃ e : KaehlerDifferential k K ≃ₗ[K] K,
      e (KaehlerDifferential.D k K b.parameter) = 1 := by
  let dt := KaehlerDifferential.D k K b.parameter
  let f := D.liftKaehlerDifferential
  let g := LinearMap.toSpanSingleton K
    (KaehlerDifferential k K) dt
  have hfg : f.comp g = LinearMap.id := by
    apply LinearMap.ext
    intro a
    change f (a • dt) = a
    rw [map_smul]
    change a * D.liftKaehlerDifferential
      (KaehlerDifferential.D k K b.parameter) = a
    rw [Derivation.liftKaehlerDifferential_comp_D, ht, mul_one]
  have hgf : g.comp f = LinearMap.id := by
    apply Derivation.liftKaehlerDifferential_unique
    ext a
    change (D.liftKaehlerDifferential
      (KaehlerDifferential.D k K a)) • dt = KaehlerDifferential.D k K a
    rw [Derivation.liftKaehlerDifferential_comp_D]
    have hD := derivation_p_basis_module_expansion b D a
    rw [ht, smul_eq_mul, mul_one] at hD
    rw [hD]
    exact (derivation_p_basis_module_expansion b
      (KaehlerDifferential.D k K) a).symm
  refine ⟨LinearEquiv.ofLinear f g hfg hgf, ?_⟩
  change D.liftKaehlerDifferential
    (KaehlerDifferential.D k K b.parameter) = 1
  rw [Derivation.liftKaehlerDifferential_comp_D]
  exact ht

/-- The literal p-basis supplies its own normalized derivation over the
actual p-th powers, and hence its genuine differential coordinate. -/
theorem p_basis_kaehler_coordinate_exists (b : PowerPBasis K p) :
    ∃ e : KaehlerDifferential (frobeniusSubfield K p) K ≃ₗ[K] K,
      e (KaehlerDifferential.D (frobeniusSubfield K p) K b.parameter) = 1 := by
  obtain ⟨D, ht⟩ := p_basis_normalized_derivation_exists b
  exact normalized_p_basis_kaehler_coordinate_exists b D ht

end Litt3.SharedTensors

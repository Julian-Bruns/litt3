import Solutions.SharedTensors.PBasisKaehler
import Mathlib.FieldTheory.Perfect

namespace Litt3.SharedTensors

variable {k K : Type*} [CommRing k] [Field K] [Algebra k K]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p] [PerfectRing k p]

/-- Actual constants from a perfect base are actual p-th powers in the
extension. The extension itself need not be perfect. -/
theorem perfect_base_constant_is_pth_power (c : k) :
    ∃ a : K, a ^ p = algebraMap k K c := by
  refine ⟨algebraMap k K ((frobeniusEquiv k p).symm c), ?_⟩
  rw [← map_pow, frobeniusEquiv_symm_pow_p]

/-- A derivation over the actual p-th powers can be rebased to the actual
perfect constant field, using its literal algebra map. -/
noncomputable def pthDerivationOverPerfectBase
    (D : Derivation (frobeniusSubfield K p) K K) : Derivation k K K where
  toFun := D
  map_add' := D.map_add
  map_smul' c a := by
    obtain ⟨r, hr⟩ := perfect_base_constant_is_pth_power (K := K) c
    have hzero : D (algebraMap k K c) = 0 := by
      rw [← hr, D.leibniz_pow, nsmul_eq_mul, CharP.cast_eq_zero K p, zero_mul]
    rw [Algebra.smul_def, D.leibniz, hzero, smul_zero, add_zero, Algebra.smul_def]
    simp only [RingHom.id_apply, Algebra.algebraMap_self, Algebra.smul_def]
  map_one_eq_zero' := D.map_one_eq_zero
  leibniz' := D.leibniz

/-- A literal p-basis alone supplies its normalized actual derivation
over any perfect base field or perfect base ring. -/
theorem p_basis_perfect_base_derivation_exists (b : PowerPBasis K p) :
    ∃ D : Derivation k K K, D b.parameter = 1 := by
  obtain ⟨D, ht⟩ := p_basis_normalized_derivation_exists b
  exact ⟨pthDerivationOverPerfectBase (k := k) D, ht⟩

/-- The actual rational Kähler module over the perfect constants has
rank one as a consequence of the literal full p-basis. -/
theorem p_basis_perfect_base_kaehler_coordinate_exists (b : PowerPBasis K p) :
    ∃ e : KaehlerDifferential k K ≃ₗ[K] K,
      e (KaehlerDifferential.D k K b.parameter) = 1 := by
  obtain ⟨D, ht⟩ := p_basis_perfect_base_derivation_exists (k := k) b
  exact normalized_p_basis_kaehler_coordinate_exists b D ht

end Litt3.SharedTensors

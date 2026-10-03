import Definitions.SharedTensors.RationalCartier
import Solutions.SharedTensors.FrobeniusCoordinates

namespace Litt3.SharedTensors

variable {k K : Type*} [CommRing k] [Field K] [Algebra k K]
variable {p : ℕ} [Fact p.Prime] [CharP K p]

/-- Exactness kills every parameter monomial below the Cartier digit. -/
theorem RationalCartierOperator.parameter_power_small
    (C : RationalCartierOperator k K p) (t : K) (n : ℕ) (hn : n < p - 1) :
    C.toAddHom (t ^ n • KaehlerDifferential.D k K t) = 0 := by
  have hnp : n + 1 < p := by omega
  have hcast : (n + 1 : K) ^ p = (n + 1 : K) := by
    have h : frobenius K p ((n + 1 : ℕ) : K) = ((n + 1 : ℕ) : K) := by
      simp only [map_natCast]
    simpa only [frobenius_def, Nat.cast_add, Nat.cast_one] using h
  have hnonzero : (n + 1 : K) ≠ 0 := by
    rw [← Nat.cast_add_one]
    exact (CharP.cast_eq_zero_iff K p (n + 1)).not.mpr
      (Nat.not_dvd_of_pos_of_lt (by omega) hnp)
  have hD : KaehlerDifferential.D k K (t ^ (n + 1)) =
      (n + 1 : K) ^ p • (t ^ n • KaehlerDifferential.D k K t) := by
    rw [(KaehlerDifferential.D k K).leibniz_pow,
      ← Nat.cast_smul_eq_nsmul K, Nat.add_sub_cancel, hcast]
    simp only [Nat.cast_add, Nat.cast_one]
  have h := C.kills_exact (t ^ (n + 1))
  rw [hD, C.pth_semilinear] at h
  exact (smul_eq_zero.mp h).resolve_left hnonzero

/-- Logarithmic fixedness computes the highest p-basis digit. -/
theorem RationalCartierOperator.parameter_power_top
    (C : RationalCartierOperator k K p) (t : K) (ht : t ≠ 0) :
    C.toAddHom (t ^ (p - 1) • KaehlerDifferential.D k K t) =
      KaehlerDifferential.D k K t := by
  have hp : 1 ≤ p := (Fact.out : p.Prime).pos
  have hpower : t ^ p * t⁻¹ = t ^ (p - 1) := by
    rw [← Nat.sub_add_cancel hp, pow_succ, mul_assoc, mul_inv_cancel₀ ht, mul_one]
    rw [Nat.add_sub_cancel]
  calc
    _ = C.toAddHom (t ^ p • (t⁻¹ • KaehlerDifferential.D k K t)) := by
      rw [smul_smul, hpower]
    _ = t • (t⁻¹ • KaehlerDifferential.D k K t) := by
      rw [C.pth_semilinear, C.fixes_logarithmic]
    _ = _ := by rw [smul_smul, mul_inv_cancel₀ ht, one_smul]

/-- The standard intrinsic Cartier characterization forces its complete
p-basis formula on every actual rational differential a dt. -/
theorem RationalCartierOperator.p_basis_formula
    (C : RationalCartierOperator k K p) (b : PowerPBasis K p)
    (ht : b.parameter ≠ 0) (a : K) :
    C.toAddHom (a • KaehlerDifferential.D k K b.parameter) =
      rationalCartierCoefficient K p b a • KaehlerDifferential.D k K b.parameter := by
  let top : Fin p := ⟨p - 1, Nat.sub_lt (Fact.out : p.Prime).pos (by decide)⟩
  calc
    _ = ∑ i : Fin p, pRootCoefficient K p b a i •
        C.toAddHom (b.parameter ^ i.val • KaehlerDifferential.D k K b.parameter) := by
      conv_lhs => rw [← p_basis_actual_expansion b a]
      rw [Finset.sum_smul, map_sum]
      apply Finset.sum_congr rfl
      intro i _
      rw [mul_smul, C.pth_semilinear]
    _ = pRootCoefficient K p b a top • KaehlerDifferential.D k K b.parameter := by
      rw [Finset.sum_eq_single top]
      · exact congrArg (fun omega => pRootCoefficient K p b a top • omega)
          (C.parameter_power_top b.parameter ht)
      · intro i _ hi
        have hilast : i.val < p - 1 := by
          have hine : i.val ≠ p - 1 := by
            intro h
            apply hi
            exact Fin.ext h
          omega
        rw [C.parameter_power_small b.parameter _ hilast, smul_zero]
      · intro h
        exact (h (Finset.mem_univ top)).elim
    _ = _ := rfl

/-- The formula is on the actual universal differential module; the
chosen coordinate is normalized by the actual dt, not an assumed proxy. -/
theorem RationalCartierOperator.coordinate_formula
    (C : RationalCartierOperator k K p) (b : PowerPBasis K p)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hnormalized : e (KaehlerDifferential.D k K b.parameter) = 1)
    (omega : KaehlerDifferential k K) :
    e (C.toAddHom omega) = rationalCartierCoefficient K p b (e omega) := by
  have ht : b.parameter ≠ 0 := by
    intro h
    rw [h, map_zero, map_zero] at hnormalized
    exact zero_ne_one hnormalized
  have hframe : omega = e omega • KaehlerDifferential.D k K b.parameter := by
    apply e.injective
    rw [map_smul, hnormalized, smul_eq_mul, mul_one]
  rw [hframe, C.p_basis_formula b ht, map_smul, hnormalized, smul_eq_mul, mul_one]
  rw [map_smul, hnormalized, smul_eq_mul, mul_one]

/-- A full p-basis proves uniqueness of any intrinsic Cartier operator
satisfying the standard properties. Parameter independence follows from
this uniqueness, once existence is supplied or constructed. -/
theorem rational_cartier_intrinsic_unique
    (C C' : RationalCartierOperator k K p) (b : PowerPBasis K p)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hnormalized : e (KaehlerDifferential.D k K b.parameter) = 1) :
    C.toAddHom = C'.toAddHom := by
  apply AddMonoidHom.ext
  intro omega
  apply e.injective
  rw [C.coordinate_formula b e hnormalized, C'.coordinate_formula b e hnormalized]

end Litt3.SharedTensors

import Solutions.SharedTensors.RationalCartierExact
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k K : Type*} [CommRing k] [Field K] [Algebra k K]
variable {p : ℕ} [Fact p.Prime] [CharP K p]

theorem p_root_derivation_term_coefficient (b : PowerPBasis K p) (a : K)
    (i j : Fin p) :
    pRootCoefficient K p b
      (pRootCoefficient K p b a i ^ p * (i.val : K) * b.parameter ^ (i.val - 1)) j =
      pRootCoefficient K p b a i * (i.val : K) *
        (if i.val - 1 = j.val then 1 else 0) := by
  have hcast : (i.val : K) ^ p = (i.val : K) := by
    change frobenius K p (i.val : K) = (i.val : K)
    simp only [map_natCast]
  rw [mul_assoc, pRootCoefficient_pth_mul b, ← hcast, pRootCoefficient_pth_mul b]
  have hlt : i.val - 1 < p := by omega
  rw [pRootCoefficient_parameter_power b j ⟨i.val - 1, hlt⟩]
  simp only [Fin.ext_iff, mul_assoc, hcast]

/-- A normalized actual derivation has exactly the actual p-th powers
as its kernel whenever the field has a genuine full one-parameter
p-basis. Perfectness is unnecessary. -/
theorem normalized_p_basis_derivation_zero_iff_pth_power
    (b : PowerPBasis K p) (D : Derivation k K K) (ht : D b.parameter = 1) (a : K) :
    D a = 0 ↔ ∃ root : K, root ^ p = a := by
  constructor
  · intro hDa
    have hcoeff : ∀ i : Fin p, 0 < i.val → pRootCoefficient K p b a i = 0 := by
      intro i hi
      let j : Fin p := ⟨i.val - 1, by omega⟩
      let f : K →+ K := {
        toFun := fun z => pRootCoefficient K p b z j
        map_zero' := pRootCoefficient_zero b j
        map_add' := fun x y => pRootCoefficient_add b x y j }
      have heq := congrArg f (derivation_p_basis_expansion b D ht a)
      rw [map_sum] at heq
      change pRootCoefficient K p b (D a) j =
        ∑ l : Fin p, pRootCoefficient K p b
          (pRootCoefficient K p b a l ^ p * (l.val : K) * b.parameter ^ (l.val - 1)) j at heq
      simp_rw [p_root_derivation_term_coefficient] at heq
      rw [hDa, pRootCoefficient_zero] at heq
      have hsum : (∑ l : Fin p, pRootCoefficient K p b a l * (l.val : K) *
          (if l.val - 1 = j.val then 1 else 0)) =
          pRootCoefficient K p b a i * (i.val : K) := by
        rw [Finset.sum_eq_single i]
        · simp [j]
        · intro l _ hli
          by_cases hl : l.val = 0
          · simp [hl]
          · have hne : l.val ≠ i.val := fun h => hli (Fin.ext h)
            have hdiff : l.val - 1 ≠ j.val := by dsimp only [j]; omega
            simp [hdiff]
        · simp
      have hcast : (i.val : K) ≠ 0 :=
        (CharP.cast_eq_zero_iff K p i.val).not.mpr
          (Nat.not_dvd_of_pos_of_lt hi i.isLt)
      exact (mul_eq_zero.mp (by rw [← hsum]; exact heq.symm)).resolve_right hcast
    let zeroIndex : Fin p := ⟨0, (Fact.out : p.Prime).pos⟩
    refine ⟨pRootCoefficient K p b a zeroIndex, ?_⟩
    conv_rhs => rw [← p_basis_actual_expansion b a]
    rw [Finset.sum_eq_single zeroIndex]
    · simp only [zeroIndex, pow_zero, mul_one]
    · intro i _ hne
      have hi : 0 < i.val := by
        have hval : i.val ≠ 0 := fun h => hne (Fin.ext h)
        omega
      rw [hcoeff i hi]
      simp [(Fact.out : p.Prime).ne_zero]
    · simp
  · rintro ⟨root, rfl⟩
    rw [D.leibniz_pow, nsmul_eq_mul, smul_eq_mul, CharP.cast_eq_zero K p, zero_mul]

end Litt3.CartierAndSpin

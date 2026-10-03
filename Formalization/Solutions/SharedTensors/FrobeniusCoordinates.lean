import Definitions.SharedTensors.FrobeniusCoordinates

namespace Litt3.SharedTensors

open Module

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

@[simp] theorem frobeniusImageEquiv_coe (a : K) :
    (frobeniusImageEquiv K p a : K) = a ^ p := rfl

@[simp] theorem pRootCoefficient_pow (b : PowerPBasis K p) (a : K) (i : Fin p) :
    pRootCoefficient K p b a i ^ p = (b.basis.repr a i : K) := by
  exact (frobenius K p).rangeRestrictFieldEquiv_apply_symm_apply _

theorem p_basis_actual_expansion (b : PowerPBasis K p) (a : K) :
    ∑ i : Fin p, pRootCoefficient K p b a i ^ p * b.parameter ^ i.val = a := by
  simpa only [pRootCoefficient_pow, ← b.basis_eq_power, Subfield.smul_def]
    using b.basis.sum_repr a

theorem p_basis_actual_expansion_unique (b : PowerPBasis K p)
    (a : K) (c : Fin p → K)
    (hc : ∑ i : Fin p, c i ^ p * b.parameter ^ i.val = a) :
    ∀ i, c i = pRootCoefficient K p b a i := by
  intro i
  apply (frobeniusImageEquiv K p).injective
  rw [pRootCoefficient, RingEquiv.apply_symm_apply]
  have hc' : ∑ j : Fin p, (frobeniusImageEquiv K p (c j)) • b.basis j = a := by
    simpa only [Subfield.smul_def, frobeniusImageEquiv_coe, b.basis_eq_power] using hc
  rw [← hc', b.basis.repr_sum_self]

@[simp] theorem pRootCoefficient_add (b : PowerPBasis K p) (a c : K) (i : Fin p) :
    pRootCoefficient K p b (a + c) i =
      pRootCoefficient K p b a i + pRootCoefficient K p b c i := by
  simp [pRootCoefficient]

@[simp] theorem pRootCoefficient_zero (b : PowerPBasis K p) (i : Fin p) :
    pRootCoefficient K p b 0 i = 0 := by simp [pRootCoefficient]

theorem pRootCoefficient_pth_mul (b : PowerPBasis K p) (a c : K) (i : Fin p) :
    pRootCoefficient K p b (c ^ p * a) i = c * pRootCoefficient K p b a i := by
  have h : c ^ p * a = (frobeniusImageEquiv K p c) • a := rfl
  rw [h]
  simp [pRootCoefficient]

theorem rationalCartierCoefficient_add (b : PowerPBasis K p) (a c : K) :
    rationalCartierCoefficient K p b (a + c) =
      rationalCartierCoefficient K p b a + rationalCartierCoefficient K p b c :=
  pRootCoefficient_add b a c _

theorem rationalCartierCoefficient_pth_mul (b : PowerPBasis K p) (a c : K) :
    rationalCartierCoefficient K p b (c ^ p * a) =
      c * rationalCartierCoefficient K p b a :=
  pRootCoefficient_pth_mul b a c _

end Litt3.SharedTensors

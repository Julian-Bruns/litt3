import Mathlib.LinearAlgebra.FreeModule.Basic
import Mathlib.Data.ZMod.Basic

namespace Litt3.Deformations

/-- The exact top-power annihilator in the literal p-power integer
quotient is its actual p-multiple image. No prime enumeration is used. -/
theorem zmod_last_power_annihilator (p a : ℕ) (positive : 0 < p)
    (x : ZMod (p ^ (a + 1))) :
    (p : ZMod (p ^ (a + 1))) ^ a * x = 0 ↔
      ∃ y : ZMod (p ^ (a + 1)), (p : ZMod (p ^ (a + 1))) * y = x := by
  letI : NeZero (p ^ (a + 1)) := ⟨Nat.ne_of_gt (pow_pos positive _)⟩
  constructor
  · intro zero
    have divisible : p ^ a * p ∣ p ^ a * x.val := by
      rw [← pow_succ]
      apply (ZMod.natCast_eq_zero_iff _ _).mp
      simpa only [Nat.cast_mul, Nat.cast_pow, ZMod.natCast_zmod_val] using zero
    have lower : p ∣ x.val := (Nat.mul_dvd_mul_iff_left (pow_pos positive a)).mp divisible
    obtain ⟨y, hy⟩ := lower
    refine ⟨(y : ZMod (p ^ (a + 1))), ?_⟩
    rw [← Nat.cast_mul, ← hy, ZMod.natCast_zmod_val]
  · rintro ⟨y, rfl⟩
    rw [← mul_assoc, ← pow_succ]
    have zero : (p : ZMod (p ^ (a + 1))) ^ (a + 1) = 0 := by
      rw [← Nat.cast_pow]
      exact (ZMod.natCast_eq_zero_iff _ _).mpr dvd_rfl
    rw [zero, zero_mul]

variable {R M : Type*} [CommRing R] [AddCommGroup M] [Module R M] [Module.Free R M]

/-- A literal ring annihilator relation extends to every actual free
module, including infinite rank, using only each vector's finite
basis support rather than finite-dimensional counting. -/
theorem free_module_scalar_kernel_from_ring (r s : R)
    (relation : ∀ x : R, r * x = 0 ↔ ∃ y : R, s * y = x) :
    LinearMap.ker (r • (LinearMap.id : M →ₗ[R] M)) =
      LinearMap.range (s • (LinearMap.id : M →ₗ[R] M)) := by
  classical
  let b := Module.Free.chooseBasis R M
  ext v
  constructor
  · intro zero
    have zero : r • v = 0 := zero
    have coordinates : ∀ i, ∃ y : R, s * y = b.repr v i := by
      intro i
      apply (relation _).mp
      have same := congrArg (fun w => b.repr w i) zero
      simpa only [map_smul, Finsupp.smul_apply, smul_eq_mul, map_zero,
        Finsupp.zero_apply] using same
    choose y preimage using coordinates
    refine ⟨∑ i ∈ (b.repr v).support, y i • b i, ?_⟩
    change s • (∑ i ∈ (b.repr v).support, y i • b i) = v
    rw [Finset.smul_sum]
    simp_rw [smul_smul, preimage]
    simpa only [Finsupp.linearCombination_apply, Finsupp.sum] using b.linearCombination_repr v
  · rintro ⟨v, rfl⟩
    change r • (s • v) = 0
    rw [smul_smul]
    have zero : r * s = 0 := (relation s).mpr ⟨1, mul_one s⟩
    rw [zero, zero_smul]

/-- The literal p-power free coefficient module has precisely the
top-power annihilator required for the unrestricted norm obstruction. -/
theorem free_zmod_last_power_kernel (p a : ℕ) (positive : 0 < p)
    (M : Type*) [AddCommGroup M] [Module (ZMod (p ^ (a + 1))) M]
    [Module.Free (ZMod (p ^ (a + 1))) M] :
    LinearMap.ker ((p : ZMod (p ^ (a + 1))) ^ a • (LinearMap.id : M →ₗ[ZMod (p ^ (a + 1))] M)) =
      LinearMap.range ((p : ZMod (p ^ (a + 1))) • (LinearMap.id : M →ₗ[ZMod (p ^ (a + 1))] M)) :=
  free_module_scalar_kernel_from_ring _ _ (zmod_last_power_annihilator p a positive)

end Litt3.Deformations

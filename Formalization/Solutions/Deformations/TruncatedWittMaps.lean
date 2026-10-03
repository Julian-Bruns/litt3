import Mathlib.RingTheory.WittVector.Truncated
import Mathlib.RingTheory.WittVector.Frobenius
import Mathlib.RingTheory.WittVector.Identities
import Mathlib.Algebra.Module.ZMod

namespace Litt3.Deformations

open TruncatedWittVector

/-- The actual truncated Witt ring map induced by a base ring map.
Its well-definedness is proved from the literal truncation kernel. -/
noncomputable def truncatedWittMap (p N : ℕ) [Fact p.Prime]
    {k l : Type*} [CommRing k] [CommRing l] (φ : k →+* l) :
    TruncatedWittVector p N k →+* TruncatedWittVector p N l :=
  RingHom.liftOfRightInverse (WittVector.truncate N) TruncatedWittVector.out
    TruncatedWittVector.truncateFun_out
    ⟨(WittVector.truncate N).comp (WittVector.map φ), by
      intro x
      simp only [WittVector.mem_ker_truncate]
      intro zero
      change WittVector.map φ x ∈ RingHom.ker (WittVector.truncate N)
      rw [WittVector.mem_ker_truncate]
      intro i bound
      change φ (x.coeff i) = 0
      rw [zero i bound, map_zero]⟩

@[simp] theorem truncated_witt_map_truncate (p N : ℕ) [Fact p.Prime]
    {k l : Type*} [CommRing k] [CommRing l] (φ : k →+* l) (x : WittVector p k) :
    truncatedWittMap p N φ (WittVector.truncate N x) =
      WittVector.truncate N (WittVector.map φ x) :=
  RingHom.liftOfRightInverse_comp_apply _ _ _ _ _

@[simp] theorem truncated_witt_map_coeff (p N : ℕ) [Fact p.Prime]
    {k l : Type*} [CommRing k] [CommRing l] (φ : k →+* l)
    (x : TruncatedWittVector p N k) (i : Fin N) :
    (truncatedWittMap p N φ x).coeff i = φ (x.coeff i) := by
  have retract : WittVector.truncate N x.out = x := TruncatedWittVector.truncateFun_out x
  rw [← retract, truncated_witt_map_truncate]
  simp

/-- Literal functorial ring equivalence of truncated Witt rings. -/
noncomputable def truncatedWittEquiv (p N : ℕ) [Fact p.Prime]
    {k l : Type*} [CommRing k] [CommRing l] (φ : k ≃+* l) :
    TruncatedWittVector p N k ≃+* TruncatedWittVector p N l where
  __ := truncatedWittMap p N φ.toRingHom
  invFun := truncatedWittMap p N φ.symm.toRingHom
  left_inv x := by ext i; simp
  right_inv x := by ext i; simp

/-- The actual top prime power vanishes in the length-N Witt ring. -/
theorem truncated_witt_top_power_zero (p N : ℕ) [Fact p.Prime]
    (k : Type*) [CommRing k] [CharP k p] :
    (p : TruncatedWittVector p N k) ^ N = 0 := by
  have truncatePower : (p : TruncatedWittVector p N k) ^ N =
      WittVector.truncate N ((p : WittVector p k) ^ N) := by simp
  rw [truncatePower]
  ext i
  simp only [WittVector.coeff_truncate, TruncatedWittVector.coeff_zero]
  exact WittVector.coeff_p_pow_eq_zero p k (Nat.ne_of_lt i.isLt)

theorem truncated_witt_top_nsmul_zero (p N : ℕ) [Fact p.Prime]
    (k : Type*) [CommRing k] [CharP k p]
    (x : TruncatedWittVector p N k) : p ^ N • x = 0 := by
  rw [nsmul_eq_mul, Nat.cast_pow, truncated_witt_top_power_zero, zero_mul]

/-- The canonical integer-residue scalar structure on the actual
truncated Witt ring, derived from its actual top-power vanishing. -/
noncomputable instance truncatedWittZModModule (p N : ℕ) [Fact p.Prime]
    (k : Type*) [CommRing k] [CharP k p] :
    Module (ZMod (p ^ N)) (TruncatedWittVector p N k) :=
  AddCommGroup.zmodModule (truncated_witt_top_nsmul_zero p N k)

/-- Actual coefficient Frobenius, as an integer-residue linear
automorphism of the actual truncated Witt ring. -/
noncomputable def truncatedWittFrobeniusLinear (p N : ℕ) [Fact p.Prime]
    (k : Type*) [CommRing k] [CharP k p] [PerfectRing k p] :
    TruncatedWittVector p N k ≃ₗ[ZMod (p ^ N)] TruncatedWittVector p N k :=
  { (truncatedWittEquiv p N (_root_.frobeniusEquiv k p)).toAddEquiv with
    map_smul' := fun r x => ZMod.map_smul
      (truncatedWittEquiv p N (_root_.frobeniusEquiv k p)).toAddEquiv r x }

@[simp] theorem truncated_witt_frobenius_linear_coeff (p N : ℕ) [Fact p.Prime]
    (k : Type*) [CommRing k] [CharP k p] [PerfectRing k p]
    (x : TruncatedWittVector p N k) (i : Fin N) :
    (truncatedWittFrobeniusLinear p N k x).coeff i = (x.coeff i) ^ p := by
  simpa only [_root_.frobeniusEquiv_apply] using
    truncated_witt_map_coeff p N (_root_.frobeniusEquiv k p).toRingHom x i

end Litt3.Deformations

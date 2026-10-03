import Solutions.Deformations.TruncatedWittMaps
import Mathlib.RingTheory.WittVector.Complete
import Mathlib.RingTheory.WittVector.Teichmuller

namespace Litt3.Deformations

@[simp] theorem truncated_witt_truncate_out (p N : ℕ) [Fact p.Prime]
    {k : Type*} [CommRing k] (x : TruncatedWittVector p N k) :
    WittVector.truncate N x.out = x := TruncatedWittVector.truncateFun_out x

/-- The actual zeroth-coordinate residue ring map on positive-length
truncated Witt vectors, constructed from the literal truncation kernel. -/
noncomputable def truncatedWittResidue (p N : ℕ) [Fact p.Prime]
    (positive : 0 < N) (k : Type*) [CommRing k] :
    TruncatedWittVector p N k →+* k :=
  RingHom.liftOfRightInverse (WittVector.truncate N) TruncatedWittVector.out
    TruncatedWittVector.truncateFun_out
    ⟨WittVector.constantCoeff, by
      intro x zero
      change x.coeff 0 = 0
      exact (WittVector.mem_ker_truncate N x).mp zero 0 positive⟩

@[simp] theorem truncated_witt_residue_truncate (p N : ℕ) [Fact p.Prime]
    (positive : 0 < N) (k : Type*) [CommRing k] (x : WittVector p k) :
    truncatedWittResidue p N positive k (WittVector.truncate N x) = x.coeff 0 :=
  RingHom.liftOfRightInverse_comp_apply _ _ _ _ _

@[simp] theorem truncated_witt_residue_coeff (p N : ℕ) [Fact p.Prime]
    (positive : 0 < N) (k : Type*) [CommRing k] (x : TruncatedWittVector p N k) :
    truncatedWittResidue p N positive k x = x.coeff ⟨0, positive⟩ := by
  have retract : WittVector.truncate N x.out = x := TruncatedWittVector.truncateFun_out x
  rw [← retract, truncated_witt_residue_truncate, WittVector.coeff_truncate]

theorem truncated_witt_scalar_power_smul (p N j : ℕ) [Fact p.Prime]
    (k : Type*) [CommRing k] [CharP k p] (x : TruncatedWittVector p N k) :
    (p : ZMod (p ^ N)) ^ j • x = (p : TruncatedWittVector p N k) ^ j * x := by
  rw [← Nat.cast_pow, Nat.cast_smul_eq_nsmul, nsmul_eq_mul, Nat.cast_pow]

/-- The genuine residue kernel is precisely the original prime-multiple
submodule. Perfectness is used to divide the actual full Witt lift. -/
theorem truncated_witt_residue_kernel (p N : ℕ) [Fact p.Prime]
    (positive : 0 < N) (k : Type*) [CommRing k] [CharP k p] [PerfectRing k p]
    (x : TruncatedWittVector p N k) :
    truncatedWittResidue p N positive k x = 0 ↔
      ∃ z : TruncatedWittVector p N k, (p : ZMod (p ^ N)) • z = x := by
  constructor
  · intro zero
    have fullZero : x.out.coeff 0 = 0 := by
      rw [← truncated_witt_residue_truncate p N positive k x.out,
        truncated_witt_truncate_out]
      exact zero
    have divisible := (WittVector.mem_span_p_iff_coeff_zero_eq_zero x.out).mpr fullZero
    obtain ⟨z, relation⟩ := Ideal.mem_span_singleton.mp divisible
    refine ⟨WittVector.truncate N z, ?_⟩
    have scalar := truncated_witt_scalar_power_smul p N 1 k (WittVector.truncate N z)
    have image := congrArg (WittVector.truncate N) relation
    simp only [map_mul, map_natCast, truncated_witt_truncate_out] at image
    simp only [pow_one] at scalar
    exact scalar.trans image.symm
  · rintro ⟨z, rfl⟩
    rw [← pow_one (p : ZMod (p ^ N)), truncated_witt_scalar_power_smul, pow_one,
      map_mul, map_natCast]
    simp [CharP.cast_eq_zero k p]

/-- Every actual nonterminal prime-power annihilator is contained
in the actual prime-multiple submodule, uniformly at arbitrary rank. -/
theorem truncated_witt_nonterminal_annihilator (p N : ℕ) [Fact p.Prime]
    (positive : 0 < N) (k : Type*) [Field k] [CharP k p] [PerfectRing k p]
    (j : ℕ) (bound : j < N) (x : TruncatedWittVector p N k)
    (zero : (p : ZMod (p ^ N)) ^ j • x = 0) :
    ∃ z : TruncatedWittVector p N k, (p : ZMod (p ^ N)) • z = x := by
  apply (truncated_witt_residue_kernel p N positive k x).mp
  have multiplication : WittVector.truncate N (x.out * (p : WittVector p k) ^ j) = 0 := by
    rw [map_mul, map_pow, map_natCast, truncated_witt_truncate_out, mul_comm]
    rw [← truncated_witt_scalar_power_smul]
    exact zero
  have coefficient := congrArg (fun v : TruncatedWittVector p N k => v.coeff ⟨j, bound⟩) multiplication
  simp only [WittVector.coeff_truncate, TruncatedWittVector.coeff_zero] at coefficient
  have formula := WittVector.mul_pow_charP_coeff_succ (p := p) (R := k) x.out (m := 0) (n := j)
  have formula' : (x.out * (p : WittVector p k) ^ j).coeff j = x.out.coeff 0 ^ (p ^ j) := by
    simpa only [zero_add] using formula
  rw [formula'] at coefficient
  have fullZero : x.out.coeff 0 = 0 := eq_zero_of_pow_eq_zero coefficient
  rw [← truncated_witt_residue_truncate p N positive k x.out,
    truncated_witt_truncate_out] at fullZero
  exact fullZero

end Litt3.Deformations

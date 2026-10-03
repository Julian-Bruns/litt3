import Solutions.Deformations.ToricHypersurfaceLengthArithmetic

namespace Litt3.Deformations

theorem toric_hypersurface_remainder_one_correction (R s : ℕ) (positiveS : 0<s)
    (remainder : R%s=1) :
    (R^2+s-1)/s = s*(R/s)^2+2*(R/s)+1 ∧
      s*((R^2+s-1)/s)=R^2+s-1 := by
  let m := R/s
  have repr : s*m+1=R := by
    simpa only [remainder,m,Nat.mul_comm,Nat.add_comm] using Nat.mod_add_div R s
  have cancel : R^2+s-1+1=R^2+s := by omega
  have square : R^2=(s*m+1)^2 := congrArg (fun v : ℕ => v^2) repr.symm
  have numerator : R^2+s-1=s*(s*m^2+2*m+1) := by nlinarith [square]
  have division : (R^2+s-1)/s=s*m^2+2*m+1 := by
    rw [numerator,Nat.mul_div_right _ positiveS]
  exact ⟨division,by rw [division]; exact numerator.symm⟩

theorem toric_hypersurface_length_remainder_one (Q R s : ℕ)
    (positiveR : 0<R) (below : R≤Q) (quadratic : 2≤s) (remainder : R%s=1) :
    toricHypersurfaceLengthSum Q R s = 2*Q*R-(R^2+s-1)/s := by
  have h := toric_hypersurface_length_floor_add Q R s positiveR below quadratic
  have correction := (toric_hypersurface_remainder_one_correction R s (by omega) remainder).1
  rw [remainder] at h
  omega

theorem toric_hypersurface_balanced_length_remainder_one (R s : ℕ)
    (positiveR : 0<R) (quadratic : 2≤s) (remainder : R%s=1) :
    toricHypersurfaceLengthSum R R s = ((2*s-1)*R^2-(s-1))/s := by
  let L := toricHypersurfaceLengthSum R R s
  let c := (R^2+s-1)/s
  have correction := toric_hypersurface_remainder_one_correction R s (by omega) remainder
  have h := toric_hypersurface_length_floor_add R R s positiveR le_rfl quadratic
  rw [remainder] at h
  have length : L+c=2*R*R := by dsimp [L,c]; omega
  have sc : s*c=R^2+s-1 := correction.2
  have cancel : R^2+s-1+1=R^2+s := by omega
  have twice : (2*s-1)+1=2*s := by omega
  have subtract : (s-1)+1=s := by omega
  have scaled := congrArg (fun v : ℕ => s*v) length
  have twiceScaled := congrArg (fun v : ℕ => v*R^2) twice
  have identity : s*L+(s-1)=(2*s-1)*R^2 := by
    nlinarith [scaled,twiceScaled]
  have numerator : (2*s-1)*R^2-(s-1)=s*L := by omega
  rw [numerator,Nat.mul_div_right _ (by omega : 0<s)]

theorem toric_hypersurface_five_power_mod_two (n : ℕ) : 5^n%2=1 := by
  rw [Nat.pow_mod]
  norm_num

theorem toric_hypersurface_five_power_mod_four (n : ℕ) : 5^n%4=1 := by
  rw [Nat.pow_mod]
  norm_num

end Litt3.Deformations

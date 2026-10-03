import Mathlib.Tactic

namespace Litt3.Deformations

def toricHypersurfaceLengthSum (Q R s : ℕ) : ℕ :=
  R+2*∑ j ∈ Finset.range Q, min R (s*j)

theorem toric_hypersurface_fin_sum_eq_range (Q R s : ℕ) (positiveQ : 0<Q) :
    (∑ i : Fin (Q-1), min R (s*(i.val+1))) =
      ∑ j ∈ Finset.range Q, min R (s*j) := by
  rw [Fin.sum_univ_eq_sum_range (fun j => min R (s*(j+1)))]
  have split : Q=(Q-1)+1 := by omega
  conv_rhs => rw [split,Finset.sum_range_succ']
  simp

theorem toric_hypersurface_double_triangular_sum (s m : ℕ) :
    2*(∑ j ∈ Finset.range (m+1),s*j)=s*m*(m+1) := by
  induction m with
  | zero => simp
  | succ m ih =>
      rw [Finset.sum_range_succ]
      nlinarith

/-- Uniform summation, with the whole floor/remainder boundary proved
from division; no finite list of exponents is evaluated. -/
theorem toric_hypersurface_length_floor_add (Q R s : ℕ)
    (positiveR : 0<R) (below : R≤Q) (quadratic : 2≤s) :
    toricHypersurfaceLengthSum Q R s + s*(R/s)^2 + (R%s)*(2*(R/s)+1)=2*Q*R := by
  let m := R/s
  let r := R%s
  have positiveS : 0<s := by omega
  have repr : s*m+r=R := by
    simpa only [m,r,Nat.mul_comm,Nat.add_comm] using Nat.mod_add_div R s
  have smallR : r<s := Nat.mod_lt R positiveS
  have small : m<Q := lt_of_lt_of_le (Nat.div_lt_self positiveR (by omega)) below
  let t := Q-(m+1)
  have split : m+1+t=Q := by dsimp [t]; omega
  have lower : ∀ j ∈ Finset.range (m+1), min R (s*j)=s*j := by
    intro j hj
    apply min_eq_right
    have bound : j≤m := by simpa only [Finset.mem_range,Nat.lt_succ_iff] using hj
    nlinarith [Nat.mul_le_mul_left s bound]
  have upper : ∀ j ∈ Finset.range t, min R (s*(m+1+j))=R := by
    intro j _
    apply min_eq_left
    nlinarith
  have sum : (∑ j ∈ Finset.range Q,min R (s*j)) =
      (∑ j ∈ Finset.range (m+1),s*j)+t*R := by
    rw [← split,Finset.sum_range_add]
    congr 1
    · apply Finset.sum_congr rfl lower
    · rw [Finset.sum_congr rfl upper]
      simp
  have triangular := toric_hypersurface_double_triangular_sum s m
  unfold toricHypersurfaceLengthSum
  rw [sum]
  change R+2*((∑ j ∈ Finset.range (m+1),s*j)+t*R)+s*m^2+r*(2*m+1)=2*Q*R
  rw [← repr,← split]
  nlinarith [triangular]

/-- Exact canonical closed formula with actual floor and remainder. -/
theorem toric_hypersurface_length_floor (Q R s : ℕ)
    (positiveR : 0<R) (below : R≤Q) (quadratic : 2≤s) :
    toricHypersurfaceLengthSum Q R s =
      2*Q*R-s*(R/s)^2-(R%s)*(2*(R/s)+1) := by
  have h := toric_hypersurface_length_floor_add Q R s positiveR below quadratic
  omega

end Litt3.Deformations

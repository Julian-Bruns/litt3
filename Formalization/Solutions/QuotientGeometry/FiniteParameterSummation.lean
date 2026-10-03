import Mathlib.Logic.Equiv.Fin.Basic
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.BigOperators.Group.Finset.Pi

namespace Litt3.QuotientGeometry

/-- Residue-class enumeration of a coefficient sum. All indices beyond
the chosen coefficient vanish by hypothesis, so no bounded approximation
is used in the resulting exact identity. -/
theorem finite_parameter_residue_sum
    {R : Type*} [AddCommMonoid R] (n : ℕ) (hn : 0 < n) (m : ℕ) (F : ℕ → R)
    (hzero : ∀ j, m < j → F j = 0) :
    (∑ d ∈ Finset.range (m + 1), ∑ i : Fin n, F (d * n + i.val)) =
      ∑ j ∈ Finset.range (m + 1), F j := by
  classical
  have hrectangle : (∑ d : Fin (m + 1), ∑ i : Fin n, F (d.val * n + i.val)) =
      ∑ j : Fin ((m + 1) * n), F j.val := by
    rw [← Fintype.sum_prod_type']
    apply Fintype.sum_equiv finProdFinEquiv
    intro x
    change F (x.1.val * n + x.2.val) = F (x.2.val + n * x.1.val)
    congr 1
    ac_rfl
  rw [Fin.sum_univ_eq_sum_range
    (fun d => ∑ i : Fin n, F (d * n + i.val)) (m + 1)] at hrectangle
  rw [hrectangle, Fin.sum_univ_eq_sum_range F ((m + 1) * n)]
  have hbound : m + 1 ≤ (m + 1) * n := by
    calc
      m + 1 = (m + 1) * 1 := by rw [mul_one]
      _ ≤ (m + 1) * n := Nat.mul_le_mul_left _ (Nat.succ_le_iff.mpr hn)
  symm
  apply Finset.sum_subset (Finset.range_mono hbound)
  intro j _ hj
  apply hzero j
  simp only [Finset.mem_range] at hj
  omega

end Litt3.QuotientGeometry

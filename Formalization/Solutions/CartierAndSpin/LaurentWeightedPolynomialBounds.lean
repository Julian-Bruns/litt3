import Solutions.CartierAndSpin.LaurentEndpointBounds
import Solutions.SharedTensors.UniformRootValuationBounds

namespace Litt3.CartierAndSpin

open Polynomial

variable {k ι : Type*} [Field k]

/-- Exact weighted coefficient inequalities multiply by adding their
weights. Arbitrary signed weights and zero coefficients are retained. -/
theorem laurent_weighted_polynomial_product_bound
    (P Q : (LaurentSeries k)[X]) (a b weight : ℤ)
    (hP : ∀ j : ℕ, ((a - weight * (j : ℤ) : ℤ) : WithTop ℤ) ≤ (P.coeff j).orderTop)
    (hQ : ∀ j : ℕ, ((b - weight * (j : ℤ) : ℤ) : WithTop ℤ) ≤ (Q.coeff j).orderTop)
    (j : ℕ) :
    ((a + b - weight * (j : ℤ) : ℤ) : WithTop ℤ) ≤ ((P * Q).coeff j).orderTop := by
  rw [coeff_mul]
  apply laurent_orderTop_sum_bound
  intro ij hij
  have hsum := Finset.mem_antidiagonal.mp hij
  have h := laurent_orderTop_mul_bound (P.coeff ij.1) (Q.coeff ij.2)
    (a - weight * (ij.1 : ℤ)) (b - weight * (ij.2 : ℤ)) (hP ij.1) (hQ ij.2)
  have hindex : a - weight * (ij.1 : ℤ) + (b - weight * (ij.2 : ℤ)) =
      a + b - weight * (j : ℤ) := by
    have hcast : (ij.1 : ℤ) + (ij.2 : ℤ) = (j : ℤ) := by exact_mod_cast hsum
    calc
      a - weight * (ij.1 : ℤ) + (b - weight * (ij.2 : ℤ)) =
          a + b - weight * ((ij.1 : ℤ) + (ij.2 : ℤ)) := by ring
      _ = _ := by rw [hcast]
  rwa [hindex] at h

/-- Every nodal polynomial has the exact weighted coefficient bound
from the actual root-order bound, even with coinciding roots. -/
theorem laurent_weighted_nodal_bound (s : Finset ι) (node : ι → LaurentSeries k)
    (weight : ℤ) (hnode : ∀ i ∈ s, (weight : WithTop ℤ) ≤ (node i).orderTop)
    (j : ℕ) :
    (((s.card : ℤ) * weight - weight * (j : ℤ) : ℤ) : WithTop ℤ) ≤
      ((Lagrange.nodal s node).coeff j).orderTop := by
  by_cases hj : j ≤ s.card
  · have h := Litt3.SharedTensors.laurent_nodal_coeff_orderTop_bound s node weight hnode j hj
    have hindex : ((s.card - j : ℕ) : ℤ) * weight =
        (s.card : ℤ) * weight - weight * (j : ℤ) := by
      rw [Nat.cast_sub hj]
      ring
    rwa [hindex] at h
  · rw [coeff_eq_zero_of_natDegree_lt (by
      rw [Lagrange.natDegree_nodal]; omega), HahnSeries.orderTop_zero]
    exact le_top

/-- A regular polynomial times a selected nodal factor retains every
small-root contact coefficient order when the root weight is nonnegative. -/
theorem regular_polynomial_times_nodal_contact_bound
    (B : (LaurentSeries k)[X]) (s : Finset ι) (node : ι → LaurentSeries k)
    (weight : ℤ) (hweight : 0 ≤ weight)
    (hB : ∀ j, (0 : WithTop ℤ) ≤ (B.coeff j).orderTop)
    (hnode : ∀ i ∈ s, (weight : WithTop ℤ) ≤ (node i).orderTop) (j : ℕ) :
    (((s.card : ℤ) * weight - weight * (j : ℤ) : ℤ) : WithTop ℤ) ≤
      ((B * Lagrange.nodal s node).coeff j).orderTop := by
  have hBweighted (i : ℕ) : ((0 - weight * (i : ℤ) : ℤ) : WithTop ℤ) ≤
      (B.coeff i).orderTop := by
    apply le_trans _ (hB i)
    exact WithTop.coe_le_coe.mpr (by nlinarith)
  simpa only [zero_add] using laurent_weighted_polynomial_product_bound
    B (Lagrange.nodal s node) 0 ((s.card : ℤ) * weight) weight hBweighted
    (laurent_weighted_nodal_bound s node weight hnode) j

end Litt3.CartierAndSpin

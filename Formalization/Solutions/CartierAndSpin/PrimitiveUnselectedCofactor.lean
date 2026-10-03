import Solutions.CartierAndSpin.WeightedInterpolationIntegrality

namespace Litt3.CartierAndSpin

open Polynomial Finset

variable {K Γ ι : Type*} [Field K] [LinearOrderedCommGroupWithZero Γ]

/-- Exact primitive content cancels every unselected pole, while a
nonzero residue at every remaining regular node makes the actual
cofactor's constant coefficient a valuation unit. -/
theorem primitive_unselected_cofactor_valuation_unit
    (v : Valuation K Γ) (s : Finset ι) (node : ι → K) (content : K)
    (hnode : ∀ i ∈ s, 1 ≤ v (node i))
    (hcontent : v content * (∏ i ∈ s, max 1 (v (node i))) = 1) :
    (∀ j : ℕ, v ((C content * Lagrange.nodal s node).coeff j) ≤ 1) ∧
    v ((C content * Lagrange.nodal s node).coeff 0) = 1 := by
  classical
  constructor
  · intro j
    rw [coeff_C_mul, map_mul]
    apply le_trans (mul_le_mul' le_rfl (nodal_coefficient_valuation_bound v s node j))
    exact le_of_eq hcontent
  · rw [coeff_C_mul, map_mul]
    have hconstant : (Lagrange.nodal s node).coeff 0 = ∏ i ∈ s, -(node i) := by
      calc
        (Lagrange.nodal s node).coeff 0 = (Lagrange.nodal s node).eval 0 :=
          Polynomial.coeff_zero_eq_eval_zero (Lagrange.nodal s node)
        _ = _ := by rw [Lagrange.eval_nodal]; simp only [zero_sub]
    rw [hconstant, map_prod]
    have hprod : (∏ i ∈ s, v (-(node i))) = ∏ i ∈ s, max 1 (v (node i)) := by
      apply prod_congr rfl
      intro i hi
      rw [v.map_neg, max_eq_right (hnode i hi)]
    rwa [hprod]

end Litt3.CartierAndSpin

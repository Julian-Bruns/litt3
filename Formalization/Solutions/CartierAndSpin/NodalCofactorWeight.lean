import Solutions.CartierAndSpin.LaurentWeightedPolynomialBounds

namespace Litt3.CartierAndSpin

open Polynomial Finset

variable {k ι : Type*} [Field k]

/-- Small roots make the actual nodal top coefficient the unique term
of least Laurent order against a cofactor with nonzero regular residue.
The cofactor may have any signed common order, and roots may coincide. -/
theorem nodal_cofactor_contact_coefficient_exact (B : (LaurentSeries k)[X])
    (s : Finset ι) (node : ι → LaurentSeries k) (c contact : ℤ)
    (hcontact : 1 ≤ contact)
    (hB : ∀ j : ℕ, (c : WithTop ℤ) ≤ (B.coeff j).orderTop)
    (hB0 : (B.coeff 0).orderTop = (c : WithTop ℤ))
    (hnode : ∀ i ∈ s, (contact : WithTop ℤ) ≤ (node i).orderTop) :
    ((B * Lagrange.nodal s node).coeff s.card).orderTop = (c : WithTop ℤ) := by
  classical
  let f := fun ij : ℕ × ℕ => B.coeff ij.1 * (Lagrange.nodal s node).coeff ij.2
  have hmem : (0, s.card) ∈ Finset.antidiagonal s.card := by simp
  have htop : (Lagrange.nodal s node).coeff s.card = 1 := by
    rw [← Lagrange.natDegree_nodal (s := s) (v := node), coeff_natDegree]
    exact Lagrange.nodal_monic.leadingCoeff
  have hsplit : (B * Lagrange.nodal s node).coeff s.card =
      B.coeff 0 + ∑ ij ∈ (Finset.antidiagonal s.card).erase (0, s.card), f ij := by
    rw [coeff_mul, ← Finset.add_sum_erase _ _ hmem]
    simp only [f, htop, mul_one]
  have htail : ((c + 1 : ℤ) : WithTop ℤ) ≤
      (∑ ij ∈ (Finset.antidiagonal s.card).erase (0, s.card), f ij).orderTop := by
    apply laurent_orderTop_sum_bound
    intro ij hij
    have hne := (Finset.mem_erase.mp hij).1
    have hsum := Finset.mem_antidiagonal.mp (Finset.mem_erase.mp hij).2
    have hi : 1 ≤ ij.1 := by
      by_contra hnot
      have hi0 : ij.1 = 0 := by omega
      have hj : ij.2 = s.card := by omega
      exact hne (Prod.ext hi0 hj)
    have hnodal := laurent_weighted_nodal_bound s node contact hnode ij.2
    have hproduct := laurent_orderTop_mul_bound (B.coeff ij.1)
      ((Lagrange.nodal s node).coeff ij.2) c
      ((s.card : ℤ) * contact - contact * (ij.2 : ℤ)) (hB ij.1) hnodal
    change ((c + 1 : ℤ) : WithTop ℤ) ≤
      (B.coeff ij.1 * (Lagrange.nodal s node).coeff ij.2).orderTop
    apply le_trans _ hproduct
    apply WithTop.coe_le_coe.mpr
    have hcast : (ij.1 : ℤ) + (ij.2 : ℤ) = (s.card : ℤ) := by exact_mod_cast hsum
    have hi' : 1 ≤ (ij.1 : ℤ) := by exact_mod_cast hi
    nlinarith
  rw [hsplit, HahnSeries.orderTop_add_eq_left, hB0]
  rw [hB0]
  exact lt_of_lt_of_le (WithTop.coe_lt_coe.mpr (by omega)) htail

/-- The exact source weight follows from actual small roots and an
actual unit-residue cofactor. No source weight or primitive-content
conclusion is supplied as an assumption. -/
theorem nodal_cofactor_exact_weight (B : (LaurentSeries k)[X])
    (s : Finset ι) (node : ι → LaurentSeries k) (c contact : ℤ)
    (hcontact : 1 ≤ contact)
    (hB : ∀ j : ℕ, (c : WithTop ℤ) ≤ (B.coeff j).orderTop)
    (hB0 : (B.coeff 0).orderTop = (c : WithTop ℤ))
    (hnode : ∀ i ∈ s, (contact : WithTop ℤ) ≤ (node i).orderTop) :
    (∀ j : ℕ, (((c + (s.card : ℤ) * contact) - contact * (j : ℤ) : ℤ) : WithTop ℤ) ≤
      ((B * Lagrange.nodal s node).coeff j).orderTop) ∧
    (∃ j : ℕ, ((B * Lagrange.nodal s node).coeff j).orderTop =
      (((c + (s.card : ℤ) * contact) - contact * (j : ℤ) : ℤ) : WithTop ℤ)) := by
  constructor
  · intro j
    apply laurent_weighted_polynomial_product_bound B (Lagrange.nodal s node)
      c ((s.card : ℤ) * contact) contact _ (laurent_weighted_nodal_bound s node contact hnode) j
    intro i
    exact le_trans (WithTop.coe_le_coe.mpr (by nlinarith)) (hB i)
  · refine ⟨s.card, ?_⟩
    have hcancel : c + (s.card : ℤ) * contact - contact * (s.card : ℤ) = c := by ring
    simpa only [hcancel] using
      nodal_cofactor_contact_coefficient_exact B s node c contact hcontact hB hB0 hnode

end Litt3.CartierAndSpin

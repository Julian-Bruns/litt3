import Solutions.CartierAndSpin.LaurentWeightedPolynomialBounds

namespace Litt3.CartierAndSpin

open Polynomial Finset

variable {k ι τ : Type*} [Field k] [DecidableEq ι]

/-- Selected interpolation terms retain their exact contact weight:
each selected weight has a simple zero and every other selected node has
order at least the contact order. All residues may coincide. -/
theorem selected_interpolation_contact_bound (s : Finset ι)
    (node xi : ι → LaurentSeries k) (B : ι → (LaurentSeries k)[X])
    (contact : ℤ) (hcontact : 0 ≤ contact)
    (hnode : ∀ i ∈ s, (contact : WithTop ℤ) ≤ (node i).orderTop)
    (hxi : ∀ i ∈ s, (1 : WithTop ℤ) ≤ (xi i).orderTop)
    (hB : ∀ i ∈ s, ∀ j, (0 : WithTop ℤ) ≤ ((B i).coeff j).orderTop) (j : ℕ) :
    ((1 + ((s.card : ℤ) - 1) * contact - contact * (j : ℤ) : ℤ) : WithTop ℤ) ≤
      ((∑ i ∈ s, C (xi i) * B i * Lagrange.nodal (s.erase i) node).coeff j).orderTop := by
  rw [finset_sum_coeff]
  apply laurent_orderTop_sum_bound
  intro i hi
  rw [mul_assoc, coeff_C_mul]
  have hnodal := regular_polynomial_times_nodal_contact_bound (B i) (s.erase i) node
    contact hcontact (hB i hi) (fun a ha => hnode a (mem_of_mem_erase ha)) j
  have hproduct := laurent_orderTop_mul_bound (xi i)
    ((B i * Lagrange.nodal (s.erase i) node).coeff j) 1
    (((s.erase i).card : ℤ) * contact - contact * (j : ℤ)) (hxi i hi) hnodal
  have hcardNat : (s.erase i).card + 1 = s.card := card_erase_add_one hi
  have hcard : ((s.erase i).card : ℤ) = (s.card : ℤ) - 1 := by
    have hc : ((s.erase i).card : ℤ) + 1 = (s.card : ℤ) := by exact_mod_cast hcardNat
    omega
  simpa only [hcard, add_sub_assoc] using hproduct

/-- Adding any regular nonselected interpolation terms with the full
selected nodal factor preserves the same sharp coefficient jets. -/
theorem full_interpolation_contact_bound (s : Finset ι) (t : Finset τ)
    (node xi : ι → LaurentSeries k) (B : ι → (LaurentSeries k)[X])
    (Cofactor : τ → (LaurentSeries k)[X]) (contact : ℤ) (hcontact : 1 ≤ contact)
    (hnode : ∀ i ∈ s, (contact : WithTop ℤ) ≤ (node i).orderTop)
    (hxi : ∀ i ∈ s, (1 : WithTop ℤ) ≤ (xi i).orderTop)
    (hB : ∀ i ∈ s, ∀ j, (0 : WithTop ℤ) ≤ ((B i).coeff j).orderTop)
    (hCofactor : ∀ i ∈ t, ∀ j, (0 : WithTop ℤ) ≤ ((Cofactor i).coeff j).orderTop)
    (j : ℕ) :
    ((1 + ((s.card : ℤ) - 1) * contact - contact * (j : ℤ) : ℤ) : WithTop ℤ) ≤
      (((∑ i ∈ s, C (xi i) * B i * Lagrange.nodal (s.erase i) node) +
        ∑ i ∈ t, Cofactor i * Lagrange.nodal s node).coeff j).orderTop := by
  rw [coeff_add]
  apply (le_min (selected_interpolation_contact_bound s node xi B contact
    (by omega) hnode hxi hB j) ?_).trans HahnSeries.min_orderTop_le_orderTop_add
  rw [finset_sum_coeff]
  apply laurent_orderTop_sum_bound
  intro i hi
  apply le_trans _ (regular_polynomial_times_nodal_contact_bound
    (Cofactor i) s node contact (by omega) (hCofactor i hi) hnode j)
  exact WithTop.coe_le_coe.mpr (by nlinarith)

end Litt3.CartierAndSpin

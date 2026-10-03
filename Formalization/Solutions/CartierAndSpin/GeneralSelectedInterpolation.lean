import Solutions.CartierAndSpin.SelectedInterpolationContact

namespace Litt3.CartierAndSpin

open Polynomial Finset

variable {k ι τ : Type*} [Field k] [DecidableEq ι]

/-- Selected interpolation weights may have any signed order. This
includes the annihilator's simple poles and the square moment's zeros. -/
theorem selected_interpolation_signed_weight_bound (s : Finset ι)
    (node xi : ι → LaurentSeries k) (B : ι → (LaurentSeries k)[X])
    (contact m : ℤ) (hcontact : 0 ≤ contact)
    (hnode : ∀ i ∈ s, (contact : WithTop ℤ) ≤ (node i).orderTop)
    (hxi : ∀ i ∈ s, (m : WithTop ℤ) ≤ (xi i).orderTop)
    (hB : ∀ i ∈ s, ∀ j, (0 : WithTop ℤ) ≤ ((B i).coeff j).orderTop) (j : ℕ) :
    ((m + ((s.card : ℤ) - 1) * contact - contact * (j : ℤ) : ℤ) : WithTop ℤ) ≤
      ((∑ i ∈ s, C (xi i) * B i * Lagrange.nodal (s.erase i) node).coeff j).orderTop := by
  rw [finset_sum_coeff]
  apply laurent_orderTop_sum_bound
  intro i hi
  rw [mul_assoc, coeff_C_mul]
  have hnodal := regular_polynomial_times_nodal_contact_bound (B i) (s.erase i) node
    contact hcontact (hB i hi) (fun a ha => hnode a (mem_of_mem_erase ha)) j
  have hproduct := laurent_orderTop_mul_bound (xi i)
    ((B i * Lagrange.nodal (s.erase i) node).coeff j) m
    (((s.erase i).card : ℤ) * contact - contact * (j : ℤ)) (hxi i hi) hnodal
  have hcardNat : (s.erase i).card + 1 = s.card := card_erase_add_one hi
  have hcard : ((s.erase i).card : ℤ) = (s.card : ℤ) - 1 := by
    have hc : ((s.erase i).card : ℤ) + 1 = (s.card : ℤ) := by exact_mod_cast hcardNat
    omega
  simpa only [hcard, add_sub_assoc] using hproduct

/-- Full selected/nonselected interpolation retains any signed
selected weight m at most the node contact order. No distinct residues
or unit differences between selected nodes are required. -/
theorem full_interpolation_signed_weight_bound (s : Finset ι) (t : Finset τ)
    (node xi : ι → LaurentSeries k) (B : ι → (LaurentSeries k)[X])
    (Cofactor : τ → (LaurentSeries k)[X]) (contact m : ℤ)
    (hcontact : 0 ≤ contact) (hm : m ≤ contact)
    (hnode : ∀ i ∈ s, (contact : WithTop ℤ) ≤ (node i).orderTop)
    (hxi : ∀ i ∈ s, (m : WithTop ℤ) ≤ (xi i).orderTop)
    (hB : ∀ i ∈ s, ∀ j, (0 : WithTop ℤ) ≤ ((B i).coeff j).orderTop)
    (hCofactor : ∀ i ∈ t, ∀ j, (0 : WithTop ℤ) ≤ ((Cofactor i).coeff j).orderTop)
    (j : ℕ) :
    ((m + ((s.card : ℤ) - 1) * contact - contact * (j : ℤ) : ℤ) : WithTop ℤ) ≤
      (((∑ i ∈ s, C (xi i) * B i * Lagrange.nodal (s.erase i) node) +
        ∑ i ∈ t, Cofactor i * Lagrange.nodal s node).coeff j).orderTop := by
  rw [coeff_add]
  apply (le_min (selected_interpolation_signed_weight_bound s node xi B contact m
    hcontact hnode hxi hB j) ?_).trans HahnSeries.min_orderTop_le_orderTop_add
  rw [finset_sum_coeff]
  apply laurent_orderTop_sum_bound
  intro i hi
  apply le_trans _ (regular_polynomial_times_nodal_contact_bound
    (Cofactor i) s node contact hcontact (hCofactor i hi) hnode j)
  exact WithTop.coe_le_coe.mpr (by nlinarith)

end Litt3.CartierAndSpin

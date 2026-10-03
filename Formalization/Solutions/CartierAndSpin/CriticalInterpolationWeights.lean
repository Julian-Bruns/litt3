import Solutions.CartierAndSpin.LaurentWeightedQuotients
import Solutions.CartierAndSpin.NodalCofactorWeight

namespace Litt3.CartierAndSpin

open Polynomial

variable {k ι : Type*} [Field k]

/-- The quotient weight follows from the actual interpolation equation.
No coefficient order of the quotient is an input. -/
theorem critical_interpolation_quotient_weight
    (F U D V Q : (LaurentSeries k)[X]) (f u d v weight : ℤ)
    (hidentity : U ^ 2 - F * Q = D * V)
    (hF : ∀ j : ℕ, ((f - weight * (j : ℤ) : ℤ) : WithTop ℤ) ≤ (F.coeff j).orderTop)
    (hexact : ∃ j : ℕ, (F.coeff j).orderTop =
      ((f - weight * (j : ℤ) : ℤ) : WithTop ℤ))
    (hU : ∀ j : ℕ, ((u - weight * (j : ℤ) : ℤ) : WithTop ℤ) ≤ (U.coeff j).orderTop)
    (hD : ∀ j : ℕ, ((d - weight * (j : ℤ) : ℤ) : WithTop ℤ) ≤ (D.coeff j).orderTop)
    (hV : ∀ j : ℕ, ((v - weight * (j : ℤ) : ℤ) : WithTop ℤ) ≤ (V.coeff j).orderTop)
    (j : ℕ) :
    ((min (2 * u) (d + v) - f - weight * (j : ℤ) : ℤ) : WithTop ℤ) ≤
      (Q.coeff j).orderTop := by
  have hproduct : F * Q = U ^ 2 - D * V := by linear_combination -hidentity
  apply laurent_weighted_polynomial_quotient_bound F Q f
    (min (2 * u) (d + v) - f) weight hF hexact
  intro i
  rw [hproduct, coeff_sub]
  have hUU := laurent_weighted_polynomial_product_bound U U u u weight hU hU i
  have hDV := laurent_weighted_polynomial_product_bound D V d v weight hD hV i
  have hleft : ((f + (min (2 * u) (d + v) - f) - weight * (i : ℤ) : ℤ) : WithTop ℤ) ≤
      ((U ^ 2).coeff i).orderTop := by
    apply le_trans _ (by simpa only [pow_two] using hUU)
    apply WithTop.coe_le_coe.mpr
    have hm := min_le_left (2 * u) (d + v)
    omega
  have hright : ((f + (min (2 * u) (d + v) - f) - weight * (i : ℤ) : ℤ) : WithTop ℤ) ≤
      ((D * V).coeff i).orderTop := by
    apply le_trans _ hDV
    apply WithTop.coe_le_coe.mpr
    have hm := min_le_right (2 * u) (d + v)
    omega
  exact le_trans (le_min hleft hright) HahnSeries.min_orderTop_le_orderTop_sub

/-- A genuine nodal source factor with a unit cofactor at the selected
point gives the sharp critical-quotient contact coefficient bound. -/
theorem selected_critical_quotient_contact_weight
    (B U D V Q : (LaurentSeries k)[X]) (s : Finset ι)
    (node : ι → LaurentSeries k) (contact : ℤ) (hcontact : 1 ≤ contact)
    (hB : ∀ j, (0 : WithTop ℤ) ≤ (B.coeff j).orderTop)
    (hB0 : (B.coeff 0).orderTop = 0)
    (hnode : ∀ i ∈ s, (contact : WithTop ℤ) ≤ (node i).orderTop)
    (hidentity : U ^ 2 - (B * Lagrange.nodal s node) * Q = D * V)
    (hU : ∀ j : ℕ,
      ((((s.card : ℤ) - 1) * contact - 1 - contact * (j : ℤ) : ℤ) : WithTop ℤ) ≤
        (U.coeff j).orderTop)
    (hD : ∀ j : ℕ,
      ((((s.card : ℤ) - 1) * contact - 3 - contact * (j : ℤ) : ℤ) : WithTop ℤ) ≤
        (D.coeff j).orderTop)
    (hV : ∀ j : ℕ,
      ((((s.card : ℤ) - 1) * contact + 1 - contact * (j : ℤ) : ℤ) : WithTop ℤ) ≤
        (V.coeff j).orderTop) (j : ℕ) :
    ((((s.card : ℤ) - 2) * contact - 2 - contact * (j : ℤ) : ℤ) : WithTop ℤ) ≤
      (Q.coeff j).orderTop := by
  obtain ⟨hF, hexact⟩ := nodal_cofactor_exact_weight B s node 0 contact hcontact hB hB0 hnode
  have h := critical_interpolation_quotient_weight (B * Lagrange.nodal s node) U D V Q
    ((s.card : ℤ) * contact) (((s.card : ℤ) - 1) * contact - 1)
    (((s.card : ℤ) - 1) * contact - 3) (((s.card : ℤ) - 1) * contact + 1)
    contact hidentity (by simpa only [zero_add] using hF)
    (by simpa only [zero_add] using hexact) hU hD hV j
  have hweights :
      min (2 * (((s.card : ℤ) - 1) * contact - 1))
        ((((s.card : ℤ) - 1) * contact - 3) + (((s.card : ℤ) - 1) * contact + 1)) -
        (s.card : ℤ) * contact = ((s.card : ℤ) - 2) * contact - 2 := by
    have heq : (((s.card : ℤ) - 1) * contact - 3) +
        (((s.card : ℤ) - 1) * contact + 1) = 2 * (((s.card : ℤ) - 1) * contact - 1) := by ring
    rw [heq, min_self]
    ring
  rwa [hweights] at h

end Litt3.CartierAndSpin

import Solutions.CartierAndSpin.NodalCriticalSecondOrder

namespace Litt3.CartierAndSpin

open Polynomial

variable {k ι : Type*} [Field k]

/-- The three canonical five-sheet coefficient orders are consequences
of the actual nodal source and exact interpolation equation. -/
theorem five_sheet_critical_contact_orders
    (B U D V Q : (LaurentSeries k)[X]) (s : Finset ι) (hs : s.card = 5)
    (node : ι → LaurentSeries k) (q : LaurentSeries k) (contact : ℤ)
    (hcontact : 1 ≤ contact)
    (hB : ∀ j, (0 : WithTop ℤ) ≤ (B.coeff j).orderTop)
    (hB0 : (B.coeff 0).orderTop = 0)
    (hnode : ∀ i ∈ s, (contact : WithTop ℤ) ≤ (node i).orderTop)
    (hq : q.orderTop = (3 : WithTop ℤ))
    (hderivative : (B * Lagrange.nodal s node).derivative = (X ^ 5 + C q) * D)
    (hidentity : U ^ 2 - (B * Lagrange.nodal s node) * Q = D * V)
    (hU : ∀ j : ℕ, ((4 * contact - 1 - contact * (j : ℤ) : ℤ) : WithTop ℤ) ≤
      (U.coeff j).orderTop)
    (hV : ∀ j : ℕ, ((4 * contact + 1 - contact * (j : ℤ) : ℤ) : WithTop ℤ) ≤
      (V.coeff j).orderTop) :
    ((3 * contact - 2 : ℤ) : WithTop ℤ) ≤ (Q.coeff 0).orderTop ∧
    ((2 * contact - 2 : ℤ) : WithTop ℤ) ≤ (Q.coeff 1).orderTop ∧
    ((contact - 2 : ℤ) : WithTop ℤ) ≤ (Q.coeff 2).orderTop := by
  have h (j : ℕ) := nodal_source_critical_quotient_contact_bound B U D V Q s node q contact
    hcontact hB hB0 hnode hq hderivative hidentity
    (by simpa [hs] using hU) (by simpa [hs] using hV) j
  constructor
  · simpa [hs] using h 0
  constructor
  · have heq : ((5 : ℤ) - 2) * contact - 2 - contact * (1 : ℤ) =
        2 * contact - 2 := by ring
    simpa only [hs, Nat.cast_ofNat, Nat.cast_one, heq] using h 1
  · have heq : ((5 : ℤ) - 2) * contact - 2 - contact * (2 : ℤ) = contact - 2 := by ring
    simpa only [hs, Nat.cast_ofNat, heq] using h 2

/-- The full second-order five-sheet source gives seven literal
coefficient jets: four constant, two linear, and one quadratic. Their
independence or realization is not asserted. -/
theorem five_sheet_second_order_critical_jets
    (B U D V Q : (LaurentSeries k)[X]) (s : Finset ι) (hs : s.card = 5)
    (node : ι → LaurentSeries k) (q : LaurentSeries k)
    (hB : ∀ j, (0 : WithTop ℤ) ≤ (B.coeff j).orderTop)
    (hB0 : (B.coeff 0).orderTop = 0)
    (hnode : ∀ i ∈ s, (2 : WithTop ℤ) ≤ (node i).orderTop)
    (hq : q.orderTop = (3 : WithTop ℤ))
    (hderivative : (B * Lagrange.nodal s node).derivative = (X ^ 5 + C q) * D)
    (hidentity : U ^ 2 - (B * Lagrange.nodal s node) * Q = D * V)
    (hUreg : ∀ j, (0 : WithTop ℤ) ≤ (U.coeff j).orderTop)
    (hDreg : ∀ j, (0 : WithTop ℤ) ≤ (D.coeff j).orderTop)
    (hVreg : ∀ j, (0 : WithTop ℤ) ≤ (V.coeff j).orderTop)
    (hU : ∀ j : ℕ, ((7 - 2 * (j : ℤ) : ℤ) : WithTop ℤ) ≤ (U.coeff j).orderTop)
    (hV : ∀ j : ℕ, ((9 - 2 * (j : ℤ) : ℤ) : WithTop ℤ) ≤ (V.coeff j).orderTop) :
    (∀ n : ℕ, n < 4 → (Q.coeff 0).coeff (n : ℤ) = 0) ∧
    (∀ n : ℕ, n < 2 → (Q.coeff 1).coeff (n : ℤ) = 0) ∧
    (Q.coeff 2).coeff 0 = 0 := by
  obtain ⟨hQ0, hQ1, hQ2⟩ := five_sheet_critical_contact_orders B U D V Q s hs node q 2
    (by omega) hB hB0 hnode hq hderivative hidentity
    (by norm_num; exact hU) (by norm_num; exact hV)
  have hcorner := nodal_source_second_order_corner_positive B U D V Q s node q
    (by omega) hB hB0 hnode hq hderivative hidentity hUreg hDreg hVreg
    (by simpa [hs] using hU) (by simpa [hs] using hV)
  have hQ0' : (4 : WithTop ℤ) ≤ (Q.coeff 0).orderTop := by norm_num at hQ0; exact hQ0
  have hQ1' : (2 : WithTop ℤ) ≤ (Q.coeff 1).orderTop := by norm_num at hQ1; exact hQ1
  have hQ2' : (1 : WithTop ℤ) ≤ (Q.coeff 2).orderTop := by simpa [hs] using hcorner
  constructor
  · intro n hn
    apply HahnSeries.coeff_eq_zero_of_lt_orderTop
    have hn' : (n : ℤ) < 4 := by exact_mod_cast hn
    exact lt_of_lt_of_le (WithTop.coe_lt_coe.mpr hn') hQ0'
  constructor
  · intro n hn
    apply HahnSeries.coeff_eq_zero_of_lt_orderTop
    have hn' : (n : ℤ) < 2 := by exact_mod_cast hn
    exact lt_of_lt_of_le (WithTop.coe_lt_coe.mpr hn') hQ1'
  · apply HahnSeries.coeff_eq_zero_of_lt_orderTop
    exact lt_of_lt_of_le (WithTop.coe_lt_coe.mpr (by omega)) hQ2'

end Litt3.CartierAndSpin

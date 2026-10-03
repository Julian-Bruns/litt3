import Solutions.CartierAndSpin.CriticalSecondOrderCorner

namespace Litt3.CartierAndSpin

open Polynomial

variable {k ι : Type*} [Field k]

/-- The second-order improvement is derived directly for the actual
nodal source and critical derivative factor. Integrality remains the
honest local source input; no critical, quotient or initial-form weight
is presumed. -/
theorem nodal_source_second_order_corner_positive
    (B U D V Q : (LaurentSeries k)[X]) (s : Finset ι)
    (node : ι → LaurentSeries k) (q : LaurentSeries k) (hs : 3 ≤ s.card)
    (hB : ∀ j, (0 : WithTop ℤ) ≤ (B.coeff j).orderTop)
    (hB0 : (B.coeff 0).orderTop = 0)
    (hnode : ∀ i ∈ s, (2 : WithTop ℤ) ≤ (node i).orderTop)
    (hq : q.orderTop = (3 : WithTop ℤ))
    (hderivative : (B * Lagrange.nodal s node).derivative = (X ^ 5 + C q) * D)
    (hidentity : U ^ 2 - (B * Lagrange.nodal s node) * Q = D * V)
    (hUreg : ∀ j, (0 : WithTop ℤ) ≤ (U.coeff j).orderTop)
    (hDreg : ∀ j, (0 : WithTop ℤ) ≤ (D.coeff j).orderTop)
    (hVreg : ∀ j, (0 : WithTop ℤ) ≤ (V.coeff j).orderTop)
    (hU : ∀ j : ℕ, ((2 * (s.card : ℤ) - 3 - 2 * (j : ℤ) : ℤ) : WithTop ℤ) ≤
      (U.coeff j).orderTop)
    (hV : ∀ j : ℕ, ((2 * (s.card : ℤ) - 1 - 2 * (j : ℤ) : ℤ) : WithTop ℤ) ≤
      (V.coeff j).orderTop) :
    (1 : WithTop ℤ) ≤ (Q.coeff (s.card - 3)).orderTop := by
  obtain ⟨hF, hexact⟩ := nodal_cofactor_exact_weight B s node 0 2 (by omega) hB hB0 hnode
  have hFreg : ∀ j, (0 : WithTop ℤ) ≤ ((B * Lagrange.nodal s node).coeff j).orderTop := by
    intro j
    simpa using regular_polynomial_times_nodal_contact_bound B s node 0 (by omega) hB
      (fun i hi => le_trans (by norm_num) (hnode i hi)) j
  have hFexact := nodal_cofactor_contact_coefficient_exact B s node 0 2
    (by omega) hB hB0 hnode
  have hQreg : ∀ j, (0 : WithTop ℤ) ≤ (Q.coeff j).orderTop := by
    intro j
    have h := critical_interpolation_quotient_weight (B * Lagrange.nodal s node) U D V Q
      0 0 0 0 0 hidentity (by simpa using hFreg)
      ⟨s.card, by simpa using hFexact⟩
      (by simpa using hUreg) (by simpa using hDreg) (by simpa using hVreg) j
    simpa using h
  have hD (j : ℕ) : ((2 * (s.card : ℤ) - 5 - 2 * (j : ℤ) : ℤ) : WithTop ℤ) ≤
      (D.coeff j).orderTop := by
    have h := critical_derivative_factor_weight (B * Lagrange.nodal s node) D q 5
      ((s.card : ℤ) * 2) 3 2 (by omega) hq (by norm_num)
      (by simpa only [zero_add] using hF) hderivative j
    have heq : (s.card : ℤ) * 2 - 2 - 3 - 2 * (j : ℤ) =
        2 * (s.card : ℤ) - 5 - 2 * (j : ℤ) := by ring
    simpa only [heq] using h
  have hQ (j : ℕ) : ((2 * (s.card : ℤ) - 6 - 2 * (j : ℤ) : ℤ) : WithTop ℤ) ≤
      (Q.coeff j).orderTop := by
    have h := nodal_source_critical_quotient_contact_bound B U D V Q s node q 2
      (by omega) hB hB0 hnode hq hderivative hidentity
      (fun i => by
        have heq : ((s.card : ℤ) - 1) * 2 - 1 - 2 * (i : ℤ) =
            2 * (s.card : ℤ) - 3 - 2 * (i : ℤ) := by ring
        simpa only [heq] using hU i)
      (fun i => by
        have heq : ((s.card : ℤ) - 1) * 2 + 1 - 2 * (i : ℤ) =
            2 * (s.card : ℤ) - 1 - 2 * (i : ℤ) := by ring
        simpa only [heq] using hV i) j
    have heq : ((s.card : ℤ) - 2) * 2 - 2 - 2 * (j : ℤ) =
        2 * (s.card : ℤ) - 6 - 2 * (j : ℤ) := by ring
    simpa only [heq] using h
  apply critical_second_order_corner_positive (B * Lagrange.nodal s node) U D V Q s.card hs
    hidentity hFreg hUreg hDreg hVreg hQreg hFexact _ hU hD hV hQ
  intro j
  have heq : 0 + (s.card : ℤ) * 2 - 2 * (j : ℤ) =
      2 * (s.card : ℤ) - 2 * (j : ℤ) := by ring
  simpa only [heq] using hF j

end Litt3.CartierAndSpin

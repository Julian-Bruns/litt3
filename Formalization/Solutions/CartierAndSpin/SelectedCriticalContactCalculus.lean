import Solutions.CartierAndSpin.CriticalDerivativeWeights
import Solutions.CartierAndSpin.GeneralSelectedInterpolation

namespace Litt3.CartierAndSpin

open Polynomial Finset

variable {k ι τ : Type*} [Field k]

/-- The canonical sharp critical-quotient bound uses only actual nodal
source data, the literal characteristic-power derivative factorization,
and the two interpolation weights. Critical coefficient orders and
primitive source content are derived. -/
theorem nodal_source_critical_quotient_contact_bound
    (B U D V Q : (LaurentSeries k)[X]) (s : Finset ι)
    (node : ι → LaurentSeries k) (q : LaurentSeries k) (contact : ℤ)
    (hcontact : 1 ≤ contact)
    (hB : ∀ j, (0 : WithTop ℤ) ≤ (B.coeff j).orderTop)
    (hB0 : (B.coeff 0).orderTop = 0)
    (hnode : ∀ i ∈ s, (contact : WithTop ℤ) ≤ (node i).orderTop)
    (hq : q.orderTop = (3 : WithTop ℤ))
    (hderivative : (B * Lagrange.nodal s node).derivative = (X ^ 5 + C q) * D)
    (hidentity : U ^ 2 - (B * Lagrange.nodal s node) * Q = D * V)
    (hU : ∀ j : ℕ,
      ((((s.card : ℤ) - 1) * contact - 1 - contact * (j : ℤ) : ℤ) : WithTop ℤ) ≤
        (U.coeff j).orderTop)
    (hV : ∀ j : ℕ,
      ((((s.card : ℤ) - 1) * contact + 1 - contact * (j : ℤ) : ℤ) : WithTop ℤ) ≤
        (V.coeff j).orderTop) (j : ℕ) :
    ((((s.card : ℤ) - 2) * contact - 2 - contact * (j : ℤ) : ℤ) : WithTop ℤ) ≤
      (Q.coeff j).orderTop := by
  obtain ⟨hF, hexact⟩ := nodal_cofactor_exact_weight B s node 0 contact hcontact hB hB0 hnode
  apply selected_critical_quotient_contact_weight B U D V Q s node contact hcontact
    hB hB0 hnode hidentity hU _ hV j
  intro i
  have h := critical_derivative_factor_weight (B * Lagrange.nodal s node) D q 5
    ((s.card : ℤ) * contact) 3 contact (by omega) hq (by norm_num; omega)
    (by simpa only [zero_add] using hF) hderivative i
  have hweight : (s.card : ℤ) * contact - contact - 3 =
      ((s.card : ℤ) - 1) * contact - 3 := by ring
  simpa only [hweight] using h

/-- Full finite interpolation expressions produce both the moment and
quotient contact inequalities. The selected weights have orders at least
-1 and +1; nonselected terms and all cofactors are regular. Residues of
the selected nodes need not be distinct. -/
theorem actual_interpolation_critical_contact_bounds
    [DecidableEq ι]
    (B D Q : (LaurentSeries k)[X]) (s : Finset ι) (t : Finset τ)
    (node chi xi : ι → LaurentSeries k)
    (CU CV : ι → (LaurentSeries k)[X])
    (NU NV : τ → (LaurentSeries k)[X])
    (q : LaurentSeries k) (contact : ℤ) (hcontact : 1 ≤ contact)
    (hB : ∀ j, (0 : WithTop ℤ) ≤ (B.coeff j).orderTop)
    (hB0 : (B.coeff 0).orderTop = 0)
    (hnode : ∀ i ∈ s, (contact : WithTop ℤ) ≤ (node i).orderTop)
    (hchi : ∀ i ∈ s, (-1 : WithTop ℤ) ≤ (chi i).orderTop)
    (hxi : ∀ i ∈ s, (1 : WithTop ℤ) ≤ (xi i).orderTop)
    (hCU : ∀ i ∈ s, ∀ j, (0 : WithTop ℤ) ≤ ((CU i).coeff j).orderTop)
    (hCV : ∀ i ∈ s, ∀ j, (0 : WithTop ℤ) ≤ ((CV i).coeff j).orderTop)
    (hNU : ∀ i ∈ t, ∀ j, (0 : WithTop ℤ) ≤ ((NU i).coeff j).orderTop)
    (hNV : ∀ i ∈ t, ∀ j, (0 : WithTop ℤ) ≤ ((NV i).coeff j).orderTop)
    (hq : q.orderTop = (3 : WithTop ℤ))
    (hderivative : (B * Lagrange.nodal s node).derivative = (X ^ 5 + C q) * D)
    (hidentity :
      ((∑ i ∈ s, C (chi i) * CU i * Lagrange.nodal (s.erase i) node) +
        ∑ i ∈ t, NU i * Lagrange.nodal s node) ^ 2 -
        (B * Lagrange.nodal s node) * Q = D *
      ((∑ i ∈ s, C (xi i) * CV i * Lagrange.nodal (s.erase i) node) +
        ∑ i ∈ t, NV i * Lagrange.nodal s node)) (j : ℕ) :
    ((1 + ((s.card : ℤ) - 1) * contact - contact * (j : ℤ) : ℤ) : WithTop ℤ) ≤
      (((∑ i ∈ s, C (xi i) * CV i * Lagrange.nodal (s.erase i) node) +
        ∑ i ∈ t, NV i * Lagrange.nodal s node).coeff j).orderTop ∧
    ((((s.card : ℤ) - 2) * contact - 2 - contact * (j : ℤ) : ℤ) : WithTop ℤ) ≤
      (Q.coeff j).orderTop := by
  have hU := full_interpolation_signed_weight_bound s t node chi CU NU contact (-1)
    (by omega) (by omega) hnode hchi hCU hNU
  have hV := full_interpolation_signed_weight_bound s t node xi CV NV contact 1
    (by omega) hcontact hnode hxi hCV hNV
  constructor
  · exact hV j
  · apply nodal_source_critical_quotient_contact_bound B _ D _ Q s node q contact
      hcontact hB hB0 hnode hq hderivative hidentity
    · intro i
      have hweight : -1 + ((s.card : ℤ) - 1) * contact =
          ((s.card : ℤ) - 1) * contact - 1 := by ring
      simpa only [hweight] using hU i
    · intro i
      have hweight : 1 + ((s.card : ℤ) - 1) * contact =
          ((s.card : ℤ) - 1) * contact + 1 := by ring
      simpa only [hweight] using hV i

end Litt3.CartierAndSpin

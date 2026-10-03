import Definitions.SharedTensors.SchemeLocalSheets
import Solutions.SharedTensors.LocalSheetPoleBounds
import Solutions.SharedTensors.SchemeDivisorSections

open CategoryTheory AlgebraicGeometry
open scoped WithZero

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.QuotientGeometry Polynomial Finset
universe u v

variable {Z X : Scheme.{u}} [IsIntegral Z] [IsIntegral X]
  [ClosedPointDVRStalks Z] [ClosedPointDVRStalks X]
  (f : Z ⟶ X) [IsFinite f] [Surjective f]

/-- All actual coefficients obey the pushed pole-divisor bound, including
multiple points in one fiber and arbitrary effective multiplicities. -/
theorem actual_scheme_coefficient_pole_bound
    (x : ClosedPoint X) (chi : Z.functionField) (P : X.functionField[X])
    {Ω : Type v} [Field Ω] (sheets : SchemeLocalSheetFactorization f x chi P Ω)
    (p : ℕ) (G : Divisor (ClosedPoint Z)) (hG : EffectiveDivisor G)
    (hpoles : ∀ z, closedPointValuation Z z chi ≤ WithZero.exp ((p : ℤ) * G z))
    (j : ℕ) :
    closedPointValuation X x (P.coeff j) ≤
      WithZero.exp ((p : ℤ) * schemeDivisorPushforward f G x) := by
  letI := closedPointFiberFintype f x
  have h := actual_local_sheet_coefficient_pole_bound
    (closedPointValuation X x) sheets.valuation sheets.base sheets.base_valuation
    P (fun z => sheets.sheet z chi) sheets.factorization
    (fun z => (p : ℤ) * G z.val)
    (fun z => mul_nonneg (Int.natCast_nonneg p) (hG z.val))
    (fun z => by rw [sheets.sheet_valuation]; exact hpoles z.val) j
  rw [← Finset.mul_sum, ← actual_scheme_divisor_pushforward_fiber_formula] at h
  exact h

/-- Genuine scheme section-space membership follows from literal completed
sheet data and the actual source pole bounds. The existence of that sheet
data remains explicit until its completion theorem is formalized. -/
theorem actual_scheme_polynomial_coefficients_in_pushed_pole_space
    [FinitePrincipalSupport X]
    {k : Type u} [Field k] (sX : X ⟶ Spec (.of k))
    (chi : Z.functionField) (P : X.functionField[X])
    (Ω : ClosedPoint X → Type v) [∀ x, Field (Ω x)]
    (sheets : ∀ x, SchemeLocalSheetFactorization f x chi P (Ω x))
    (p : ℕ) (G : Divisor (ClosedPoint Z)) (hG : EffectiveDivisor G)
    (hpoles : ∀ z, closedPointValuation Z z chi ≤ WithZero.exp ((p : ℤ) * G z)) :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ j, P.coeff j ∈ schemeDivisorSectionSpace sX (p • schemeDivisorPushforward f G) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro j x
  simpa only [Finsupp.smul_apply, nsmul_eq_mul] using
    actual_scheme_coefficient_pole_bound f x chi P (sheets x) p G hG hpoles j

end Litt3.SharedTensors

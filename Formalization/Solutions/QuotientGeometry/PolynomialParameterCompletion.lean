import Solutions.QuotientGeometry.PrincipalAdicComparison
import Solutions.QuotientGeometry.PowerSeriesAdic
import Mathlib.Algebra.Polynomial.Div
import Mathlib.RingTheory.PowerSeries.Order
import Mathlib.RingTheory.PowerSeries.Inverse

namespace Litt3.QuotientGeometry

open Polynomial

variable (k : Type*) [Field k]

private theorem polynomial_parameter_residue_injective
    (P : k[X]) :
    ((Polynomial.coeToPowerSeries.ringHom : k[X] →+* PowerSeries k) Polynomial.X) ∣
      (Polynomial.coeToPowerSeries.ringHom P : PowerSeries k) → Polynomial.X ∣ P := by
  simp only [Polynomial.coeToPowerSeries.ringHom_apply, Polynomial.coe_X]
  rw [PowerSeries.X_dvd_iff, Polynomial.X_dvd_iff]
  simp

private theorem polynomial_parameter_residue_surjective
    (f : PowerSeries k) : ∃ P : k[X],
      ((Polynomial.coeToPowerSeries.ringHom : k[X] →+* PowerSeries k) Polynomial.X) ∣
        f - (Polynomial.coeToPowerSeries.ringHom P : PowerSeries k) := by
  refine ⟨Polynomial.C (PowerSeries.constantCoeff f), ?_⟩
  simp only [Polynomial.coeToPowerSeries.ringHom_apply, Polynomial.coe_X, Polynomial.coe_C]
  rw [PowerSeries.X_dvd_iff]
  simp

/-- The polynomial parameter completion is the entire formal power
series ring, constructed through the actual quotient isomorphisms. -/
noncomputable def polynomialParameterCompletionEquiv :
    PowerSeries k ≃+* AdicCompletion (Ideal.span {(Polynomial.X : k[X])}) (k[X]) := by
  let ep := principalAdicComparison (Polynomial.coeToPowerSeries.ringHom : k[X] →+* PowerSeries k)
    (Polynomial.X : k[X]) (by simpa using (PowerSeries.X_ne_zero (R := k)))
    (polynomial_parameter_residue_injective k) (polynomial_parameter_residue_surjective k)
  letI : IsAdicComplete
      (Ideal.span {(Polynomial.coeToPowerSeries.ringHom : k[X] →+* PowerSeries k) Polynomial.X})
      (PowerSeries k) := by
    simpa [powerSeriesParameterIdeal] using power_series_parameter_adic_complete k
  exact (AdicCompletion.ofAlgEquiv
    (Ideal.span {(Polynomial.coeToPowerSeries.ringHom : k[X] →+* PowerSeries k) Polynomial.X})).toRingEquiv.trans ep.symm

@[simp] theorem polynomialParameterCompletionEquiv_coe (P : k[X]) :
    polynomialParameterCompletionEquiv k (P : PowerSeries k) =
      AdicCompletion.of (Ideal.span {(Polynomial.X : k[X])}) (k[X]) P := by
  dsimp only [polynomialParameterCompletionEquiv, RingEquiv.trans_apply]
  apply (principalAdicComparison (Polynomial.coeToPowerSeries.ringHom : k[X] →+* PowerSeries k)
    (Polynomial.X : k[X]) (by simpa using (PowerSeries.X_ne_zero (R := k)))
    (polynomial_parameter_residue_injective k) (polynomial_parameter_residue_surjective k)).injective
  rw [RingEquiv.apply_symm_apply, principalAdicComparison_of]
  rfl

@[simp] theorem polynomialParameterCompletionEquiv_X :
    polynomialParameterCompletionEquiv k PowerSeries.X =
      AdicCompletion.of (Ideal.span {(Polynomial.X : k[X])}) (k[X]) Polynomial.X := by
  simpa using polynomialParameterCompletionEquiv_coe k (Polynomial.X : k[X])

@[simp] theorem polynomialParameterCompletionEquiv_C (c : k) :
    polynomialParameterCompletionEquiv k (PowerSeries.C c) =
      AdicCompletion.of (Ideal.span {(Polynomial.X : k[X])}) (k[X]) (Polynomial.C c) := by
  simpa using polynomialParameterCompletionEquiv_coe k (Polynomial.C c)

end Litt3.QuotientGeometry

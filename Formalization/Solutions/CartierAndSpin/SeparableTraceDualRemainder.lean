import Solutions.CartierAndSpin.SeparableTraceDualCoefficient
import Solutions.CartierAndSpin.ReducedSourcePolynomials

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- The full trace-dual formula for every polynomial numerator, using
its actual reduced remainder in the original unsplit source quotient. -/
theorem separable_quotient_residue_trace_remainder (F J : K[X]) (hF : F ≠ 0)
    (hsep : F.Separable) (derivativeUnit : (AdjoinRoot F)ˣ)
    (hunit : (derivativeUnit : AdjoinRoot F) = AdjoinRoot.mk F F.derivative) :
    Algebra.trace K (AdjoinRoot F)
      (AdjoinRoot.mk F J * (↑derivativeUnit⁻¹ : AdjoinRoot F)) =
      (J % F).coeff (F.natDegree - 1) / F.leadingCoeff := by
  have hdegree : (J % F).degree < F.natDegree := by
    rw [← degree_eq_natDegree hF]
    exact degree_mod_lt J hF
  rw [← source_quotient_mk_remainder F J]
  exact separable_quotient_residue_trace_coefficient F (J % F) hF hsep
    derivativeUnit hunit hdegree

end Litt3.CartierAndSpin

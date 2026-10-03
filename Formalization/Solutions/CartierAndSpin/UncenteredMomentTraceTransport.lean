import Solutions.CartierAndSpin.UncenteredTraceTransport
import Definitions.CartierAndSpin.LinearMoments

namespace Litt3.CartierAndSpin

variable {R K A B : Type*} [CommRing R] [Field K] [Algebra R K]
  [CommRing A] [CommRing B] [Algebra K A] [Algebra K B]
  [Algebra R A] [Algebra R B] [IsScalarTower R K A] [IsScalarTower R K B]

/-- Every derivative moment, including the zeroth, transports through
the actual algebra equivalence and the actual scaled denominator unit. -/
theorem trace_derivative_moment_equiv_transport (E : Derivation R A A)
    (e : B ≃ₐ[K] A) (unit : Aˣ) (scale : K) (hscale : scale ≠ 0) (x : B) (n : ℕ) :
    let E' := transportedDerivation (e.symm.restrictScalars R) E
    let unit' := Units.map e.symm.toMonoidHom (scaledAlgebraUnit scale hscale unit)
    functionalMoment (Algebra.trace K B) (↑unit'⁻¹ : B) (E' x) n =
      functionalMoment (Algebra.trace K A) (scale⁻¹ • (↑unit⁻¹ : A)) (E (e x)) n := by
  dsimp only [functionalMoment]
  rw [← Algebra.trace_eq_of_algEquiv e, map_mul, map_pow]
  have hderivative : e (transportedDerivation (e.symm.restrictScalars R) E x) = E (e x) := by
    change e (e.symm (E (e x))) = E (e x)
    exact e.apply_symm_apply _
  have hinverse : e (↑(Units.map e.symm.toMonoidHom (scaledAlgebraUnit scale hscale unit))⁻¹ : B) =
      scale⁻¹ • (↑unit⁻¹ : A) := by
    rw [← map_inv]
    change e (e.symm (↑(scaledAlgebraUnit scale hscale unit)⁻¹ : A)) = _
    rw [e.apply_symm_apply, scaledAlgebraUnit_inverse_value]
  rw [hderivative, hinverse]

end Litt3.CartierAndSpin

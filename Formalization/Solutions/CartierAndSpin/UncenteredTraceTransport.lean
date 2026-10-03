import Solutions.CartierAndSpin.AffineTraceTransport

namespace Litt3.CartierAndSpin

variable {R K A B : Type*} [CommRing R] [Field K] [Algebra R K]
  [CommRing A] [CommRing B] [Algebra K A] [Algebra K B]
  [Algebra R A] [Algebra R B] [IsScalarTower R K A] [IsScalarTower R K B]

theorem trace_derivative_energy_equiv_transport (E : Derivation R A A)
    (e : B ≃ₐ[K] A) (unit : Aˣ) (scale : K) (hscale : scale ≠ 0) (x : B) :
    let E' := transportedDerivation (e.symm.restrictScalars R) E
    let unit' := Units.map e.symm.toMonoidHom (scaledAlgebraUnit scale hscale unit)
    Algebra.trace K B (E' x ^ 2 * (↑unit'⁻¹ : B)) =
      Algebra.trace K A (E (e x) ^ 2 * (scale⁻¹ • (↑unit⁻¹ : A))) := by
  dsimp only
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

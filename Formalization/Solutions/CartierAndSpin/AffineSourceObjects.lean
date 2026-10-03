import Solutions.CartierAndSpin.AffineSourceCenteredEnergy
import Solutions.CartierAndSpin.UncenteredTraceTransport

namespace Litt3.CartierAndSpin

open Polynomial

variable {R K A B : Type*} [CommRing R] [Field K] [Algebra R K]
  [CommRing A] [CommRing B] [Algebra K A] [Algebra K B]
  [Algebra R A] [Algebra R B] [IsScalarTower R K A] [IsScalarTower R K B]

theorem transportedDerivation_compatible_with_base (D : Derivation R K K)
    (E : Derivation R A A)
    (compatible : ∀ c : K, E (algebraMap K A c) = algebraMap K A (D c))
    (e : B ≃ₐ[K] A) (c : K) :
    transportedDerivation (e.symm.restrictScalars R) E (algebraMap K B c) =
      algebraMap K B (D c) := by
  change e.symm (E (e (algebraMap K B c))) = _
  rw [e.commutes, compatible, e.symm.commutes]

theorem affine_source_transported_unit_value (F : K[X]) (p : ℕ) [CharP K p] (hp : 2 ≤ p)
    (a b q : K) (N : ℕ) (ha : a ≠ 0) (unit : (AdjoinRoot F)ˣ)
    (hunit : (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q)) :
    (Units.map (affineSourceQuotientEquiv F a b N ha).symm.toMonoidHom
      (scaledAlgebraUnit (a ^ p) (pow_ne_zero _ ha) unit) :
        AdjoinRoot (affineSourceFramePolynomial F a b N)) =
      AdjoinRoot.mk (affineSourceFramePolynomial F a b N) (X ^ p + C (a ^ p * q - b ^ p)) := by
  let e := affineSourceQuotientEquiv F a b N ha
  apply e.injective
  change e (e.symm (scaledAlgebraUnit (a ^ p) (pow_ne_zero _ ha) unit : AdjoinRoot F)) = _
  rw [e.apply_symm_apply, scaledAlgebraUnit_value, hunit]
  exact (affine_source_quotient_factor F p hp a b q N ha).symm

end Litt3.CartierAndSpin

import Solutions.CartierAndSpin.SourceBoundarySubringIntegrality
import Solutions.CartierAndSpin.UncenteredMomentTraceTransport
import Solutions.CartierAndSpin.AffineSourceObjects
import Solutions.CartierAndSpin.SourceTranslationTwistedEnergy

namespace Litt3.CartierAndSpin

open Polynomial

variable {R K ι : Type*} [CommRing R] [Field K] [Algebra R K]
  [CharP K 5] [Fintype ι]

/-- Boundary regularity is preserved in the literal translated
polynomial quotient, with its actual transported unit and derivation. -/
theorem source_boundary_quotient_integrality (S : Subring K) (D : Derivation R K K)
    (F H : K[X]) (q tau leading : K) (node : ι → K)
    (hdegree : 5 ≤ F.natDegree) (hsep : F.Separable) (hinj : Function.Injective node)
    (hleading : leading ≠ 0) (htau : tau ≠ 0)
    (hfactor : F = C leading * Lagrange.nodal Finset.univ node)
    (hsource : F = (X ^ 5 + C q) * H + C tau)
    (hs : (H %ₘ (X ^ 5 + C q)).coeff 4 = 0)
    (hD : ∀ x ∈ S, D x ∈ S) (hnodes : ∀ i, node i ∈ S)
    (hInv : ∀ i, (node i ^ 5 + q)⁻¹ ∈ S) :
    ∃ (unit : (AdjoinRoot F)ˣ) (E : Derivation R (AdjoinRoot F) (AdjoinRoot F)),
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ 5 + C q) ∧
      (∀ a : K, E (algebraMap K (AdjoinRoot F) a) = algebraMap K (AdjoinRoot F) (D a)) ∧
      ∀ b : K,
        let e := affineSourceQuotientEquiv F 1 b F.natDegree one_ne_zero
        let F' := affineSourceFramePolynomial F 1 b F.natDegree
        let E' := transportedDerivation (e.symm.restrictScalars R) E
        let unit' := Units.map e.symm.toMonoidHom unit
        F' = (X ^ 5 + C (q - b ^ 5)) * H.comp (X - C b) + C tau ∧
        (unit' : AdjoinRoot F') = AdjoinRoot.mk F' (X ^ 5 + C (q - b ^ 5)) ∧
        (∀ a : K, E' (algebraMap K (AdjoinRoot F') a) = algebraMap K (AdjoinRoot F') (D a)) ∧
        functionalMoment (Algebra.trace K (AdjoinRoot F')) (↑unit'⁻¹ : AdjoinRoot F')
          (E' (AdjoinRoot.root F')) 2 ∈ S ∧
        functionalMomentFiveInvariant (Algebra.trace K (AdjoinRoot F')) (↑unit'⁻¹ : AdjoinRoot F')
          (E' (AdjoinRoot.root F')) ∈ S := by
  obtain ⟨unit, E, hunit, compatible, hmoment, htranslated⟩ :=
    source_boundary_subring_integrality S D F H q tau leading node hdegree hsep hinj
      hleading htau hfactor hsource hs hD hnodes hInv
  refine ⟨unit, E, hunit, compatible, ?_⟩
  intro b
  dsimp only
  have htransport (n : ℕ) := trace_derivative_moment_equiv_transport E
    (affineSourceQuotientEquiv F 1 b F.natDegree one_ne_zero) unit 1 one_ne_zero
    (AdjoinRoot.root (affineSourceFramePolynomial F 1 b F.natDegree)) n
  simp only [scaledAlgebraUnit_one, inv_one, one_smul, affineSourceQuotientEquiv_root,
    map_one, one_mul] at htransport
  refine ⟨?_, ?_, transportedDerivation_compatible_with_base D E compatible _, ?_, ?_⟩
  · simpa using affine_source_frame_presentation 5 (by omega) F H 1 b q tau
      F.natDegree one_ne_zero hsource
  · simpa only [one_pow, one_mul, one_div, inv_one, Polynomial.C_1,
      scaledAlgebraUnit_one] using affine_source_transported_unit_value
      F 5 (by omega) 1 b q F.natDegree one_ne_zero unit hunit
  · rw [htransport 2]
    exact (htranslated b).1
  · unfold functionalMomentFiveInvariant
    rw [htransport 2, htransport 4, htransport 3]
    exact (htranslated b).2

end Litt3.CartierAndSpin

import Solutions.CartierAndSpin.UnsplitMomentTranslation
import Solutions.CartierAndSpin.UncenteredMomentTraceTransport
import Solutions.CartierAndSpin.SourceTranslationTwistedEnergy

namespace Litt3.CartierAndSpin

open Polynomial Finset

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]

/-- Every boundary moment has its full binomial translation law in
the literal translated source quotient. The two invariant combinations
are transported in that quotient as well, with no splitting hypothesis. -/
theorem source_quotient_moment_translation (D : Derivation R K K)
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K)
    (hp : 2 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0)
    (hsep : F.Separable) (hsource : F = (X ^ p + C q) * H + C tau)
    (hs : (H %ₘ (X ^ p + C q)).coeff (p - 1) = 0) :
    ∃ (unit : (AdjoinRoot F)ˣ) (E : Derivation R (AdjoinRoot F) (AdjoinRoot F)),
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      (∀ a : K, E (algebraMap K (AdjoinRoot F) a) = algebraMap K (AdjoinRoot F) (D a)) ∧
      functionalMoment (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
        (E (AdjoinRoot.root F)) 0 = 0 ∧
      functionalMoment (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
        (E (AdjoinRoot.root F)) 1 = 0 ∧
      ∀ b : K,
        let quotientEquiv := affineSourceQuotientEquiv F 1 b F.natDegree one_ne_zero
        let F' := affineSourceFramePolynomial F 1 b F.natDegree
        let E' := transportedDerivation (quotientEquiv.symm.restrictScalars R) E
        let unit' := Units.map quotientEquiv.symm.toMonoidHom unit
        (unit' : AdjoinRoot F') = AdjoinRoot.mk F' (X ^ p + C (q - b ^ p)) ∧
        (∀ a : K, E' (algebraMap K (AdjoinRoot F') a) = algebraMap K (AdjoinRoot F') (D a)) ∧
        (∀ n : ℕ,
          functionalMoment (Algebra.trace K (AdjoinRoot F')) (↑unit'⁻¹ : AdjoinRoot F')
            (E' (AdjoinRoot.root F')) n =
            ∑ j ∈ range (n + 1), (n.choose j : K) * D b ^ (n - j) *
              functionalMoment (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
                (E (AdjoinRoot.root F)) j) ∧
        functionalMoment (Algebra.trace K (AdjoinRoot F')) (↑unit'⁻¹ : AdjoinRoot F')
          (E' (AdjoinRoot.root F')) 2 =
          functionalMoment (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
            (E (AdjoinRoot.root F)) 2 ∧
        functionalMomentDiscriminant (Algebra.trace K (AdjoinRoot F')) (↑unit'⁻¹ : AdjoinRoot F')
          (E' (AdjoinRoot.root F')) =
          functionalMomentDiscriminant (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
            (E (AdjoinRoot.root F)) := by
  obtain ⟨unit, E, hunit, compatible, hzero, hone, htranslations⟩ :=
    sourceTraceZeroMomentTranslations D F H p q tau hp hdegree htau hsep hsource hs
  refine ⟨unit, E, hunit, compatible, hzero, hone, ?_⟩
  intro b
  dsimp only
  have htransport (n : ℕ) := trace_derivative_moment_equiv_transport E
    (affineSourceQuotientEquiv F 1 b F.natDegree one_ne_zero) unit 1 one_ne_zero
    (AdjoinRoot.root (affineSourceFramePolynomial F 1 b F.natDegree)) n
  simp only [scaledAlgebraUnit_one, inv_one, one_smul, affineSourceQuotientEquiv_root,
    map_one, one_mul] at htransport
  refine ⟨?_, transportedDerivation_compatible_with_base D E compatible _, ?_, ?_, ?_⟩
  · simpa only [one_pow, one_mul, one_div, inv_one, Polynomial.C_1,
      scaledAlgebraUnit_one] using affine_source_transported_unit_value
      F p hp 1 b q F.natDegree one_ne_zero unit hunit
  · intro n
    rw [htransport n]
    exact (htranslations b).2.1 n
  · rw [htransport 2]
    exact (htranslations b).2.2.1
  · unfold functionalMomentDiscriminant
    rw [htransport 2, htransport 4, htransport 3]
    exact (htranslations b).2.2.2

end Litt3.CartierAndSpin

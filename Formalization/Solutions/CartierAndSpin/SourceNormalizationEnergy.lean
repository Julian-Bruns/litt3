import Definitions.CartierAndSpin.SourceNormalization
import Solutions.CartierAndSpin.AffineSourceObjects
import Solutions.CartierAndSpin.UnsplitSourceEnergy

namespace Litt3.CartierAndSpin

open Polynomial

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]

theorem sourceNormalizationQuotientEquiv_mk (F P : K[X]) (t : K) (ht : t ≠ 0) :
    sourceNormalizationQuotientEquiv F t ht (AdjoinRoot.mk (C t * F) P) = AdjoinRoot.mk F P := by
  exact Ideal.quotientEquivAlgOfEq_mk K _ P

theorem source_normalized_remainder (H : K[X]) (p : ℕ) [CharP K p] (hp : 2 ≤ p) (q t : K) :
    (C t * H) %ₘ (X ^ p + C q) = C t * (H %ₘ (X ^ p + C q)) := by
  simpa [zero_pow (by omega : p ≠ 0)] using
    affine_source_remainder p hp H 1 0 q t one_ne_zero

/-- Qsharp is independent of every nonzero meromorphic equation scale.
The actual quotient, root, denominator unit and derivation are all
transported through the equality of the literal source ideals. -/
theorem source_normalization_twisted_energy (D : Derivation R K K)
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K)
    (hp : 3 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0)
    (hsep : F.Separable) (hsource : F = (X ^ p + C q) * H + C tau) :
    ∃ (unit : (AdjoinRoot F)ˣ) (E : Derivation R (AdjoinRoot F) (AdjoinRoot F)),
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      (∀ c : K, E (algebraMap K (AdjoinRoot F) c) = algebraMap K (AdjoinRoot F) (D c)) ∧
      ∀ (t : K) (ht : t ≠ 0),
        let e := sourceNormalizationQuotientEquiv F t ht
        let E' := transportedDerivation (e.symm.restrictScalars R) E
        let unit' := Units.map e.symm.toMonoidHom unit
        (unit' : AdjoinRoot (C t * F)) = AdjoinRoot.mk (C t * F) (X ^ p + C q) ∧
        (∀ c : K, E' (algebraMap K (AdjoinRoot (C t * F)) c) =
          algebraMap K (AdjoinRoot (C t * F)) (D c)) ∧
        sourceQuotientDifferentialEnergy (C t * F) E' unit' -
          4 * D q * D (((C t * H) %ₘ (X ^ p + C q)).coeff (p - 2) / (t * tau)) =
          sourceQuotientDifferentialEnergy F E unit -
            4 * D q * D ((H %ₘ (X ^ p + C q)).coeff (p - 2) / tau) := by
  obtain ⟨unit, E, hunit, compatible, hdifferential, hsquare, hpower⟩ :=
    sourceQuotientDifferentialCalculus D F H p q tau hp hdegree htau hsep hsource
  refine ⟨unit, E, hunit, compatible, ?_⟩
  intro t ht
  dsimp only
  let e := sourceNormalizationQuotientEquiv F t ht
  constructor
  · apply e.injective
    change e (e.symm (unit : AdjoinRoot F)) = _
    rw [e.apply_symm_apply, sourceNormalizationQuotientEquiv_mk, hunit]
  constructor
  · exact transportedDerivation_compatible_with_base D E compatible e
  · have hscale : scaledAlgebraUnit (1 : K) one_ne_zero unit = unit := by
      apply Units.ext
      simp [scaledAlgebraUnit_value]
    have henergy := trace_derivative_energy_equiv_transport E e unit 1 one_ne_zero
      (AdjoinRoot.root (C t * F))
    simp only [hscale, inv_one, one_smul] at henergy
    have hroot : e (AdjoinRoot.root (C t * F)) = AdjoinRoot.root F :=
      sourceNormalizationQuotientEquiv_mk F X t ht
    rw [hroot] at henergy
    unfold sourceQuotientDifferentialEnergy
    rw [henergy, source_normalized_remainder H p (by omega) q t, coeff_C_mul]
    congr 2
    field_simp

end Litt3.CartierAndSpin

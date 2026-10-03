import Solutions.CartierAndSpin.AffineSourceCoefficientWeights
import Solutions.CartierAndSpin.AffineSourceObjects
import Solutions.CartierAndSpin.UnsplitSourceEnergy

namespace Litt3.CartierAndSpin

open Polynomial

variable {R K A : Type*} [CommRing R] [Field K] [Algebra R K]
  [CommRing A] [Algebra K A] [Algebra R A]

theorem functional_translation_energy_invariant (D : Derivation R K K)
    (E : Derivation R A A)
    (compatible : ∀ x : K, E (algebraMap K A x) = algebraMap K A (D x))
    (l : A →ₗ[K] K) (weight w : A) (b : K)
    (hzero : l weight = 0) (hfirst : l (E w * weight) = 0) :
    l (E (w + algebraMap K A b) ^ 2 * weight) = l (E w ^ 2 * weight) := by
  simpa only [map_one, one_mul, one_pow, zero_pow (by omega : (2 : ℕ) ≠ 0), D.map_one_eq_zero, mul_zero,
    zero_mul, add_zero, hzero, hfirst] using
    functional_affine_derivative_square D E compatible l weight w 1 b

theorem scaledAlgebraUnit_one (unit : Aˣ) : scaledAlgebraUnit (1 : K) one_ne_zero unit = unit := by
  apply Units.ext
  simp only [scaledAlgebraUnit_value, map_one, one_mul]

/-- On the actual source coefficient s=0, Qsharp is invariant under
every meromorphic source translation in the literal translated quotient. -/
theorem source_translation_twisted_energy (D : Derivation R K K)
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K)
    (hp : 3 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0)
    (hsep : F.Separable) (hsource : F = (X ^ p + C q) * H + C tau)
    (hs : (H %ₘ (X ^ p + C q)).coeff (p - 1) = 0) :
    ∃ (unit : (AdjoinRoot F)ˣ) (E : Derivation R (AdjoinRoot F) (AdjoinRoot F)),
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      (∀ c : K, E (algebraMap K (AdjoinRoot F) c) = algebraMap K (AdjoinRoot F) (D c)) ∧
      ∀ b : K,
        let e := affineSourceQuotientEquiv F 1 b F.natDegree one_ne_zero
        let F' := affineSourceFramePolynomial F 1 b F.natDegree
        let H' := H.comp (X - C b)
        let E' := transportedDerivation (e.symm.restrictScalars R) E
        let unit' := Units.map e.symm.toMonoidHom unit
        F' = (X ^ p + C (q - b ^ p)) * H' + C tau ∧
        (unit' : AdjoinRoot F') = AdjoinRoot.mk F' (X ^ p + C (q - b ^ p)) ∧
        (∀ c : K, E' (algebraMap K (AdjoinRoot F') c) = algebraMap K (AdjoinRoot F') (D c)) ∧
        sourceQuotientDifferentialEnergy F' E' unit' -
          4 * D (q - b ^ p) * D ((H' %ₘ (X ^ p + C (q - b ^ p))).coeff (p - 2) / tau) =
          sourceQuotientDifferentialEnergy F E unit -
            4 * D q * D ((H %ₘ (X ^ p + C q)).coeff (p - 2) / tau) := by
  obtain ⟨unit, E, hunit, compatible, hdifferential, hsquare, hpower⟩ :=
    sourceQuotientDifferentialCalculus D F H p q tau hp hdegree htau hsep hsource
  obtain ⟨unit0, hunit0, hmoments⟩ := source_coefficient_moments F H p q tau
    (by omega) hdegree htau hsep hsource
  have hunitEq : unit0 = unit := by apply Units.ext; rw [hunit0, hunit]
  subst unit0
  have hzero : Algebra.trace K (AdjoinRoot F) (↑unit⁻¹ : AdjoinRoot F) = 0 := by
    simpa only [pow_zero, one_mul] using (hmoments 0 (by omega)).1
  have hfirst : Algebra.trace K (AdjoinRoot F)
      (E (AdjoinRoot.root F) * (↑unit⁻¹ : AdjoinRoot F)) = 0 := by
    simpa only [Nat.reduceSub, pow_zero, one_mul, hs, zero_mul, zero_div] using
      hdifferential 1 (by omega) (by omega)
  refine ⟨unit, E, hunit, compatible, ?_⟩
  intro b
  dsimp only
  refine ⟨?_, ?_, transportedDerivation_compatible_with_base D E compatible _, ?_⟩
  · simpa using affine_source_frame_presentation p (by omega) F H 1 b q tau
      F.natDegree one_ne_zero hsource
  · simpa only [one_pow, one_mul, one_div, inv_one, Polynomial.C_1,
      scaledAlgebraUnit_one] using affine_source_transported_unit_value
      F p (by omega) 1 b q F.natDegree one_ne_zero unit hunit
  · have hcenter := (affine_source_remainder_coefficient_weights p (by omega)
      H 1 b q F.natDegree one_ne_zero).2
    simp only [one_pow, one_mul, one_div, inv_one, Polynomial.C_1, hs, mul_zero, add_zero] at hcenter
    have hDq : D (q - b ^ p) = D q := by
      rw [map_sub, D.leibniz_pow]
      simp only [nsmul_eq_mul, smul_eq_mul, CharP.cast_eq_zero, zero_mul, sub_zero]
    rw [hcenter, hDq]
    unfold sourceQuotientDifferentialEnergy
    congr 1
    have henergy := trace_derivative_energy_equiv_transport E
      (affineSourceQuotientEquiv F 1 b F.natDegree one_ne_zero) unit 1 one_ne_zero
      (AdjoinRoot.root (affineSourceFramePolynomial F 1 b F.natDegree))
    simp only [scaledAlgebraUnit_one, inv_one, one_smul, affineSourceQuotientEquiv_root,
      map_one, one_mul] at henergy
    rw [henergy]
    exact functional_translation_energy_invariant D E compatible (Algebra.trace K (AdjoinRoot F))
      (↑unit⁻¹ : AdjoinRoot F) (AdjoinRoot.root F) b hzero hfirst

end Litt3.CartierAndSpin

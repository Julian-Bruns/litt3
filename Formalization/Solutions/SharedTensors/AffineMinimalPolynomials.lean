import Solutions.SharedTensors.DifferentialPolynomials
import Mathlib.FieldTheory.Minpoly.Field
import Mathlib.FieldTheory.IntermediateField.Adjoin.Basic

namespace Litt3.SharedTensors

open Polynomial

variable {k K L : Type*} [Field k] [Field K] [Field L]
  [Algebra k K] [Algebra k L] [Algebra K L]

theorem derivation_polynomial_aeval
    (D : Derivation k K K) (E : Derivation k L L)
    (compatible : ∀ a : K, algebraMap K L (D a) = E (algebraMap K L a))
    (chi : L) (F : K[X]) :
    E (aeval chi F) = aeval chi (coefficientDifferential D.toLinearMap F) +
      aeval chi (derivative F) * E chi := by
  have h := D.apply_aeval_eq' E (Algebra.linearMap K L) compatible chi F
  have hpoly : coefficientDifferential D.toLinearMap F =
      PolynomialModule.equivPolynomial (D.mapCoeffs F) := rfl
  rw [hpoly, PolynomialModule.aeval_equivPolynomial]
  simpa only [smul_eq_mul] using h

/-- The top coefficient cancels for the actual monic polynomial;
the affine differential expression has strictly smaller degree. -/
theorem affine_derivation_polynomial_degree_lt
    (D : Derivation k K K) (eta beta : K) (F : K[X]) (hF : F.Monic) :
    (affineDifferentialPolynomial D.toLinearMap eta beta F.natDegree F).degree <
      F.natDegree := by
  apply (degree_lt_iff_coeff_zero _ _).mpr
  intro i hi
  rw [affine_differential_polynomial_coeff]
  have hnext : F.coeff (i + 1) = 0 :=
    coeff_eq_zero_of_natDegree_lt (by omega)
  rcases eq_or_lt_of_le hi with heq | hlt
  · subst i
    simp only [hF.coeff_natDegree, hnext, mul_zero, add_zero, sub_self, zero_mul]
    exact D.map_one_eq_zero
  · have hzero : F.coeff i = 0 := coeff_eq_zero_of_natDegree_lt hlt
    simp only [hzero, hnext, map_zero, mul_zero, add_zero]

/-- An actual algebraic element satisfying the affine differential
equation forces its actual minimal polynomial to satisfy the exact
polynomial equation. No conjugate set or Galois closure is assumed. -/
theorem affine_minimal_polynomial_equation
    (D : Derivation k K K) (E : Derivation k L L)
    (compatible : ∀ a : K, algebraMap K L (D a) = E (algebraMap K L a))
    (eta beta : K) (chi : L) (integral : IsIntegral K chi)
    (affine : E chi = algebraMap K L eta + chi * algebraMap K L beta) :
    affineDifferentialPolynomial D.toLinearMap eta beta
      (minpoly K chi).natDegree (minpoly K chi) = 0 := by
  let F := minpoly K chi
  let H := affineDifferentialPolynomial D.toLinearMap eta beta F.natDegree F
  have hF : F.Monic := minpoly.monic integral
  have hroot : aeval chi F = 0 := minpoly.aeval K chi
  have hdiff := derivation_polynomial_aeval D E compatible chi F
  rw [hroot, map_zero, affine] at hdiff
  have hHroot : aeval chi H = 0 := by
    simp only [H, affineDifferentialPolynomial, map_sub, map_add, map_mul,
      aeval_C, aeval_X, hroot, mul_zero, sub_zero]
    linear_combination -hdiff
  have hdiv : F ∣ H := minpoly.dvd K chi hHroot
  by_contra hne
  have hnat := natDegree_le_of_dvd hdiv hne
  have hlt := affine_derivation_polynomial_degree_lt D eta beta F hF
  have hnatlt := (natDegree_lt_iff_degree_lt hne).mpr hlt
  change H.natDegree < F.natDegree at hnatlt
  omega

/-- Every actual separable minimal polynomial with the stated complete
coefficient-space vanishings has degree below the characteristic. -/
theorem affine_minimal_polynomial_degree_bound
    (p : ℕ) [CharP K p] (hp : 0 < p)
    (D : Derivation k K K) (E : Derivation k L L)
    (compatible : ∀ a : K, algebraMap K L (D a) = E (algebraMap K L a))
    (eta beta : K) (V : Submodule k K)
    (characters : NoHomogeneousCharacters D.toLinearMap beta V p)
    (constants : NoNonconstantDifferentialConstants D.toLinearMap V)
    (chi : L) (integral : IsIntegral K chi) (separable : IsSeparable K chi)
    (coefficients : CoefficientsIn V (minpoly K chi))
    (affine : E chi = algebraMap K L eta + chi * algebraMap K L beta) :
    (minpoly K chi).natDegree < p := by
  apply character_polynomial_separable_degree_bound p hp D.toLinearMap eta beta V
    characters constants (minpoly K chi) (minpoly.monic integral) coefficients
  · exact (affine_differential_polynomial_zero_iff ..).mp
      (affine_minimal_polynomial_equation D E compatible eta beta chi integral affine)
  · exact minpoly.irreducible integral
  · exact separable

/-- The bound is on the actual generated field extension. It does not
require the ambient field to be finite over the constant field. -/
theorem affine_generated_field_degree_bound
    (p : ℕ) [CharP K p] (hp : 0 < p)
    (D : Derivation k K K) (E : Derivation k L L)
    (compatible : ∀ a : K, algebraMap K L (D a) = E (algebraMap K L a))
    (eta beta : K) (V : Submodule k K)
    (characters : NoHomogeneousCharacters D.toLinearMap beta V p)
    (constants : NoNonconstantDifferentialConstants D.toLinearMap V)
    (chi : L) (integral : IsIntegral K chi) (separable : IsSeparable K chi)
    (coefficients : CoefficientsIn V (minpoly K chi))
    (affine : E chi = algebraMap K L eta + chi * algebraMap K L beta) :
    Module.finrank K (IntermediateField.adjoin K {chi}) < p := by
  rw [IntermediateField.adjoin.finrank integral]
  exact affine_minimal_polynomial_degree_bound p hp D E compatible eta beta V
    characters constants chi integral separable coefficients affine

/-- If the actual element generates the supplied source field, the
same conclusion bounds that source field's actual extension degree. -/
theorem affine_source_field_degree_bound
    (p : ℕ) [CharP K p] (hp : 0 < p)
    (D : Derivation k K K) (E : Derivation k L L)
    (compatible : ∀ a : K, algebraMap K L (D a) = E (algebraMap K L a))
    (eta beta : K) (V : Submodule k K)
    (characters : NoHomogeneousCharacters D.toLinearMap beta V p)
    (constants : NoNonconstantDifferentialConstants D.toLinearMap V)
    (chi : L) (integral : IsIntegral K chi) (separable : IsSeparable K chi)
    (coefficients : CoefficientsIn V (minpoly K chi))
    (affine : E chi = algebraMap K L eta + chi * algebraMap K L beta)
    (generates : IntermediateField.adjoin K {chi} = ⊤) :
    Module.finrank K L < p := by
  have h := affine_generated_field_degree_bound p hp D E compatible eta beta V
    characters constants chi integral separable coefficients affine
  rw [generates] at h
  simpa only [IntermediateField.finrank_top'] using h

end Litt3.SharedTensors

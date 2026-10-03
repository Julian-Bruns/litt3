import Solutions.Deformations.BalancedPreparedMonomialSocle
import Solutions.Deformations.QuadraticFrobeniusRedundancy
import Solutions.Deformations.PolynomialSeriesPowerCutoffRelations

set_option maxHeartbeats 800000
set_option synthInstance.maxHeartbeats 100000

namespace Litt3.Deformations

variable {K A : Type*} [Field K] [CommRing A] [Algebra K A]

/-- The literal two-relation polynomial quotient is the quotient of
the genuine original quadratic algebra by the retained odd root power. -/
noncomputable def balancedPreparedSplitRelationEquiv (g : A) (Q : ℕ) :
    (Polynomial A ⧸ Ideal.span ({splitQuadraticPolynomial g, Polynomial.X ^ Q} : Set _)) ≃ₐ[K]
      (SplitQuadraticAlgebra g ⧸ Ideal.span
        ({AdjoinRoot.root (splitQuadraticPolynomial g) ^ Q} : Set _)) := by
  have image : (Ideal.span ({Polynomial.X ^ Q} : Set (Polynomial A))).map
      (Ideal.Quotient.mk (Ideal.span ({splitQuadraticPolynomial g} : Set (Polynomial A)))) =
      Ideal.span ({AdjoinRoot.root (splitQuadraticPolynomial g) ^ Q} : Set _) := by
    rw [Ideal.map_span, Set.image_singleton, map_pow]
    rfl
  rw [Ideal.span_insert]
  exact (DoubleQuot.quotQuotEquivQuotSupₐ K
    (Ideal.span ({splitQuadraticPolynomial g} : Set _))
    (Ideal.span ({Polynomial.X ^ Q} : Set _))).symm.trans
      (Ideal.quotientEquivAlgOfEq K image)

/-- The original balanced odd-power relation removes exactly the one
nonzero actual highest socle direction in the coefficient quadratic algebra. -/
theorem balanced_prepared_split_polynomial_finrank [Nontrivial A] [Module.Finite K A]
    (g : A) (m : ℕ) (top : (-g) ^ m ≠ 0) (cutoff : g ^ (m + 1) = 0)
    (scalar : ∀ a : A, ∃ c : K, a * (-g) ^ m = c • ((-g) ^ m)) :
    Module.finrank K (Polynomial A ⧸
      Ideal.span ({splitQuadraticPolynomial g, Polynomial.X ^ (2 * m + 1)} : Set _)) =
        2 * Module.finrank K A - 1 := by
  rw [(balancedPreparedSplitRelationEquiv (K := K) g (2 * m + 1)).toLinearEquiv.finrank_eq]
  exact balanced_prepared_split_quotient_finrank g m top cutoff scalar

variable (p : ℕ) [Fact p.Prime] [CharP A p]

/-- Actual nilpotent square completion retains both the literal
original quadratic equation and the ORIGINAL Frobenius-power relation. -/
noncomputable def balancedPreparedQuadraticTranslationEquiv (n : ℕ)
    (f : Polynomial A) (monic : f.Monic) (degree : f.natDegree = 2)
    (t : A) (half : f.coeff 1 = 2 * t) (nilpotent : t ^ (p ^ n) = 0) :
    (Polynomial A ⧸ Ideal.span ({f, Polynomial.X ^ (p ^ n)} : Set _)) ≃ₐ[K]
      (Polynomial A ⧸ Ideal.span
        ({splitQuadraticPolynomial (f.coeff 0 - t ^ 2), Polynomial.X ^ (p ^ n)} : Set _)) := by
  let e := (Polynomial.algEquivAevalXAddC (-t)).restrictScalars K
  have image : (Ideal.span ({f, Polynomial.X ^ (p ^ n)} : Set (Polynomial A))).map
      e.toRingHom = Ideal.span
        ({splitQuadraticPolynomial (f.coeff 0 - t ^ 2), Polynomial.X ^ (p ^ n)} : Set _) := by
    rw [Ideal.map_span, Set.image_insert_eq, Set.image_singleton]
    change Ideal.span {Polynomial.algEquivAevalXAddC (-t) f,
      Polynomial.algEquivAevalXAddC (-t) (Polynomial.X ^ (p ^ n))} = _
    rw [monic_degree_two_original_polynomial f monic degree,
      quadratic_polynomial_translation _ _ t half,
      polynomial_translation_frobenius_power p n t nilpotent]
    simp [quadraticLinearPolynomial]
  exact Ideal.quotientEquivAlg _ _ e image.symm

end Litt3.Deformations

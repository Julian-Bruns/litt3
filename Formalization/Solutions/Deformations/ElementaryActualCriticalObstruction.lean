import Solutions.Deformations.ElementaryActualCriticalDetectors
import Solutions.Deformations.ElementaryCriticalParameterDivisibility
import Solutions.Deformations.ElementaryDetectorFrobenius

namespace Litt3.Deformations

open scoped BigOperators LinearAlgebra.Projectivization WeightedRootPolynomialScalars

variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

/-- The actual inverse coefficient Frobenius is applied after the
entire actual signed projective ratio, recovering the actual original
critical normal coefficient. -/
theorem elementary_actual_critical_detector_frobenius (r : ℕ)
    [Fintype (ℙ (ZMod 5) (Fin r → ZMod 5))] (positive : 0 < r)
    (q : MvPolynomial (Fin r) k) (quadratic : q.IsHomogeneous 2)
    (anisotropic : ∀ a : Fin r → ZMod 5, a ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl 5) k (a i)) ≠ 0)
    (x Z : weightedRootProduct (Polynomial k) 5 Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k 5 (by omega) r (4 * r - 1))
    (preimage : weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q) * x = Z)
    (i : Fin r) :
    (_root_.frobeniusEquiv k 5).symm ((-1 : k) ^ (r + 1) *
      ∑ P : ℙ (ZMod 5) (Fin r → ZMod 5), ZMod.castHom (dvd_refl 5) k (P.rep i) *
        weightedRootPolynomialFunctionEvaluation (ZMod 5) k (ZMod.castHom (dvd_refl 5) k) r Z P.rep /
          q.eval (fun j => ZMod.castHom (dvd_refl 5) k (P.rep j))) =
      (_root_.frobeniusEquiv k 5).symm ((weightedRootPolynomialBasis k 5 (by omega) r).repr x
        (0, finiteFieldDetectorExponent (ZMod 5) (by norm_num) i)) := by
  rw [elementary_actual_critical_detector k (ZMod.castHom (dvd_refl 5) k) r positive q quadratic
    anisotropic x Z homogeneous preimage i]
  have sign : (-1 : k) ^ (r + 1) * (-1 : k) ^ (r + 1) = 1 := by
    rw [← pow_add, show r + 1 + (r + 1) = 2 * (r + 1) by omega, pow_mul]
    simp
  rw [← mul_assoc, sign, one_mul]

/-- Full necessary-and-sufficient critical obstruction in the actual
parameter algebra. Homogeneous division, the original r coefficients
and parameter divisibility are proved, rather than supplied as inputs. -/
theorem elementary_actual_critical_obstruction (r : ℕ)
    [Fintype (ℙ (ZMod 5) (Fin r → ZMod 5))] (positive : 0 < r)
    (q : MvPolynomial (Fin r) k) (quadratic : q.IsHomogeneous 2)
    (anisotropic : ∀ a : Fin r → ZMod 5, a ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl 5) k (a i)) ≠ 0)
    (Z : weightedRootProduct (Polynomial k) 5 Polynomial.X r)
    (homogeneous : Z ∈ weightedRootHomogeneousComponent k 5 (by omega) r (4 * r + 1)) :
    (∀ i : Fin r, (_root_.frobeniusEquiv k 5).symm ((-1 : k) ^ (r + 1) *
      ∑ P : ℙ (ZMod 5) (Fin r → ZMod 5), ZMod.castHom (dvd_refl 5) k (P.rep i) *
        weightedRootPolynomialFunctionEvaluation (ZMod 5) k (ZMod.castHom (dvd_refl 5) k) r Z P.rep /
          q.eval (fun j => ZMod.castHom (dvd_refl 5) k (P.rep j))) = 0) ↔
      ∃ x : weightedRootProduct (Polynomial k) 5 Polynomial.X r,
        x ∈ weightedRootHomogeneousComponent k 5 (by omega) r (4 * r - 1) ∧
        (∃ y : weightedRootProduct (Polynomial k) 5 Polynomial.X r,
          x = (Polynomial.X : Polynomial k) • y) ∧
        weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q) * x = Z := by
  constructor
  · intro vanishing
    obtain ⟨x, member, preimage⟩ := elementary_critical_homogeneous_division k r positive q quadratic
      anisotropic Z homogeneous
    refine ⟨x, member, ?_, preimage⟩
    apply (elementary_critical_parameter_divisibility k r positive x member).mpr
    intro i
    apply (_root_.frobeniusEquiv k 5).symm.injective
    rw [map_zero]
    exact (elementary_actual_critical_detector_frobenius k r positive q quadratic anisotropic
      x Z member preimage i).symm.trans (vanishing i)
  · rintro ⟨x, member, divisible, preimage⟩ i
    rw [elementary_actual_critical_detector_frobenius k r positive q quadratic anisotropic
      x Z member preimage i]
    rw [(elementary_critical_parameter_divisibility k r positive x member).mp divisible i, map_zero]

end Litt3.Deformations

import Solutions.Deformations.WeightedRootNormalProduct
import Mathlib.RingTheory.AlgebraTower
import Mathlib.Algebra.Polynomial.Basis

namespace Litt3.Deformations

noncomputable section

namespace WeightedRootPolynomialScalars

scoped instance scalarAlgebra (k : Type*) [CommRing k] (q : ℕ) (tau : Polynomial k) (r : ℕ) :
    Algebra k (weightedRootProduct (Polynomial k) q tau r) :=
  ((algebraMap (Polynomial k) (weightedRootProduct (Polynomial k) q tau r)).comp
    (Polynomial.C : k →+* Polynomial k)).toAlgebra

scoped instance scalarTower (k : Type*) [CommRing k] (q : ℕ) (tau : Polynomial k) (r : ℕ) :
    IsScalarTower k (Polynomial k) (weightedRootProduct (Polynomial k) q tau r) :=
  IsScalarTower.of_algebraMap_eq' rfl

end WeightedRootPolynomialScalars

open scoped WeightedRootPolynomialScalars

variable (k : Type*) [CommRing k] [Nontrivial k]

/-- A genuine coefficient-field basis of the untruncated source
algebra, indexed by original parameter powers and original normal powers. -/
noncomputable def weightedRootPolynomialBasis (q : ℕ) (large : 1 < q) (r : ℕ) :
    Module.Basis (ℕ × (Fin r → Fin q)) k
      (weightedRootProduct (Polynomial k) q Polynomial.X r) :=
  (Polynomial.basisMonomials k).smulTower
    (weightedRootProductBasis q large Polynomial.X r)

theorem weighted_root_polynomial_basis_apply (q : ℕ) (large : 1 < q) (r : ℕ)
    (j : ℕ) (alpha : Fin r → Fin q) :
    weightedRootPolynomialBasis k q large r (j, alpha) =
      (Polynomial.X : Polynomial k) ^ j • weightedRootProductBasis q large Polynomial.X r alpha := by
  rw [weightedRootPolynomialBasis, Module.Basis.smulTower_apply]
  simp only [Polynomial.coe_basisMonomials, ← Polynomial.C_mul_X_pow_eq_monomial,
    Polynomial.C_1, one_mul]

/-- The exact actual coordinate is the coefficient of the original
parameter power in the actual original normal coordinate. -/
theorem weighted_root_polynomial_basis_coordinate (q : ℕ) (large : 1 < q) (r : ℕ)
    (x : weightedRootProduct (Polynomial k) q Polynomial.X r)
    (j : ℕ) (alpha : Fin r → Fin q) :
    (weightedRootPolynomialBasis k q large r).repr x (j, alpha) =
      ((weightedRootProductBasis q large Polynomial.X r).repr x alpha).coeff j := by
  rw [weightedRootPolynomialBasis, Module.Basis.smulTower_repr]
  rfl

end

end Litt3.Deformations

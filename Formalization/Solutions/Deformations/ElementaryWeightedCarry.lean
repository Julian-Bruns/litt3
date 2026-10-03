import Theorems.Deformations.ElementaryWeightedCarry
import Solutions.Deformations.ElementaryWittKernelBounds
import Solutions.Deformations.ElementaryWittTailAbsorption
import Solutions.Deformations.ElementaryWittNormLine
import Solutions.Deformations.ElementaryWittCriticalObstruction
import Solutions.Deformations.ElementaryActualRepresentative
import Solutions.Deformations.ElementaryWeightedInitial

namespace Litt3.Deformations

open scoped BigOperators LinearAlgebra.Projectivization WeightedRootPolynomialScalars
  ElementaryGradedScalars

variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

section Precision

variable (N : ℕ) [Fact (0 < N)] (r : ℕ)

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k
local instance : Nontrivial (TruncatedCoefficientRing k N) :=
  (truncatedResidue k N (Fact.out : 0 < N)).domain_nontrivial

theorem elementary_weighted_carry_grading : ElementaryWeightedCarryGrading k N r where
  equivalence d := ⟨elementaryWittGradedClassLinearEquiv N k r d⟩
  scalar := elementary_witt_graded_class_actual_scalar N k r
  naturalProduct := elementary_witt_graded_class_product_mk N k r
  comparisonProduct := elementary_witt_graded_class_product_comparison N k r
  originalParameters := elementary_witt_original_parameter_initial N k r
  originalPrime := elementary_witt_original_prime_initial N k r
  parameterTruncation := truncated_parameter_pow N
  parameterRelations := weighted_root_product_coordinate_relation 5 (truncatedParameter k N) r

theorem elementary_weighted_carry_precision (precisionBound : N ≤ r) :
    ElementaryWeightedCarryPrecision k N r := by
  intro L q reduction anisotropic x kernel
  exact elementary_witt_precision_kernel_bound N k r precisionBound L q reduction anisotropic x kernel

end Precision

section FinalPrecision

variable (r : ℕ)
variable [Fintype (ℙ (ZMod 5) (Fin r → ZMod 5))]

local instance : Fact (0 < r + 1) := ⟨by omega⟩
local instance : Nontrivial (TruncatedWittVector 5 (r + 1) k) :=
  truncated_witt_nontrivial 5 (r + 1) (by omega) k

theorem elementary_weighted_carry_final (positive : 0 < r)
    (L : AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5) →+
      AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryWittQuadraticReduction (r + 1) k r L q)
    (anisotropic : ElementaryOriginalAnisotropy k r q) :
    ElementaryWeightedCarryFinal k r L q where
  kernel := elementary_witt_final_kernel_bound k r L q reduction anisotropic
  tail := elementary_witt_tail_absorption r k positive L q reduction anisotropic
  normLine := by
    intro y
    rw [elementary_five_normal_weights_eq]
    exact elementary_witt_weighted_norm_line (r + 1) r (by omega) k y
  detector := elementary_witt_critical_obstruction r k positive L q reduction anisotropic
  projectiveIndependence := fun Z homogeneous i a b ha hb same =>
    elementary_actual_critical_representative k r (ZMod.castHom (dvd_refl 5) k)
      q reduction.2.1 Z homogeneous i a b ha hb same

/-- Whole canonical scope, proved uniformly and without assuming any
source conclusion. Rank positivity suffices; the source takes r >= 2. -/
theorem elementary_weighted_carry (positive : 0 < r) : ElementaryWeightedCarryResult k r where
  grading N h := by
    letI : Fact (0 < N) := ⟨h⟩
    exact elementary_weighted_carry_grading k N r
  precision N h bound := by
    letI : Fact (0 < N) := ⟨h⟩
    exact elementary_weighted_carry_precision k N r bound
  final := elementary_weighted_carry_final k r positive

end FinalPrecision

/-- The source's r=3 thresholds and image criterion are literal
specializations of the complete uniform clause bundle. -/
theorem elementary_weighted_carry_three
    [Fintype (ℙ (ZMod 5) (Fin 3 → ZMod 5))] : ElementaryWeightedCarryResult k 3 :=
  elementary_weighted_carry k 3 (by omega)

omit [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5] in
theorem elementary_weighted_carry_even_sign (r : ℕ) (even : Even r) :
    (-1 : k) ^ (r + 1) = -1 := by
  rw [pow_succ, even.neg_one_pow, one_mul]

/-- At rank three, inverse Frobenius still follows the entire sum;
only the source sign simplifies to positive. -/
theorem elementary_critical_theta_three
    [Fintype (ℙ (ZMod 5) (Fin 3 → ZMod 5))]
    (q : MvPolynomial (Fin 3) k)
    (Z : weightedRootProduct (Polynomial k) 5 Polynomial.X 3) (i : Fin 3) :
    elementaryCriticalTheta k 3 q Z i =
      (_root_.frobeniusEquiv k 5).symm
        (∑ P : ℙ (ZMod 5) (Fin 3 → ZMod 5), ZMod.castHom (dvd_refl 5) k (P.rep i) *
          weightedRootPolynomialFunctionEvaluation (ZMod 5) k (ZMod.castHom (dvd_refl 5) k) 3 Z P.rep /
            q.eval (fun j => ZMod.castHom (dvd_refl 5) k (P.rep j))) := by
  change (_root_.frobeniusEquiv k 5).symm ((-1 : k) ^ 4 * _) = _
  rw [show (-1 : k) ^ 4 = 1 by ring, one_mul]

end Litt3.Deformations

import Theorems.Deformations.ElementaryPrimeWeightedCarry
import Solutions.Deformations.ElementaryPrimeWittKernelBounds
import Solutions.Deformations.ElementaryPrimeWittNormAnnihilator
import Solutions.Deformations.ElementaryPrimeWittTailAbsorption
import Solutions.Deformations.ElementaryPrimeWittNormLine
import Solutions.Deformations.ElementaryPrimeWittCriticalObstruction
import Solutions.Deformations.ElementaryPrimeCriticalDivisionUniqueness
import Solutions.Deformations.ElementaryPrimeActualCriticalObstruction
import Solutions.Deformations.ElementaryPrimeCriticalDimensions
import Solutions.Deformations.ElementaryPrimeActualRepresentative
import Solutions.Deformations.ElementaryPrimeWittNormLeadingRealization

namespace Litt3.Deformations

open scoped LinearAlgebra.Projectivization ElementaryPrimeGradedScalars

variable (p : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

section Precision

variable (N : ℕ) [Fact (0 < N)] (r : ℕ)

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k
local instance : Nontrivial (TruncatedCoefficientRing k N) :=
  (truncatedResidue k N (Fact.out : 0 < N)).domain_nontrivial

/-- Complete genuine graded comparison, with literal original generators
and natural multiplication of actual quotient representatives. -/
theorem elementary_prime_weighted_carry_grading :
    ElementaryPrimeWeightedCarryGrading p k N r where
  equivalence d := ⟨elementaryPrimeWittGradedClassLinearEquiv p N k r d⟩
  scalar d t x := elementary_prime_witt_graded_class_actual_scalar p N k r d t x
  naturalProduct d e x y := elementary_prime_witt_graded_class_product_mk p N k r d e x y
  comparisonProduct d e x y := elementary_prime_witt_graded_class_product_comparison p N k r d e x y
  originalParameters i := elementary_prime_witt_original_parameter_initial p N k r i
  originalPrime := elementary_prime_witt_original_prime_initial p N k r
  parameterTruncation := truncated_parameter_pow N
  parameterRelations i := weighted_root_product_coordinate_relation p (truncatedParameter k N) r i

end Precision

section Integral

variable (r a : ℕ) [Fact (0 < r)]

local instance : Nontrivial (TruncatedWittVector p r k) :=
  truncated_witt_nontrivial p r (Fact.out : 0 < r) k

/-- The complete integral norm-target clause is derived from the full
original additive operator, including the actual ideal annihilators. -/
theorem elementary_prime_weighted_carry_integral
    (large : 2 < p) (principalPositive : 0 < a) (degreeBound : a + 1 ≤ p - 1)
    (L : AddMonoidAlgebra (TruncatedWittVector p r k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p r k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryPrimeWittReduction p r k r a L q)
    (anisotropic : ElementaryPrimeOriginalAnisotropy p k r q) :
    ElementaryPrimeWeightedCarryIntegral p k r a L := by
  have first : p - 1 ≤ (p - 1) * r := Nat.le_mul_of_pos_right (p - 1) (Fact.out : 0 < r)
  refine {
    normTarget := fun x eta equation => elementary_prime_witt_integral_norm_preimage p r k
      large a principalPositive degreeBound L q reduction anisotropic x eta equation
    leadingNorm := fun x eta equation => elementary_prime_witt_norm_leading_annihilator p r k
      large a principalPositive degreeBound L q reduction anisotropic x eta equation
    divisibleNormTarget := fun x eta divisible equation => elementary_prime_witt_divisible_norm_preimage
      p r k large a principalPositive degreeBound L q reduction anisotropic x eta divisible equation
    divisibleLeadingNorm := fun x eta divisible equation => elementary_prime_witt_divisible_norm_leading_annihilator
      p r k large a principalPositive degreeBound L q reduction anisotropic x eta divisible equation
    annihilatorIdentity := ?_
    divisibleAnnihilatorIdentity := ?_ }
  · simpa only [show (p - 1) * r + 1 - (a + 1) = (p - 1) * r - a by omega]
      using elementary_original_augmentation_annihilator (R := k) p r (a + 1) (by omega)
  · simpa only [show (p - 1) * r + 1 - a = (p - 1) * r - a + 1 by omega]
      using elementary_original_augmentation_annihilator (R := k) p r a (by omega)

end Integral

section Final

variable (r a : ℕ) [Fintype (ℙ (ZMod p) (Fin r → ZMod p))]

local instance : Fact (0 < r + 1) := ⟨by omega⟩
local instance : Nontrivial (TruncatedWittVector p (r + 1) k) :=
  truncated_witt_nontrivial p (r + 1) (by omega) k

/-- All final-precision conclusions, including full prescribed-reduction
norm fibers and the exact whole-sum inverse-Frobenius detector. -/
theorem elementary_prime_weighted_carry_final
    (large : 2 < p) (positive : 0 < r)
    (principalLower : 2 ≤ a) (principalUpper : a + 1 ≤ p - 1)
    (L : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryPrimeWittReduction p (r + 1) k r a L q)
    (anisotropic : ElementaryPrimeOriginalAnisotropy p k r q) :
    ElementaryPrimeWeightedCarryFinal p k r a large L q := by
  have principalPositive : 0 < a := by omega
  have normLine := fun y => elementary_prime_witt_weighted_norm_line p (r + 1) r (by omega) k y
  refine {
    kernel := elementary_prime_witt_final_kernel_bound p k large r a principalPositive principalUpper
      L q reduction anisotropic
    tail := elementary_prime_witt_tail_absorption p r a k principalPositive principalUpper positive
      L q reduction anisotropic
    normLine := ?_
    detector := elementary_prime_witt_critical_obstruction p r a k large principalLower principalUpper
      positive L q reduction anisotropic
    criticalDivision := fun Z homogeneous => elementary_prime_critical_homogeneous_division_unique p k
      large r a positive principalLower principalUpper q reduction.2.1 anisotropic Z homogeneous
    detectorCoefficients := fun H Z homogeneous equation i =>
      elementary_prime_actual_critical_detector_frobenius p k large r positive q anisotropic
        H Z homogeneous equation i
    dimensions := elementary_prime_critical_dimensions p r a k large positive principalLower principalUpper
    projectiveIndependence := fun Z homogeneous i v w hv hw same =>
      elementary_prime_actual_critical_representative p k r a positive
        (ZMod.castHom (dvd_refl p) k) q reduction.2.1 Z homogeneous i v w hv hw same
    normNecessary := fun eta x equation => elementary_prime_witt_final_integral_norm_necessary p r a k
      large principalPositive principalUpper positive L q reduction anisotropic eta x equation
    normSoluble := elementary_prime_witt_final_integral_norm_iff p r a k
      large principalPositive principalUpper positive L q reduction anisotropic
    fullNormFiber := ?_ }
  · intro y
    simpa only [elementaryOriginalNorm] using normLine y
  · intro eta y
    constructor
    · rintro ⟨x, equation, reduced⟩
      obtain ⟨divisible, member⟩ := elementary_prime_witt_final_integral_norm_necessary p r a k
        large principalPositive principalUpper positive L q reduction anisotropic eta x equation
      refine ⟨divisible, ?_⟩
      simpa only [elementaryOriginalNorm] using (normLine y).mp ⟨x, member, reduced⟩
    · rintro ⟨divisible, c, reduced⟩
      obtain ⟨x, equation, leading⟩ := elementary_prime_witt_norm_leading_realization p r a k
        large principalPositive principalUpper positive L q reduction anisotropic eta divisible c
      exact ⟨x, equation, leading.trans reduced.symm⟩

end Final

/-- Whole Version3 weighted-carry theorem, in greater generality: any
positive rank and every principal degree from two through p−2. No
coefficient linearity, graded presentation or obstruction conclusion is assumed. -/
theorem elementary_prime_weighted_carry (r a : ℕ) (large : 2 < p) (positive : 0 < r)
    (principalLower : 2 ≤ a) (principalUpper : a + 1 ≤ p - 1)
    [Fintype (ℙ (ZMod p) (Fin r → ZMod p))] :
    ElementaryPrimeWeightedCarryResult p k r a large positive := by
  refine {
    grading := ?_
    precision := ?_
    integral := ?_
    final := ?_ }
  · intro N h
    letI : Fact (0 < N) := ⟨h⟩
    exact elementary_prime_weighted_carry_grading p k N r
  · intro N h bound
    letI : Fact (0 < N) := ⟨h⟩
    letI : Nontrivial (TruncatedWittVector p N k) := truncated_witt_nontrivial p N h k
    intro L q reduction anisotropic x kernel
    exact elementary_prime_witt_precision_kernel_bound p N k large r a bound (by omega)
      principalUpper L q reduction anisotropic x kernel
  · letI : Fact (0 < r) := ⟨positive⟩
    letI : Nontrivial (TruncatedWittVector p r k) := truncated_witt_nontrivial p r positive k
    intro L q reduction anisotropic
    exact elementary_prime_weighted_carry_integral p k r a large (by omega) principalUpper
      L q reduction anisotropic
  · intro L q reduction anisotropic
    exact elementary_prime_weighted_carry_final p k r a large positive principalLower principalUpper
      L q reduction anisotropic

end Litt3.Deformations

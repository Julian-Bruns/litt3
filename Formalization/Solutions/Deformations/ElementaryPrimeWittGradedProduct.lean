import Solutions.Deformations.ElementaryPrimeWittGradedScalars
import Solutions.Deformations.ElementaryPrimeWittAssociatedMultiplication

set_option maxHeartbeats 1600000

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars ElementaryPrimeGradedScalars

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

theorem elementary_prime_parameter_degree_mul (r d e : ℕ)
    (x : elementaryPrimeTruncatedParameterDegree p N k r d)
    (y : elementaryPrimeTruncatedParameterDegree p N k r e) :
    x.val * y.val ∈ elementaryPrimeTruncatedParameterDegree p N k r (d + e) := by
  obtain ⟨X, xImage⟩ := x.property
  obtain ⟨Y, yImage⟩ := y.property
  change weightedRootTruncation k p N (Fact.out : 0 < N) r X.val = x.val at xImage
  change weightedRootTruncation k p N (Fact.out : 0 < N) r Y.val = y.val at yImage
  refine ⟨⟨X.val * Y.val, weighted_root_homogeneous_mul k p (by have := (Fact.out : p.Prime).two_le; omega)
    r d e X.val Y.val X.property Y.property⟩, ?_⟩
  change weightedRootTruncation k p N (Fact.out : 0 < N) r (X.val * Y.val) = x.val * y.val
  rw [map_mul, xImage, yImage]

/-- Genuine multiplication of actual associated-weight quotient classes,
constructed from their proved faithful parameter comparison. The next
theorem proves that this is exactly the natural product of actual representatives. -/
noncomputable def elementaryPrimeWittGradedClassProduct (r d e : ℕ)
    (x : ElementaryPrimeWittGradedClass p N k r d) (y : ElementaryPrimeWittGradedClass p N k r e) :
    ElementaryPrimeWittGradedClass p N k r (d + e) :=
  (elementaryPrimeWittGradedClassEquiv p N k r (d + e)).symm
    ⟨(elementaryPrimeWittGradedClassEquiv p N k r d x).val *
        (elementaryPrimeWittGradedClassEquiv p N k r e y).val,
      elementary_prime_parameter_degree_mul p N k r d e
        (elementaryPrimeWittGradedClassEquiv p N k r d x) (elementaryPrimeWittGradedClassEquiv p N k r e y)⟩

/-- Full quotient multiplication is the literal natural multiplication
of actual weighted representatives, so is independent of every representative. -/
theorem elementary_prime_witt_graded_class_product_mk (r d e : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d)
    (y : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r e) :
    elementaryPrimeWittGradedClassProduct p N k r d e (QuotientAddGroup.mk x) (QuotientAddGroup.mk y) =
      QuotientAddGroup.mk (elementaryPrimeWittWeightProduct p N k r d e x y) := by
  apply (elementaryPrimeWittGradedClassEquiv p N k r (d + e)).injective
  apply Subtype.ext
  rw [elementaryPrimeWittGradedClassProduct, AddEquiv.apply_symm_apply]
  change (elementaryPrimeWittGradedClassEquiv p N k r d (QuotientAddGroup.mk x)).val *
    (elementaryPrimeWittGradedClassEquiv p N k r e (QuotientAddGroup.mk y)).val = _
  simp only [elementary_prime_witt_graded_class_equiv_mk]
  exact (elementary_prime_witt_associated_map_multiplicative p N k r d e x y).symm

theorem elementary_prime_witt_graded_class_product_comparison (r d e : ℕ)
    (x : ElementaryPrimeWittGradedClass p N k r d) (y : ElementaryPrimeWittGradedClass p N k r e) :
    (elementaryPrimeWittGradedClassLinearEquiv p N k r (d + e)
      (elementaryPrimeWittGradedClassProduct p N k r d e x y)).val =
      (elementaryPrimeWittGradedClassLinearEquiv p N k r d x).val *
        (elementaryPrimeWittGradedClassLinearEquiv p N k r e y).val := by
  change ((elementaryPrimeWittGradedClassEquiv p N k r (d + e))
    ((elementaryPrimeWittGradedClassEquiv p N k r (d + e)).symm _)).val = _
  rw [AddEquiv.apply_symm_apply]
  rfl

end Litt3.Deformations

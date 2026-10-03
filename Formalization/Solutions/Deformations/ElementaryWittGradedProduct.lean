import Solutions.Deformations.ElementaryWittGradedScalars
import Solutions.Deformations.ElementaryWittAssociatedMultiplication

set_option maxHeartbeats 1600000

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars ElementaryGradedScalars

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

theorem elementary_parameter_degree_mul (r d e : ℕ)
    (x : elementaryTruncatedParameterDegree N k r d)
    (y : elementaryTruncatedParameterDegree N k r e) :
    x.val * y.val ∈ elementaryTruncatedParameterDegree N k r (d + e) := by
  obtain ⟨X, xImage⟩ := x.property
  obtain ⟨Y, yImage⟩ := y.property
  change weightedRootTruncation k 5 N (Fact.out : 0 < N) r X.val = x.val at xImage
  change weightedRootTruncation k 5 N (Fact.out : 0 < N) r Y.val = y.val at yImage
  refine ⟨⟨X.val * Y.val, weighted_root_homogeneous_mul k 5 (by omega)
    r d e X.val Y.val X.property Y.property⟩, ?_⟩
  change weightedRootTruncation k 5 N (Fact.out : 0 < N) r (X.val * Y.val) = x.val * y.val
  rw [map_mul, xImage, yImage]

/-- Genuine multiplication of actual associated-weight quotient classes,
constructed from their proved faithful parameter comparison. The next
theorem proves that this is exactly the natural product of actual representatives. -/
noncomputable def elementaryWittGradedClassProduct (r d e : ℕ)
    (x : ElementaryWittGradedClass N k r d) (y : ElementaryWittGradedClass N k r e) :
    ElementaryWittGradedClass N k r (d + e) :=
  (elementaryWittGradedClassEquiv N k r (d + e)).symm
    ⟨(elementaryWittGradedClassEquiv N k r d x).val *
        (elementaryWittGradedClassEquiv N k r e y).val,
      elementary_parameter_degree_mul N k r d e
        (elementaryWittGradedClassEquiv N k r d x) (elementaryWittGradedClassEquiv N k r e y)⟩

/-- Full quotient multiplication is the literal natural multiplication
of actual weighted representatives, so is independent of every representative. -/
theorem elementary_witt_graded_class_product_mk (r d e : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d)
    (y : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r e) :
    elementaryWittGradedClassProduct N k r d e (QuotientAddGroup.mk x) (QuotientAddGroup.mk y) =
      QuotientAddGroup.mk (elementaryWittWeightProduct N k r d e x y) := by
  apply (elementaryWittGradedClassEquiv N k r (d + e)).injective
  apply Subtype.ext
  rw [elementaryWittGradedClassProduct, AddEquiv.apply_symm_apply]
  change (elementaryWittGradedClassEquiv N k r d (QuotientAddGroup.mk x)).val *
    (elementaryWittGradedClassEquiv N k r e (QuotientAddGroup.mk y)).val = _
  simp only [elementary_witt_graded_class_equiv_mk]
  exact (elementary_witt_associated_map_multiplicative N k r d e x y).symm

theorem elementary_witt_graded_class_product_comparison (r d e : ℕ)
    (x : ElementaryWittGradedClass N k r d) (y : ElementaryWittGradedClass N k r e) :
    (elementaryWittGradedClassLinearEquiv N k r (d + e)
      (elementaryWittGradedClassProduct N k r d e x y)).val =
      (elementaryWittGradedClassLinearEquiv N k r d x).val *
        (elementaryWittGradedClassLinearEquiv N k r e y).val := by
  change ((elementaryWittGradedClassEquiv N k r (d + e))
    ((elementaryWittGradedClassEquiv N k r (d + e)).symm _)).val = _
  rw [AddEquiv.apply_symm_apply]
  rfl

end Litt3.Deformations

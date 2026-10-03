import Solutions.Deformations.ElementaryWittGradedClass
import Solutions.Deformations.ElementaryWittAssociatedScalar

set_option maxHeartbeats 1400000

namespace Litt3.Deformations

noncomputable section

namespace ElementaryGradedScalars

scoped instance parameterAlgebra (N : ℕ) [Fact (0 < N)]
    (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5] (r : ℕ) :
    Algebra k (weightedRootProduct (TruncatedCoefficientRing k N) 5 (truncatedParameter k N) r) :=
  (elementaryAssociatedScalar N k r).toAlgebra

end ElementaryGradedScalars

open scoped WeightedRootPolynomialScalars ElementaryGradedScalars

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

theorem elementary_parameter_truncation_smul (r : ℕ) (a : k)
    (Z : weightedRootProduct (Polynomial k) 5 Polynomial.X r) :
    weightedRootTruncation k 5 N (Fact.out : 0 < N) r (a • Z) =
      a • weightedRootTruncation k 5 N (Fact.out : 0 < N) r Z := by
  rw [Algebra.smul_def, map_mul, Algebra.smul_def]
  rfl

theorem elementary_parameter_degree_smul (r d : ℕ) (a : k)
    (z : weightedRootProduct (TruncatedCoefficientRing k N) 5 (truncatedParameter k N) r)
    (member : z ∈ elementaryTruncatedParameterDegree N k r d) :
    a • z ∈ elementaryTruncatedParameterDegree N k r d := by
  change ∃ Z : weightedRootHomogeneousComponent k 5 (by omega) r d,
    weightedRootTruncation k 5 N (Fact.out : 0 < N) r Z.val = z at member
  obtain ⟨Z, image⟩ := member
  refine ⟨a • Z, ?_⟩
  change weightedRootTruncation k 5 N (Fact.out : 0 < N) r (a • Z.val) = a • z
  rw [elementary_parameter_truncation_smul, image]

namespace ElementaryGradedScalars

scoped instance degreeSmul (r d : ℕ) : SMul k (elementaryTruncatedParameterDegree N k r d) :=
  ⟨fun a z => ⟨a • z.val, elementary_parameter_degree_smul N k r d a z.val z.property⟩⟩

scoped instance degreeModule (r d : ℕ) : Module k (elementaryTruncatedParameterDegree N k r d) :=
  Function.Injective.module k (elementaryTruncatedParameterDegree N k r d).subtype
    Subtype.val_injective (fun _ _ => rfl)

/-- The coefficient-field action on genuine quotient classes is derived
from the proved faithful grading, not assumed on the original Witt module. -/
scoped instance classSmul (r d : ℕ) : SMul k (ElementaryWittGradedClass N k r d) :=
  ⟨fun a x => (elementaryWittGradedClassEquiv N k r d).symm
    (a • elementaryWittGradedClassEquiv N k r d x)⟩

scoped instance classModule (r d : ℕ) : Module k (ElementaryWittGradedClass N k r d) :=
  Function.Injective.module k (elementaryWittGradedClassEquiv N k r d).toAddMonoidHom
    (elementaryWittGradedClassEquiv N k r d).injective
    (fun a x => (elementaryWittGradedClassEquiv N k r d).apply_symm_apply
      (a • elementaryWittGradedClassEquiv N k r d x))

end ElementaryGradedScalars

/-- Every genuine associated-weight quotient is now genuinely k-linearly
equivalent to its entire literal homogeneous parameter class. -/
def elementaryWittGradedClassLinearEquiv (r d : ℕ) :
    ElementaryWittGradedClass N k r d ≃ₗ[k] elementaryTruncatedParameterDegree N k r d :=
  { elementaryWittGradedClassEquiv N k r d with
    map_smul' := fun a x => by
      change (elementaryWittGradedClassEquiv N k r d)
        ((elementaryWittGradedClassEquiv N k r d).symm
          (a • elementaryWittGradedClassEquiv N k r d x)) =
        a • elementaryWittGradedClassEquiv N k r d x
      exact (elementaryWittGradedClassEquiv N k r d).apply_symm_apply _ }

/-- The derived k-action is exactly the natural actual Witt coefficient
action through residue. It is therefore independent of every chosen lift. -/
theorem elementary_witt_graded_class_actual_scalar (r d : ℕ) (t : TruncatedWittVector 5 N k)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d) :
    (QuotientAddGroup.mk (t • x) : ElementaryWittGradedClass N k r d) =
      truncatedWittResidue 5 N (Fact.out : 0 < N) k t •
        (QuotientAddGroup.mk x : ElementaryWittGradedClass N k r d) := by
  apply (elementaryWittGradedClassLinearEquiv N k r d).injective
  rw [map_smul]
  apply Subtype.ext
  change elementaryWittAssociatedMap N k r d (t • x) =
    truncatedWittResidue 5 N (Fact.out : 0 < N) k t • elementaryWittAssociatedMap N k r d x
  rw [elementary_witt_associated_map_scalar, Algebra.smul_def]
  rfl

end

end Litt3.Deformations

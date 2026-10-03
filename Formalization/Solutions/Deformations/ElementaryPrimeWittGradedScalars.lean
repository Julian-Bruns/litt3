import Solutions.Deformations.ElementaryPrimeWittGradedClass
import Solutions.Deformations.ElementaryPrimeWittAssociatedScalar

set_option maxHeartbeats 1400000

namespace Litt3.Deformations

noncomputable section

namespace ElementaryPrimeGradedScalars

scoped instance parameterAlgebra (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
    (k : Type*) [Field k] [CharP k p] [PerfectRing k p] (r : ℕ) :
    Algebra k (weightedRootProduct (TruncatedCoefficientRing k N) p (truncatedParameter k N) r) :=
  (elementaryPrimeAssociatedScalar p N k r).toAlgebra

end ElementaryPrimeGradedScalars

open scoped WeightedRootPolynomialScalars ElementaryPrimeGradedScalars

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

theorem elementary_prime_parameter_truncation_smul (r : ℕ) (a : k)
    (Z : weightedRootProduct (Polynomial k) p Polynomial.X r) :
    weightedRootTruncation k p N (Fact.out : 0 < N) r (a • Z) =
      a • weightedRootTruncation k p N (Fact.out : 0 < N) r Z := by
  rw [Algebra.smul_def, map_mul, Algebra.smul_def]
  rfl

theorem elementary_prime_parameter_degree_smul (r d : ℕ) (a : k)
    (z : weightedRootProduct (TruncatedCoefficientRing k N) p (truncatedParameter k N) r)
    (member : z ∈ elementaryPrimeTruncatedParameterDegree p N k r d) :
    a • z ∈ elementaryPrimeTruncatedParameterDegree p N k r d := by
  change ∃ Z : weightedRootHomogeneousComponent k p (by have := (Fact.out : p.Prime).two_le; omega) r d,
    weightedRootTruncation k p N (Fact.out : 0 < N) r Z.val = z at member
  obtain ⟨Z, image⟩ := member
  refine ⟨a • Z, ?_⟩
  change weightedRootTruncation k p N (Fact.out : 0 < N) r (a • Z.val) = a • z
  rw [elementary_prime_parameter_truncation_smul, image]

namespace ElementaryPrimeGradedScalars

scoped instance degreeSmul (r d : ℕ) : SMul k (elementaryPrimeTruncatedParameterDegree p N k r d) :=
  ⟨fun a z => ⟨a • z.val, elementary_prime_parameter_degree_smul p N k r d a z.val z.property⟩⟩

scoped instance degreeModule (r d : ℕ) : Module k (elementaryPrimeTruncatedParameterDegree p N k r d) :=
  Function.Injective.module k (elementaryPrimeTruncatedParameterDegree p N k r d).subtype
    Subtype.val_injective (fun _ _ => rfl)

/-- The coefficient-field action on genuine quotient classes is derived
from the proved faithful grading, not assumed on the original Witt module. -/
scoped instance classSmul (r d : ℕ) : SMul k (ElementaryPrimeWittGradedClass p N k r d) :=
  ⟨fun a x => (elementaryPrimeWittGradedClassEquiv p N k r d).symm
    (a • elementaryPrimeWittGradedClassEquiv p N k r d x)⟩

scoped instance classModule (r d : ℕ) : Module k (ElementaryPrimeWittGradedClass p N k r d) :=
  Function.Injective.module k (elementaryPrimeWittGradedClassEquiv p N k r d).toAddMonoidHom
    (elementaryPrimeWittGradedClassEquiv p N k r d).injective
    (fun a x => (elementaryPrimeWittGradedClassEquiv p N k r d).apply_symm_apply
      (a • elementaryPrimeWittGradedClassEquiv p N k r d x))

end ElementaryPrimeGradedScalars

/-- Every genuine associated-weight quotient is now genuinely k-linearly
equivalent to its entire literal homogeneous parameter class. -/
def elementaryPrimeWittGradedClassLinearEquiv (r d : ℕ) :
    ElementaryPrimeWittGradedClass p N k r d ≃ₗ[k] elementaryPrimeTruncatedParameterDegree p N k r d :=
  { elementaryPrimeWittGradedClassEquiv p N k r d with
    map_smul' := fun a x => by
      change (elementaryPrimeWittGradedClassEquiv p N k r d)
        ((elementaryPrimeWittGradedClassEquiv p N k r d).symm
          (a • elementaryPrimeWittGradedClassEquiv p N k r d x)) =
        a • elementaryPrimeWittGradedClassEquiv p N k r d x
      exact (elementaryPrimeWittGradedClassEquiv p N k r d).apply_symm_apply _ }

/-- The derived k-action is exactly the natural actual Witt coefficient
action through residue. It is therefore independent of every chosen lift. -/
theorem elementary_prime_witt_graded_class_actual_scalar (r d : ℕ) (t : TruncatedWittVector p N k)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d) :
    (QuotientAddGroup.mk (t • x) : ElementaryPrimeWittGradedClass p N k r d) =
      truncatedWittResidue p N (Fact.out : 0 < N) k t •
        (QuotientAddGroup.mk x : ElementaryPrimeWittGradedClass p N k r d) := by
  apply (elementaryPrimeWittGradedClassLinearEquiv p N k r d).injective
  rw [map_smul]
  apply Subtype.ext
  change elementaryPrimeWittAssociatedMap p N k r d (t • x) =
    truncatedWittResidue p N (Fact.out : 0 < N) k t • elementaryPrimeWittAssociatedMap p N k r d x
  rw [elementary_prime_witt_associated_map_scalar, Algebra.smul_def]
  rfl

end

end Litt3.Deformations

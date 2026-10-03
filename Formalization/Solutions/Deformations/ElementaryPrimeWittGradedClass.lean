import Definitions.Deformations.ElementaryPrimeWittGradedClass

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

theorem elementary_prime_witt_next_weight_eq_kernel (r d : ℕ) :
    elementaryPrimeWittNextWeight p N k r d = (elementaryPrimeWittAssociatedMap p N k r d).ker := by
  ext x
  exact (elementary_prime_witt_associated_map_kernel p N k r d x).symm

theorem elementary_prime_witt_associated_range_eq_degree (r d : ℕ) :
    (elementaryPrimeWittAssociatedMap p N k r d).range = elementaryPrimeTruncatedParameterDegree p N k r d := by
  ext z
  rw [AddMonoidHom.mem_range, elementary_prime_witt_associated_map_full_range]
  constructor
  · rintro ⟨Z, homogeneous, image⟩
    exact ⟨⟨Z, homogeneous⟩, image⟩
  · rintro ⟨Z, image⟩
    exact ⟨Z.val, Z.property, image⟩

/-- Constructed genuine associated-weight quotient equivalence with
the entire actual homogeneous parameter class, at every precision.
It follows from the proved exact source kernel and full actual range. -/
noncomputable def elementaryPrimeWittGradedClassEquiv (r d : ℕ) :
    ElementaryPrimeWittGradedClass p N k r d ≃+ elementaryPrimeTruncatedParameterDegree p N k r d := by
  let changeKernel := QuotientAddGroup.quotientAddEquivOfEq
    (elementary_prime_witt_next_weight_eq_kernel p N k r d)
  let firstIso := QuotientAddGroup.quotientKerEquivRange (elementaryPrimeWittAssociatedMap p N k r d)
  have rangeEquality := elementary_prime_witt_associated_range_eq_degree p N k r d
  let changeRange : (elementaryPrimeWittAssociatedMap p N k r d).range ≃+
      elementaryPrimeTruncatedParameterDegree p N k r d :=
    { toFun := fun z => ⟨z.val, rangeEquality ▸ z.property⟩
      invFun := fun z => ⟨z.val, rangeEquality.symm ▸ z.property⟩
      left_inv := fun _ => Subtype.ext rfl
      right_inv := fun _ => Subtype.ext rfl
      map_add' := fun _ _ => Subtype.ext rfl }
  exact changeKernel.trans (firstIso.trans changeRange)

@[simp] theorem elementary_prime_witt_graded_class_equiv_mk (r d : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d) :
    (elementaryPrimeWittGradedClassEquiv p N k r d (QuotientAddGroup.mk x)).val =
      elementaryPrimeWittAssociatedMap p N k r d x := rfl

end Litt3.Deformations

import Definitions.Deformations.ElementaryWittGradedClass

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

theorem elementary_witt_next_weight_eq_kernel (r d : ℕ) :
    elementaryWittNextWeight N k r d = (elementaryWittAssociatedMap N k r d).ker := by
  ext x
  exact (elementary_witt_associated_map_kernel N k r d x).symm

theorem elementary_witt_associated_range_eq_degree (r d : ℕ) :
    (elementaryWittAssociatedMap N k r d).range = elementaryTruncatedParameterDegree N k r d := by
  ext z
  rw [AddMonoidHom.mem_range, elementary_witt_associated_map_full_range]
  constructor
  · rintro ⟨Z, homogeneous, image⟩
    exact ⟨⟨Z, homogeneous⟩, image⟩
  · rintro ⟨Z, image⟩
    exact ⟨Z.val, Z.property, image⟩

/-- Constructed genuine associated-weight quotient equivalence with
the entire actual homogeneous parameter class, at every precision.
It follows from the proved exact source kernel and full actual range. -/
noncomputable def elementaryWittGradedClassEquiv (r d : ℕ) :
    ElementaryWittGradedClass N k r d ≃+ elementaryTruncatedParameterDegree N k r d := by
  let changeKernel := QuotientAddGroup.quotientAddEquivOfEq
    (elementary_witt_next_weight_eq_kernel N k r d)
  let firstIso := QuotientAddGroup.quotientKerEquivRange (elementaryWittAssociatedMap N k r d)
  have rangeEquality := elementary_witt_associated_range_eq_degree N k r d
  let changeRange : (elementaryWittAssociatedMap N k r d).range ≃+
      elementaryTruncatedParameterDegree N k r d :=
    { toFun := fun z => ⟨z.val, rangeEquality ▸ z.property⟩
      invFun := fun z => ⟨z.val, rangeEquality.symm ▸ z.property⟩
      left_inv := fun _ => Subtype.ext rfl
      right_inv := fun _ => Subtype.ext rfl
      map_add' := fun _ _ => Subtype.ext rfl }
  exact changeKernel.trans (firstIso.trans changeRange)

@[simp] theorem elementary_witt_graded_class_equiv_mk (r d : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d) :
    (elementaryWittGradedClassEquiv N k r d (QuotientAddGroup.mk x)).val =
      elementaryWittAssociatedMap N k r d x := rfl

end Litt3.Deformations

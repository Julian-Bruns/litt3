import Solutions.Deformations.ElementaryWittAssociatedMap
import Mathlib.GroupTheory.QuotientGroup.Basic

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

/-- The actual next source weight as a subgroup of the actual current
weight, defined directly from the original filtration. -/
noncomputable def elementaryWittNextWeight (r d : ℕ) :
    AddSubgroup (elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d) :=
  AddSubgroup.comap
    (elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d).subtype.toAddMonoidHom
    (elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r (d + 1)).toAddSubgroup

/-- The literal genuine associated-weight quotient Wd/W(d+1).
Its denominator is an actual filtration subgroup, not a map kernel
presumed equal to it. -/
abbrev ElementaryWittGradedClass (r d : ℕ) :=
  elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (Nat.zero_lt_succ 4) r d ⧸
    elementaryWittNextWeight N k r d

/-- The actual degree-d component of the literal parameter-truncated
algebra, as the full image of its genuine homogeneous component. -/
noncomputable def elementaryTruncatedParameterDegree (r d : ℕ) :
    AddSubgroup (weightedRootProduct (TruncatedCoefficientRing k N) 5 (truncatedParameter k N) r) :=
  AddMonoidHom.range ((weightedRootTruncation k 5 N (Fact.out : 0 < N) r).toAddMonoidHom.comp
    (weightedRootHomogeneousComponent k 5 (by omega) r d).subtype.toAddMonoidHom)

end Litt3.Deformations

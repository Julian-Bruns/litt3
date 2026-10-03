import Solutions.Deformations.ElementaryPrimeWittAssociatedMap
import Mathlib.GroupTheory.QuotientGroup.Basic

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

/-- The actual next source weight as a subgroup of the actual current
weight, defined directly from the original filtration. -/
noncomputable def elementaryPrimeWittNextWeight (r d : ℕ) :
    AddSubgroup (elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d) :=
  AddSubgroup.comap
    (elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d).subtype.toAddMonoidHom
    (elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r (d + 1)).toAddSubgroup

/-- The literal genuine associated-weight quotient Wd/W(d+1).
Its denominator is an actual filtration subgroup, not a map kernel
presumed equal to it. -/
abbrev ElementaryPrimeWittGradedClass (r d : ℕ) :=
  elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (Fact.out : p.Prime).pos r d ⧸
    elementaryPrimeWittNextWeight p N k r d

/-- The actual degree-d component of the literal parameter-truncated
algebra, as the full image of its genuine homogeneous component. -/
noncomputable def elementaryPrimeTruncatedParameterDegree (r d : ℕ) :
    AddSubgroup (weightedRootProduct (TruncatedCoefficientRing k N) p (truncatedParameter k N) r) :=
  AddMonoidHom.range ((weightedRootTruncation k p N (Fact.out : 0 < N) r).toAddMonoidHom.comp
    (weightedRootHomogeneousComponent k p (by have := (Fact.out : p.Prime).two_le; omega) r d).subtype.toAddMonoidHom)

end Litt3.Deformations

import Solutions.Jacobians.ClosedStalkRationalUniformizers

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X]

/-- The complement of the literal finite support of the original
closed-point divisor. Closedness uses each ORIGINAL point's closedness,
so no T1 hypothesis is imposed on the scheme's actual topological space. -/
noncomputable def actualDivisorSupportComplement
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) : X.Opens := by
  classical
  exact ⟨(⋃ x ∈ D.support, ({x.val} : Set X))ᶜ,
    (isClosed_biUnion_finset (fun x _ => x.property)).isOpen_compl⟩

/-- At every original closed point in the genuine support-complement
open, the original divisor coefficient is actually zero. -/
theorem actualDivisorSupportComplement_coefficient
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X))
    (x : Litt3.SharedTensors.ClosedPoint X)
    (hx : x.val ∈ actualDivisorSupportComplement X D) : D x = 0 := by
  classical
  by_contra h
  exact hx (Set.mem_iUnion.mpr ⟨x, Set.mem_iUnion.mpr
    ⟨Finsupp.mem_support_iff.mpr h, Set.mem_singleton x.val⟩⟩)

theorem actualDivisorSupportComplement_mem_of_zero
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X))
    (x : Litt3.SharedTensors.ClosedPoint X) (hx : D x = 0) :
    x.val ∈ actualDivisorSupportComplement X D := by
  classical
  intro hmem
  obtain ⟨y, hy⟩ := Set.mem_iUnion.mp hmem
  obtain ⟨hy, hxy⟩ := Set.mem_iUnion.mp hy
  have hxy : x.val = y.val := Set.mem_singleton_iff.mp hxy
  have he : y = x := Subtype.ext hxy.symm
  subst y
  exact (Finsupp.mem_support_iff.mp hy) hx

/-- The original generic point belongs to the genuine complement of
EVERY finite closed-point divisor support. -/
theorem actualDivisorSupportComplement_generic
    [ClosedPointDVRStalks X] (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    genericPoint X ∈ actualDivisorSupportComplement X D := by
  classical
  intro hmem
  obtain ⟨y, hy⟩ := Set.mem_iUnion.mp hmem
  obtain ⟨hy, hgy⟩ := Set.mem_iUnion.mp hy
  have hgy : genericPoint X = y.val := Set.mem_singleton_iff.mp hgy
  apply actual_generic_point_not_closed X
  simpa only [hgy] using y.property

end Litt3.Jacobians

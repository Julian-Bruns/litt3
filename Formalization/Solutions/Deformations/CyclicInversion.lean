import Theorems.Deformations.CyclicInversion
import Solutions.Deformations.CyclicGroupAlgebra
import Solutions.Deformations.CyclicCoordinates

namespace Litt3.Deformations

variable {k : Type*} [CommRing k]

@[simp] theorem cyclic_group_inversion_single (N : ℕ) (g : ZMod N) (c : k) :
    cyclicGroupInversion k N (AddMonoidAlgebra.single g c) =
      AddMonoidAlgebra.single (-g) c := by
  exact AddMonoidAlgebra.mapDomain_single

theorem cyclic_group_inversion_involutive (N : ℕ) :
    Specifications.CyclicGroupInversionInvolutive (k := k) N := by
  intro x
  induction x using AddMonoidAlgebra.induction_on with
  | hM g =>
    change cyclicGroupInversion k N (cyclicGroupInversion k N
      (AddMonoidAlgebra.single g 1)) = AddMonoidAlgebra.single g 1
    rw [cyclic_group_inversion_single, cyclic_group_inversion_single, neg_neg]
  | hadd x y hx hy =>
    simp only [map_add, hx, hy]
  | hsmul c x hx =>
    have h : cyclicGroupInversion k N (c • x) = c • cyclicGroupInversion k N x := by
      change AddMonoidAlgebra.mapDomain _ (c • x) = c • AddMonoidAlgebra.mapDomain _ x
      exact Finsupp.mapDomain_smul c x
    have h' : cyclicGroupInversion k N (c • cyclicGroupInversion k N x) =
        c • cyclicGroupInversion k N (cyclicGroupInversion k N x) := by
      change AddMonoidAlgebra.mapDomain _ (c • _) = c • AddMonoidAlgebra.mapDomain _ _
      exact Finsupp.mapDomain_smul c (cyclicGroupInversion k N x)
    rw [h, h', hx]

@[simp] theorem cyclic_group_inversion_generator (N : ℕ) :
    cyclicGroupInversion k N (cyclicGroupGenerator k N : CyclicGroupAlgebra k N) =
      (cyclicGroupGenerator k N)⁻¹ :=
  cyclic_group_inversion_single N 1 1

/-- Actual inversion negates the actual skew coordinate. -/
theorem cyclic_group_skew_inversion (N : ℕ) [Invertible (2 : CyclicGroupAlgebra k N)] :
    cyclicGroupInversion k N (cyclicSkewCoordinate (cyclicGroupGenerator k N)) =
      -cyclicSkewCoordinate (cyclicGroupGenerator k N) :=
  cyclic_skew_coordinate_involution _ _ (cyclic_group_inversion_involutive N)
    (cyclic_group_inversion_generator N)

end Litt3.Deformations

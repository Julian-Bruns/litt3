import Solutions.Deformations.CommutingRangeQuotient
import Mathlib.LinearAlgebra.Isomorphisms

namespace Litt3.Deformations

variable {R M : Type*} [CommRing R] [AddCommGroup M] [Module R M]

/-- The induced endomorphism has precisely the literal image of the
original endomorphism in the original quotient. -/
theorem commuting_range_quotient_range (A T : Module.End R M) (commute : Commute A T) :
    LinearMap.range (commutingRangeQuotientEnd A T commute) =
      (LinearMap.range T).map (LinearMap.range A).mkQ := by
  have identity : (commutingRangeQuotientEnd A T commute).comp (LinearMap.range A).mkQ =
      (LinearMap.range A).mkQ.comp T := rfl
  calc
    LinearMap.range (commutingRangeQuotientEnd A T commute) =
        LinearMap.range ((commutingRangeQuotientEnd A T commute).comp
          (LinearMap.range A).mkQ) :=
      (LinearMap.range_comp_of_range_eq_top _
        (LinearMap.range_eq_top.mpr (LinearMap.range A).mkQ_surjective)).symm
    _ = LinearMap.range ((LinearMap.range A).mkQ.comp T) := congrArg LinearMap.range identity
    _ = (LinearMap.range T).map (LinearMap.range A).mkQ := LinearMap.range_comp _ _

/-- Taking the cokernel of either original commuting endomorphism
first gives the same complete double quotient. Both actual operators
and every original representative are retained. -/
noncomputable def commutingCokernelsEquiv (A F : Module.End R M) (commute : Commute A F) :
    ((M ⧸ LinearMap.range F) ⧸
      LinearMap.range (commutingRangeQuotientEnd F A commute.symm)) ≃ₗ[R]
      ((M ⧸ LinearMap.range A) ⧸
        LinearMap.range (commutingRangeQuotientEnd A F commute)) :=
  (Submodule.quotEquivOfEq _ _ (commuting_range_quotient_range F A commute.symm)).trans
    ((Submodule.quotientQuotientEquivQuotientSup (LinearMap.range F) (LinearMap.range A)).trans
      ((Submodule.quotEquivOfEq _ _ (sup_comm _ _)).trans
        ((Submodule.quotientQuotientEquivQuotientSup (LinearMap.range A) (LinearMap.range F)).symm.trans
          (Submodule.quotEquivOfEq _ _ (commuting_range_quotient_range A F commute).symm))))

@[simp] theorem commuting_cokernels_equiv_mk (A F : Module.End R M)
    (commute : Commute A F) (v : M) :
    commutingCokernelsEquiv A F commute
        ((LinearMap.range (commutingRangeQuotientEnd F A commute.symm)).mkQ
          ((LinearMap.range F).mkQ v)) =
      (LinearMap.range (commutingRangeQuotientEnd A F commute)).mkQ
        ((LinearMap.range A).mkQ v) := rfl

end Litt3.Deformations

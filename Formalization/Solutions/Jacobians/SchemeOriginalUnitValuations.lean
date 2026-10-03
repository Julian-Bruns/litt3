import Solutions.Jacobians.SchemeSectionValuationBounds
import Mathlib.RingTheory.LocalRing.MaximalIdeal.Basic

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] [ClosedPointDVRStalks X]

/-- An ACTUAL unit of an original open's structure ring has valuation
one at EVERY original closed point of that open. Its unit property is
transported through the genuine ORIGINAL germ map, rather than assumed
for a completion or a rational scalar. -/
theorem actual_original_open_unit_valuation_one
    (U : X.Opens) [Nonempty U] (c : Γ(X, U)ˣ)
    (x : Litt3.SharedTensors.ClosedPoint X) (hx : x.val ∈ U) :
    closedPointValuation X x (algebraMap Γ(X, U) X.functionField c.val) = 1 := by
  let xU : U := ⟨x.val, hx⟩
  letI := X.presheaf.algebra_section_stalk xU
  letI := functionField_isScalarTower X U xU
  rw [IsScalarTower.algebraMap_apply Γ(X, U) (X.presheaf.stalk x.val) X.functionField]
  change (discreteValuationPlace (X.presheaf.stalk x.val)).valuation X.functionField
    (algebraMap (X.presheaf.stalk x.val) X.functionField
      (algebraMap Γ(X, U) (X.presheaf.stalk x.val) c.val)) = 1
  rw [IsDedekindDomain.HeightOneSpectrum.valuation_of_algebraMap]
  apply IsDedekindDomain.HeightOneSpectrum.intValuation_eq_one_iff.mpr
  change algebraMap Γ(X, U) (X.presheaf.stalk x.val) c.val ∉
    IsLocalRing.maximalIdeal (X.presheaf.stalk x.val)
  exact IsLocalRing.notMem_maximalIdeal.mpr
    (c.isUnit.map (algebraMap Γ(X, U) (X.presheaf.stalk x.val)))

end Litt3.Jacobians

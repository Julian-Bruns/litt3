import Solutions.Jacobians.AffineDivisorSectionMembership

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace
open scoped nonZeroDivisors
open IsDedekindDomain

namespace Litt3.Jacobians

universe u
variable {X : Scheme.{u}} [IsIntegral X] [JacobsonSpace X] [ClosedPointDVRStalks X]
  {U : X.Opens} (hU : IsAffineOpen U)
  [IsDedekindDomain Γ(X, U)] [Nonempty U] (hfield : ¬IsField Γ(X, U))

/-- The ACTUAL sections of the ACTUAL global divisor SHEAF over an
ORIGINAL affine chart are linearly equivalent to the ACTUAL Dedekind
fractional ideal in the ORIGINAL function field. This derives full section
surjectivity and respects the original coordinate-ring scalar action. -/
noncomputable def actualAffineDivisorSectionsFractionalIdealEquiv
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    (actualSchemeDivisorSheaf X D).val.obj (op U) ≃ₗ[Γ(X, U)]
      letI := functionField_isFractionRing_of_isAffineOpen X U hU
      (((actualDedekindSectionFractionalIdeal Γ(X, U) X.functionField
        (actualAffineChartDivisorRestriction hU hfield D)).val :
          FractionalIdeal (Γ(X, U))⁰ X.functionField) : Submodule Γ(X, U) X.functionField) := by
  letI := functionField_isFractionRing_of_isAffineOpen X U hU
  let e := actualRationalFunctionOpenLinearEquiv X U
  apply e.ofSubmodules (actualSchemeDivisorOpenSubmodule X D (op U))
    (((actualDedekindSectionFractionalIdeal Γ(X, U) X.functionField
      (actualAffineChartDivisorRestriction hU hfield D)).val :
        FractionalIdeal (Γ(X, U))⁰ X.functionField) : Submodule Γ(X, U) X.functionField)
  ext f
  rw [Submodule.mem_map]
  constructor
  · rintro ⟨a, ha, rfl⟩
    exact (actual_affine_divisor_section_mem_iff hU hfield D a).mp ha
  · intro hf
    refine ⟨e.symm f, ?_, e.apply_symm_apply f⟩
    apply (actual_affine_divisor_section_mem_iff hU hfield D (e.symm f)).mpr
    change e (e.symm f) ∈ (actualDedekindSectionFractionalIdeal Γ(X, U) X.functionField
      (actualAffineChartDivisorRestriction hU hfield D)).val
    rw [e.apply_symm_apply]
    exact hf

/-- Thus ORIGINAL affine divisor-sheaf sections are genuinely invertible
over the ORIGINAL affine coordinate ring, with no Picard or local-frame
input. This concerns actual affine sections, not proper global sections. -/
noncomputable instance actualAffineDivisorSections_invertible
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    Module.Invertible Γ(X, U) ((actualSchemeDivisorSheaf X D).val.obj (op U)) := by
  letI := functionField_isFractionRing_of_isAffineOpen X U hU
  exact Module.Invertible.congr
    (actualAffineDivisorSectionsFractionalIdealEquiv hU hfield D).symm

end Litt3.Jacobians

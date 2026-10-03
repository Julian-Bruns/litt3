import Solutions.Jacobians.ActualRationalFunctionEvaluation

open CategoryTheory Opposite AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X]

/-- The true rational-function SHEAF on every nonempty ORIGINAL open
is the ORIGINAL function field as a module over the ORIGINAL section ring.
The scalar action is compared through actual generic germs, not assumed. -/
noncomputable def actualRationalFunctionOpenLinearEquiv
    (U : X.Opens) [Nonempty U] :
    (actualSchemeRationalFunctionModuleSheaf X).val.obj (op U) ≃ₗ[Γ(X, U)]
      X.functionField where
  toAddEquiv := (actualSchemeRationalFunctionOpenIso X U).commRingCatIsoToRingEquiv.toAddEquiv
  map_smul' r a := by
    classical
    let x : U := Classical.arbitrary U
    have h := actualRationalFunctionEvaluation_smul X U x.val x.property r a
    rw [actualRationalFunctionEvaluation_eq_open] at h
    exact h

end Litt3.Jacobians

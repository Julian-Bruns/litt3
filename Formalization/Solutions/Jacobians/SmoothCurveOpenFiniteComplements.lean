import Solutions.Jacobians.ActualFiniteTypeNoetherianSpaces
import Solutions.Jacobians.ClosedSetsFiniteInSoberNoetherianSpaces
import Solutions.SharedTensors.SmoothCurvePointStrata

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u

/-- The complement of ANY nonempty original open of an actual
quasi-compact smooth integral curve is a finite set of original closed
points. No properness, affine-open choice, or supplied finite-support
hypothesis is needed. -/
theorem actual_smooth_curve_nonempty_open_complement_finite
    {k : Type u} [Field k] [IsAlgClosed k] {X : Scheme.{u}} [IsIntegral X]
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [QuasiCompact sX]
    (U : X.Opens) [Nonempty U] :
    ({x : X | x ∉ U} : Set X).Finite := by
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  letI : IsNoetherian X := actual_finite_type_scheme_noetherian sX
  apply actual_closed_set_finite_of_closed_singletons _ U.isOpen.isClosed_compl
  intro x hx
  rcases Litt3.SharedTensors.actual_smooth_curve_point_closed_or_generic sX x with
    hclosed | hgeneric
  · exact hclosed
  · subst x
    have hg : genericPoint X ∈ U :=
      ((genericPoint_spec X).mem_open_set_iff U.isOpen).mpr
        (by simpa using (inferInstance : Nonempty U))
    exact False.elim (hx hg)

end Litt3.Jacobians

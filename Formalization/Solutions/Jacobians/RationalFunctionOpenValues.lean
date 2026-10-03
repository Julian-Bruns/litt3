import Solutions.Jacobians.SchemeDivisorSheaves

open CategoryTheory Opposite AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X]

/-- Evaluation at ANY two original points of the same nonempty open
returns the same ENTIRE original rational function. -/
theorem actualRationalFunctionEvaluation_point_independent
    (U : X.Opens) (x y : X) (hx : x ∈ U) (hy : y ∈ U) :
    actualRationalFunctionEvaluation X U x hx =
      actualRationalFunctionEvaluation X U y hy := by
  letI : Nonempty U := ⟨⟨x, hx⟩⟩
  rw [actualRationalFunctionEvaluation_eq_open, actualRationalFunctionEvaluation_eq_open]

/-- True restriction on a nonempty smaller ORIGINAL open preserves
the full original rational function, expressed through the honest open
ring isomorphisms rather than assumed generic compatibility. -/
theorem actualRationalFunctionOpenValue_restriction
    {U V : X.Opens} [Nonempty U] [Nonempty V] (i : V ⟶ U)
    (a : (actualSchemeRationalFunctionRingSheaf X).val.obj (op U)) :
    (actualSchemeRationalFunctionOpenIso X V).hom.hom
      ((actualSchemeRationalFunctionRingSheaf X).val.map i.op a) =
      (actualSchemeRationalFunctionOpenIso X U).hom.hom a := by
  let x : V := Classical.arbitrary V
  have h := RingHom.congr_fun
    (actualRationalFunctionEvaluation_restriction X i x.val x.property) a
  change actualRationalFunctionEvaluation X V x.val x.property
      ((actualSchemeRationalFunctionRingSheaf X).val.map i.op a) =
    actualRationalFunctionEvaluation X U x.val (i.le x.property) a at h
  rw [actualRationalFunctionEvaluation_eq_open,
    actualRationalFunctionEvaluation_eq_open] at h
  exact h

/-- True divisor-sheaf restrictions preserve the SAME original
rational function on every nonempty original subopen. -/
theorem actualDivisorSheafSectionValue_restriction
    [ClosedPointDVRStalks X] (D : Divisor (Litt3.SharedTensors.ClosedPoint X))
    {U V : X.Opens} [Nonempty U] [Nonempty V] (i : V ⟶ U)
    (a : (actualSchemeDivisorSheaf X D).val.obj (op U)) :
    (actualSchemeRationalFunctionOpenIso X V).hom.hom
      ((actualSchemeDivisorSheaf X D).val.map i.op a).val =
      (actualSchemeRationalFunctionOpenIso X U).hom.hom a.val :=
  actualRationalFunctionOpenValue_restriction X i a.val

end Litt3.Jacobians

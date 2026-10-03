import Solutions.QuotientGeometry.SchemeBaseFields
import Mathlib.AlgebraicGeometry.Morphisms.FiniteType

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- The literal coefficient algebra on EVERY affine chart of an actual
locally finite type scheme over a field is finite type. -/
theorem actual_affine_chart_finiteType
    {k : Type u} [Field k] {X : Scheme.{u}}
    (sX : X ⟶ Spec (.of k)) [LocallyOfFiniteType sX]
    (U : X.Opens) (hU : IsAffineOpen U) :
    letI := (chartBaseFieldHom sX U).toAlgebra
    Algebra.FiniteType k Γ(X, U) := by
  letI := (chartBaseFieldHom sX U).toAlgebra
  apply RingHom.finiteType_algebraMap.mp
  change RingHom.FiniteType (chartBaseFieldHom sX U)
  change RingHom.FiniteType
    (((Scheme.ΓSpecIso (.of k)).inv ≫ sX.appLE ⊤ U le_top).hom)
  rw [CommRingCat.hom_comp,
    RingHom.finiteType_respectsIso.cancel_left_isIso]
  exact LocallyOfFiniteType.finiteType_of_affine_subset
    ⟨⊤, isAffineOpen_top (Spec (.of k))⟩ ⟨U, hU⟩ le_top

end Litt3.QuotientGeometry

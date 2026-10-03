import Solutions.QuotientGeometry.AffineChartFiniteType
import Mathlib.AlgebraicGeometry.Noetherian
import Mathlib.AlgebraicGeometry.Morphisms.QuasiCompact

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

open Litt3.QuotientGeometry

universe u

/-- Actual locally finite type schemes over a field are locally Noetherian:
the coefficient algebra on EVERY original affine open is the finite type
algebra derived from the actual structure morphism. -/
theorem actual_locally_finite_type_scheme_locally_noetherian
    {k : Type u} [Field k] {X : Scheme.{u}}
    (sX : X ⟶ Spec (.of k)) [LocallyOfFiniteType sX] :
    IsLocallyNoetherian X := by
  refine ⟨fun U => ?_⟩
  letI := (chartBaseFieldHom sX U).toAlgebra
  letI : Algebra.FiniteType k Γ(X, U) :=
    actual_affine_chart_finiteType sX U U.property
  exact Algebra.FiniteType.isNoetherianRing k Γ(X, U)

/-- Quasi-compactness of the actual locally finite type structure map
gives a genuine Noetherian scheme, hence a Noetherian original space. -/
theorem actual_finite_type_scheme_noetherian
    {k : Type u} [Field k] {X : Scheme.{u}}
    (sX : X ⟶ Spec (.of k)) [LocallyOfFiniteType sX] [QuasiCompact sX] :
    IsNoetherian X := by
  letI : IsLocallyNoetherian X :=
    actual_locally_finite_type_scheme_locally_noetherian sX
  letI : CompactSpace X := QuasiCompact.compactSpace_of_compactSpace sX
  exact ⟨⟩

end Litt3.Jacobians

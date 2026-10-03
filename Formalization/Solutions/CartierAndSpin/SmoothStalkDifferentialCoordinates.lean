import Solutions.QuotientGeometry.SmoothStalkDifferentialInjectivity
import Mathlib.LinearAlgebra.Dimension.Constructions
import Mathlib.LinearAlgebra.Pi

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] {X : Scheme.{u}}
  (sX : X ⟶ Spec (.of k))

/-- The ENTIRE original smooth point-stalk universal module has the
literal relative rank, in arbitrary characteristic and dimension. -/
theorem actual_smooth_stalk_differential_rank (n : ℕ)
    [IsSmoothOfRelativeDimension n sX] (x : X) :
    letI := (stalkBaseFieldHom sX x).toAlgebra
    Module.rank (X.presheaf.stalk x) (KaehlerDifferential k (X.presheaf.stalk x)) = n := by
  letI := (stalkBaseFieldHom sX x).toAlgebra
  obtain ⟨U, hU, hx, hs⟩ := actual_smooth_point_chart sX n x
  let xU : U := ⟨x, hx⟩
  letI : Nonempty U := ⟨xU⟩
  letI : Algebra k Γ(X, U) := (chartBaseFieldHom sX U).toAlgebra
  letI := X.presheaf.algebra_section_stalk xU
  letI : IsScalarTower k Γ(X, U) (X.presheaf.stalk x) :=
    IsScalarTower.of_algebraMap_eq'
      (actual_chart_stalk_base_field_compatibility sX U xU).symm
  letI : Algebra.IsStandardSmoothOfRelativeDimension n k Γ(X, U) := hs
  letI : Algebra.IsStandardSmooth k Γ(X, U) :=
    Algebra.IsStandardSmoothOfRelativeDimension.isStandardSmooth n
  letI := hU.isLocalization_stalk xU
  letI : Algebra.FormallyEtale Γ(X, U) (X.presheaf.stalk x) :=
    Algebra.FormallyEtale.of_isLocalization (hU.primeIdealOf xU).asIdeal.primeCompl
  let e := KaehlerDifferential.tensorKaehlerEquivOfFormallyEtale k Γ(X, U)
    (X.presheaf.stalk x)
  have hr := e.lift_rank_eq
  rw [Module.rank_baseChange,
    Algebra.IsStandardSmoothOfRelativeDimension.rank_kaehlerDifferential n] at hr
  simpa only [Cardinal.lift_natCast, Cardinal.lift_eq_nat_iff] using hr.symm

/-- Every actual smooth curve point-stalk admits a genuine rank-one
universal differential coordinate. The original local module, its
freeness and rank are all constructed; no parameter or characteristic
p-basis is an input. -/
noncomputable def actualSmoothCurveStalkDifferentialCoordinate
    [IsSmoothOfRelativeDimension 1 sX] (x : X) :
    letI := (stalkBaseFieldHom sX x).toAlgebra
    KaehlerDifferential k (X.presheaf.stalk x) ≃ₗ[X.presheaf.stalk x] X.presheaf.stalk x := by
  letI := (stalkBaseFieldHom sX x).toAlgebra
  letI := actual_smooth_stalk_differentials_free sX 1 x
  exact (finDimVectorspaceEquiv 1 (actual_smooth_stalk_differential_rank sX 1 x)).trans
    (LinearEquiv.funUnique (Fin 1) (X.presheaf.stalk x) (X.presheaf.stalk x))

end Litt3.CartierAndSpin

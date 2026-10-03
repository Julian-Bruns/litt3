import Solutions.QuotientGeometry.AffineChartStalkCoefficients
import Mathlib.AlgebraicGeometry.Morphisms.Affine

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- Original coefficient fields commute with the original full
inverse-image section pullback. -/
theorem actual_affine_chart_pullback_coefficient_square
    {k : Type u} [Field k] {X Y : Scheme.{u}}
    (f : X ⟶ Y) (sX : X ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
    (hover : f ≫ sY = sX) (U : Y.Opens) :
    (f.app U).hom.comp (chartBaseFieldHom sY U) =
      chartBaseFieldHom sX (f ⁻¹ᵁ U) := by
  change (((Scheme.ΓSpecIso (.of k)).inv ≫
    sY.appLE ⊤ U le_top) ≫ f.app U).hom = _
  rw [Category.assoc, Scheme.Hom.app_eq_appLE,
    Scheme.Hom.appLE_comp_appLE, hover]
  rfl

/-- The true affine chart points of an actual morphism are related
by the true coordinate-ring comap. -/
theorem actual_affine_chart_prime_comap
    {X Y : Scheme.{u}} (f : X ⟶ Y) (U : Y.Opens)
    (hU : IsAffineOpen U) (hV : IsAffineOpen (f ⁻¹ᵁ U))
    (x : f ⁻¹ᵁ U) :
    Spec.map (f.app U) (hV.primeIdealOf x) =
      hU.primeIdealOf ⟨f x, x.property⟩ := by
  apply hU.fromSpec.isOpenEmbedding.injective
  have hs := IsAffineOpen.SpecMap_appLE_fromSpec f hU hV le_rfl
  rw [← Scheme.Hom.app_eq_appLE] at hs
  have he := congrArg (fun g : Spec Γ(X, f ⁻¹ᵁ U) ⟶ Y =>
    g (hV.primeIdealOf x)) hs
  simpa only [Scheme.Hom.comp_apply, IsAffineOpen.fromSpec_primeIdealOf] using he

end Litt3.QuotientGeometry

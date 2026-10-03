import Solutions.QuotientGeometry.AffineChartStalkMapSquares

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] {X Y : Scheme.{u}}
  (f : X ⟶ Y) (sX : X ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
  (hover : f ≫ sY = sX) (U : Y.Opens)
  (hU : IsAffineOpen U) (hV : IsAffineOpen (f ⁻¹ᵁ U))
  (b : U) (x : f ⁻¹ᵁ U) (hb : b.val = f x)

include hb

theorem actual_affine_chart_fixed_prime_comap :
    (hU.primeIdealOf b).asIdeal =
      (hV.primeIdealOf x).asIdeal.comap (f.app U).hom := by
  have he : b = ⟨f x, x.property⟩ := Subtype.ext hb
  subst b
  exact congrArg PrimeSpectrum.asIdeal (actual_affine_chart_prime_comap f U hU hV x).symm

/-- A genuine chart-localization map from the SAME fixed original
base chart prime to any original point over it. -/
noncomputable def actualAffineChartFixedLocalizedBaseMap :
    letI := (chartBaseFieldHom sY U).toAlgebra
    letI := (chartBaseFieldHom sX (f ⁻¹ᵁ U)).toAlgebra
    Localization.AtPrime (hU.primeIdealOf b).asIdeal →ₐ[k]
      Localization.AtPrime (hV.primeIdealOf x).asIdeal := by
  letI := (chartBaseFieldHom sY U).toAlgebra
  letI := (chartBaseFieldHom sX (f ⁻¹ᵁ U)).toAlgebra
  letI := (f.app U).hom.toAlgebra
  letI : IsScalarTower k Γ(Y, U) Γ(X, f ⁻¹ᵁ U) :=
    IsScalarTower.of_algebraMap_eq'
      (actual_affine_chart_pullback_coefficient_square f sX sY hover U).symm
  exact localizedCoefficientBaseMap (k := k)
    (hU.primeIdealOf b).asIdeal (hV.primeIdealOf x).asIdeal
    (actual_affine_chart_fixed_prime_comap f U hU hV b x hb)

instance actualAffineChartFixedLocalizedBaseMap_isLocal :
    letI := (chartBaseFieldHom sY U).toAlgebra
    letI := (chartBaseFieldHom sX (f ⁻¹ᵁ U)).toAlgebra
    IsLocalHom
      (actualAffineChartFixedLocalizedBaseMap f sX sY hover U hU hV b x hb).toRingHom := by
  have he : b = ⟨f x, x.property⟩ := Subtype.ext hb
  subst b
  exact actualAffineChartLocalizedBaseMap_isLocal f sX sY hover U hU hV x

/-- The literal fixed-point original Scheme stalk map agrees on its
ENTIRE stalk with its genuine affine-chart localization map. -/
theorem actual_affine_chart_fixed_stalk_map_localization :
    letI := (chartBaseFieldHom sY U).toAlgebra
    letI := (chartBaseFieldHom sX (f ⁻¹ᵁ U)).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY b.val).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
    (actualAffineChartStalkCoefficientAlgEquiv sX (f ⁻¹ᵁ U) hV x).toAlgHom.comp
      (actualSchemeFixedBaseStalkMap f sX sY hover b.val x hb) =
    (actualAffineChartFixedLocalizedBaseMap f sX sY hover U hU hV b x hb).comp
      (actualAffineChartStalkCoefficientAlgEquiv sY U hU b).toAlgHom := by
  have he : b = ⟨f x, x.property⟩ := Subtype.ext hb
  subst b
  simpa [actualSchemeFixedBaseStalkMap, actualSchemeStalkPointAlgEquiv,
    actualAffineChartFixedLocalizedBaseMap, actualAffineChartLocalizedBaseMap] using
    actual_affine_chart_stalk_map_localization f sX sY hover U hU hV x

end Litt3.QuotientGeometry

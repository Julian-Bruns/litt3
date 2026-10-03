import Solutions.QuotientGeometry.AffineChartLocalizedBaseMaps
import Solutions.QuotientGeometry.SchemeFixedBaseStalkMap

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- The full ORIGINAL scheme stalk map agrees with the genuine
localization of its original affine chart pullback, respecting all
original coefficients. This is an equality on the entire stalk. -/
theorem actual_affine_chart_stalk_map_localization
    {k : Type u} [Field k] {X Y : Scheme.{u}}
    (f : X ⟶ Y) (sX : X ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
    (hover : f ≫ sY = sX) (U : Y.Opens)
    (hU : IsAffineOpen U) (hV : IsAffineOpen (f ⁻¹ᵁ U)) (x : f ⁻¹ᵁ U) :
    letI := (chartBaseFieldHom sY U).toAlgebra
    letI := (chartBaseFieldHom sX (f ⁻¹ᵁ U)).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f x)).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
    (actualAffineChartStalkCoefficientAlgEquiv sX (f ⁻¹ᵁ U) hV x).toAlgHom.comp
      (actualSchemeStalkAlgHom f sX sY hover x) =
    (actualAffineChartLocalizedBaseMap f sX sY hover U hU hV x).comp
      (actualAffineChartStalkCoefficientAlgEquiv sY U hU ⟨f x, x.property⟩).toAlgHom := by
  letI := (chartBaseFieldHom sY U).toAlgebra
  letI := (chartBaseFieldHom sX (f ⁻¹ᵁ U)).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f x)).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
  let b : U := ⟨f x, x.property⟩
  letI := Y.presheaf.algebra_section_stalk b
  letI := hU.isLocalization_stalk b
  apply AlgHom.coe_ringHom_injective
  apply IsLocalization.ringHom_ext (hU.primeIdealOf b).asIdeal.primeCompl
  apply RingHom.ext
  intro a
  change actualAffineChartStalkCoefficientAlgEquiv sX (f ⁻¹ᵁ U) hV x
      (f.stalkMap x (Y.presheaf.germ U (f x) x.property a)) =
    actualAffineChartLocalizedBaseMap f sX sY hover U hU hV x
      (actualAffineChartStalkCoefficientAlgEquiv sY U hU b
        (Y.presheaf.germ U (f x) x.property a))
  rw [Scheme.Hom.germ_stalkMap_apply,
    actualAffineChartStalkCoefficientAlgEquiv_germ,
    actualAffineChartStalkCoefficientAlgEquiv_germ,
    actualAffineChartLocalizedBaseMap_ring]

end Litt3.QuotientGeometry

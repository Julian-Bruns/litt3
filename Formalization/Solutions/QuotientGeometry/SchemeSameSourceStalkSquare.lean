import Solutions.QuotientGeometry.SchemeStalkCoefficients

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- The original equality of two scheme maps out of the SAME source
implies the entire square of actual stalk maps. The point transport
is the canonical genuine stalk isomorphism. -/
theorem actual_same_source_scheme_stalk_square
    {T X Y B : Scheme.{u}} (f₁ : T ⟶ X) (f₂ : T ⟶ Y)
    (χ₁ : X ⟶ B) (χ₂ : Y ⟶ B) (hcomm : f₁ ≫ χ₁ = f₂ ≫ χ₂) (t : T) :
    χ₁.stalkMap (f₁ t) ≫ f₁.stalkMap t =
      (B.presheaf.stalkCongr (.of_eq (congrArg (fun f : T ⟶ B => f t) hcomm))).hom ≫
        χ₂.stalkMap (f₂ t) ≫ f₂.stalkMap t := by
  have he := Scheme.Hom.stalkMap_congr_hom (f₁ ≫ χ₁) (f₂ ≫ χ₂) hcomm t
  simpa only [Scheme.Hom.stalkMap_comp, Category.assoc] using he

/-- Actual over-base scheme maps induce coefficient-preserving local
maps at every point, with the exact original same-source stalk square. -/
theorem actual_same_source_scheme_stalk_ring_square
    {T X Y B : Scheme.{u}} (f₁ : T ⟶ X) (f₂ : T ⟶ Y)
    (χ₁ : X ⟶ B) (χ₂ : Y ⟶ B) (hcomm : f₁ ≫ χ₁ = f₂ ≫ χ₂) (t : T) :
    (f₁.stalkMap t).hom.comp (χ₁.stalkMap (f₁ t)).hom =
      (f₂.stalkMap t).hom.comp ((χ₂.stalkMap (f₂ t)).hom.comp
        (B.presheaf.stalkCongr (.of_eq
          (congrArg (fun f : T ⟶ B => f t) hcomm))).hom.hom) := by
  exact congrArg CommRingCat.Hom.hom
    (actual_same_source_scheme_stalk_square f₁ f₂ χ₁ χ₂ hcomm t)

end Litt3.QuotientGeometry

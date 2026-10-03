import Solutions.QuotientGeometry.SchemeFixedBaseStalkMap
import Solutions.QuotientGeometry.SchemeSameSourceCoefficientSquare
import Solutions.QuotientGeometry.SchemeStalkInjectivity

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- A true surjective morphism of integral schemes induces an
injective original stalk map at every actual point over a fixed base
point. The point transport itself is a genuine equivalence. -/
theorem actual_integral_fixed_base_scheme_stalk_injective
    {k : Type u} [Field k] {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : Y ⟶ X) [Surjective f]
    (sY : Y ⟶ Spec (.of k)) (sX : X ⟶ Spec (.of k))
    (hover : f ≫ sX = sY) (b : X) (y : Y) (hb : b = f y) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX b).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY y).toAlgebra
    Function.Injective (actualSchemeFixedBaseStalkMap f sY sX hover b y hb) := by
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX b).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX (f y)).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY y).toAlgebra
  change Function.Injective ((actualSchemeStalkAlgHom f sY sX hover y).comp
    (actualSchemeStalkPointAlgEquiv sX b (f y) hb).toAlgHom)
  exact (actual_integral_surjective_scheme_stalk_injective f y).comp
    (actualSchemeStalkPointAlgEquiv sX b (f y) hb).injective

/-- BOTH original maps out of the SAME scheme produce a full stalk
square over any fixed actual downstairs point. The square follows
from the true Scheme commutation, rather than being supplied. -/
theorem actual_fixed_same_source_scheme_stalk_square
    {k : Type u} [Field k] {T X Y B : Scheme.{u}}
    (f₁ : T ⟶ X) (f₂ : T ⟶ Y) (χ₁ : X ⟶ B) (χ₂ : Y ⟶ B)
    (sT : T ⟶ Spec (.of k)) (sX : X ⟶ Spec (.of k))
    (sY : Y ⟶ Spec (.of k)) (sB : B ⟶ Spec (.of k))
    (hf₁ : f₁ ≫ sX = sT) (hf₂ : f₂ ≫ sY = sT)
    (hχ₁ : χ₁ ≫ sB = sX) (hχ₂ : χ₂ ≫ sB = sY)
    (hcomm : f₁ ≫ χ₁ = f₂ ≫ χ₂) (t : T) (b : B)
    (hb₁ : b = χ₁ (f₁ t)) (hb₂ : b = χ₂ (f₂ t)) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sB b).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX (f₁ t)).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f₂ t)).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sT t).toAlgebra
    (actualSchemeStalkAlgHom f₁ sT sX hf₁ t).comp
        (actualSchemeFixedBaseStalkMap χ₁ sX sB hχ₁ b (f₁ t) hb₁) =
      (actualSchemeStalkAlgHom f₂ sT sY hf₂ t).comp
        (actualSchemeFixedBaseStalkMap χ₂ sY sB hχ₂ b (f₂ t) hb₂) := by
  subst b
  simpa [actualSchemeFixedBaseStalkMap, actualSchemeStalkPointAlgEquiv,
    actualSchemeSecondBaseStalkMap] using
    actual_same_source_scheme_stalk_coefficient_square f₁ f₂ χ₁ χ₂
      sT sX sY sB hf₁ hf₂ hχ₁ hχ₂ hcomm t

end Litt3.QuotientGeometry

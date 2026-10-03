import Solutions.QuotientGeometry.SchemeStalkPointTransport
import Solutions.QuotientGeometry.SchemeStalkInjectivity

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

theorem actualSchemeSecondBaseStalkMap_injective
    {k : Type u} [Field k] {T X Y B : Scheme.{u}} [IsIntegral Y] [IsIntegral B]
    (f₁ : T ⟶ X) (f₂ : T ⟶ Y) (χ₁ : X ⟶ B) (χ₂ : Y ⟶ B) [Surjective χ₂]
    (sY : Y ⟶ Spec (.of k)) (sB : B ⟶ Spec (.of k))
    (hχ₂ : χ₂ ≫ sB = sY) (hcomm : f₁ ≫ χ₁ = f₂ ≫ χ₂) (t : T) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sB (χ₁ (f₁ t))).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f₂ t)).toAlgebra
    Function.Injective (actualSchemeSecondBaseStalkMap f₁ f₂ χ₁ χ₂ sY sB hχ₂ hcomm t) := by
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sB (χ₁ (f₁ t))).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sB (χ₂ (f₂ t))).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f₂ t)).toAlgebra
  exact (actual_integral_surjective_scheme_stalk_injective χ₂ (f₂ t)).comp
    (actualSchemeStalkPointAlgEquiv sB (χ₁ (f₁ t)) (χ₂ (f₂ t))
      (congrArg (fun f : T ⟶ B => f t) hcomm)).injective

end Litt3.QuotientGeometry

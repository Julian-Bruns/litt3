import Solutions.QuotientGeometry.SchemeStalkPointTransport

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- The complete coefficient-algebra square at a point is constructed
from BOTH actual maps of the SAME scheme source and the original
commuting scheme diagram. -/
theorem actual_same_source_scheme_stalk_coefficient_square
    {k : Type u} [Field k] {T X Y B : Scheme.{u}}
    (f₁ : T ⟶ X) (f₂ : T ⟶ Y) (χ₁ : X ⟶ B) (χ₂ : Y ⟶ B)
    (sT : T ⟶ Spec (.of k)) (sX : X ⟶ Spec (.of k))
    (sY : Y ⟶ Spec (.of k)) (sB : B ⟶ Spec (.of k))
    (hf₁ : f₁ ≫ sX = sT) (hf₂ : f₂ ≫ sY = sT)
    (hχ₁ : χ₁ ≫ sB = sX) (hχ₂ : χ₂ ≫ sB = sY)
    (hcomm : f₁ ≫ χ₁ = f₂ ≫ χ₂) (t : T) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sB (χ₁ (f₁ t))).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX (f₁ t)).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f₂ t)).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sT t).toAlgebra
    (actualSchemeStalkAlgHom f₁ sT sX hf₁ t).comp
        (actualSchemeStalkAlgHom χ₁ sX sB hχ₁ (f₁ t)) =
      (actualSchemeStalkAlgHom f₂ sT sY hf₂ t).comp
        (actualSchemeSecondBaseStalkMap f₁ f₂ χ₁ χ₂ sY sB hχ₂ hcomm t) := by
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sB (χ₁ (f₁ t))).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sB (χ₂ (f₂ t))).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX (f₁ t)).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f₂ t)).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sT t).toAlgebra
  apply AlgHom.ext
  intro a
  change (f₁.stalkMap t).hom ((χ₁.stalkMap (f₁ t)).hom a) =
    (f₂.stalkMap t).hom ((χ₂.stalkMap (f₂ t)).hom
      (actualSchemeStalkPointAlgEquiv sB (χ₁ (f₁ t)) (χ₂ (f₂ t))
        (congrArg (fun f : T ⟶ B => f t) hcomm) a))
  have he := RingHom.congr_fun
    (actualSchemeStalkPointAlgEquiv_ring sB (χ₁ (f₁ t)) (χ₂ (f₂ t))
      (congrArg (fun f : T ⟶ B => f t) hcomm)) a
  change actualSchemeStalkPointAlgEquiv sB (χ₁ (f₁ t)) (χ₂ (f₂ t))
    (congrArg (fun f : T ⟶ B => f t) hcomm) a = _ at he
  rw [he]
  exact RingHom.congr_fun
    (actual_same_source_scheme_stalk_ring_square f₁ f₂ χ₁ χ₂ hcomm t) a

end Litt3.QuotientGeometry

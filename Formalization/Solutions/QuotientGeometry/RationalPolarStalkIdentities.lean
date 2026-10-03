import Solutions.QuotientGeometry.FunctionFieldStalkSquares

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- The ORIGINAL rational polar relation descends to the ORIGINAL
fixed-base stalk relation through the genuine function-field/stalk square.
No local polar equation is a premise. This holds for integral schemes
without smoothness, DVR, characteristic or ramification assumptions. -/
theorem actual_rational_polar_identity_descends
    {k : Type u} [Field k] {X B : Scheme.{u}} [IsIntegral X] [IsIntegral B]
    (χ : X ⟶ B) [Surjective χ]
    (sX : X ⟶ Spec (.of k)) (sB : B ⟶ Spec (.of k))
    (hover : χ ≫ sB = sX) (b : B) (x : X) (hb : b = χ x)
    (u : B.presheaf.stalk b) (G F : X.presheaf.stalk x) (m n : ℕ) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sB b).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
    Litt3.SharedTensors.schemeFunctionFieldPullback χ
        (algebraMap (B.presheaf.stalk b) B.functionField u) *
      (algebraMap (X.presheaf.stalk x) X.functionField G) ^ m =
      (algebraMap (X.presheaf.stalk x) X.functionField F) ^ n →
    actualSchemeFixedBaseStalkMap χ sX sB hover b x hb u * G ^ m = F ^ n := by
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sB b).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
  intro hglobal
  apply (IsFractionRing.injective (X.presheaf.stalk x) X.functionField)
  rw [map_mul, map_pow, map_pow]
  have hsq := DFunLike.congr_fun
    (actual_function_field_pullback_fixed_base_stalk χ sX sB hover b x hb) u
  change Litt3.SharedTensors.schemeFunctionFieldPullback χ
      (algebraMap (B.presheaf.stalk b) B.functionField u) =
    algebraMap (X.presheaf.stalk x) X.functionField
      (actualSchemeFixedBaseStalkMap χ sX sB hover b x hb u) at hsq
  rw [← hsq]
  exact hglobal

/-- A single ORIGINAL rational F,G pair restricts to the exact polar
identity at every original fiber stalk. Genuine rational restrictions
are inputs; the local equation is proved by original field injectivity. -/
theorem actual_global_polar_pair_identity_descends
    {k : Type u} [Field k] {X B : Scheme.{u}} [IsIntegral X] [IsIntegral B]
    (χ : X ⟶ B) [Surjective χ]
    (sX : X ⟶ Spec (.of k)) (sB : B ⟶ Spec (.of k))
    (hover : χ ≫ sB = sX) (b : B) (x : X) (hb : b = χ x)
    (u : B.presheaf.stalk b) (G F : X.presheaf.stalk x) (m n : ℕ)
    (Gr Fr : X.functionField)
    (hG : algebraMap (X.presheaf.stalk x) X.functionField G = Gr)
    (hF : algebraMap (X.presheaf.stalk x) X.functionField F = Fr) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sB b).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
    Litt3.SharedTensors.schemeFunctionFieldPullback χ
        (algebraMap (B.presheaf.stalk b) B.functionField u) * Gr ^ m = Fr ^ n →
    actualSchemeFixedBaseStalkMap χ sX sB hover b x hb u * G ^ m = F ^ n := by
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sB b).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
  intro hglobal
  apply actual_rational_polar_identity_descends χ sX sB hover b x hb u G F m n
  rw [hG, hF]
  exact hglobal

end Litt3.QuotientGeometry

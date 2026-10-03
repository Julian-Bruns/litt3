import Solutions.QuotientGeometry.SmoothStalkDifferentialInjectivity

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k))

/-- An actual rational differential identity descends to the ORIGINAL
universal differential module of a smooth stalk. The true function-field
localization is injective by smoothness, rather than assumed faithful. -/
theorem actual_smooth_rational_differential_identity_descends (n : ℕ)
    [IsSmoothOfRelativeDimension n sX] (x : X) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
    letI := (genericBaseFieldHom sX).toAlgebra
    letI : IsScalarTower k (X.presheaf.stalk x) X.functionField :=
      IsScalarTower.of_algebraMap_eq'
        (Litt3.SharedTensors.stalk_base_field_generic_compatibility sX x).symm
    ∀ (G a : X.presheaf.stalk x)
      (omega : KaehlerDifferential k (X.presheaf.stalk x)),
      KaehlerDifferential.D k X.functionField
        (algebraMap (X.presheaf.stalk x) X.functionField G) =
      (algebraMap (X.presheaf.stalk x) X.functionField a) •
        (KaehlerDifferential.map k k (X.presheaf.stalk x) X.functionField omega) →
      KaehlerDifferential.D k (X.presheaf.stalk x) G = a • omega := by
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : IsScalarTower k (X.presheaf.stalk x) X.functionField :=
    IsScalarTower.of_algebraMap_eq'
      (Litt3.SharedTensors.stalk_base_field_generic_compatibility sX x).symm
  intro G a omega hid
  apply actual_smooth_stalk_differential_map_injective sX n x
  rw [KaehlerDifferential.map_D, map_smul,
    ← IsScalarTower.algebraMap_smul X.functionField a]
  exact hid

end Litt3.QuotientGeometry

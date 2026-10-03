import Solutions.QuotientGeometry.SchemeStalkCoefficients
import Definitions.QuotientGeometry.SchemeBaseFields
import Mathlib.AlgebraicGeometry.AffineScheme

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

variable {X : Scheme.{u}} {k : Type u} [Field k]

/-- The actual structure-map coefficient field on every affine
chart agrees with the original Scheme stalk coefficient field. -/
theorem actual_chart_stalk_base_field_compatibility
    (sX : X ⟶ Spec (.of k)) (U : X.Opens) (x : U) :
    letI := X.presheaf.algebra_section_stalk x
    (algebraMap Γ(X, U) (X.presheaf.stalk x)).comp (chartBaseFieldHom sX U) =
      Litt3.SharedTensors.stalkBaseFieldHom sX x := by
  letI := X.presheaf.algebra_section_stalk x
  change ((Scheme.ΓSpecIso (.of k)).inv ≫ sX.appTop ≫
      X.presheaf.map (homOfLE le_top).op ≫ X.presheaf.germ U x x.2).hom = _
  rw [X.presheaf.germ_res]
  rfl

/-- The original Scheme stalk of an arbitrary affine open is
coefficient-preservingly equivalent to the genuine localization
of that chart's section ring at its actual point prime. -/
noncomputable def actualAffineChartStalkCoefficientAlgEquiv
    (sX : X ⟶ Spec (.of k)) (U : X.Opens) (hU : IsAffineOpen U) (x : U) :
    letI := (chartBaseFieldHom sX U).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
    X.presheaf.stalk x ≃ₐ[k] Localization.AtPrime (hU.primeIdealOf x).asIdeal := by
  letI := (chartBaseFieldHom sX U).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
  letI := X.presheaf.algebra_section_stalk x
  letI : IsScalarTower k Γ(X, U) (X.presheaf.stalk x) :=
    IsScalarTower.of_algebraMap_eq' (actual_chart_stalk_base_field_compatibility sX U x).symm
  letI := hU.isLocalization_stalk x
  exact (IsLocalization.algEquiv (hU.primeIdealOf x).asIdeal.primeCompl
    (X.presheaf.stalk x) (Localization.AtPrime (hU.primeIdealOf x).asIdeal)).restrictScalars k

/-- The coefficient equivalence respects the ENTIRE original
section-to-stalk germ map. -/
theorem actualAffineChartStalkCoefficientAlgEquiv_germ
    (sX : X ⟶ Spec (.of k)) (U : X.Opens) (hU : IsAffineOpen U) (x : U)
    (a : Γ(X, U)) :
    letI := (chartBaseFieldHom sX U).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
    actualAffineChartStalkCoefficientAlgEquiv sX U hU x (X.presheaf.germ U x x.2 a) =
      algebraMap Γ(X, U) (Localization.AtPrime (hU.primeIdealOf x).asIdeal) a := by
  letI := (chartBaseFieldHom sX U).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
  letI := X.presheaf.algebra_section_stalk x
  letI : IsScalarTower k Γ(X, U) (X.presheaf.stalk x) :=
    IsScalarTower.of_algebraMap_eq' (actual_chart_stalk_base_field_compatibility sX U x).symm
  letI := hU.isLocalization_stalk x
  exact (IsLocalization.algEquiv (hU.primeIdealOf x).asIdeal.primeCompl
    (X.presheaf.stalk x) (Localization.AtPrime (hU.primeIdealOf x).asIdeal)).commutes a

end Litt3.QuotientGeometry

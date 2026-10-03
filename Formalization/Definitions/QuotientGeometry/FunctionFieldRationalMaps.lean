import Definitions.SharedTensors.SchemeFunctionFields
import Mathlib.AlgebraicGeometry.RationalMap

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

/-- The actual generic-point Scheme map associated to an actual
contravariant function-field map. -/
noncomputable def genericStalkSchemeMap
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (φ : Y.functionField →+* X.functionField) : Spec X.functionField ⟶ Y :=
  Spec.map (CommRingCat.ofHom φ) ≫ Y.fromSpecStalk (genericPoint Y)

/-- Compatibility is the actual base-Scheme diagram, rather than a
formal label saying that a field map is over the constants. -/
def GenericFieldMapOver
    {X Y S : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ S) (sY : Y ⟶ S) (φ : Y.functionField →+* X.functionField) : Prop :=
  genericStalkSchemeMap φ ≫ sY = X.fromSpecStalk (genericPoint X) ≫ sX

noncomputable def functionFieldPartialMap
    {X Y S : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ S) (sY : Y ⟶ S) [LocallyOfFiniteType sY]
    (φ : Y.functionField →+* X.functionField) (hφ : GenericFieldMapOver sX sY φ) :
    X.PartialMap Y :=
  Scheme.PartialMap.ofFromSpecStalk sX sY (genericStalkSchemeMap φ) hφ

noncomputable def functionFieldRationalMap
    {X Y S : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ S) (sY : Y ⟶ S) [LocallyOfFiniteType sY]
    (φ : Y.functionField →+* X.functionField) (hφ : GenericFieldMapOver sX sY φ) :
    X.RationalMap Y :=
  Scheme.RationalMap.ofFunctionField sX sY (genericStalkSchemeMap φ) hφ

end Litt3.QuotientGeometry

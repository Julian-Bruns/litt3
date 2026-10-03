import Definitions.Deformations.RegularFunctionRepresentation
import Mathlib.Algebra.BigOperators.Pi

namespace Litt3.Deformations

variable {k G V : Type*} [CommRing k] [Group G] [AddCommGroup V] [Module k V]

/-- The actual single-supported function at a specified group element. -/
noncomputable def regularFunctionDeltaMap (g : G) : V →ₗ[k] (G → V) := by
  classical
  exact {
    toFun v := Pi.single g v
    map_add' v w := by ext x; simp [Pi.single_apply]; split_ifs <;> simp
    map_smul' c v := by ext x; simp [Pi.single_apply] }

end Litt3.Deformations

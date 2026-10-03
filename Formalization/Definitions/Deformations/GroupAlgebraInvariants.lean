import Definitions.Deformations.PGroupInvariants
import Mathlib.RingTheory.SimpleModule.Basic

namespace Litt3.Deformations

open scoped MonoidAlgebra

variable {k G V : Type*} [CommRing k] [Group G] [AddCommGroup V] [Module k V]

/-- Full actual invariance on the associated group-algebra module. -/
def groupAlgebraInvariantPredicate (ρ : Representation k G V) (x : ρ.asModule) : Prop :=
  ∀ g, ρ g (ρ.asModuleEquiv x) = ρ.asModuleEquiv x

end Litt3.Deformations

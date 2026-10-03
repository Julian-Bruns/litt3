import Definitions.Deformations.RadicalComplements
import Mathlib.LinearAlgebra.Dual.Lemmas
import Mathlib.LinearAlgebra.Dimension.Constructions
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas

namespace Litt3.Deformations

variable {k V ι : Type*} [Field k] [AddCommGroup V] [Module k V] [Fintype ι]

/-- The actual cup-boundary on a finite direct sum of section spaces. -/
noncomputable def socleCupBoundary (B : ι → LinearMap.BilinForm k V) :
    (ι → V) →ₗ[k] Module.Dual k V :=
  ∑ i, LinearMap.comp (B i) (LinearMap.proj i)

/-- The complete common radical, retaining all cup forms. -/
def commonCupRadical (B : ι → LinearMap.BilinForm k V) : Submodule k V :=
  ⨅ i, BilinearRadical (B i)

variable {W : Type*} [AddCommGroup W] [Module k W]

/-- An actual left-exact section sequence ending at the specified
cup-boundary. Its dimension formula is not assumed as input. -/
structure SocleSectionSequence (B : ι → LinearMap.BilinForm k V) (W : Type*)
    [AddCommGroup W] [Module k W] where
  inclusion : V →ₗ[k] W
  projection : W →ₗ[k] (ι → V)
  inclusion_injective : Function.Injective inclusion
  exact_at_sections : LinearMap.range inclusion = LinearMap.ker projection
  exact_at_boundary : LinearMap.range projection = LinearMap.ker (socleCupBoundary B)

end Litt3.Deformations

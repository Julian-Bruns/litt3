import Mathlib.Algebra.Module.ZMod
import Mathlib.LinearAlgebra.Quotient.Basic

namespace Litt3.Deformations

variable {M : Type*} [AddCommGroup M] (n : ℕ) [Module (ZMod n) M]

/-- The original unrestricted additive operator, with its actual
forced integer-quotient scalar structure. -/
def additiveZModOperator (L : M →+ M) : Module.End (ZMod n) M :=
  L.toZModLinearMap n

/-- The source mixed comparison after the actual coefficient
automorphism, retaining its original additive map. -/
def mixedAdditiveComparison (L : M →+ M) (Phi : M ≃ₗ[ZMod n] M) :
    Module.End (ZMod n) M :=
  (additiveZModOperator n L).comp Phi.symm.toLinearMap

end Litt3.Deformations

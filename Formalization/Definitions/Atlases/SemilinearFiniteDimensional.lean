import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas
import Mathlib.LinearAlgebra.Finsupp.Defs

namespace Litt3.Atlases

variable {K V : Type*} [DivisionRing K] [AddCommGroup V] [Module K V]

/-- A scalar automorphism acts on a free module through its basis
coordinates. This is an existence device, with no matrix enumeration. -/
noncomputable def basisScalarTwist {ι : Type*} (b : Module.Basis ι K V)
    (σ : K ≃+* K) :
    haveI := RingHomInvPair.of_ringEquiv σ
    haveI := RingHomInvPair.symm (↑σ : K →+* K) (↑σ.symm : K →+* K)
    V ≃ₛₗ[(↑σ : K →+* K)] V :=
  haveI := RingHomInvPair.of_ringEquiv σ
  haveI := RingHomInvPair.symm (↑σ : K →+* K) (↑σ.symm : K →+* K)
  (b.repr.trans (Finsupp.mapRange.linearEquiv σ.toSemilinearEquiv)).trans b.repr.symm

end Litt3.Atlases

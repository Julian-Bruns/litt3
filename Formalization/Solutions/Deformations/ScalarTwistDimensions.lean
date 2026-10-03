import Solutions.Deformations.ScalarTwistedRepresentations
import Definitions.Atlases.SemilinearFiniteDimensional
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas

namespace Litt3.Deformations

universe u

variable {k V : Type u} [Field k] [AddCommGroup V] [Module k V]

/-- A basis gives an auxiliary linear equivalence solely for
proving dimensions of the scalar twist. The canonical semilinear
comparison square never uses or chooses this identification. -/
noncomputable def scalarTwistDimensionEquiv (σ : k ≃+* k) : V ≃ₗ[k] ScalarTwist σ V := by
  letI := RingHomInvPair.of_ringEquiv σ
  letI := RingHomInvPair.symm (↑σ : k →+* k) (↑σ.symm : k →+* k)
  let e := Litt3.Atlases.basisScalarTwist (Module.Free.chooseBasis k V) σ
  let f := scalarTwistedLinearMap σ e.toLinearMap
  apply LinearEquiv.ofBijective f
  constructor
  · intro x y h
    exact e.injective (congrArg ScalarTwist.value h)
  · intro y
    exact ⟨e.symm y.value, ScalarTwist.ext σ V (e.apply_symm_apply y.value)⟩

theorem scalar_twist_finrank (σ : k ≃+* k) :
    Module.finrank k (ScalarTwist σ V) = Module.finrank k V :=
  (scalarTwistDimensionEquiv (V := V) σ).finrank_eq.symm

instance scalarTwistModuleFinite (σ : k ≃+* k) [FiniteDimensional k V] :
    FiniteDimensional k (ScalarTwist σ V) :=
  Module.Finite.of_injective (scalarTwistDimensionEquiv (V := V) σ).symm.toLinearMap
    (scalarTwistDimensionEquiv (V := V) σ).symm.injective

end Litt3.Deformations

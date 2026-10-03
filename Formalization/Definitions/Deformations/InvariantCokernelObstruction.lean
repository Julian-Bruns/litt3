import Definitions.Deformations.RepresentationCocycles
import Mathlib.LinearAlgebra.Isomorphisms

namespace Litt3.Deformations

universe u

noncomputable section

variable (k G L U DL DU : Type u) [Field k] [Group G]
    [AddCommGroup L] [Module k L] [AddCommGroup U] [Module k U]
    [AddCommGroup DL] [Module k DL] [AddCommGroup DU] [Module k DU]

/-- An actual equivariant linear comparison square with full invariant
descent on both source and target spaces. Different source and target
scalar transports are allowed, so an actual Frobenius twist need not be
identified with the original space. -/
structure InvariantDescentSquare where
  sourceAction : Representation k G L
  targetAction : Representation k G U
  sourcePullback : DL →ₗ[k] L
  targetPullback : DU →ₗ[k] U
  targetInjective : Function.Injective targetPullback
  sourceInvariantImage : LinearMap.range sourcePullback = sourceAction.invariants
  targetInvariantImage : LinearMap.range targetPullback = targetAction.invariants
  upperMap : L →ₗ[k] U
  lowerMap : DL →ₗ[k] DU
  upperEquivariant : ∀ g x, upperMap (sourceAction g x) = targetAction g (upperMap x)
  commutes : upperMap.comp sourcePullback = targetPullback.comp lowerMap

namespace InvariantDescentSquare

variable {k G L U DL DU}
variable (square : InvariantDescentSquare k G L U DL DU)

def kernelAction : Representation k G (LinearMap.ker square.upperMap) :=
  square.sourceAction.subrepresentation (LinearMap.ker square.upperMap) (by
    intro g x hx
    change square.upperMap (square.sourceAction g x) = 0
    rw [square.upperEquivariant, show square.upperMap x = 0 from hx, map_zero])

def invariantPreimage : Submodule k L :=
  square.targetAction.invariants.comap square.upperMap

/-- The genuine induced map on the two actual cokernels. -/
def cokernelPullback : (DU ⧸ LinearMap.range square.lowerMap) →ₗ[k]
    (U ⧸ LinearMap.range square.upperMap) :=
  (LinearMap.range square.lowerMap).mapQ (LinearMap.range square.upperMap)
    square.targetPullback (by
      rintro x ⟨d, rfl⟩
      exact ⟨square.sourcePullback d, LinearMap.congr_fun square.commutes d⟩)

/-- Actual differences of a point whose image is invariant are full
cocycles in the genuine kernel representation. -/
def differenceCocycle (b : square.invariantPreimage) :
    groupCohomology.cocycles₁ (Rep.of square.kernelAction) :=
  ⟨fun g => ⟨square.sourceAction g b.1 - b.1, by
      change square.upperMap (square.sourceAction g b.1 - b.1) = 0
      rw [map_sub, square.upperEquivariant]
      exact sub_eq_zero.mpr
        ((Representation.mem_invariants square.targetAction _).mp b.2 g)⟩,
    (groupCohomology.mem_cocycles₁_iff (A := Rep.of square.kernelAction) _).mpr (by
      intro g h
      apply Subtype.ext
      change square.sourceAction (g * h) b.1 - b.1 =
        square.sourceAction g (square.sourceAction h b.1 - b.1) +
          (square.sourceAction g b.1 - b.1)
      rw [map_mul, Module.End.mul_apply, map_sub]
      abel)⟩

def differenceCocycleMap : square.invariantPreimage →ₗ[k]
    groupCohomology.cocycles₁ (Rep.of square.kernelAction) where
  toFun := square.differenceCocycle
  map_add' b c := by
    apply groupCohomology.cocycles₁_ext
    intro g
    apply Subtype.ext
    change square.sourceAction g (b.1 + c.1) - (b.1 + c.1) =
      (square.sourceAction g b.1 - b.1) + (square.sourceAction g c.1 - c.1)
    rw [map_add]
    abel
  map_smul' a b := by
    apply groupCohomology.cocycles₁_ext
    intro g
    apply Subtype.ext
    change square.sourceAction g (a • b.1) - a • b.1 =
      a • (square.sourceAction g b.1 - b.1)
    simp only [map_smul, smul_sub]

def cohomologyConnectingMap : square.invariantPreimage →ₗ[k]
    groupCohomology (Rep.of square.kernelAction) 1 :=
  (groupCohomology.H1π (Rep.of square.kernelAction)).hom.comp square.differenceCocycleMap

/-- Unique descent of the actual invariant image of a point. -/
noncomputable def invariantImageDescent : square.invariantPreimage →ₗ[k] DU :=
  by
  let imageMap : square.invariantPreimage →ₗ[k] LinearMap.range square.targetPullback := {
    toFun b := ⟨square.upperMap b.1, by rw [square.targetInvariantImage]; exact b.2⟩
    map_add' b c := Subtype.ext (square.upperMap.map_add b.1 c.1)
    map_smul' a b := Subtype.ext (square.upperMap.map_smul a b.1) }
  exact (LinearEquiv.ofInjective square.targetPullback square.targetInjective).symm.toLinearMap.comp imageMap

noncomputable def cokernelRepresentativeMap : square.invariantPreimage →ₗ[k]
    (DU ⧸ LinearMap.range square.lowerMap) :=
  (LinearMap.range square.lowerMap).mkQ.comp square.invariantImageDescent

end InvariantDescentSquare

end

end Litt3.Deformations

import Definitions.Deformations.SemilinearInvariantCokernel
import Solutions.Deformations.ScalarTwistedRepresentations
import Solutions.Deformations.InvariantCokernelCriteria

namespace Litt3.Deformations.SemilinearInvariantDescentData

open scoped MonoidAlgebra

universe u

variable {k G V D : Type u} [Field k] [Group G]
    [AddCommGroup V] [Module k V] [AddCommGroup D] [Module k D]
    {σ : k ≃+* k} (data : SemilinearInvariantDescentData (G := G) (V := V) (D := D) σ)

/-- The actual semilinear square becomes a genuine linear square
with distinct scalar-twisted target spaces and original pullback maps.
All full invariant-image and equivariance properties are proved. -/
def asLinearSquare : InvariantDescentSquare k G V (ScalarTwist σ V) D (ScalarTwist σ D) where
  sourceAction := data.action
  targetAction := scalarTwistedRepresentation σ data.action
  sourcePullback := data.pullback
  targetPullback := scalarTwistedPullback σ data.pullback
  targetInjective := scalar_twisted_pullback_injective σ data.pullback data.pullbackInjective
  sourceInvariantImage := data.invariantImage
  targetInvariantImage :=
    scalar_twisted_pullback_invariant_image σ data.action data.pullback data.invariantImage
  upperMap := scalarTwistedLinearMap σ data.upperOperator
  lowerMap := scalarTwistedLinearMap σ data.lowerOperator
  upperEquivariant g v := ScalarTwist.ext σ V (data.operatorEquivariant g v)
  commutes := by
    apply LinearMap.ext
    intro d
    exact ScalarTwist.ext σ V (data.operatorCommutes d)

@[simp] theorem upper_kernel_eq : LinearMap.ker data.asLinearSquare.upperMap =
    LinearMap.ker data.upperOperator := by
  ext v
  rw [LinearMap.mem_ker, LinearMap.mem_ker]
  constructor
  · intro h
    exact congrArg ScalarTwist.value h
  · intro h
    exact ScalarTwist.ext σ V h

@[simp] theorem lower_kernel_eq : LinearMap.ker data.asLinearSquare.lowerMap =
    LinearMap.ker data.lowerOperator := by
  ext d
  rw [LinearMap.mem_ker, LinearMap.mem_ker]
  constructor
  · intro h
    exact congrArg ScalarTwist.value h
  · intro h
    exact ScalarTwist.ext σ D h

/-- The full genuine cohomology/cokernel obstruction comparison
for actual semilinear operators retains the usual scalar twist and
the exact value of every actual primitive representative. -/
theorem semilinear_invariant_cokernel_comparison
    (primitives : RepresentationCocyclePrimitives data.action) :
    Specifications.InvariantCokernelComparison data.asLinearSquare :=
  data.asLinearSquare.invariant_cokernel_comparison primitives

variable [Finite G]

theorem semilinear_invariant_cokernel_comparison_of_free
    [Module.Free k[G] data.action.asModule] :
    Specifications.InvariantCokernelComparison data.asLinearSquare :=
  data.semilinear_invariant_cokernel_comparison
    (free_group_module_cocycle_primitives data.action)

/-- The full kernel-growth and obstruction-vanishing equivalences
hold for the actual scalar-twisted square of every finite p-group.
Finite dimension is used only for its growth clauses. -/
theorem semilinear_invariant_cokernel_criteria
    {p : ℕ} [Fact p.Prime] [CharP k p] (group : IsPGroup p G)
    [FiniteDimensional k V] [Module.Free k[G] data.action.asModule] :
    Specifications.InvariantCokernelCriteria data.asLinearSquare := by
  letI : Module.Free k[G] data.asLinearSquare.sourceAction.asModule :=
    inferInstanceAs (Module.Free k[G] data.action.asModule)
  exact data.asLinearSquare.invariant_cokernel_criteria group data.pullbackInjective

end Litt3.Deformations.SemilinearInvariantDescentData

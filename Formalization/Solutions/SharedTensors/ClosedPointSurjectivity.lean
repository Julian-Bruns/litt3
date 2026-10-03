import Definitions.SharedTensors.SchemeDivisors
import Mathlib.AlgebraicGeometry.Morphisms.FiniteType
import Mathlib.Topology.JacobsonSpace

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.SharedTensors

universe u

/-- A nonempty closed fiber of an actual surjective finite map has
an actual closed point. Jacobson source suffices; there is no chosen
geometric Galois closure or presumed rational point. -/
theorem mapClosedPoint_surjective
    {X Y : Scheme.{u}} [JacobsonSpace X]
    (f : X ⟶ Y) [IsFinite f] [Surjective f] :
    Function.Surjective (mapClosedPoint f) := by
  intro y
  have hne : (f ⁻¹' ({y.val} : Set Y)).Nonempty := by
    obtain ⟨x, hx⟩ := f.surjective y.val
    exact ⟨x, hx⟩
  have hc : IsClosed (f ⁻¹' ({y.val} : Set Y)) := y.property.preimage f.continuous
  obtain ⟨x, hx, hcx⟩ := nonempty_inter_closedPoints hne hc.isLocallyClosed
  exact ⟨⟨x, hcx⟩, Subtype.ext hx⟩

theorem finite_type_over_field_jacobson
    {X : Scheme.{u}} {K : Type u} [Field K]
    (sX : X ⟶ Spec (.of K)) [LocallyOfFiniteType sX] : JacobsonSpace X :=
  LocallyOfFiniteType.jacobsonSpace sX

end Litt3.SharedTensors

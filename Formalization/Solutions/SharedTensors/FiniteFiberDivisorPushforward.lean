import Definitions.SharedTensors.SchemeDivisors
import Mathlib.Algebra.BigOperators.Group.Finset.Pi

namespace Litt3.SharedTensors

open Litt3.Jacobians Finset

abbrev PointFiber {Z X : Type*} (f : Z → X) (x : X) := {z : Z // f z = x}

theorem pointFiber_finite {Z X : Type*} (f : Z → X)
    (hf : ∀ s : Set X, s.Finite → (f ⁻¹' s).Finite) (x : X) :
    Finite (PointFiber f x) := by
  have h : {z : Z | f z = x}.Finite := by
    simpa using hf {x} (Set.finite_singleton x)
  exact Set.finite_coe_iff.mpr h

/-- Unweighted pushforward of actual integral point divisors. For rational
closed points of an étale curve cover these are the geometric weights. -/
noncomputable def divisorPushforward {Z X : Type*} (f : Z → X) :
    Divisor Z →+ Divisor X := Finsupp.mapDomain.addMonoidHom f

theorem divisorPushforward_apply_eq_fiber_sum {Z X : Type*}
    (f : Z → X) (x : X) [Fintype (PointFiber f x)] (D : Divisor Z) :
    divisorPushforward f D x = ∑ z : PointFiber f x, D z.val := by
  classical
  change (Finsupp.mapDomain f D) x = _
  rw [Finsupp.mapDomain, Finsupp.sum_apply, Finsupp.sum]
  have hleft : (∑ z ∈ D.support, (Finsupp.single (f z) (D z)) x) =
      ∑ z ∈ D.support.filter (fun z => f z = x), D z := by
    rw [sum_filter]
    apply sum_congr rfl
    intro z _
    simp only [Finsupp.single_apply, eq_comm]
  rw [hleft]
  symm
  rw [← sum_filter_ne_zero]
  apply sum_bij (fun z _ => z.val)
  · intro z hz
    exact mem_filter.mpr
      ⟨Finsupp.mem_support_iff.mpr (mem_filter.mp hz).2, z.property⟩
  · intro z hz z' hz' heq
    exact Subtype.ext heq
  · intro z hz
    exact ⟨⟨z, (mem_filter.mp hz).2⟩,
      mem_filter.mpr ⟨mem_univ _, Finsupp.mem_support_iff.mp (mem_filter.mp hz).1⟩, rfl⟩
  · intro z _
    rfl

open CategoryTheory AlgebraicGeometry
universe u

instance closedPointFiber_finite {Z X : Scheme.{u}} (f : Z ⟶ X) [IsFinite f]
    (x : ClosedPoint X) : Finite (PointFiber (mapClosedPoint f) x) :=
  pointFiber_finite (mapClosedPoint f) (mapClosedPoint_finite_preimage f) x

noncomputable def closedPointFiberFintype {Z X : Scheme.{u}} (f : Z ⟶ X)
    [IsFinite f] (x : ClosedPoint X) : Fintype (PointFiber (mapClosedPoint f) x) :=
  Fintype.ofFinite _

noncomputable def schemeDivisorPushforward {Z X : Scheme.{u}} (f : Z ⟶ X) [IsFinite f] :
    Divisor (ClosedPoint Z) →+ Divisor (ClosedPoint X) :=
  divisorPushforward (mapClosedPoint f)

theorem actual_scheme_divisor_pushforward_fiber_formula
    {Z X : Scheme.{u}} (f : Z ⟶ X) [IsFinite f] (x : ClosedPoint X)
    (D : Divisor (ClosedPoint Z)) :
    letI := closedPointFiberFintype f x
    schemeDivisorPushforward f D x = ∑ z : PointFiber (mapClosedPoint f) x, D z.val := by
  letI := closedPointFiberFintype f x
  exact divisorPushforward_apply_eq_fiber_sum (mapClosedPoint f) x D

end Litt3.SharedTensors

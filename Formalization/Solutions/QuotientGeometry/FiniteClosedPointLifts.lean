import Solutions.QuotientGeometry.AffineChartMapSquares
import Solutions.QuotientGeometry.FiniteAffineChartAlgebras
import Definitions.SharedTensors.SchemeDivisors
import Mathlib.Topology.JacobsonSpace
import Mathlib.RingTheory.Ideal.GoingUp

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

/-- Every actual point over a genuine closed point under a finite
scheme morphism is closed. The proof uses the original integral
affine chart pullback and its actual prime comap. -/
theorem actual_finite_map_preimage_closed_point
    {X Y : Scheme.{u}} [JacobsonSpace X]
    (f : X ⟶ Y) [IsFinite f] (x : X)
    (hy : IsClosed ({f x} : Set Y)) : IsClosed ({x} : Set X) := by
  obtain ⟨U, hU, hxU, _⟩ := exists_isAffineOpen_mem_and_subset
    (show f x ∈ (⊤ : Y.Opens) from trivial)
  let hV := hU.preimage f
  let xV : f ⁻¹ᵁ U := ⟨x, hxU⟩
  let yU : U := ⟨f x, hxU⟩
  letI := (f.app U).hom.toAlgebra
  letI : Algebra.IsIntegral Γ(Y, U) Γ(X, f ⁻¹ᵁ U) :=
    actual_finite_map_affine_chart_integral f U hU
  have hJ : (hU.primeIdealOf yU).asIdeal.IsMaximal :=
    hU.primeIdealOf_isMaximal_of_isClosed yU hy
  have hcomap := congrArg PrimeSpectrum.asIdeal
    (actual_affine_chart_prime_comap f U hU hV xV)
  have hP : (hV.primeIdealOf xV).asIdeal.IsMaximal :=
    Ideal.isMaximal_of_isIntegral_of_isMaximal_comap _ (hcomap.symm ▸ hJ)
  have hp : hV.primeIdealOf xV ∈ closedPoints (Spec Γ(X, f ⁻¹ᵁ U)) :=
    (hV.primeIdealOf xV).isClosed_singleton_iff_isMaximal.mpr hP
  have hc := (Set.ext_iff.mp
    hV.fromSpec.isOpenEmbedding.preimage_closedPoints (hV.primeIdealOf xV)).mpr hp
  change IsClosed ({hV.fromSpec (hV.primeIdealOf xV)} : Set X) at hc
  simpa only [IsAffineOpen.fromSpec_primeIdealOf] using hc

/-- An actual finite surjective scheme map is surjective on actual
closed points, with no chosen-lift or rational-point hypothesis. -/
theorem actual_finite_map_closed_points_surjective
    {X Y : Scheme.{u}} [JacobsonSpace X]
    (f : X ⟶ Y) [IsFinite f] [Surjective f] :
    Function.Surjective (Litt3.SharedTensors.mapClosedPoint f) := by
  intro y
  obtain ⟨x, hx⟩ := f.surjective y.val
  let t : Litt3.SharedTensors.ClosedPoint X :=
    ⟨x, actual_finite_map_preimage_closed_point f x (hx ▸ y.property)⟩
  exact ⟨t, Subtype.ext hx⟩

end Litt3.QuotientGeometry

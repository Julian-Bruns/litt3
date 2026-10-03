import Definitions.Deformations.ClosedSignedFiltration
import Solutions.Deformations.ArtinSchreierDegreePower
import Solutions.Deformations.ArtinSchreierNormalDegree
import Mathlib.Topology.Algebra.Ring.Basic

namespace Litt3.Deformations

variable {R A I : Type*} [CommRing R] [CommRing A] [Algebra R A] [Fintype I]
  [TopologicalSpace A] [ContinuousAdd A] [ContinuousMul A] [ContinuousConstSMul R A]

/-- Continuity extends the proved integral monomial product bound to
the genuinely closed carry modules, without choosing digits. -/
theorem closed_signed_filtration_multiplicative (p : A) (w : ℕ) (e : I → A)
    (d b : ℤ) (x y : A)
    (hx : x ∈ closedSignedFiltration R p w e d)
    (hy : y ∈ closedSignedFiltration R p w e b) :
    x * y ∈ closedSignedFiltration R p w e (d + b) := by
  have first (z : A) (hz : z ∈ signedGeneratorFiltration R p w e d) :
      z * y ∈ closedSignedFiltration R p w e (d + b) := by
    have maps : Set.MapsTo (fun t : A => z * t)
        (signedGeneratorFiltration R p w e b : Set A)
        (signedGeneratorFiltration R p w e (d + b) : Set A) := fun t ht =>
      signed_generator_filtration_multiplicative p w e d b z t hz ht
    exact maps.closure (continuous_const.mul continuous_id) hy
  have maps : Set.MapsTo (fun z : A => z * y)
      (signedGeneratorFiltration R p w e d : Set A)
      (closedSignedFiltration R p w e (d + b) : Set A) := first
  have image := maps.closure (continuous_id.mul continuous_const) hx
  simpa only [closedSignedFiltration, Submodule.topologicalClosure_coe, closure_closure] using image

/-- The pth-power bound also survives actual p-adic closure; it uses
the displayed chart relations only on the original coordinates. -/
theorem artin_schreier_closed_degree_one_power (p : ℕ) (prime : p.Prime) (e : I → A)
    (a b : I → R) (relations : ∀ i, e i ^ p = a i • e i + b i • (1 : A))
    (x : A) (member : x ∈ closedSignedFiltration R (p : A) (p - 1) e 1) :
    x ^ p ∈ closedSignedFiltration R (p : A) (p - 1) e 1 := by
  have maps : Set.MapsTo (fun y : A => y ^ p)
      (signedGeneratorFiltration R (p : A) (p - 1) e 1 : Set A)
      (signedGeneratorFiltration R (p : A) (p - 1) e 1 : Set A) := fun y hy =>
    artin_schreier_degree_one_power p prime e
      (artin_schreier_coordinate_power p e a b relations) y hy
  exact maps.closure (continuous_id.pow p) member

/-- Exact normal-coordinate reduction remains true under closure. -/
theorem artin_schreier_closed_normal_form (q : ℕ) (large : 1 < q) (p : A) (w : ℕ)
    (e : I → A) (a b : I → R)
    (relations : ∀ i, e i ^ q = a i • e i + b i • (1 : A)) (d : ℤ) :
    closedSignedFiltration R p w e d = (normalSignedFiltration R q p w e d).topologicalClosure := by
  rw [closedSignedFiltration, artin_schreier_signed_normal_form q large p w e a b relations d]

end Litt3.Deformations

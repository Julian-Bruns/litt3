import Mathlib.RingTheory.AdicCompletion.Basic
import Mathlib.Topology.Algebra.Nonarchimedean.AdicTopology
import Mathlib.Topology.Algebra.Module.Basic
import Mathlib.Tactic

namespace Litt3.Deformations

open Filter
open scoped Topology

variable {A : Type*} [CommRing A] [TopologicalSpace A]

/-- Full actual ideal-power approximations converge in the genuine
adic topology, before choosing any module basis or coefficient digits. -/
theorem adic_approximation_tendsto (J : Ideal A) (adic : IsAdic J)
    (f : ℕ → A) (x : A) (approximation : ∀ n, f n ≡ x [SMOD (J ^ n)]) :
    Tendsto f atTop (nhds x) := by
  apply (adic.hasBasis_nhds x).tendsto_right_iff.mpr
  intro n _
  filter_upwards [eventually_ge_atTop n] with m bound
  refine ⟨f m - x, ?_, ?_⟩
  · exact Ideal.pow_le_pow_right bound (SModEq.sub_mem.mp (approximation m))
  · ring

/-- An actual closed set retains the adic limit of every compatible
original approximation. -/
theorem adic_approximation_mem_closed (J : Ideal A) (adic : IsAdic J)
    (f : ℕ → A) (x : A) (approximation : ∀ n, f n ≡ x [SMOD (J ^ n)])
    (S : Set A) (closed : IsClosed S) (member : ∀ n, f n ∈ S) : x ∈ S :=
  closed.mem_of_tendsto (adic_approximation_tendsto J adic f x approximation)
    (Eventually.of_forall member)

end Litt3.Deformations

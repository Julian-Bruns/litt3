import Mathlib.Topology.Algebra.Nonarchimedean.AdicTopology
import Mathlib.Topology.Algebra.Group.Basic
import Mathlib.Tactic

namespace Litt3.Deformations

variable {A B : Type*} [CommRing A] [CommRing B]
  [TopologicalSpace A] [IsTopologicalRing A] [TopologicalSpace B] [IsTopologicalRing B]

/-- Actual ideal-compatible ring homomorphisms are continuous in the
actual adic topologies; continuity is derived, not presumed. -/
theorem adic_ringHom_continuous (J : Ideal A) (K : Ideal B)
    (sourceAdic : IsAdic J) (targetAdic : IsAdic K)
    (f : A →+* B) (ideals : J.map f ≤ K) : Continuous f := by
  apply continuous_of_continuousAt_zero f.toAddMonoidHom
  change Filter.Tendsto f (nhds (0 : A)) (nhds (f 0))
  rw [map_zero]
  apply (sourceAdic.hasBasis_nhds_zero).tendsto_iff (targetAdic.hasBasis_nhds_zero) |>.mpr
  intro n _
  refine ⟨n, trivial, ?_⟩
  intro x member
  have mapped : f x ∈ (J ^ n).map f := Ideal.mem_map_of_mem f member
  rw [Ideal.map_pow] at mapped
  exact pow_le_pow_left' ideals n mapped

/-- Every actual ring homomorphism preserves the original integer
prime and is therefore continuous in its p-adic topologies. -/
theorem prime_adic_ringHom_continuous (p : ℕ)
    (sourceAdic : IsAdic (Ideal.span {(p : A)}))
    (targetAdic : IsAdic (Ideal.span {(p : B)})) (f : A →+* B) : Continuous f := by
  apply adic_ringHom_continuous _ _ sourceAdic targetAdic f
  simp only [Ideal.map_span, Set.image_singleton, map_natCast]
  exact le_rfl

end Litt3.Deformations

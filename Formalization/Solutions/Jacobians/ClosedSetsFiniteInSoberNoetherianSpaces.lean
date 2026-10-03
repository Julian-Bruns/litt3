import Mathlib.Topology.NoetherianSpace
import Mathlib.Topology.Sober

open TopologicalSpace

namespace Litt3.Jacobians

universe u

/-- In ANY quasi-sober Noetherian space, an actual closed set all
of whose points are closed is finite. Sobriety supplies genuine generic
points of irreducible closed components; no curve or point-counting
hypothesis is needed. -/
theorem actual_closed_set_finite_of_closed_singletons
    {T : Type u} [TopologicalSpace T] [QuasiSober T] [NoetherianSpace T]
    (S : Set T) (hS : IsClosed S)
    (hpoints : ∀ x ∈ S, IsClosed ({x} : Set T)) : S.Finite := by
  obtain ⟨C, hCfinite, hCclosed, hCirred, hSC⟩ :=
    NoetherianSpace.exists_finite_set_isClosed_irreducible hS
  rw [hSC]
  apply hCfinite.sUnion
  intro Z hZ
  obtain ⟨x, hx⟩ := QuasiSober.sober (hCirred Z hZ) (hCclosed Z hZ)
  have hxS : x ∈ S := by
    rw [hSC]
    exact Set.mem_sUnion.mpr ⟨Z, hZ, hx.mem⟩
  rw [← hx.def, (hpoints x hxS).closure_eq]
  exact Set.finite_singleton x

end Litt3.Jacobians

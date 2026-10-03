import Solutions.Jacobians.ActualTildeRankOneStalks

open TensorProduct

namespace Litt3.Jacobians

variable {R M : Type*} [CommRing R] [AddCommGroup M] [Module R M]
  [Module.Invertible R M]

/-- An original dual functional acts by a rank-one interchange identity;
this holds before any localization, even over rings with zero divisors. -/
theorem original_invertible_functional_interchange (g : Module.Dual R M) (m n : M) :
    g m • n = g n • m := by
  have h := congrArg (fun u => TensorProduct.lid R M ((g.rTensor M) u))
    (Module.Invertible.tmul_comm (m₁ := m) (m₂ := n))
  simpa using h

/-- Every original prime has a genuine original element and dual functional
whose pairing avoids that prime. The pairing is derived from the canonical
dual contraction, not a supplied frame or local generator. -/
theorem original_invertible_pairing_outside_prime (P : Ideal R) [P.IsPrime] :
    ∃ (m : M) (g : Module.Dual R M), g m ∉ P := by
  by_contra h
  push_neg at h
  have hall : ∀ u : Module.Dual R M ⊗[R] M, contractLeft R M u ∈ P := by
    intro u
    induction u using TensorProduct.induction_on with
    | zero => exact P.zero_mem
    | tmul g m => simpa using h m g
    | add a b ha hb => simpa using P.add_mem ha hb
  obtain ⟨u, hu⟩ := (Module.Invertible.bijective (R := R) (M := M)).surjective 1
  exact (Ideal.IsPrime.ne_top (inferInstance : P.IsPrime))
    ((Ideal.eq_top_iff_one P).mpr (hu ▸ hall u))

end Litt3.Jacobians

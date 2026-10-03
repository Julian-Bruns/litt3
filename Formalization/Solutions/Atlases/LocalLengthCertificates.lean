import Mathlib.RingTheory.Length
import Mathlib.RingTheory.Nakayama
import Mathlib.RingTheory.LocalRing.Module
import Mathlib.RingTheory.Ideal.Quotient.Operations
import Mathlib.RingTheory.Ideal.Operations
import Mathlib.Tactic

namespace Litt3.Atlases

section Modules

variable {R M N : Type*} [CommRing R] [AddCommGroup M] [AddCommGroup N]
  [Module R M] [Module R N]

/-- Exact equality of finite module lengths makes a surjective actual
map injective. Infinite or approximate lengths do not certify this. -/
theorem surjective_injective_of_equal_finite_length (f : M →ₗ[R] N)
    (hsurj : Function.Surjective f) (hfinite : Module.length R N ≠ ⊤)
    (hlength : Module.length R M = Module.length R N) : Function.Injective f := by
  have he := Module.length_eq_add_of_exact (LinearMap.ker f).subtype f
    (Submodule.subtype_injective _) hsurj (LinearMap.exact_subtype_ker_map f)
  have hzero : Module.length R (LinearMap.ker f) = 0 :=
    ENat.add_left_injective_of_ne_top hfinite (by
      change Module.length R (LinearMap.ker f) + Module.length R N =
        0 + Module.length R N
      rw [zero_add, ← he, hlength])
  letI : Subsingleton (LinearMap.ker f) := Module.length_eq_zero_iff.mp hzero
  apply LinearMap.ker_eq_bot.mp
  ext x
  constructor
  · intro hx
    have h := congrArg Subtype.val
      (Subsingleton.elim (⟨x, hx⟩ : LinearMap.ker f) 0)
    exact h
  · intro hx
    have hx0 : x = 0 := by simpa only [Submodule.mem_bot] using hx
    exact hx0 ▸ (LinearMap.ker f).zero_mem

end Modules

section Ideals

variable {C : Type*} [CommRing C]

/-- Equal finite lengths of nested actual ideal quotients force the
ideals themselves equal, with no finiteness assumption on the ambient ring. -/
theorem ideal_eq_of_equal_finite_quotient_length (I J : Ideal C) (hIJ : I ≤ J)
    (hfinite : Module.length C (C ⧸ J) ≠ ⊤)
    (hlength : Module.length C (C ⧸ I) = Module.length C (C ⧸ J)) : I = J := by
  let f := Ideal.Quotient.factorₐ C hIJ
  have hsurj : Function.Surjective f := by
    intro y
    obtain ⟨x, rfl⟩ := Ideal.Quotient.mkₐ_surjective C J y
    exact ⟨Ideal.Quotient.mkₐ C I x, rfl⟩
  have hinj := surjective_injective_of_equal_finite_length f.toLinearMap
    hsurj hfinite hlength
  apply le_antisymm hIJ
  intro x hx
  apply Ideal.Quotient.eq_zero_iff_mem.mp
  change Ideal.Quotient.mkₐ C I x = 0
  apply hinj
  change Ideal.Quotient.mkₐ C J x = f 0
  rw [map_zero]
  exact Ideal.Quotient.eq_zero_iff_mem.mpr hx

variable [IsLocalRing C] [IsNoetherianRing C]

/-- One exact consecutive local truncation-length plateau certifies
the entire actual local algebra by Nakayama. -/
theorem maximalIdeal_pow_eq_bot_of_truncation_length_plateau (r : ℕ)
    (hfinite : Module.length C (C ⧸ (IsLocalRing.maximalIdeal C) ^ r) ≠ ⊤)
    (hlength : Module.length C (C ⧸ (IsLocalRing.maximalIdeal C) ^ (r + 1)) =
      Module.length C (C ⧸ (IsLocalRing.maximalIdeal C) ^ r)) :
    (IsLocalRing.maximalIdeal C) ^ r = ⊥ := by
  let m := IsLocalRing.maximalIdeal C
  have he : m ^ (r + 1) = m ^ r :=
    ideal_eq_of_equal_finite_quotient_length _ _
      (Ideal.pow_le_pow_right (Nat.le_succ r)) hfinite hlength
  apply Submodule.eq_bot_of_le_smul_of_le_jacobson_bot m (m ^ r)
    (IsNoetherian.noetherian _)
  · rw [Ideal.smul_eq_mul, ← pow_succ', he]
  · rw [IsLocalRing.jacobson_eq_maximalIdeal ⊥ bot_ne_top]

end Ideals
end Litt3.Atlases

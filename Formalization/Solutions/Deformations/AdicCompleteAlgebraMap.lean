import Mathlib.RingTheory.AdicCompletion.Basic
import Mathlib.Tactic

namespace Litt3.Deformations

variable {R A : Type*} [CommRing R] [CommRing A] [Algebra R A]

/-- Adic completeness over the original coefficient ideal gives actual
ring completeness over its actual extended ideal. -/
theorem adic_complete_algebra_map (J : Ideal R) [IsAdicComplete J A] :
    IsAdicComplete (J.map (algebraMap R A)) A := by
  refine { haus' := ?_, prec' := ?_ }
  · intro x congruences
    apply IsHausdorff.haus' (I := J)
    intro n
    have member := SModEq.sub_mem.mp (congruences n)
    apply SModEq.sub_mem.mpr
    simpa only [sub_zero, smul_eq_mul, Ideal.mul_top, Ideal.smul_top_eq_map,
      ← Ideal.map_pow] using member
  · intro f compatible
    have original : ∀ {m n : ℕ}, m ≤ n →
        f m ≡ f n [SMOD (J ^ m • (⊤ : Submodule R A))] := by
      intro m n bound
      have member := SModEq.sub_mem.mp (compatible bound)
      apply SModEq.sub_mem.mpr
      simpa only [smul_eq_mul, Ideal.mul_top, Ideal.smul_top_eq_map,
        ← Ideal.map_pow] using member
    obtain ⟨L, limits⟩ := IsPrecomplete.prec' (I := J) f original
    refine ⟨L, fun n => ?_⟩
    have member := SModEq.sub_mem.mp (limits n)
    apply SModEq.sub_mem.mpr
    simpa only [smul_eq_mul, Ideal.mul_top, Ideal.smul_top_eq_map,
      ← Ideal.map_pow] using member

end Litt3.Deformations

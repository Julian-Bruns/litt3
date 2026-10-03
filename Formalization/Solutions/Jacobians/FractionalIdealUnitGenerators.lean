import Solutions.Jacobians.FractionalIdealPrincipalPicard

open scoped nonZeroDivisors

namespace Litt3.Jacobians

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K] [IsFractionRing R K]

/-- A true original-module trivialization gives the actual fractional
ideal generator as the inverse image of the ORIGINAL unit 1. The precise
generator is retained so restrictions of genuine sheaf maps can glue it. -/
theorem fractionalIdeal_eq_span_of_inverse_unit
    (I : FractionalIdeal R⁰ K) (e : (I : Submodule R K) ≃ₗ[R] R) :
    I = FractionalIdeal.spanSingleton R⁰ (e.symm 1).val := by
  let g : (I : Submodule R K) := e.symm 1
  have hxgen (x : (I : Submodule R K)) : x = e x • g := by
    apply e.injective
    simp [g]
  ext x
  constructor
  · intro hx
    let xi : (I : Submodule R K) := ⟨x, hx⟩
    apply (FractionalIdeal.mem_spanSingleton R⁰).mpr
    refine ⟨e xi, ?_⟩
    simpa only [Submodule.coe_smul] using (congrArg Subtype.val (hxgen xi)).symm
  · intro hx
    obtain ⟨r, hr⟩ := (FractionalIdeal.mem_spanSingleton R⁰).mp hx
    rw [← hr]
    exact (I : Submodule R K).smul_mem r g.property

end Litt3.Jacobians

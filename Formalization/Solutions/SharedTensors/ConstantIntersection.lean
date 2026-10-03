import Definitions.SharedTensors.ConstantIntersection

namespace Litt3.SharedTensors

open Litt3.Jacobians

variable {K F G E : Type*} [Field K] [Field F] [Field G] [Field E]

theorem endpoint_units_intersection_constants
    (κF : K →+* F) (κG : K →+* G) (φ : F →+* E) (ψ : G →+* E)
    (h : EndpointFieldIntersectionConstants κF κG φ ψ)
    (a : Additive Fˣ) (b : Additive Gˣ)
    (hab : rationalUnitPullback φ a = rationalUnitPullback ψ b) :
    ∃ c : Additive Kˣ,
      rationalUnitPullback κF c = a ∧ rationalUnitPullback κG c = b := by
  have hv : φ a.toMul.val = ψ b.toMul.val :=
    congrArg (fun u : Additive Eˣ => u.toMul.val) hab
  obtain ⟨c, hcF, hcG⟩ := h a.toMul.val b.toMul.val hv
  have hc : c ≠ 0 := by
    intro hz
    have : a.toMul.val = 0 := by rw [← hcF, hz, map_zero]
    exact a.toMul.ne_zero this
  let u : Additive Kˣ := Additive.ofMul (Units.mk0 c hc)
  refine ⟨u, ?_, ?_⟩ <;> apply Additive.toMul.injective <;> apply Units.ext
  · exact hcF
  · exact hcG

end Litt3.SharedTensors

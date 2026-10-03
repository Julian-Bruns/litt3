import Definitions.Jacobians.PrincipalPullbacks

namespace Litt3.SharedTensors

variable {K F G E : Type*} [Field K] [Field F] [Field G] [Field E]

/-- Literal intersection of the two actual field images consists of
the same endpoint constants. Both embeddings into E remain present. -/
def EndpointFieldIntersectionConstants
    (κF : K →+* F) (κG : K →+* G) (φ : F →+* E) (ψ : G →+* E) : Prop :=
  ∀ a b, φ a = ψ b → ∃ c, κF c = a ∧ κG c = b

end Litt3.SharedTensors

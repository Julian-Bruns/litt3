import Definitions.SharedTensors.DivisorRelations
import Definitions.Jacobians.PrincipalPullbacks

namespace Litt3.SharedTensors

open Litt3.Jacobians

variable {F G E : Type*} [Field F] [Field G] [Field E]

/-- Both actual endpoint field maps are retained. Additive notation for
units records the original multiplicative subgroup F*G*. -/
def unitRelationMap (φ : F →+* E) (ψ : G →+* E) :
    (Additive Fˣ × Additive Gˣ) →+ Additive Eˣ :=
  (rationalUnitPullback φ).comp (AddMonoidHom.fst _ _) -
    (rationalUnitPullback ψ).comp (AddMonoidHom.snd _ _)

abbrev UnitRelationQuotient (φ : F →+* E) (ψ : G →+* E) :=
  Additive Eˣ ⧸ (unitRelationMap φ ψ).range

end Litt3.SharedTensors

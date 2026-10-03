import Solutions.CartierAndSpin.LogarithmicChoiceImages
import Solutions.CartierAndSpin.EndpointDecompositionTorsor
import Solutions.CartierAndSpin.SharedCartierFixedCardinality

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k F G E : Type*} [Field k] [IsAlgClosed k] [Field F] [Field G] [Field E]
  [Algebra k F] [Algebra k G] [Algebra k E] [Algebra F E] [Algebra G E]
  [IsScalarTower k F E] [IsScalarTower k G E]
  [Algebra.IsSeparable F E] [Algebra.IsSeparable G E]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP E p]

/-- The ACTUAL shared Cartier-fixed group parametrizes all logarithmic
one-form choices relative to one actual logarithmic decomposition.
Primitive-function pth-power ambiguity is retained by using the
literal ranges of the original endpoint logarithmic homomorphisms. -/
noncomputable def actualLogarithmicChoiceSharedEquiv
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (CE : RationalCartierOperator k E p)
    (omega : KaehlerDifferential k E) (f : Additive Fˣ) (g : Additive Gˣ)
    (h0 : KaehlerDifferential.map k k G E (rationalLogarithmicDifferential k G g) -
      KaehlerDifferential.map k k F E (rationalLogarithmicDifferential k F f) = omega) :
    sharedIntrinsicCartierFixedForms k F G E CE ≃ actualLogarithmicChoiceFiber k F G E omega := by
  let eF := Classical.choice (one_variable_kaehler_coordinate_exists hfgF htrdegF)
  let eG := Classical.choice (one_variable_kaehler_coordinate_exists hfgG htrdegG)
  have hF : Function.Injective (endpointLogarithmicFormPullback k F E) :=
    (separable_universal_differential_map_injective (E := E) eF).comp Subtype.val_injective
  have hG : Function.Injective (endpointLogarithmicFormPullback k G E) :=
    (separable_universal_differential_map_injective (E := E) eG).comp Subtype.val_injective
  let e := endpointDecompositionSharedEquiv
    (endpointLogarithmicFormPullback k F E) (endpointLogarithmicFormPullback k G E)
    hF hG omega
    ⟨rationalLogarithmicDifferential k F f, ⟨f, rfl⟩⟩
    ⟨rationalLogarithmicDifferential k G g, ⟨g, rfl⟩⟩ h0
  rw [← endpoint_logarithmic_form_shared_image_eq hfgF htrdegF hfgG htrdegG CE]
  exact e

/-- Logarithmic one-form choices form an actual torsor under the
literal shared Cartier-fixed group when one choice exists. -/
noncomputable def actualLogarithmicChoiceTorsor
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (CE : RationalCartierOperator k E p)
    (omega : KaehlerDifferential k E) (f : Additive Fˣ) (g : Additive Gˣ)
    (h0 : KaehlerDifferential.map k k G E (rationalLogarithmicDifferential k G g) -
      KaehlerDifferential.map k k F E (rationalLogarithmicDifferential k F f) = omega) :
    AddTorsor (sharedIntrinsicCartierFixedForms k F G E CE)
      (actualLogarithmicChoiceFiber k F G E omega) :=
  actualTranslationTorsorOfEquiv
    (actualLogarithmicChoiceSharedEquiv hfgF htrdegF hfgG htrdegG CE omega f g h0)

/-- Every NONEMPTY original logarithmic one-form choice fiber has
exactly one or p points; the zero/shared-rank boundary and constant
intersection are proved on the actual spaces. -/
theorem actual_logarithmic_choice_cardinality_one_or_prime
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (hinter : EndpointFieldIntersectionConstants (algebraMap k F) (algebraMap k G)
      (algebraMap F E) (algebraMap G E))
    (CE : RationalCartierOperator k E p)
    (omega : KaehlerDifferential k E) (f : Additive Fˣ) (g : Additive Gˣ)
    (h0 : KaehlerDifferential.map k k G E (rationalLogarithmicDifferential k G g) -
      KaehlerDifferential.map k k F E (rationalLogarithmicDifferential k F f) = omega) :
    Nat.card (actualLogarithmicChoiceFiber k F G E omega) = 1 ∨
      Nat.card (actualLogarithmicChoiceFiber k F G E omega) = p := by
  rw [← Nat.card_congr (actualLogarithmicChoiceSharedEquiv
    hfgF htrdegF hfgG htrdegG CE omega f g h0)]
  exact actual_shared_cartier_fixed_cardinality_one_or_prime
    hfgF htrdegF hfgG htrdegG hinter CE

end Litt3.CartierAndSpin

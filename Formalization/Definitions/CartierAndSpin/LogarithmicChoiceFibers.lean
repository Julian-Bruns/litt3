import Definitions.CartierAndSpin.EndpointDecompositionFibers
import Definitions.CartierAndSpin.LogarithmicDifferentials

namespace Litt3.CartierAndSpin

variable (k F G E : Type*) [Field k] [Field F] [Field G] [Field E]
  [Algebra k F] [Algebra k G] [Algebra k E] [Algebra F E] [Algebra G E]
  [IsScalarTower k F E] [IsScalarTower k G E]

/-- Original universal pullback restricted to actual endpoint
logarithmic ONE-FORMS. Primitive functions are not identified with
their logarithms. -/
noncomputable def endpointLogarithmicFormPullback :
    (rationalLogarithmicDifferential k F).range →+ KaehlerDifferential k E :=
  (KaehlerDifferential.map k k F E).toAddMonoidHom.comp
    (rationalLogarithmicDifferential k F).range.subtype

/-- Actual logarithmic one-form decompositions. Different primitive
functions with the same logarithm give the same point of this fiber. -/
noncomputable def actualLogarithmicChoiceFiber (omega : KaehlerDifferential k E) :=
  endpointDecompositionFiber (endpointLogarithmicFormPullback k F E)
    (endpointLogarithmicFormPullback k G E) omega

end Litt3.CartierAndSpin

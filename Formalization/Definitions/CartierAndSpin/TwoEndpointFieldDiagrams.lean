import Definitions.CartierAndSpin.ActualFieldDifferentialMaps

namespace Litt3.CartierAndSpin

variable (k F G E F' G' E' : Type*)
  [Field k] [Field F] [Field G] [Field E] [Field F'] [Field G'] [Field E']
  [Algebra k F] [Algebra k G] [Algebra k E]
  [Algebra k F'] [Algebra k G'] [Algebra k E']
  [Algebra F E] [Algebra G E] [Algebra F' E'] [Algebra G' E']

/-- A literal diagram of BOTH actual endpoint field inclusions and
their COMMON actual ambient field. -/
structure TwoEndpointFieldDiagram where
  ambient : E →ₐ[k] E'
  left : F →ₐ[k] F'
  right : G →ₐ[k] G'
  left_commutes : ∀ x, ambient (algebraMap F E x) = algebraMap F' E' (left x)
  right_commutes : ∀ x, ambient (algebraMap G E x) = algebraMap G' E' (right x)

end Litt3.CartierAndSpin

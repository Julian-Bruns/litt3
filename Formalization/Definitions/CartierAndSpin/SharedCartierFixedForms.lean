import Definitions.CartierAndSpin.CartierFixedDifferentials

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable (k F G E : Type*) [Field k] [Field F] [Field G] [Field E]
  [Algebra k F] [Algebra k G] [Algebra k E] [Algebra F E] [Algebra G E]
  [IsScalarTower k F E] [IsScalarTower k G E]

/-- The actual intersection of BOTH rational universal-differential
images in the same source field. No extension of scalars is performed. -/
noncomputable def sharedRationalDifferentialImages :
    AddSubgroup (KaehlerDifferential k E) :=
  (KaehlerDifferential.map k k F E).toAddMonoidHom.range ⊓
    (KaehlerDifferential.map k k G E).toAddMonoidHom.range

/-- The literal Cartier-fixed part of that actual two-leg intersection. -/
noncomputable def sharedIntrinsicCartierFixedForms {p : ℕ}
    (C : RationalCartierOperator k E p) : AddSubgroup (KaehlerDifferential k E) :=
  sharedRationalDifferentialImages k F G E ⊓ intrinsicCartierFixedSubgroup C

end Litt3.CartierAndSpin

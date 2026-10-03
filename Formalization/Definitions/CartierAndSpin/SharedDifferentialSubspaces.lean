import Mathlib.RingTheory.Kaehler.Basic
import Mathlib.Algebra.Module.Submodule.Range

namespace Litt3.CartierAndSpin

variable (k F G E : Type*) [Field k] [Field F] [Field G] [Field E]
  [Algebra k F] [Algebra k G] [Algebra k E] [Algebra F E] [Algebra G E]
  [IsScalarTower k F E] [IsScalarTower k G E]

/-- The original universal differential pullback, viewed as a k-linear
map. Restricting the scalar action does not extend endpoint forms. -/
noncomputable def actualRationalDifferentialPullback :
    KaehlerDifferential k F →ₗ[k] KaehlerDifferential k E :=
  (KaehlerDifferential.map k k F E).restrictScalars k

/-- The literal shared k-subspace of BOTH original endpoint images. -/
noncomputable def sharedRationalDifferentialSubspace :
    Submodule k (KaehlerDifferential k E) :=
  LinearMap.range (actualRationalDifferentialPullback k F E) ⊓
    LinearMap.range (actualRationalDifferentialPullback k G E)

end Litt3.CartierAndSpin

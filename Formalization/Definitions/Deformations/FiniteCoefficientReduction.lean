import Definitions.Deformations.FormalCyclicGeneration
import Definitions.Deformations.FiniteShiftCokernel

namespace Litt3.Deformations

variable {R K L : Type*} [CommRing R] [AddCommGroup K] [Module R K]
    [AddCommGroup L] [Module R L]

/-- Literal coefficientwise action between different finite coefficient modules. -/
def finiteCoefficientMap (q : ℕ) (f : K →ₗ[R] L) :
    (Fin q → K) →ₗ[R] (Fin q → L) where
  toFun v j := f (v j)
  map_add' v w := funext (fun j => f.map_add (v j) (w j))
  map_smul' r v := funext (fun j => f.map_smul r (v j))

/-- The literal final coefficient inclusion, including q=0. -/
def finiteSocleCoefficient (q : ℕ) : K →ₗ[R] (Fin q → K) where
  toFun eta j := if j.val + 1 = q then eta else 0
  map_add' eta theta := by
    funext j
    by_cases last : j.val + 1 = q <;> simp [last]
  map_smul' r eta := by
    funext j
    by_cases last : j.val + 1 = q <;> simp [last]

end Litt3.Deformations

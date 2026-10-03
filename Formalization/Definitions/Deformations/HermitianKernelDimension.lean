import Definitions.Deformations.HermitianCyclicKernel
import Definitions.Deformations.CyclicBlockProfile

namespace Litt3.Deformations

def cyclicFamilyDimension {ι : Type*} [Fintype ι] (degree multiplicity : ι → ℕ) : ℕ :=
  ∑ i, multiplicity i * degree i

end Litt3.Deformations

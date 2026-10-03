import Definitions.Deformations.HermitianLeadingExtraction
import Definitions.Deformations.SkewMatrixForm
import Definitions.Deformations.RadicalDimensionDrop

namespace Litt3.Deformations

variable (k : Type*) [CommRing k]

noncomputable def truncatedResidueMatrix {ι κ : Type*} (N : ℕ) (positive : 0 < N)
    (B : Matrix ι κ (TruncatedCoefficientRing k N)) : Matrix ι κ k :=
  B.map (truncatedResidue k N positive)

end Litt3.Deformations
